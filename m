Received: from eggs.gnu.org ([2001:4830:134:3::10]:55029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZL0-0000Dg-2y
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eOZKv-0002ub-J8
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:31195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eOZKv-0002sa-AK
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 20:26:21 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 12 Dec 2017 01:26:16 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5E5381@SHSMSX103.ccr.corp.intel.com>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-4-git-send-email-changpeng.liu@intel.com>
	<20171211135942.GC5962@stefanha-x1.localdomain>
In-Reply-To: <20171211135942.GC5962@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 3/4] contrib/libvhost-user: enable
 virtio config space messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, December 11, 2017 10:00 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> <james.r.harris@intel.com>
> Subject: Re: [PATCH v6 3/4] contrib/libvhost-user: enable virtio config s=
pace
> messages
>=20
> On Tue, Dec 05, 2017 at 02:27:18PM +0800, Changpeng Liu wrote:
> > @@ -798,6 +801,70 @@ vu_set_slave_req_fd(VuDev *dev, VhostUserMsg
> *vmsg)
> >  }
> >
> >  static bool
> > +vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
> > +{
> > +    int ret =3D -1;
> > +
> > +    if (dev->iface->get_config) {
> > +        ret =3D dev->iface->get_config(dev, vmsg->payload.config.regio=
n,
> > +                                     vmsg->payload.config.size);
> > +    }
> > +
> > +    if (ret) {
> > +        /* resize to zero to indicate an error to master */
> > +        vmsg->size =3D 0;
> > +    }
>=20
> Please document this error case in vhost-user.txt.  I don't remember
> reading about it.
Thanks, will add it to vhost-user.txt.

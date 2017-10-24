Received: from eggs.gnu.org ([2001:4830:134:3::10]:46164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e6nGS-0007WY-Fi
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1e6nGP-0005du-BO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:40:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:44922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1e6nGO-0005bV-VA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 20:40:13 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 24 Oct 2017 00:40:06 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5D91EE@SHSMSX103.ccr.corp.intel.com>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
	<20171019151745.GH6205@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8682@SHSMSX103.ccr.corp.intel.com>
	<20171020095435.GD21393@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8EB6@SHSMSX103.ccr.corp.intel.com>
	<20171023155223-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171023155223-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Monday, October 23, 2017 8:55 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>; qemu-devel@nongnu.org;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; felipe@nutanix.com;
> Harris, James R <james.r.harris@intel.com>
> Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vhost-user-bl=
k host
> device
>=20
> On Mon, Oct 23, 2017 at 04:26:36AM +0000, Liu, Changpeng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > > Sent: Friday, October 20, 2017 5:55 PM
> > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> > > marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> > > <james.r.harris@intel.com>
> > > Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vhost-use=
r-blk
> host
> > > device
> > >
> > > On Fri, Oct 20, 2017 at 01:47:58AM +0000, Liu, Changpeng wrote:
> > > > > > +static Property vhost_user_blk_properties[] =3D {
> > > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > > +    DEFINE_PROP_UINT16("num_queues", VHostUserBlk, num_queues,
> 1),
> > > > > > +    DEFINE_PROP_UINT32("queue_size", VHostUserBlk, queue_size,=
 128),
> > > > > > +    DEFINE_PROP_BIT64("f_size_max", VHostUserBlk, host_feature=
s,
> > > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > > +    DEFINE_PROP_BIT64("f_sizemax", VHostUserBlk, host_features=
,
> > > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > > +    DEFINE_PROP_BIT64("f_segmax", VHostUserBlk, host_features,
> > > > > > +                      VIRTIO_BLK_F_SEG_MAX, true),
> > > > > > +    DEFINE_PROP_BIT64("f_geometry", VHostUserBlk, host_feature=
s,
> > > > > > +                      VIRTIO_BLK_F_GEOMETRY, true),
> > > > > > +    DEFINE_PROP_BIT64("f_readonly", VHostUserBlk, host_feature=
s,
> > > > > > +                      VIRTIO_BLK_F_RO, false),
> > > > > > +    DEFINE_PROP_BIT64("f_blocksize", VHostUserBlk, host_featur=
es,
> > > > > > +                      VIRTIO_BLK_F_BLK_SIZE, true),
> > > > > > +    DEFINE_PROP_BIT64("f_topology", VHostUserBlk, host_feature=
s,
> > > > > > +                      VIRTIO_BLK_F_TOPOLOGY, true),
> > > > > > +    DEFINE_PROP_BIT64("f_multiqueue", VHostUserBlk, host_featu=
res,
> > > > > > +                      VIRTIO_BLK_F_MQ, true),
> > > > > > +    DEFINE_PROP_BIT64("f_flush", VHostUserBlk, host_features,
> > > > > > +                      VIRTIO_BLK_F_FLUSH, true),
> > > > > > +    DEFINE_PROP_BIT64("f_barrier", VHostUserBlk, host_features=
,
> > > > > > +                      VIRTIO_BLK_F_BARRIER, false),
> > > > > > +    DEFINE_PROP_BIT64("f_scsi", VHostUserBlk, host_features,
> > > > > > +                      VIRTIO_BLK_F_SCSI, false),
> > > > > > +    DEFINE_PROP_BIT64("f_wce", VHostUserBlk, host_features,
> > > > > > +                      VIRTIO_BLK_F_WCE, false),
> > > > >
> > > > > Please explain how feature negotation works.  The vhost-user slav=
e
> > > > > advertises support features in the return value from
> > > > > VHOST_USER_GET_FEATURES.  How does this additional feature mask
> work
> > > and
> > > > > why is it useful?
> > > > According to Paolo's previous comments, VIRTIO_BLK_F_WCE/
> > > VIRTIO_BLK_F_SCSI/ VIRTIO_BLK_F_BARRIER
> > > > should be removed. Here I added all the feature flags just want to =
avoid
> the
> > > case that vhost-user slave target
> > > > can support but Qemu vhost block driver cannot support it.
> > >
> > > Please explain a bit more how these options can be used.
> > >
> > > When I looked at the vhost code it seemed like the vhost slave can
> > > report any feature bits it wishes (even things QEMU doesn't know abou=
t).
> > > What is the purpose of override some of the feature bits on the QEMU
> > > command-line?
> > Hi Stefan,
> > Here I added a switch which can override vhost-slave's feature bits, fo=
r
> example, vhost-slave reported `VIRTIO_BLK_F_RO`,
> > but Qemu vhost-master can disable it through command line when started =
the
> Qemu. Users don't need to change any
> > vhost-slave's code to disable this feature, and this is also aligned wi=
th vhost-
> scsi and vhost-net's implementation.
>=20
> Yes but I don't see these properties in virtio_blk_properties. Please
> make the names consistent at least when virtio-blk has them.
> I am pretty sure you don't want to expose e.g. _F_SCSI.
Yes, I should remove F_SCSI/F_WCE/F_BARRIER features, Virtio-blk hardcoded =
4 features: VIRTIO_BLK_F_SEG_MAX/VIRTIO_BLK_F_GEOMETRY/
VIRTIO_BLK_F_TOPOLOGY/VIRTIO_BLK_F_BLK_SIZE, and extra several configuratio=
n parameters for VIRTIO_BLK_F_CONFIG_WCE/VIRTIO_BLK_F_MQ,
I can change those feature bits same as virtio-blk.
>=20
>=20
> > > Stefan

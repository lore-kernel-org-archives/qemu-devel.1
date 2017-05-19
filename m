Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBkzI-0001GD-3J
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBkzF-0004BN-0Z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dBkzE-0004Au-Qd
	for qemu-devel@nongnu.org; Fri, 19 May 2017 12:42:44 -0400
Date: Fri, 19 May 2017 19:42:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170519193757-mutt-send-email-mst@kernel.org>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170517194401-mutt-send-email-mst@kernel.org>
	<63eaa3cf-1114-0ab2-da05-9f2731464c83@redhat.com>
	<aea73610-1b28-3ac9-4787-36b0f70c07f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aea73610-1b28-3ac9-4787-36b0f70c07f1@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com

On Fri, May 19, 2017 at 03:46:36PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 16:43, Maxime Coquelin wrote:
> > > >=20
> > > > +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the
> > > > slave, and the
> > > > +master initiated the slave to master communication channel using=
 the
> > > > +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB
> > > > miss and access
> > > > +failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests
> > > > to the master
> > > > +with a struct vhost_iotlb_msg payload. For miss events, the
> > > > iotlb payload has
> > > > +to be filled with the miss message type (1), the I/O virtual
> > > > address and the
> > > > +permissions flags. For access failure event, the iotlb payload
> > > > has to be
> > > > +filled with the access failure message type (4), the I/O
> > > > virtual address and
> > > > +the permissions flags.
> > >=20
> > > I don't think slave should cache invalid entries. If it does not,
> > > how can it detect access failure as opposed to a miss?
> >=20
> > Of course, invalid cache entries should not be cached.
> > The VHOST_IOTLB_ACCESS_FAIL has been specified for the Kernel backend=
,
> > even if the latter does not implement it yet.
>=20
> Yes, I leave this for future use e.g reporting copy_to_user() failure t=
o
> userspace.
>=20
> Thanks

Interesting. And it's not handled now.
So let's add a text "reserved for reporting internal access
errors in the future. Should not be used for now.".

--=20
MST

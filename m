Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePp4O-0008HC-PX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:26:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePp4K-0005Yb-Li
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:26:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePp4K-0005YC-BL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:26:24 -0500
Date: Fri, 15 Dec 2017 12:26:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215122614.GB26982@stefanha-x1.localdomain>
References: <CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<5A3211CC.60607@intel.com>
	<20171214173231.GS14433@stefanha-x1.localdomain>
	<5A33918D.5040500@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <5A33918D.5040500@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 05:10:37PM +0800, Wei Wang wrote:
> On 12/15/2017 01:32 AM, Stefan Hajnoczi wrote:
> > On Thu, Dec 14, 2017 at 01:53:16PM +0800, Wei Wang wrote:
> > > On 12/13/2017 08:35 PM, Stefan Hajnoczi wrote:
> > > > On Wed, Dec 13, 2017 at 04:11:45PM +0800, Wei Wang wrote:
> > > >=20
> > > > I think the current approach is fine for a prototype but is not sui=
table
> > > > for wider use by the community because it:
> > > > 1. Does not scale to multiple device types (net, scsi, blk, etc)
> > > > 2. Does not scale as the vhost-user protocol changes
> > > > 3. It is hard to make slaves run in both host userspace and the gue=
st
> > > >=20
> > > > It would be good to solve these problems so that vhost-pci can beco=
me
> > > > successful.  It's very hard to fix these things after the code is m=
erged
> > > > because guests will depend on the device interface.
> > > >=20
> > > > Here are the points in detail (in order of importance):
> > > >=20
> > > > 1. Does not scale to multiple device types (net, scsi, blk, etc)
> > > >=20
> > > > vhost-user is being applied to new device types beyond virtio-net.
> > > > There will be demand for supporting other device types besides
> > > > virtio-net with vhost-pci.
> > > >=20
> > > > This patch series requires defining a new virtio device type for ea=
ch
> > > > vhost-user device type.  It is a lot of work to design a new virtio
> > > > device.  Additionally, the new virtio device type should become par=
t of
> > > > the VIRTIO standard, which can also take some time and requires wri=
ting
> > > > a standards document.
> > > >=20
> > > > 2. Does not scale as the vhost-user protocol changes
> > > >=20
> > > > When the vhost-user protocol changes it will be necessary to update=
 the
> > > > vhost-pci device interface to reflect those changes.  Each protocol
> > > > change requires thinking how the virtio devices need to look in ord=
er to
> > > > support the new behavior.  Changes to the vhost-user protocol will
> > > > result in changes to the VIRTIO specification for the vhost-pci vir=
tio
> > > > devices.
> > > >=20
> > > > 3. It is hard to make slaves run in both host userspace and the gue=
st
> > > >=20
> > > > If a vhost-user slave wishes to support running in host userspace a=
nd
> > > > the guest then not much code can be shared between these two modes =
since
> > > > the interfaces are so different.
> > > >=20
> > > > How would you solve these issues?
> > > 1st one: I think we can factor out a common vhost-pci device layer in=
 QEMU.
> > > Specific devices (net, scsi etc) emulation comes on top of it. The
> > > vhost-user protocol sets up VhostPCIDev only. So we will have somethi=
ng like
> > > this:
> > >=20
> > > struct VhostPCINet {
> > >      struct VhostPCIDev vp_dev;
> > >      u8 mac[8];
> > >      ....
> > > }
> > Defining VhostPCIDev is an important step to making it easy to implement
> > other device types.  I'm interested is seeing how this would look either
> > in code or in a more detailed outline.
> >=20
> > I wonder what the device-specific parts will be.  This patch series does
> > not implement a fully functional vhost-user-net device so I'm not sure.
>=20
> I think we can move most of the fields from this series' VhostPCINet to
> VhostPCIDev:
>=20
> struct VhostPCIDev {
> VirtIODevice parent_obj;
> MemoryRegion bar_region;
> MemoryRegion metadata_region;
> struct vhost_pci_metadata *metadata;
> void *remote_mem_base[MAX_REMOTE_REGION];
> uint64_t remote_mem_map_size[MAX_REMOTE_REGION];
> CharBackend chr_be;
> };
>=20
> struct VhostPCINet {
> struct VhostPCIDev vp_dev;
> uint32_t host_features;
> struct vpnet_config config;
> size_t config_size;
> uint16_t status;
> }
>=20
>=20
>=20
>=20
> >=20
> > > 2nd one: I think we need to view it the other way around: If there is=
 a
> > > demand to change the protocol, then where is the demand from? I think=
 mostly
> > > it is because there is some new features from the device/driver. That=
 is, we
> > > first have already thought about how the virtio device looks like wit=
h the
> > > new feature, then we add the support to the protocol.
> > The vhost-user protocol will change when people using host userspace
> > slaves decide to change it.  They may not know or care about vhost-pci,
> > so the virtio changes will be an afterthought that falls on whoever
> > wants to support vhost-pci.
> >=20
> > This is why I think it makes a lot more sense to stick to the vhost-user
> > protocol as the vhost-pci slave interface instead of inventing a new
> > interface on top of it.
>=20
> I don't think it is different in practice. If the added protocol msg needs
> some setup on the vhost-pci device side, then we will also need to think
> about how to use it for the device setup explicitly, with the possibility=
 of
> delivering the modified msg to the guest (like SET_MEM_TABLE) if using the
> relaying method.
>=20
> Vhost-pci takes "advantage" of the vhost-user protocol for the inter-VM d=
ata
> path setup. If the added vhost-user message isn't useful for vhost-pci
> setup, I think the slave don't need to handle it even.

vhost-pci setup is incomplete in this patch series.  Currently the guest
slave is unable to participate in feature negotiation or limit the
number of queues.  Reconnection is also not supported yet.

Guest slaves must be able to use a vhost-pci device without requiring
QEMU -device options (like max queues, feature bits, etc) for that
specific slave implementation.  Why?  In a cloud environment it is
incovenient or impossible for users to add QEMU -device options for the
slave implementation they are using.

Addressing these issues will require more vhost-pci<->guest slave
communication.  The number of messages that can be hidden will shrink.

Stefan

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM79mAAoJEJykq7OBq3PI+FYIAKwAAZoM7quzlVrMGVkYhJqr
ax/caqPWiBE8wAI9V1dgNQpOyBEHwcy58h7YZb576J9wAiZwGzUDLszDKwHbyn/c
aJ5RzFTwVQQ5PXnwvb1yzQji5p0FpsMYHO9erRYD8K64hZ2tjxpY41oeV+eWT/8U
3EsYB8sOwxS09dn8TyDZ99h7lPF0ZoyNOPRDgyQsZGaUBhhDztkJi1Qc3o5aOgqO
HCl1/agymo8ucXRCKP9sBHwgBqsh9pe4fCIag3NI+U57A08769JmuKnMflhSjRwz
KoOVXPHXyFBVH+iteKECsDja52dSQFo5eDCMaW/2Q3KnIyrMdFbKzsOXVXzrJ2E=
=rjk/
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

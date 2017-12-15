Received: from eggs.gnu.org ([2001:4830:134:3::10]:52249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpHk-0004XB-HT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePpHh-0004nu-7i
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:40:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePpHg-0004mu-WC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:40:13 -0500
Date: Fri, 15 Dec 2017 12:40:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215124002.GD26982@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
	<20171205160020.GH31150@stefanha-x1.localdomain>
	<5A27C752.2050906@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <5A27C752.2050906@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 5/7] vhost-user:
 VHOST_USER_SET_VHOST_PCI msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 06:32:50PM +0800, Wei Wang wrote:
> On 12/06/2017 12:00 AM, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 11:33:14AM +0800, Wei Wang wrote:
> > > Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg =
is
> > > used to signal the vhost-pci device to start/stop working.
> > >=20
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > ---
> > >   hw/net/vhost_net.c                | 37 ++++++++++++++++++++++++++++=
+++++++++
> > >   hw/virtio/vhost-pci-slave.c       |  2 +-
> > >   hw/virtio/vhost-user.c            | 17 +++++++++++++++++
> > >   hw/virtio/vhost.c                 |  7 +++++++
> > >   include/hw/virtio/vhost-backend.h |  2 ++
> > >   include/hw/virtio/vhost-user.h    |  2 ++
> > >   include/hw/virtio/vhost.h         |  2 ++
> > >   include/net/vhost_net.h           |  2 ++
> > >   8 files changed, 70 insertions(+), 1 deletion(-)
> > New protocol messages must be documented in docs/interop/vhost-user.txt.
>=20
> OK, I'll add it to the doc after the discussion.
>=20
> >=20
> > Why is a new message needed?  I'm not sure why it is specific to
> > vhost-pci.
>=20
> Yes, it might be useful for other vhost-user slave implementations. Proba=
bly
> we can name it "VHOST_USER_SET_SLAVE"?
> The message is used to "link up" or "link down" the slave device. For
> example, when virtio-net leaves, it sends a "VHOST_USER_SET_SLAVE" msg to
> the salve to link down the slave device.
> (a similar msg is VHOST_USER_SET_VRING_ENABLE, but that is for virtqueue
> enable/disable, not for a device level enable/disable)

Why is VHOST_USER_SET_VHOST_PCI necessary when DPDK and other vhost-user
net device slaves already exist today and didn't need it?

Stefan

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaM8KiAAoJEJykq7OBq3PIrFYH/3yqAzTG4fvSzCXIWFBSNgQQ
aNw4DrfE4Uwv8VNAs2fX96VlLk6H/py+O46JIScho3uTOHSsmfcKSjRbF9gnrv4j
DHqjMsxVeuvB5Go6/A0hdJKkcT6pGEHzmGAJ6ocRiM2IVdXc4sKLm5upVQy8/hZm
xVGFF7yi+veMRK2HwHTB/rhPNYCgD4Fy+8RlLobJFR9Evvgm50tjDBpHiKCwL9tn
vehSap0fjSOgakx4v3Q4VFSy3Bfh6mKbr34F9Guo0j80xbhBUf3QcZ0GW5kWmUuX
9qFKlKNhbFm6LJ8bSPladanV5a12juJYlFFewgf7KsdVqZ4FwULg4FAkSLKoJqI=
=UWXq
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

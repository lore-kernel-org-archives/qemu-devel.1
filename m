Received: from eggs.gnu.org ([2001:4830:134:3::10]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePtTZ-0002MS-Ha
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePtTW-0003pi-DO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:08:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePtTW-0003p9-6d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:08:42 -0500
Date: Fri, 15 Dec 2017 17:08:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171215170834.GA31668@stefanha-x1.localdomain>
References: <20171215170519.31392-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20171215170519.31392-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [RFC virtio-dev] vhost-user-slave: add vhost-user
 slave device type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org
Cc: qemu-devel@nongnu.org, Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 05:05:19PM +0000, Stefan Hajnoczi wrote:
> The vhost-user slave device facilitates vhost-user device emulation
> through vhost-user protocol exchanges and access to shared memory.
> Software-defined networking, storage, and other I/O appliances can
> provide services through this device.
>=20
> This device is based on Wei Wang's vhost-pci work.  The vhost-user slave
> device differs from vhost-pci because it is a single virtio device type
> that exposes the vhost-user protocol instead of a family of new virtio
> device types, one for each vhost-user device type.
>=20
> This device supports vhost-user slave and vhost-user master
> reconnection.  It also contains a UUID so that vhost-user slave programs
> can identify a specific device among many without using bus addresses.
>=20
> It is somewhat unconventional for a virtio device because it makes use
> of additional resources called doorbells, notifications, and shared
> memory.  A mapping of these resources to the virtio PCI transport is
> provided.  Other transports, such as CCW may not be able to support
> this device.

HTML version here:
https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaNAGSAAoJEJykq7OBq3PIOnYH/Rf4HGCbFN+UjOYk2NPsiafD
g9pOroGlAmXqweJgD/XG0IYSwnGfCly4uWp+ycRN8T6VevFLnnOUGpbH/4kYr1D3
sq3hz7AIlFxYPqMfwsIGk5C/NLigDB/eBigeU9VPvT5J60c8AS9Jm+8yph3EPykK
rbG57qkuVtfbEfUBYbuNZDAO4GB//cGxBxKnfayYqHlFIjBEybBHIHF1nFQbr8ba
nvf8pUZUNiZVzIFzlWnEv6aq/Gkf43wbDlwQ6ApBoS8voh2PFjB42h18RfcS5K04
nxMAnk4sL3eiZmdDpK/BYcJFaAHoq9EI4Hv6e3F7XnBCQzgIve07g1LuS0pfw1Y=
=JmIh
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

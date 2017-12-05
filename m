Received: from eggs.gnu.org ([2001:4830:134:3::10]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMEEy-0005Pi-9i
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMEEv-0002Gk-6O
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:30:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMEEu-0002GT-Ug
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:30:29 -0500
Date: Tue, 5 Dec 2017 14:30:01 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205143001.GE31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. This
> patch series implements the vhost-pci-net device setup and emulation. The
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of the
> remote VM, vring info).
>=20
> Currently, only the fundamental functions are implemented. More features,
> such as MQ and live migration, will be updated in the future.
>=20
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html

Please be explicit about "vhost-pci" vs "vhost-pci-net" in future
emails.  In this email you use "vhost-pci" to mean both things and it's
likely to cause confusion.  For example, MQ and DPDK PMD are related to
vhost-pci-net.

This is a general problem with all of vhost-user, not just vhost-pci.
People sometimes focus solely on virtio-net.  It causes layering
violations and protocol limitations because they are not thinking about
the virtio device model as a whole.

Eventually virtio-gpu, virtio-scsi, etc should all work over vhost-pci
so it's important to keep the virtio architecture in mind with a
separation between the transport and devices.

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJq1pAAoJEJykq7OBq3PI/C8IAMo/2pz1x1Psm5ntCKwSt7Xx
QXUnpNyg/s8/d6IGenLCPWwAUKaY37SGJxBYyumsnO7dBU0GZ7OfA90dNkJH7mjR
azeyUt87ojKHBt2F+kR7sLH7ZTCG/+zpvqCjhUGVgT/U7zCscUkVtxRUXJkLYBAs
9trrukxO4V/rj+oKs/P1PQ4rkOs/LxTw9jcEInNrjs3IImrD3t05aa0B6lRx4fiw
5za+abzMqVn3HDTtCnamZ1jVEifMiWKf/i3qRS/Vw525FAHHA2IGtm+FAoB1pCpO
+r3ZxG0xEjpD57V5wFnTPEkfsoNKebLnYuGVXHRG1RxxqkY1aeisfUBvAnh7/p8=
=oaUX
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--

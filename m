Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFkJ-00050j-5O
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMFkG-0004bv-1N
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMFkF-0004bW-R5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:06:55 -0500
Date: Tue, 5 Dec 2017 16:06:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205160646.GJ31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iRjOs3ViPWHdlw/I"
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


--iRjOs3ViPWHdlw/I
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
>=20
> v2->v3 changes:
> 1) static device creation: instead of creating and hot-plugging the
>    device when receiving a vhost-user msg, the device is not created
>    via the qemu booting command line.
> 2) remove vqs: rq and ctrlq are removed in this version.
>     - receive vq: the receive vq is not needed anymore. The PMD directly
>                   shares the remote txq and rxq - grab from remote txq to
>                   receive packets, and put to rxq to send packets.
>     - ctrlq: the ctrlq is replaced by the first 4KB metadata area of the
>              device Bar-2.
> 3) simpler implementation: the entire implementation has been tailored
>    from ~1800 LOC to ~850 LOC.

Please write qtest test cases for vhost-pci.  See
tests/virtio-net-test.c and tests/vhost-user-test.c for examples.

Stefan

--iRjOs3ViPWHdlw/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsQWAAoJEJykq7OBq3PITK4H/RltWGVrnTUMECEUNVSXnNs1
kv1jbxIAy8hRpAvQXxazocpQjNqxUsq3otu7hz0+mXcemlMQ+YsZtnbldamlDbt6
PfPxh7E3dnU56iO+CLuKsVexlbB7SBahCvE2/dMD370Gc9CryBkjFLxCki2J55et
S2NzxzDquFst2otumsFOxzZUGq9+QH0CWeEShhQ7IY01g7n15hU4QabGwSFlM3jn
xm/7SUURcSlSbfYelol+8NgX8vTe5asf4ToNRok3nuuZjOL0conw4Rsj2GAKtpQD
QqpbAv5tMH9pdVTDsfWNMysJ8//ezGT2S2YrEDCBvEFjpOfy4Mhl79OlC+derdg=
=vz3y
-----END PGP SIGNATURE-----

--iRjOs3ViPWHdlw/I--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pGs-0005hu-BD
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4pGr-0007lm-8D
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:24:34 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<24c7d85bd96b8cbf02bf60dabc0787724c19b18b.1508257445.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7902dc77-4db2-119a-639b-0bce00b896b9@redhat.com>
Date: Wed, 18 Oct 2017 09:24:24 -0500
MIME-Version: 1.0
In-Reply-To: <24c7d85bd96b8cbf02bf60dabc0787724c19b18b.1508257445.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mvOcqIpfGa537MOCQE7eHn2kMeVHs9lsu"
Subject: Re: [Qemu-devel] [PATCH v5 06/10] qemu-iotests: make ./check
 automatically reap QEMU processes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mvOcqIpfGa537MOCQE7eHn2kMeVHs9lsu
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <7902dc77-4db2-119a-639b-0bce00b896b9@redhat.com>
Subject: Re: [PATCH v5 06/10] qemu-iotests: make ./check automatically reap
 QEMU processes
References: <cover.1508257445.git.jcody@redhat.com>
 <24c7d85bd96b8cbf02bf60dabc0787724c19b18b.1508257445.git.jcody@redhat.com>
In-Reply-To: <24c7d85bd96b8cbf02bf60dabc0787724c19b18b.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 11:31 AM, Jeff Cody wrote:
> Check will now take care of cleaning up all QEMU processes started
> from bash tests using the common.qemu framework.
>=20
> This also paves the way to added another check option to keep QEMU
> processes around, in the case of a failed test.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/085   | 2 --

and 28, after fixing things earlier in the series

> +++ b/tests/qemu-iotests/check
> @@ -845,10 +845,13 @@ do
>          # TEST_DIR / QEMU_TEST_DIR
>          (
>          export TEST_DIR=3D$TEST_DIR_SEQ
> -        . "$source_iotests/common.config"
> -        . "$source_iotests/common.rc"
> +        cd "$source_iotests";
> +        . ./common.config
> +        . ./common.rc
> +        . ./common.qemu
> =20
>          _cleanup_protocols
> +        _cleanup_qemu

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mvOcqIpfGa537MOCQE7eHn2kMeVHs9lsu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnnZBgACgkQp6FrSiUn
Q2qxCQf+IqZsp6dk4WMp92HJfuSNTbYXX9vC4wmerpfadUgg69wmYIB7h3oZIRUW
lhkhV9IRF+yvl8/B/TbCxcBTx34Spu2lg5urFtckTl+mnR+yPB+x5MGwhQx35lpU
kc+a2L7NdKpnVZtXWJuODvt1+5fWE22g82JUEX3phj5LOOBuohr+ic0guaF3NCpn
QX63xaX3KZBvZQh7PSq+sq/eEBagPl0QWdliQTteyc6vvtORPWY2b6xISguVIexG
95lhZtc5mZZFSQQersIPkyajXvo5xZguXNuCZ5fUuX8vTkQL4zih0bNfaeqhv655
ydbt0DhxigonlcI7CIr+6ESHGCccBg==
=QP5D
-----END PGP SIGNATURE-----

--mvOcqIpfGa537MOCQE7eHn2kMeVHs9lsu--

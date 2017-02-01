Received: from eggs.gnu.org ([2001:4830:134:3::10]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYjO7-0003fY-TS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYjO6-0001tI-V1
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:07:07 -0500
References: <1485878172-15463-1-git-send-email-pl@kamp.de>
	<1485878172-15463-3-git-send-email-pl@kamp.de>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <863201d4-1207-1917-0d13-3083c4cede6f@redhat.com>
Date: Wed, 1 Feb 2017 02:06:54 +0100
MIME-Version: 1.0
In-Reply-To: <1485878172-15463-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vf1n3UIXDXCISbWaoVDIWV10nO95DJ6QC"
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: fix naming of runtime
 opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vf1n3UIXDXCISbWaoVDIWV10nO95DJ6QC
From: Max Reitz <mreitz@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 ashijeetacharya@gmail.com, jcody@redhat.com, armbru@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <863201d4-1207-1917-0d13-3083c4cede6f@redhat.com>
Subject: Re: [PATCH V2 2/2] block/nfs: fix naming of runtime opts
References: <1485878172-15463-1-git-send-email-pl@kamp.de>
 <1485878172-15463-3-git-send-email-pl@kamp.de>
In-Reply-To: <1485878172-15463-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 16:56, Peter Lieven wrote:
> commit 94d6a7a accidently left the naming of runtime opts and QAPI
> scheme inconsistent. As one consequence passing of parameters in the
> URI is broken. Sync the naming of the runtime opts to the QAPI
> scheme.
>=20
> Please note that this is technically backwards incompatible with the 2.=
8
> release, but the 2.8 release is the only version that had the wrong nam=
ing.
> Furthermore release 2.8 suffered from a NULL pointer deference during
> URI parsing.

I always love things like this. "This technically breaks X, but
obviously nobody used X, because X always crashed." Reminds me of how we
success^W accidentally removed qcow2 encryption.

Technically however this also changes the runtime parameter names, I
think. Giving them probably did work in 2.8, so it is not compatible
there. I don't mind very much, though, and you're the maintainer, so
it's fine with me.

Anyway, I think this patch should also update nfs_refresh_filename().

Max


--vf1n3UIXDXCISbWaoVDIWV10nO95DJ6QC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRNK4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AV9IH+gNI49pUrWmlBBt2I3d4BhZX2md+tMvk
qbHl7RrbjKW91Se0C1av53Rcos0YEuloL4al/vHdPwM5HGUCmqxBMSH2Ht3E1WGl
VZIPgfMtLbdLK2zIl+rB06oGSv/zsPjoUcmdsVaLo2wtP9jyp27UKLopj/BamePl
BVba1v+2FpJ7jZc5af6dM+4amww4YPNZyvBjiSH38R6ybqkQH7oWW496mN/nNfwj
WrpLPl52F/DhbI8MDWDm3mIRJ3pJzHLtRzu6063nAmsQrI4Z7CfhQ+upS1VwHMAk
NhVGqX6V0F90HzJz2YsXYXgVEjWjB3Nhsv5yLs3TsqCVX4N45zuLn9A=
=2A+8
-----END PGP SIGNATURE-----

--vf1n3UIXDXCISbWaoVDIWV10nO95DJ6QC--

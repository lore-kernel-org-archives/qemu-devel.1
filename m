Received: from eggs.gnu.org ([2001:4830:134:3::10]:35443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYy7X-0004nI-9u
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYy7W-0000Vs-6j
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:50:59 -0500
References: <1485942829-10756-1-git-send-email-pl@kamp.de>
	<1485942829-10756-3-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <018a5f72-8052-dede-b2af-3010b4182563@redhat.com>
Date: Wed, 1 Feb 2017 10:50:48 -0600
MIME-Version: 1.0
In-Reply-To: <1485942829-10756-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6u0fqwqqGNMjqU9wp6bcpgSFF4lIXfhco"
Subject: Re: [Qemu-devel] [PATCH V3 2/2] block/nfs: fix naming of runtime
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6u0fqwqqGNMjqU9wp6bcpgSFF4lIXfhco
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com,
 jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <018a5f72-8052-dede-b2af-3010b4182563@redhat.com>
Subject: Re: [PATCH V3 2/2] block/nfs: fix naming of runtime opts
References: <1485942829-10756-1-git-send-email-pl@kamp.de>
 <1485942829-10756-3-git-send-email-pl@kamp.de>
In-Reply-To: <1485942829-10756-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/01/2017 03:53 AM, Peter Lieven wrote:
> commit 94d6a7a accidently left the naming of runtime opts and QAPI

Whoops - I caught one typo in v2, but missed another:
s/accidently/accidentally/

> scheme inconsistent. As one consequence passing of parameters in the
> URI is broken. Sync the naming of the runtime opts to the QAPI
> scheme.
>=20
> Please note that this is technically backwards incompatible with the 2.=
8
> release, but the 2.8 release is the only version that had the wrong nam=
ing.
> Furthermore release 2.8 suffered from a NULL pointer dereference during=

> URI parsing.
>=20
> Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/nfs.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

(Maintainer can probably fix the typo)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6u0fqwqqGNMjqU9wp6bcpgSFF4lIXfhco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkhHoAAoJEKeha0olJ0NqVAAIAJeRd6j6zOLcRjwmoFevV4kL
82/jPPbS/bTyWJ+Mu4Wkap7i2Wz/WwSTYXPPX/gr639OLaYJ0o8a+j9H41ZE6kfN
NLdMNQafgKbAfZHqecTaTx4LPuIeCWH5uYtCi3DgosNYzgo/QsPSe4l5P9r8QIUD
rweTUnFa5KBQMwa74qRQ2lGuHvHoPx3kflJKxgp/waz7PPUFtzmoV1hOz/Cvanj6
zhHAjcyGkjrbihHMD1h7hRUC510n++A8C+n40uj3HXUFfBKe90QVoeCHk8sBcl1q
5dkNbs/ysQq3LYLMqfTLJBqzH4Oc/tkeQey7mF6mC0QReyDJ27i2w7btU+FcOgM=
=h6zJ
-----END PGP SIGNATURE-----

--6u0fqwqqGNMjqU9wp6bcpgSFF4lIXfhco--

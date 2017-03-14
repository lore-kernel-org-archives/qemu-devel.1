Received: from eggs.gnu.org ([2001:4830:134:3::10]:46687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntaz-000744-Mu
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntav-0007v6-Qy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:03:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntav-0007uX-LY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:03:01 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-40-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21461cfe-54a1-2199-0967-0a7fccb1794d@redhat.com>
Date: Tue, 14 Mar 2017 16:02:59 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-40-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="19PKJw7SiAEqd4fkKJusrIK2nCn6gHbBN"
Subject: Re: [Qemu-devel] [PATCH for-2.9 39/47] qapi: Drop unused variable
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--19PKJw7SiAEqd4fkKJusrIK2nCn6gHbBN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <21461cfe-54a1-2199-0967-0a7fccb1794d@redhat.com>
Subject: Re: [PATCH for-2.9 39/47] qapi: Drop unused variable events
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-40-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-40-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Missed in commit e98859a
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 0da426a..12b1bda 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -49,7 +49,6 @@ name_case_whitelist =3D []
>  enum_types =3D []
>  struct_types =3D []
>  union_types =3D []
> -events =3D []
>  all_names =3D {}

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--19PKJw7SiAEqd4fkKJusrIK2nCn6gHbBN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFqDAAoJEKeha0olJ0NqeewIAIvdr3H4R45MipOriODOQGpO
Uy1a3oS7X/GBxPOFL4ta1AgUp+5V7ZpQ1CtzqfBbLDPELPxMFmWmnjAmIQY6UnPP
9oid2ndA4+E01f8tUhy1PZY5QcQdb8tperVYJsjjZ03uxHtvnWDx95+0gQBc/qN8
ZbR7nKtPQD3ghQNn9o+OmQrCDLKPtZ0E7ZA3NXiaGs+SEQ30RLfgXaBUbMnrPqSc
T65sWApvO3IFm7v+355YPcFlK4/4nxcQwGG5gYuHD+JHGM87ZjQo8sciQ0L6gAFz
7nVQ6ElIHmDfnoyfVxcWd2pK03GhArVrjZXw7KEkWrYHOGXuzLzOIENHncW1yco=
=v01+
-----END PGP SIGNATURE-----

--19PKJw7SiAEqd4fkKJusrIK2nCn6gHbBN--

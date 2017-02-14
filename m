Received: from eggs.gnu.org ([2001:4830:134:3::10]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdknQ-0004UR-IX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdknN-0003en-Bq
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:38:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdknN-0003eX-2y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:37:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE30485540
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:37:56 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-8-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6b0508f-9fca-b064-088e-f7fb31e9c745@redhat.com>
Date: Tue, 14 Feb 2017 15:37:54 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-8-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r9l4d0bDtRAPF1IWFeCabpAdRwX4nAAur"
Subject: Re: [Qemu-devel] [PATCH 07/24] util/cutils: Clean up variable names
 around qemu_strtol()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r9l4d0bDtRAPF1IWFeCabpAdRwX4nAAur
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a6b0508f-9fca-b064-088e-f7fb31e9c745@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/24] util/cutils: Clean up variable names
 around qemu_strtol()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-8-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Name same things the same, different things differently.
>=20
> * qemu_strtol()'s parameter @nptr is called @p in
>   check_strtox_error().  Rename the latter.
>=20
> * qemu_strtol()'s parameter @endptr is called @next in
>   check_strtox_error().  Rename the latter.
>=20
> * qemu_strtol()'s variable @p is called @endptr in
>   check_strtox_error().  Rename both to @ep.
>=20
> * qemu_strtol()'s variable @err is *negative* errno,
>   check_strtox_error()'s parameter @err is *positive*.  Rename the
>   latter to @eno.

Whether or not you rename @eno based on Paolo's comments,

>=20
> Same for qemu_strtoul(), qemu_strtoi64(), qemu_strtou64(), of course.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--r9l4d0bDtRAPF1IWFeCabpAdRwX4nAAur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3iyAAoJEKeha0olJ0NqsDYIAIjAavF4GRZblVQIAy0za+3i
s3L9qws9P1lkfh+dP7by01I/pWr1JNezX432rYcgtpChWY5U6mW+BYT65cXxsvA0
TeQB9gCCoGxcJ69T5V3PVbSP1/TRW7D8C9V0/ppH+NaqLgExBPgfq6Im7JZMoNzy
UCsODCKKyeo2y+rHW4bJ6+1N+gyRgSk5Q1VXcwwB7c+FuFx2SZafC2553nNicSW4
6X5I5lZ2DxgwiF4RAyAxxBMqIRLWMa7g7scMYwUZt8X9PexDwkudMfF2RsK+h/BX
n3WnGvwoibOA64/2uqM0/yYQO+ew4UHBuTgHUQcj/aQqxGGUngsi6aN17f+3mCY=
=s8S6
-----END PGP SIGNATURE-----

--r9l4d0bDtRAPF1IWFeCabpAdRwX4nAAur--

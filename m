Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9fd-0002b6-6L
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw9fc-0006ss-7w
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:50:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cw9fb-0006sh-VI
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:50:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C475C7EBAE
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 15:49:58 +0000 (UTC)
References: <20170406154107.9178-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
Date: Thu, 6 Apr 2017 10:49:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170406154107.9178-1-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="poKf6jXpnQfp7FKkCiLTdJ34bTfwTPUXG"
Subject: Re: [Qemu-devel] [PATCH] tests/check-qdict: Fix missing brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--poKf6jXpnQfp7FKkCiLTdJ34bTfwTPUXG
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Message-ID: <48d5bb0d-25a9-365c-04fa-e3dad7ecf6e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/check-qdict: Fix missing brackets
References: <20170406154107.9178-1-dgilbert@redhat.com>
In-Reply-To: <20170406154107.9178-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 10:41 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
> boolean; it's got a point.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/check-qdict.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index 81162ee572..6f3fbcf9c1 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -559,7 +559,7 @@ static void qdict_join_test(void)
>          g_assert(qdict_size(dict1) =3D=3D 2);
>          g_assert(qdict_size(dict2) =3D=3D !overwrite);
> =20
> -        g_assert(qdict_get_int(dict1, "foo") =3D=3D overwrite ? 84 : 4=
2);
> +        g_assert(qdict_get_int(dict1, "foo") =3D=3D (overwrite ? 84 : =
42));

How is the test passing pre-patch, and why does it not change the test
post-patch?  Does that mean that overwrite is not doing what we expected?=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--poKf6jXpnQfp7FKkCiLTdJ34bTfwTPUXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5mOlAAoJEKeha0olJ0NqUioH/RyhlkQd5SB5XSnbkxOFt/Ov
hvB+9l+C1gs0Kv9hBoCgCHx1sZJdGmpYtCrVuRCsWPw8w2mFelwo92+aHMpq6yKA
siG5463FeImaF0znGTkUmuX311VY9x1VFLC5IA3O+AT1RWq6TvLgei7Gd3fZPUHc
GQ+dzz2/v/VJJ3aaTHYGrvxRLfez1zulIVSGuDcuVr3/9W6LxGE/Iku5JXvMtsoT
iHUdDfrq/XcLconL93byLCyJB0dmQysda66oEw16MLEaMzGghsRGHJcwmfkVcVk+
uTD/L+j6UydjYqxwUfsgjw1cmbIVKjnJhod6ZLoJlHW8V9ecJ61VSuurW8g+K60=
=c+j/
-----END PGP SIGNATURE-----

--poKf6jXpnQfp7FKkCiLTdJ34bTfwTPUXG--

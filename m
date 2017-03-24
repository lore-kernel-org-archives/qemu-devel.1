Received: from eggs.gnu.org ([2001:4830:134:3::10]:53618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUCF-0005vw-EA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUCC-0006U7-Df
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crUCC-0006U0-4x
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7EF1C04B926
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 18:44:19 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba964c67-f7d4-8088-75c0-33fed97faa81@redhat.com>
Date: Fri, 24 Mar 2017 13:44:12 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SwSW7s1ugqBDBj9ON7j9HRpfAVKOsBBOV"
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/9] rbd: Clean up after the
 previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SwSW7s1ugqBDBj9ON7j9HRpfAVKOsBBOV
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <ba964c67-f7d4-8088-75c0-33fed97faa81@redhat.com>
Subject: Re: [PATCH RFC v2 4/9] rbd: Clean up after the previous commit
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> This code in qemu_rbd_parse_filename()
>=20
>     found_str =3D qemu_rbd_next_tok(p, '\0', &p);

This says to take a string starting at p, modify it in place, update p
to point past the delimiter (well, to nowhere since the delimiter of
'\0' means it is the last token parsed), and return the original
starting into found_str....

>     p =3D found_str;

=2E..and this says to revert the change to p (why we had to pass &p
instead of NULL is beyond me).  Furthermore, reading the modifications
that qemu_rbd_next_tok() does in place (namely, looking for \ escape
sequences), it doesn't do any when delimiter is '\0'.  Prior to patch 3,
it was therefore useful as an idiom for length checking - but as you
killed even that aspect, I agree with your assessment that it is now a
no-op.

>=20
> has no effect.  Drop it, and simplify qemu_rbd_next_tok().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SwSW7s1ugqBDBj9ON7j9HRpfAVKOsBBOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1Wj8AAoJEKeha0olJ0NqaFIH/igPbOKZazE8BjJymgEm9WKY
4ZZrEv+F1lPONKDDt99FMt/7Tfg4t4PS6StIDglwu9fConpqvAThuddOEnhWL9uu
3TjynZVkldFcbShUkB4DWia0fonEMJghclT9M4FikAO46VR1LPkb+tSXjgsPXH/h
TbD2sWUL9N81TeGgKBT1fTCFwZvglbfLk+xNbvOHBvQPaL4wRl1KLi6LXkm4p0pp
bjnzSFhzXSm1s4BApMsCArOLaIdMytp9TLeWv19EmDaSDa0Z71CBmEXYhRnWKr2w
6u1aT45Jy9JtuW6/tJLur1/Cd32ixIacdrId4mD/ODCoL7dJWJZWkktjw+Uly+A=
=wFLM
-----END PGP SIGNATURE-----

--SwSW7s1ugqBDBj9ON7j9HRpfAVKOsBBOV--

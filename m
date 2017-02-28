Received: from eggs.gnu.org ([2001:4830:134:3::10]:48063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijD6-00038w-2H
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijD1-0006Gu-AN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cijD1-0006GX-24
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:56:59 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 231E03D961
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 14:56:59 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-18-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <915e35bf-bac6-43cd-29f2-176984971310@redhat.com>
Date: Tue, 28 Feb 2017 08:56:56 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-18-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J7x9x5r6iIJ4PuRLFAbqPW4RsxpERlCIo"
Subject: Re: [Qemu-devel] [PATCH v2 17/26] qapi: Drop unused non-strict
 qobject input visitor
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
--J7x9x5r6iIJ4PuRLFAbqPW4RsxpERlCIo
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <915e35bf-bac6-43cd-29f2-176984971310@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 17/26] qapi: Drop unused non-strict
 qobject input visitor
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> The split between tests/test-qobject-input-visitor.c and
> tests/test-qobject-input-strict.c now makes less sense than ever.  The
> next commit will take care of that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

If I read Paolo's thread correctly, we were deferring his patches that
relied on a non-strict visit until 2.10.  And we can re-add non-strict
via a new constructor, rather than adding back a bool parameter to all
existing callers, so it doesn't hurt too badly that we are doing this
now for 2.9 (or a revert always works, if it is justified).

Reviewed-by: Eric Blake <eblake@redhat.com>


> @@ -276,7 +269,6 @@ static GenericList *qobject_input_next_list(Visitor=
 *v, GenericList *tail,
>      return tail->next;
>  }
> =20
> -
>  static void qobject_input_start_alternate(Visitor *v, const char *name=
,
>                                            GenericAlternate **obj, size=
_t size,
>                                            bool promote_int, Error **er=
rp)

Spurious hunk?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--J7x9x5r6iIJ4PuRLFAbqPW4RsxpERlCIo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtY+4AAoJEKeha0olJ0Nq3hEIAJjQ1jDSaOAoKYaVpnMc4Sko
xhT/vsNbbGY1pFNuDOy6Ce6m1JoRvAimVAN8idZnu6tFHaURUMlCY4Dc1xMPYtYt
nENMd+0susZpZnh5bRH/Q299eks/t1RtS5Njb0/r1WRxmyb+ew+iQ1HHA+7oHlVc
JAJwZ9CWRzj1zvmUS70MJqib0xjQrDEMbn0p+1N0amu5bWgmSfPVps/PKptTUOfc
u/Wacl9WG4Hd0xbroJ2j53zZBIst6fAADuGBR/renTYkg1ga2s3fg27QGZmWlQ9z
HHYV9HJFIRg1AaSzSbWh4U9SDarhdZSrRGUupM2D/Lt65d7bSiE7g73Hfp3YFHs=
=a/IB
-----END PGP SIGNATURE-----

--J7x9x5r6iIJ4PuRLFAbqPW4RsxpERlCIo--

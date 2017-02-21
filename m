Received: from eggs.gnu.org ([2001:4830:134:3::10]:48864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGMb-00026C-P8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:44:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGMY-0007ep-KM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:44:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgGMY-0007eg-Dq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:44:38 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7679F4DD4B
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:44:38 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-13-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <621b027f-2ecc-7fa2-bc04-c5cdbf91e9bb@redhat.com>
Date: Tue, 21 Feb 2017 13:44:36 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-13-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8GgkxgwDoQ9JV5EqOofAEK9sJP9UBswMd"
Subject: Re: [Qemu-devel] [PATCH 12/14] tests: Don't check qobject_type()
 before qobject_to_qbool()
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
--8GgkxgwDoQ9JV5EqOofAEK9sJP9UBswMd
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <621b027f-2ecc-7fa2-bc04-c5cdbf91e9bb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/14] tests: Don't check qobject_type()
 before qobject_to_qbool()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-13-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qbool(obj) returns NULL when obj isn't a QBool.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QBOOL.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c                 | 24 ++++++------------------
>  tests/test-qobject-output-visitor.c | 12 +++++-------
>  2 files changed, 11 insertions(+), 25 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8GgkxgwDoQ9JV5EqOofAEK9sJP9UBswMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJikAAoJEKeha0olJ0Nq9p4IAKM76vT14KvS45Jk43VXMOpK
zb3mE2Ms0a7jTvkXrIaT1C/2a8QLWtX8RYlLP13E7Y6n5DdnbsU4Ih8VsvorhRrR
DnSnE/dt3N2eY73/XLHio+jEDrYowt4R+oCH7O6KYbiBGqRulUIeCtQ1/pdx/Nqk
L/1+HWeSewe98QP9C/dzGVBKruFnr2aqseQQjyz8Y9AatPWti6EFoL80gcOWWYKQ
RCjQgNxzM/tUnZXD10y2AqhbZJPrllCSAQrRrFZv4edoKaOHoFUEZpoG95Xh3G4V
+wukm8zvnKpNMi3+TEpGJog7j/+ZeLkHr4tBSicwff1t8Hf/Htmd1heQdiRe6ks=
=9RMD
-----END PGP SIGNATURE-----

--8GgkxgwDoQ9JV5EqOofAEK9sJP9UBswMd--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrQA-0001S5-7v
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrQ5-0001vn-M7
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCrQ5-0001ug-C2
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45BDE47041
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:47:00 +0000 (UTC)
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
	<1495471335-23707-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49915086-e945-1ccc-2928-7de0c3c3469c@redhat.com>
Date: Mon, 22 May 2017 12:46:58 -0500
MIME-Version: 1.0
In-Reply-To: <1495471335-23707-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="671V2fn58i3l2UftHLO3dp0wFluCDI8ik"
Subject: Re: [Qemu-devel] [PATCH 1/4] qobject-input-visitor: Reject
 non-finite numbers with keyval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--671V2fn58i3l2UftHLO3dp0wFluCDI8ik
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com
Message-ID: <49915086-e945-1ccc-2928-7de0c3c3469c@redhat.com>
Subject: Re: [PATCH 1/4] qobject-input-visitor: Reject non-finite numbers with
 keyval
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
 <1495471335-23707-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:42 AM, Markus Armbruster wrote:
> The QObject input visitor can produce only finite numbers when its
> input comes out of the JSON parser, because the the JSON parser
> implements RFC 7159, which provides no syntax for infinity and NaN.
>=20
> However, it can produce infinity and NaN when its input comes out of
> keyval_parse(), because we parse with strtod() then.
>=20
> The keyval variant should not be able to express things the JSON
> variant can't.  Rejecting non-finite numbers there is the conservative
> fix.  It's also minimally invasive.

I also posted patches once (and should revive them) to add more
assertions in our code base that we aren't passing non-finite numbers to
the JSON outputter.

>=20
> We could instead extend our JSON dialect to provide for infinity and
> NaN.  Not today.
>=20
> Note that the JSON formatter can emit non-finite numbers (marked FIXME
> in commit 6e8e5cb).
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c       | 3 ++-
>  tests/test-qobject-input-visitor.c | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--671V2fn58i3l2UftHLO3dp0wFluCDI8ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyQTAAoJEKeha0olJ0NqmCoH/2D688rVw7EQJMlTWBPABZF4
LiqPXagTMlFJt6yXAwa9kBbdpGYT+uUst7WcRAsvA0zohjtiusE6kcJWEpNZQc5W
/RY+lK4XFP4l5xLJDJ83TWxoEsrDc1KUkbWL+QSmD264h9rNuf9UESviETvVa5UF
GrD9OhetFrkwgGChT1Z0ROMqDlYX61xIf/Ss/9jLnJPNhud8sBy/xvEbpsL0Crkl
b405Pmf4P/LjeyZW2f1XoOte0xXpzpGaN+2XZZy22nEzt5S7bx9NmFBQWz+bMJ43
5L+93FQU09wKRN4dNNuPNZGLhsqn7q39UmLzE7tVyLan8bNayv5AnRjLmbHlTtI=
=V3D4
-----END PGP SIGNATURE-----

--671V2fn58i3l2UftHLO3dp0wFluCDI8ik--

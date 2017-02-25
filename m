Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chfEt-0002eS-3e
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chfEq-0007NA-1t
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:30:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chfEp-0007Ly-Ou
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:30:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A85C9811D8
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 16:30:27 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-17-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79895263-30d6-ed80-7d47-d2f22dbd6c47@redhat.com>
Date: Sat, 25 Feb 2017 10:30:25 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-17-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BUd7rN52O0uuJMgHSD0wtkspnCjDRoncp"
Subject: Re: [Qemu-devel] [PATCH 16/21] test-qobject-input-visitor: Use
 strict visitor
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
--BUd7rN52O0uuJMgHSD0wtkspnCjDRoncp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <79895263-30d6-ed80-7d47-d2f22dbd6c47@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/21] test-qobject-input-visitor: Use strict
 visitor
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> The qobject input visitor comes in a strict and a non-strict variant.
> This test is the non-strict variant's last user.

Well, depending on Paolo's proposed addition.

>  Turns out it relies
> on non-strict only in test_visitor_in_null(), and just out of
> laziness.  We don't actually test the non-strict behavior.
>=20
> Clean up test_visitor_in_null(), and switch to the strict variant.
> The next commit will drop the non-strict variant.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I'm in favor of unifying the two tests into one and reducing the
duplication (this and the next patch), whether or not we decide that
Paolo's patch means we don't want to eliminate non-strict mode.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BUd7rN52O0uuJMgHSD0wtkspnCjDRoncp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsbEhAAoJEKeha0olJ0NqpW4H/iKBtyKlhZGmGbwDH19nXa1H
fzMY/rjmx1BEsdMgnYoP+GCfgobCK0aVlPoCsoEn8nqOodF2fpYe85YWa2Cz7809
E/BIrtuH/ZecTXG17Ad7F6lM6BBMo92gOOHwwDfEauAzpk4c4YUmjTifmtlb9kN4
wSKmj5rP8x194DRIowYnGta+foo5Kzg7SZW1aauwJ22/Rn7RY3iPHn4Jld7OSRuC
jg5krz6ao4rWG4Ojlw/yeTmZjftOLt7MagZcFbzyyZTe9VbPfiIDgXUI4wNic8iy
JQ/v3aljA6FizN+eKO+ze3LJiLEptvx+hqLZnKHBRBdQ5dxI3AQLKqzr52HV9xA=
=BgLq
-----END PGP SIGNATURE-----

--BUd7rN52O0uuJMgHSD0wtkspnCjDRoncp--

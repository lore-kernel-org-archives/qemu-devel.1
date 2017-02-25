Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chez3-0005Xg-OS
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chez0-0002UL-K6
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chez0-0002UA-Av
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:14:06 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 641CEC05680F
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 16:14:06 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d505c648-6f39-4dee-da74-f1409c5860c3@redhat.com>
Date: Sat, 25 Feb 2017 10:14:04 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="86HL1LOicTkvMEB9AdG5Dgq8UarjmlGRX"
Subject: Re: [Qemu-devel] [PATCH 14/21] qapi: Make string input and opts
 visitor require non-null input
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
--86HL1LOicTkvMEB9AdG5Dgq8UarjmlGRX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d505c648-6f39-4dee-da74-f1409c5860c3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/21] qapi: Make string input and opts
 visitor require non-null input
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> The string input visitor tries to cope with null input.  Null input
> isn't used anywhere, and isn't covered by tests.  Unsurprisingly, it
> doesn't fully work: start_list() crashes because it passes the input
> via parse_str() to strtoll() unchecked.
>=20
> Make string_input_visitor_new() assert its argument isn't null, and
> drop the code trying to deal with null input.
>=20
> The opts visitor crashes when you try to actually visit something with
> null input.  Make opts_visitor_new() assert its argument isn't null,
> mostly for clarity.
>=20
> qobject_input_visitor_new() already asserts its argument isn't null.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/opts-visitor.c         |  1 +
>  qapi/string-input-visitor.c | 54 ++++++++++++++-----------------------=
--------
>  2 files changed, 18 insertions(+), 37 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--86HL1LOicTkvMEB9AdG5Dgq8UarjmlGRX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsa1MAAoJEKeha0olJ0Nqbk0IAJ/aOplAxAo5jaY+X8DHLkBA
Wl0g1qN5tw9oR8xCYADxZtfuNIkKqtWZpMtAfkGd4YNfx2tZV0IMQJNv7xJ54ewa
5q1X90zAsCSgjmIWgKs584O5HYKasayi6+0eVAFOg5Nq5Xy8KTKS218Lnj/PLZlT
qHWwgB5VLaJDBjf0X/06ywS7NvswTvIWnC764kvKJhrYnGCfEwfv07EJO+1ARPIr
LeB0kTV+BBSligxv1MZXp1PICElBPItNMqu7YkTCHA/0D8Ezh9Ady24gZAt6KCZZ
sIowiGctN3bf+2qgCo2rdHjUJiUEPP9pZmjBDEOGcX/AxlnXIPNz1MvRr3K7iBE=
=ZODI
-----END PGP SIGNATURE-----

--86HL1LOicTkvMEB9AdG5Dgq8UarjmlGRX--

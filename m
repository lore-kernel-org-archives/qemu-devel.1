Received: from eggs.gnu.org ([2001:4830:134:3::10]:44021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajXD-0005np-MK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dajXA-0001kY-Uo
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:13:03 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dajXA-0001k2-Nt
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:13:00 -0400
Received: by mail-wm0-x243.google.com with SMTP id q189so12753786wmd.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:13:00 -0700 (PDT)
Date: Thu, 27 Jul 2017 15:12:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170727141257.GI10129@stefanha-x1.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-4-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20170725171014.25193-4-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/6] qemu.py: cleanup message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:10:11PM +0200, Amador Pahim wrote:
> The message contains the self._args, which has only part of the
> options used in the qemu command line and is not representative
> enough to figure out what happened to the process.
>=20
> This patch drops the self._args part of the message.
>=20
> Signed-off-by: Amador Pahim <apahim@redhat.com>
> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZefTpAAoJEJykq7OBq3PIGFMH/3RCjyRB+jc6h3tWAIDMxRH0
sWaQwvXhJJaOPjDNM4LlVIZLgln1GGp8/UzNZ1cgqcL1vhE4uCBapzgkK+d1w9Ik
2qicEmeR6cddQjzgXQ73lWqbit0p0/t/mluSqjF12ypdTaxhVRGN6m16kZSn/HuD
JCYGOPbzgjCI9/wlhAYsR1qLxLFqwYJ6K6dV58yh9AkNQ3asFgtyIC3s7lmWtqiQ
FcB0mF3cLyFFWg346z6A1UsfrQ4YooGsOP9QL06TXNwPSK1ZFFfX7HGp++WJSJ+E
JjFYzxXsXsO8mzTGvgHJ1wsuxPfj9e8k312XwfRGIaPd5zxNm3t7Af641OJWvGs=
=2Wfc
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--

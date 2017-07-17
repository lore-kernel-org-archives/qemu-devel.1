Received: from eggs.gnu.org ([2001:4830:134:3::10]:43203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX3L2-0002Y5-Lk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dX3Ky-0002rS-Kz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:33:16 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dX3Ky-0002qq-FC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:33:12 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t70so21372211wmt.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:33:12 -0700 (PDT)
Date: Mon, 17 Jul 2017 11:33:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170717103308.GI7163@stefanha-x1.localdomain>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Li7ckgedzMh1NgdW"
Content-Disposition: inline
In-Reply-To: <87o9so1hl7.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Cleber Rosa <cleber@redhat.com>


--Li7ckgedzMh1NgdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 05:28:52PM +0200, Markus Armbruster wrote:
> What can we do to improve QMP testing?  Sadly, I don't have the master
> plan ready.  I can tell people their new code needs to come with tests,
> but that won't help much unless subsystem maintainers pick up the habit,
> too.  There are a few obvious tests to write for old code, such as a
> generic test of query-like commands without arguments and without side
> effects, similar to what test-hmp.c does for HMP command info (I hope to
> get around to that one).  But for much of the old code, we don't even
> know where the test coverage holes are.
>=20
> Ideas anyone?

It makes sense for maintainers to ask that new QMP commands come with
comprehensive tests.

For me the main question is how to begin?  What is the easiest and
preferred way to write QMP command test cases?

Today the most common approach is a qtest test case that sends commands
and verifies that the expected response is returned.  This approach
works but we could benefit from a discussion about the alternatives
(e.g.  qemu-iotests style shell scripts with output diffing).

If it's easy to write tests then developers will contribute more tests.

Stefan

--Li7ckgedzMh1NgdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbJJkAAoJEJykq7OBq3PI0DgH/1MUcdaOVygDaA1mvyXn3HFr
qgKC7CsZ+8Vg0rUqAZwxNRp/oLfjg2ol2dynqpCBwsOH5W25NSsaoZym4ELZcknG
/5iA7Hu51yL0K0RHz1DZ4TS3GUFLJh6qliUfyARTQJ9TPOIXOQzeNcAzb41oXSAd
597qKEC2CU7nFrSly54B50t4c0fBjI18IzYT665YMnTDQNwnS0trjkOj1Ny+HzS8
fYAHgNhMW6XKWNSSwyWnsL0smhhZJ/c5no3cqz4e38FMZwyjh+JANLZHBcrp6fFe
gwU/VFB8x9lAFLisoZk9lNkvfdArh7FyoJEN0LtIlg+c21X46BGQ413bYK2I/38=
=R6jY
-----END PGP SIGNATURE-----

--Li7ckgedzMh1NgdW--

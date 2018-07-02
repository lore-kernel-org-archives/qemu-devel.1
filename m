Received: from eggs.gnu.org ([2001:4830:134:3::10]:57577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZuYn-0005Dj-Ox
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZuYi-0007W9-SG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:51:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fZuYi-0007VG-Jf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 04:51:44 -0400
Received: by mail-wr0-x241.google.com with SMTP id k6-v6so14657797wrp.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 01:51:43 -0700 (PDT)
Date: Mon, 2 Jul 2018 09:51:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702085140.GA32600@stefanha-x1.localdomain>
References: <20180702065237.27899-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20180702065237.27899-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] qtest: Use cpu address space instead of
 system memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 09:52:37AM +0300, Julia Suvorova via Qemu-devel wro=
te:
> Some devices (like nvic in armv7m) are not accessable through
> address_space_memory, therefore can not be tested with qtest.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  qtest.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOeecAAoJEJykq7OBq3PIpBUIAJ4y7AzZOX7qu5HGDrELaym6
Igw9Yl5UP5uLj/xD5oAdhI+3BTFxJ6+cFf1+JImNuzTLt002147JSn3pGEQMPqmw
BrJIvtJ1jjTqydrpDD2ijo0WOaOBQNRKbMUmEr+1jYTzNfq+N40HA/BpQYRk6tO+
/cnvTVBDXD4jIjMZuCBUDm/WqeROWE89xOEbxCGqNIbT/o5SOsaw/BtA3bSfTNCF
51kjYCAykK1O+Pv1p7kktfh0+ot1CqiJHOYUQMu1InXmKVtu/+SVV39aSF9QbsfF
HpEFdLOfCaiLb8Kr+w4rxpce9K/ebNgiZ99CNhwLk1p7X51fJkb1del3URdr5dQ=
=fvFq
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

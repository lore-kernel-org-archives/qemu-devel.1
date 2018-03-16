Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ewrnq-0005Gq-Tk
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ewrnl-0001Zz-Jx
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:01:58 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ewrnl-0001Zh-Ci
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:01:53 -0400
Received: by mail-wm0-x231.google.com with SMTP id t6so3958838wmt.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 09:01:53 -0700 (PDT)
Date: Fri, 16 Mar 2018 16:01:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180316160149.GD21347@stefanha-x1.localdomain>
References: <1521144392-26203-1-git-send-email-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <1521144392-26203-1-git-send-email-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] net/vde: print error on vde_open() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 11:06:32PM +0300, Julia Suvorova wrote:
> Despite the fact that now when the initialization of vde fails, qemu
> does not end silently, no informative error is printed. The patch
> generates an error and pushes it through the calling function.
>=20
> Related bug: https://bugs.launchpad.net/qemu/+bug/676029
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  net/vde.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaq+ptAAoJEJykq7OBq3PI1aAIAKxEu9YsoXWNe9DyPH8xirec
sB0pLjV3RTytDTeveet2LMSzLbZMH+1PQvO5d3Egx4t/8Qeo30LCJomzhpCV/yFl
+Rx72+UQKR0woB4BrtbNLxqDs/K3sC8J7N6+Bd7egk4wcmpUcrxs5ANLKhyBFNY3
uLebkckv4mzDNVW7PXNvx5xhgbiP3EwhlOX23qtrY/zTQqeg8U6lEcbpi2q0MbpH
9PIa9HiAkv8PkajaEySZEr0RexfMOmxWxevRpOHhH+of66f4zbWeyym1qSlrMJm8
rvzrKm6giUSUYNz/Bg/IwUnKa7eaUqJeYdUnBUWbZWqbIOZVyl54WV242HHWYoE=
=Mo9j
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC8x-0002jl-VU
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC8r-0001PK-S8
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:32:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIC8r-0001OX-KT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:32:05 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j26-v6so5729594wre.1
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 05:32:05 -0700 (PDT)
Date: Thu, 1 Nov 2018 12:32:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101123202.GQ24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-9-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-9-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 08/13] hw/gpio/nrf51_gpio: Add nRF51
 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:22PM -0400, Steffen G=F6rtz wrote:
> +/*
> + * Check if the output driver is connected to the direction switch
> + * given the current configuration and logic level.
> + * It is not differentiated between standard and "high"(-power) drive mo=
des.
> + */
> +static bool is_connected(uint32_t config, uint32_t level)
> +{
> +    bool state;
> +    uint32_t drive_config =3D extract32(config, 8, 3);
> +
> +    switch (drive_config) {
> +    case 0 ... 3:
> +        state =3D true;
> +        break;
> +    case 4 ... 5:
> +        state =3D level !=3D 0;
> +        break;
> +    case 6 ... 7:
> +        state =3D level =3D=3D 0;
> +        break;
> +    }
> +
> +    return state;
> +}

gcc (GCC) 8.2.1 20181011 doesn't know that extract32(..., 3) can only
result in values [0, 7] so it warns that state can be uninitialized.

It might be simplest to include a default case that returns false (with
a comment).

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vJCAAoJEJykq7OBq3PIMXEH/j2wfsp7oyQBkEjZgLMrX6zv
nab+X4p3LiH7OgRqaLYkKCgiqVAYxemxHBc20r89ntZ2Pe+UKGmuk0IhR6r6gO0f
wXh/0T/i71mQ2cIo+QDAWxckD7XVCerVDtFf1UcNl3Z9WgbxG/vc9PeSPJZhy9h2
pl+2+uH/WVgFUYDQXW8BEiQuMDU/yuSeE6Al8yCCaxh/29EY7EtksleeqbBdjDiN
AVS5PK+HebRsr39Qm2C3PGrRttKjTuPfC18ewH7DtDM5skqokfcr0PkhRoyJToFu
coa/ovCRcoVgZqpns4aBpwBnBla2nJOOGygJilQjU2DXwst2+in3tiUL35g6Glk=
=Ojsw
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--

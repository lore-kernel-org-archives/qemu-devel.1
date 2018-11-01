Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC9F-0002jl-Nu
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIC2q-0004i3-7v
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:25:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIC2p-0004fr-SS
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:25:52 -0400
Received: by mail-wr1-x442.google.com with SMTP id d10-v6so19905474wrs.5
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 05:25:51 -0700 (PDT)
Date: Thu, 1 Nov 2018 12:25:48 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101122548.GN24946@stefanha-x1.localdomain>
References: <20181031002526.14262-1-contrib@steffen-goertz.de>
	<20181031002526.14262-6-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+cfQkLQGU7KOA/8T"
Content-Disposition: inline
In-Reply-To: <20181031002526.14262-6-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v3 05/13] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
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


--+cfQkLQGU7KOA/8T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 08:25:19PM -0400, Steffen G=F6rtz wrote:
> +static Property nrf51_nvm_properties[] =3D {
> +    DEFINE_PROP_UINT32("code_size", NRF51NVMState, code_size, 0x100),

I'm a fan of '-' instead of '_' in qdev property names.  There are more
instances of '-' than '_', but it's up to you.

Stefan

--+cfQkLQGU7KOA/8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2vDMAAoJEJykq7OBq3PIlHYIAKTFplLM+zsxlOkEGq4Yexx+
NR2rhOpgA102JjiRxD+t0xUu4qchzeOY0OtfmkscYknWwE60FlIsRb+5iaaOU/bF
HRU7SwjIi+rzc7dQY49mod+ouXL+ko4UNapSFpBFnFpTEE6XEcHCvIZHtj+IKmzD
G55HXkOofUl1aKYyoeV0ROMcfnnJCdL5D5s0fGoxNq+OMVXW+iAFSbmepBlJ98Kv
/syMR9PDKsYx3Pf62QjHNdpuX9lcUh377OQkkwtuj8or8/ZYYZ/i69vw8ql225eY
tfZw/4bmGKBQgeian1dcYT//kxqLNiBDy9nopmE8ulA+g6iplF7/Tp5t7Q1slRA=
=zQ+h
-----END PGP SIGNATURE-----

--+cfQkLQGU7KOA/8T--

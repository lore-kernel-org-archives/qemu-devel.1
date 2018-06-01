Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOj4z-0002Ej-Cy
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOj4w-0008JJ-4u
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:49 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:46111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOj4v-0008Iw-Sh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:22:46 -0400
Received: by mail-wr0-x234.google.com with SMTP id v13-v6so24480385wrp.13
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:22:45 -0700 (PDT)
Date: Fri, 1 Jun 2018 13:22:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601122243.GN8687@stefanha-x1.localdomain>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
	<CAFEAcA_cuf4ZXcwK9+z26wFTb0L28cDuT3_xaJAFy5ijt=ZskQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_cuf4ZXcwK9+z26wFTb0L28cDuT3_xaJAFy5ijt=ZskQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 07:09:20PM +0100, Peter Maydell wrote:
> On 28 May 2018 at 15:26, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Hi,
> > I took a look at what's required for ARM Cortex M0 emulation that we
> > need for the micro:bit ARM board.  The following notes are based on
> > Appendix D3 of the ARMv6-M Architecture Reference Manual that Peter
> > Maydell recommended.
> >
> > Several people can work on this since there are many smaller tasks.
> >
> > The general approach for each task:
> > 1. Look at Appendix D3 to understand the architecture differences.
> > 2. Look at QEMU source code (mainly target/arm/translate.c) to
> > understand the current status.
>=20
> Rough guide to where things are:

Thanks for the info, that was very helpful.

Stefan

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbETqTAAoJEJykq7OBq3PIfsIH/0h5uxckwQ4wg1iviANgpDMY
/5eIMga89BGKGDSuW1UbRSZIVComWVFHcR7qJhp+uxWhXxnVb6zjeSKopMZvNUGA
0FLfJ6mflalS1Fp0hxOBjM+jyqkfNfLz5eTFTN8CuCE78s9QOk7bIMMPYNuF3Jw1
2a0EmMd49AZZF4etxj6vQH1WfeTq9wUkadJPLW/CJwfhRl+CTC2Ml4iRJ36uKAjd
hXSsmKAEq2ZW8csEOp6KGUDDAZPNoYUiBA0HtYAtzAlaGWDuwe90rMcjb1eYlrnl
wHTDhu7LXDMcn18PL0OpWXzdFMRzgojsjGkMIwjh4VOTRLjScrKdqvzdpFXH8/A=
=TT44
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--

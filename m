Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIA4n-0000H1-6r
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gIA4i-0000fM-7d
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:19:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gIA4g-0000bR-Ka
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:19:38 -0400
Received: by mail-wm1-x341.google.com with SMTP id s10-v6so909107wmc.5
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 03:19:29 -0700 (PDT)
Date: Thu, 1 Nov 2018 10:19:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181101101925.GI24946@stefanha-x1.localdomain>
References: <20181025005052.27661-1-jusual@mail.ru>
	<CAFEAcA-oZ86C99T8Yutu8L1EsnqM1vNvEK+tEfV7Haw+O5A=7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-oZ86C99T8Yutu8L1EsnqM1vNvEK+tEfV7Haw+O5A=7A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] arm: Add nRF51 SoC UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2018 at 02:37:42PM +0000, Peter Maydell wrote:
> On 25 October 2018 at 01:50, Julia Suvorova <jusual@mail.ru> wrote:
> > This series adds support for the nRF51 SoC UART, that used in
> > BBC Micro:bit board, and QTest for it.
> >
> > v3:
> >     * serial_hd() moved to the board code
> >     * sysbus_init_child_obj() used for initialization
> >     * qemu_chr_fe_accept_input() called after byte popping
> >
> > v2:
> >     * Suspend/Enable functionality added
> >     * Connection to SoC moved to a separate patch
> >     * Added QTest for checking reception functionality
> >     * Mini-kernel test changed to fit current implementation
> >     * Addressed review comments on R_*, uart_can_receive, VMState,
> >       uart_transmit
> >
> > Julia Suvorova (3):
> >   hw/char: Implement nRF51 SoC UART
> >   hw/arm/nrf51_soc: Connect UART to nRF51 SoC
> >   tests/boot-serial-test: Add microbit board testcase
>=20
> Applied to target-arm.next, thanks.
>=20
> What's the current status of the 'microbit' board with these
> patches? Are we missing anything important? Can we run any
> interesting guest programs?

qemu.git/master can't run interesting programs yet.  Missing:

 * Steffen G=F6rtz's patches (rng, timer, uicr, ficr)
 * Julia's serial qtest (this is a prerequisite for the next item)
 * My -kernel vs -device loader fix (currently qemu.git/master is broken
   and cannot load any kernel at all!)

But we're getting there step by step :).

Stefan

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb2tMtAAoJEJykq7OBq3PI6BQH/RITfmUrRCKbpXb6e82Icxx+
BKUnDvbs8+T3G+W85xY9ysFrgC3Cc/+yqB0x7JyJYr+l2Ld3t+uGetFbLgmi477p
vbtJsBF/ya6G5j+KwMgEgxUolsd2DjPS4r1go4zMTIKZ6kfJDJsf1fPGwDuoVfH+
D4foi9LibnU1efj9q+KJKli55ALQ5h0UvzzeubwNL/v2j8sQRrzfNTT6AS95HoBQ
R4Bzi6lj4jwJhV7eZQIR7SygdPgv8oSrXzQkAjwgbWE+Pj0m9swxbxjIduXCUJlu
UDg5fRyolVXJj2gY8Ks7n9kFPOW231HrMbZd8AiSd8wMPUn1ojhCp+MUSB7UmAY=
=rlcM
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--

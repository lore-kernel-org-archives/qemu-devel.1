Received: from eggs.gnu.org ([2001:4830:134:3::10]:35529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkD3h-0005nQ-4H
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkD3g-0006ef-C0
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:38:17 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkD3g-0006eD-6H
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:38:16 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so23110951oib.9
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:38:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9d7f6a73-a00f-ebc1-efb3-18367e3c0f32@amsat.org>
References: <eb8233618cf64aa21c87e2809933f112a7aedf68.1532735306.git.alistair.francis@wdc.com>
	<9d7f6a73-a00f-ebc1-efb3-18367e3c0f32@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 19:37:55 +0100
Message-ID: <CAFEAcA_nr=hS4Qe=n-=HU389S5cvZArt97QJ83jLQ-x2xRKFWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] configure: Add RISC-V host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 30 July 2018 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Before this patch:
>
> $ ./configure
>
> ERROR: Unsupported CPU =3D riscv64, try --enable-tcg-interpreter
>
> $ ./configure --enable-tcg-interpreter
> Unsupported CPU =3D riscv64, will use TCG with TCI (experimental)
>
> [...]
>
> WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!


> It is unlikely the RISC-V port goes away in the next future releases :)

...but it is not supported as a *host* CPU.

We should fix this somewhat nonsensical error message by
completing the deprecate-and-drop cycle for this bit of
configure, ie by outright rejecting attempts to build on
host CPU types we don't recognize and support, the same
way we do with unrecognized host OS types.

thanks
-- PMM

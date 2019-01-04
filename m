Received: from eggs.gnu.org ([208.118.235.92]:50113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gfR0E-0006eE-Ev
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gfR09-0001dT-Fa
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:03:14 -0500
Received: from mail-eopbgr790092.outbound.protection.outlook.com
	([40.107.79.92]:16696
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gfR09-0001bk-5s
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:03:09 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 4 Jan 2019 15:03:05 +0000
Message-ID: <BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20190101182745.GA17022@sx9>
In-Reply-To: <20190101182745.GA17022@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/tcg/mips: Test R5900
 three-operand MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Tuesday, January 1, 2019 7:27 PM
> To: Aleksandar Markovic
> Cc: Aurelien Jarno; Philippe Mathieu-Daud=E9; J=FCrgen Urban; Maciej W. R=
ozycki;
> qemu-devel@nongnu.org
> Subject: Re: [PATCH v2 09/12] tests/tcg/mips: Test R5900 three-operand MA=
DDU1
>=20
> Thanks Aleksandar!
>=20
> > > From: Fredrik Noring <noring@nocrew.org>
> > > Subject: [PATCH v2 09/12] tests/tcg/mips: Test R5900 three-operand MA=
DDU1
> >
> > Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > This patch is selected for integration in the next MIPS pull request sc=
heduled shortly.
> >
> > THANKS FOR ALL EFFORTS!
>=20
> Is this a preparation to revert commit 823f2897bdd7 ("target/mips: Disabl=
e
> R5900 support")?
>=20
> Fredrik

Hello!

Glad to see you back!

Yes, one can say this is a step towards reenabling R5900 support.

However, this is not the only step. I will let you know about all
needed details in near future - and I apologize for being little
slow with responses so far, I was being swamped with other tasks.

Let's not rush. If one learned that the rush is bad, that is me,
making severe missteps, overly eager to do the thing sooner rather
than later. However, the faster in not always the better.

At this moment I have a question a suggestion for you:

- Question: Do you have somewhere link to n32 R5900 toolchain, or
similar thing that would enable me to test R5900's n32 in QEMU
(I'll do the tweaks in QEMU by myself for that, but I need a way
to compile R5900 test programs for n32)?

- Suggestion: The next MIPS pull request is scehuled for Friday,
Jan 18, 2018. It would be fantastic if you could prepare the
following by Jan 14:

  * Add 32 TCGv_i64 registers that would represent higher halves
  of R5900 general purpose registers.
  * Add TCGv_i32 register SA (shift amount).
  * Perhaps consider adding higher halves of registers HI an LO
  independently on HI/LO array used by DSP.
  * It is customary to implement R/W access while introducing
  such registers:
    * Implement R/W access instructions to higher halves of
    R5900 GPRs:
      * LQ
      * SQ
    * Implement R/W access instructions to SA register:
      * MFSA
      * MTSA
      * MTSAH
      * MTSAB

I think a reasonable person would consider that the number and
size of registers of emulated CPU is a fundamental thing that
must be done before enabling its support - hence my suggestion
above.

If you don't have enough time resources before Jan 14, that is
fine too, do everything at your own pace.

My vision is that we continue step by step amending R5900 until
we reach a decent and stable state of emulation and than enable
the R5900 support for end user. (I'll provide all the details
later on.)

Let me know if you have questions and/or different opinion.

Looking forward to seeing you!

Aleksandar

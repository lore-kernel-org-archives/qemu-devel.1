Received: from eggs.gnu.org ([2001:4830:134:3::10]:48100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuHSr-0005Zs-U7
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuHSk-0000C2-A4
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:21:50 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com
	([104.47.37.113]:22221
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuHSj-0000BM-Nu
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:21:46 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 27 Aug 2018 13:21:40 +0000
Message-ID: <BN7PR08MB486809299DE00E37CA2091F0C60B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <cover.1535133088.git.jancraig@amazon.com>
	<f1e92127959ffb3df713a06452328a71170bda93.1535133089.git.jancraig@amazon.com>
	<231c38e4-8ad4-0f73-69ab-7a66d20716d3@linaro.org>,
	<0ba3173789a84b53be491b580eb30d77@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <0ba3173789a84b53be491b580eb30d77@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/7] target/mips: Add MXU instructions
 S32I2M and S32M2I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Petar Jovanovic <pjovanovic@wavecomp.com>

> Craig Janeczek via Qemu-devel wrote:
>
> I also wrote a series of tests which I cross compiled then ran on
> both HW and through QEMU. Although I did not submit those tests
> as part of this patchset as I am unsure of how to add them into the=20
> QEMU test infrastructure.

Alex,

Here we have another case of someone having - and wanting to add to QEMU - =
some MIPS tests.

I gather they are very similar to the tests in:

tests/tcg/mips/mips32-dsp, and
tests/tcg/mips/mips32-dspr2.

However, you say something is wrong with them (but we are using them for te=
stings of DSP and DSP R2 ASE for MIPS CPUs that have such feature).

Can you please tell us:

- What should we do to existing DSP and DSP R2 to fit into QEMU test infras=
tructure?=20

- What would be the guidance for Craig to integrate new tests that he wrote=
 into QEMU (which are I suppose of similar nature to DSP tests)?

Many thanks!

Aleksandar

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqHPT-0004ud-Ku
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqHPQ-0006a9-SL
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:57:35 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:43362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqHPQ-0006ZX-J6
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 06:57:32 -0500
Received: by mail-oi0-x22f.google.com with SMTP id a207so10396953oii.10
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 03:57:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180226104723.GH14196@redhat.com>
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<20180223101032.GA31076@redhat.com>
	<CAHNT7NvMMAD6sAT60RnLgFXwdFPWHEXtysMQt04Qejnpw30Bkg@mail.gmail.com>
	<20180226104723.GH14196@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2018 11:57:10 +0000
Message-ID: <CAFEAcA_Gwh3EpVVhZ_zU3LuogZXjh8cpRWrvtHbNdfgQmdzgJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 26 February 2018 at 10:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I accept that MIT is compatible with GPLv2+, so that's not an immediate l=
egal
> problem. The issue is that as we add more & more different licenses to QE=
MU,
> it becomes a maintenance burden to developers, especially when doing code
> refactoring across files. You have to be careful you're not taking a piec=
e
> of GPLv2+ code and copying/moving it into a file that's MIT licensed, as
> that would be non-compliant. We already suffer this problem with our mixt=
ure
> of GPLv2-only and GPLv2+ and LGPLv2+ and BSD licensed code. So I'm person=
ally
> loathe to see us add yet another license to the mix.

Unless I'm confused, we already have a lot of MIT-licensed code in the tree=
,
including much of the block layer, accel/tcg, the audio subsystem. Looking
at vl.c, it was put under the MIT license by Fabrice in 2003, so we've
been living with it as part of our licensing mix for a very long time alrea=
dy.

thanks
-- PMM

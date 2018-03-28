Received: from eggs.gnu.org ([2001:4830:134:3::10]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10nQ-00077W-Lz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10nP-00052v-PP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:26:40 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f10nP-00052l-JY
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:26:39 -0400
Received: by mail-pf0-x243.google.com with SMTP id g14so412316pfh.3
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:26:39 -0700 (PDT)
References: <1522180487-22899-1-git-send-email-mjc@sifive.com>
	<1522180487-22899-2-git-send-email-mjc@sifive.com>
	<0b20ff75-00d7-80db-ed2a-8b644a57b415@amsat.org>
	<CAHNT7Nt40C8Bh3VJHjv8f+obSbU6Ki8ThXH2L7o4zoSM2LnK5A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2bb7c25b-237b-4225-319c-90f14f3c560d@linaro.org>
Date: Wed, 28 Mar 2018 10:26:30 +0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nt40C8Bh3VJHjv8f+obSbU6Ki8ThXH2L7o4zoSM2LnK5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] RISC-V: Workaround for critical
 mstatus.FS MTTCG bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>

On 03/28/2018 08:15 AM, Michael Clark wrote:
> On looking at this again, I think we may need to remove
> the qemu_tcg_mttcg_enabled conditional and always return dirty if the state is
> initial or clean, but not off.

Yes.

> While testing on uniprocessor worked okay, it's likely because we were lucky
> and there was no task migration or multiple FPU tasks working.

Also yes.

>     > +        if (qemu_tcg_mttcg_enabled()) {
>     > +            /* FP is always dirty or off */
>     > +            if (mstatus & MSTATUS_FS) {
>     > +                mstatus |= MSTATUS_FS;
>     > +            }
>     > +        }

I've just posted an alternate patch set to track MSTATUS_FS more exactly, but
if that's thought to be too much this late in the cycle, then I'll sign off on
this patch without the mttcg test.


r~

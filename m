Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAeZ5-0000yy-7B
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAeZ4-0001aN-5n
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:11:27 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:56142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAeZ3-0001Zs-UT
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:11:26 -0400
Received: by mail-wm0-x22b.google.com with SMTP id y83so2563423wmc.4
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 09:11:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 16:11:03 +0000
Message-ID: <CAFEAcA94At9aJ9q_ub3_CNpF+cMUbadPPafuxnE6Fi6Q2UOu5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 6 October 2017 at 18:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> Running the test program
> http://people.linaro.org/~peter.maydell/thumb-over-page
> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
> in the usermode emulator:
>  ./build/x86/arm-linux-user/qemu-arm ~/linaro/qemu-misc-tests/thumb-over-page
>
> results in an assertion failure:
> write_insns1: T32 insn crossing page boundary
> Calling into buffer at 0x6fff9
> qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169:
> tb_lock: Assertion `!have_tb_lock' failed.
> qemu-arm: /home/petmay01/linaro/qemu-from-laptop/qemu/accel/tcg/translate-all.c:169:
> tb_lock: Assertion `!have_tb_lock' failed.
> Segmentation fault (core dumped)
>
> It ought to exit successfully:
> write_insns1: T32 insn crossing page boundary
> Calling into buffer at 0x6fff9
> got sig 11
> fault pc 0x6fffe r0 0x1
> e104462:xenial:qemu$

Ping! This still asserts -- what's our plan for fixing it?

thanks
-- PMM

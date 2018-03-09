Received: from eggs.gnu.org ([2001:4830:134:3::10]:40280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFWP-0004YC-JW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFWO-0002xo-E1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:45:09 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euFWO-0002xV-8j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:45:08 -0500
Received: by mail-oi0-x243.google.com with SMTP id g5so6644072oiy.8
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 02:45:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 10:44:47 +0000
Message-ID: <CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
> I need to dig into this. I'll need to take the assertions out, or run with
> tracing to see which fcvt test is triggering this unreachable piece of
> code. FYI. I can look into it.

> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_int_and_pack:
> code should not be reached
> qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEMU}
> -nographic -machine spike_v1.10 -kernel $i

This looks like maybe it's the issue Richard Jones sent a patch for ?
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html

thanks
-- PMM

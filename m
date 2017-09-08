Received: from eggs.gnu.org ([2001:4830:134:3::10]:47696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqFGI-0000Op-Vj
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqFGE-0008IX-BD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:07:42 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:44952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqFGE-0008Gz-4X
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:07:38 -0400
Received: by mail-wm0-x236.google.com with SMTP id 137so4525109wmj.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 02:07:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59B249C7.2000400@ispras.ru>
References: <59B17425.1050701@ispras.ru>
	<CAFEAcA-QP7J_Rjre_RmwuYFnBU84gPFXuH4efeSddwgXhgq5Vg@mail.gmail.com>
	<59B249C7.2000400@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 10:07:16 +0100
Message-ID: <CAFEAcA_WHLYsC6Ft4U90kU0YbqhuQNVSD_9Jxsp5EETHPT-1vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] emulation cycle number implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 September 2017 at 08:41, Sergey Smolov <smolov@ispras.ru> wrote:
> But what if I like to track guest hardware cycles? I run the same program on
> QEMU and RTL model of MIPS microprocessor, and I want to compare simulation
> traces. I expect, that emulation will start from 0 tick in both cases, at
> least.

Broadly, you can't, because QEMU is not a cycle accurate emulator.
(For 21st century CPUs, cycle accurate emulation that isn't just
"run the RTL" is pretty near to impossible for practical purposes
anyway.) If you're using QEMU's icount mode then cpu_get_ticks()
will I think get you number of instructions executed; that's as
good as you're going to get, I'm afraid.

Last time I wanted to do comparison of simulation traces I just
compared the sequence of instructions executed, without worrying
about trying to compare against the other simulation's notional
clock cycle count as well.

thanks
-- PMM

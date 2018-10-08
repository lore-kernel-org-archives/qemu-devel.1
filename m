Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9dPm-0006bV-KK
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9dPj-0000Cy-Cj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9dPi-0000BD-VZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:50:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id c25-v6so8650917pfe.6
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:50:06 -0700 (PDT)
References: <20181007205153.GA30270@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84760c9e-995b-8def-6a34-0e6e4ec39d95@linaro.org>
Date: Mon, 8 Oct 2018 14:50:02 -0700
MIME-Version: 1.0
In-Reply-To: <20181007205153.GA30270@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-system-hppa: Raise exception 26 on
 emulated hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 10/7/18 1:51 PM, Helge Deller wrote:
> On PCXS chips (PA7000, pa 1.1a), trap #18 is raised on memory faults,
> while all later chips (>= PA7100) generate either trap #26, #27 or #28
> (depending on the fault type).
> 
> Since the current qemu emulation emulates a B160L machine (with a
> PA7300LC PCX-L2 chip, we should raise trap #26 (EXCP_DMAR) instead of
> #18 (EXCP_DMP) on access faults by the Linux kernel to page zero.
> 
> With the patch we now get the correct output (I tested against real
> hardware):
>  Kernel Fault: Code=26 (Data memory access rights trap) (Addr=00000004)
> instead of:
>  Kernel Fault: Code=18 (Data memory protection/unaligned access trap) (Addr=00000004)
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Queued, thanks.


r~

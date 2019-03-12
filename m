Received: from eggs.gnu.org ([209.51.188.92]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y6B-0007Nl-5J
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3Y5Q-0008Dn-Bz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:28:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3Y5P-0008Cp-SJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:28:16 -0400
Received: by mail-pg1-x543.google.com with SMTP id 125so694957pgc.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:28:15 -0700 (PDT)
References: <20190311191602.25796-1-svens@stackframe.org>
	<20190311191602.25796-12-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60efee59-c608-d796-884a-c9cb1ff9a98c@linaro.org>
Date: Mon, 11 Mar 2019 20:28:12 -0700
MIME-Version: 1.0
In-Reply-To: <20190311191602.25796-12-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/11] target/hppa: call eval_interrupt()
 after ssm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 3/11/19 12:16 PM, Sven Schnelle wrote:
> HP-UX (all versions) is losing timer interrupts, which leads to
> hangs. Pressing a key on the console fixes this, so it looks like
> QEMU is just looping trough TBs without checking for interrupts.
> Further investion showed that this happens when interrupts are
> triggered, without PSW_I enabled. Calling eval_interrupt() after
> PSW_I is set seems to fix this.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  target/hppa/cpu.h        | 1 +
>  target/hppa/int_helper.c | 2 +-
>  target/hppa/op_helper.c  | 6 ++++++
>  3 files changed, 8 insertions(+), 1 deletion(-)

The correct fix is to exit to the main loop.


r~

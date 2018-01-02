Received: from eggs.gnu.org ([2001:4830:134:3::10]:54469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP9Y-0002AI-Tb
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWP9X-0004Lk-W3
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:11:00 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWP9X-0004LS-Pk
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:10:59 -0500
Received: by mail-pf0-x242.google.com with SMTP id e3so25801133pfi.10
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:10:59 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-6-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec748459-b9d7-b485-ffd0-11266d229c14@linaro.org>
Date: Tue, 2 Jan 2018 08:10:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/17] target/m68k: add CPU_LOG_INT trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> Display the interrupts/exceptions information
> in QEMU logs (-d int)
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    if (qemu_loglevel_mask(CPU_LOG_INT)) {
> +        static int count;
> +        qemu_log("INT %6d: %s(%#x) pc=%08x sp=%08x sr=%04x\n",
> +                 ++count, m68k_exception_name(cs->exception_index),
> +                 vector, env->pc, env->aregs[7], env->sr);
> +    }
> +
>      fmt |= 0x40000000;
>      fmt |= vector << 16;
>      fmt |= env->sr;

Just so long as you're aware that you're printing the SR without CCR here...


r~

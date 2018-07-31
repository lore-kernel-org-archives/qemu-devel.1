Received: from eggs.gnu.org ([2001:4830:134:3::10]:40318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaWM-0007Nq-JJ
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkaWJ-0008Ox-Bk
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:41:26 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:40913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkaWJ-0008Og-6B
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 15:41:23 -0400
Received: by mail-vk0-x243.google.com with SMTP id q184-v6so4870045vke.7
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 12:41:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-44-git-send-email-aleksandar.markovic@rt-rk.com>
	<3205b1ca-8e79-e040-6ed5-494e1895f99b@linaro.org>
Message-ID: <3d969928-7306-bd2d-564c-d9b5c22fd37a@linaro.org>
Date: Tue, 31 Jul 2018 15:41:18 -0400
MIME-Version: 1.0
In-Reply-To: <3205b1ca-8e79-e040-6ed5-494e1895f99b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 43/76] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/31/2018 02:58 PM, Richard Henderson wrote:
> On 07/30/2018 12:12 PM, Aleksandar Markovic wrote:
>> +        switch (extract32(ctx->opcode, 12, 1)) {
>> +        case 0:
>> +            /* NM_SHRA_QB */
>> +            check_dspr2(ctx);
>> +            gen_helper_shra_qb(cpu_gpr[ret], t0, v1_t);
> More unprotected use of cpu_gpr[0].
> 
> I think you need some sort of solution that prevents this completely, without
> having to think about it.  E.g. global replace cpu_gpr[x] -> read_gpr(ctx, x) /
> dest_gpr(ctx, x), where the two functions allocate tcg temporaries on demand.

I forgot to say... and then poison cpu_gpr so that uses cannot creep back into
the codebase.  See e.g. include/exec/poison.h.


r~

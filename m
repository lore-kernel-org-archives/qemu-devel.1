Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9yvt-0002YS-E5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9yvo-0005bh-Gs
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:48:45 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9yvo-0005aj-1I
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:48:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id u12-v6so1431510pfn.12
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 13:48:39 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-2-cota@braap.org>
	<CAFEAcA8DyV6_BfRZT2_9K1PKNkPnLqw8e=55uJ3R1r5+ejkRFw@mail.gmail.com>
	<20181009182053.GA28943@flamenco>
	<CAFEAcA_2DfNTmhhs5p6zeQ6ZODuFryNK05-VnOV_NTZ1LOQQMA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <87deab9a-4feb-b39d-12ff-c97dac223918@linaro.org>
Date: Tue, 9 Oct 2018 13:48:35 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2DfNTmhhs5p6zeQ6ZODuFryNK05-VnOV_NTZ1LOQQMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] target/alpha: remove tlb_flush from
 alpha_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/9/18 11:25 AM, Peter Maydell wrote:
>>         /* PALBR */
>>         tcg_gen_st_i64(vb, cpu_env, offsetof(CPUAlphaState, palbr));
>>         /* Changing the PAL base register implies un-chaining all of the TBs
>>            that ended with a CALL_PAL.  Since the base register usually only
>>            changes during boot, flushing everything works well.  */
>>         gen_helper_tb_flush(cpu_env);
>>         return DISAS_PC_STALE;
> 
> Mmm, it works (though would it work if the CPU wasn't the
> only one in the system?). I just have a reflexive dislike
> of design approaches used by only one thing -- I tend to
> like to smooth them out so there's more consistency...

It could be less important now that we have goto_ptr.
If you really think I should get rid of it, I will.


r~

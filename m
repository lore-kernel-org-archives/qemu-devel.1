Received: from eggs.gnu.org ([209.51.188.92]:39784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyi1Y-0007gY-Df
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhpl-0008JW-R3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:52:06 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyhpl-0008IA-J1
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:52:05 -0500
Received: by mail-pf1-x442.google.com with SMTP id i20so6666437pfo.6
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:52:05 -0800 (PST)
References: <20190220235017.1060-1-richard.henderson@linaro.org>
	<20190220235017.1060-3-richard.henderson@linaro.org>
	<CAFEAcA_e4aGCi=uYe-Jy5GG7-VuxbRMagiTqT_mfFBS3c4SCpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e8a6ca6-c041-cbc3-c8d4-ad68bc329036@linaro.org>
Date: Tue, 26 Feb 2019 10:52:01 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_e4aGCi=uYe-Jy5GG7-VuxbRMagiTqT_mfFBS3c4SCpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Implement ARMv8.0-PredRes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/26/19 10:44 AM, Peter Maydell wrote:
> On Wed, 20 Feb 2019 at 23:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is named "Execution and Data prediction restriction instructions"
>> within the ARMv8.5 manual, and given the name "PredRes" by binutils.
> 
> The official name is v8.0-PredInv.
> (You can see this used in the xml descriptions for the new insns, eg:
> https://developer.arm.com/docs/ddi0595/b/aarch64-system-instructions/cfp-rctx )

Thanks.  I may file a bug against binutils.  ;-)

>> +
>> +    /* All v8.0-a cpus support aarch64.  */
> 
> True, but why is it relevant here ?
> 
>> +    if (cpu_isar_feature(aa64_specres, cpu)) {
>> +        define_arm_cp_regs(cpu, specres_reginfo);
>> +    }

The context, I think, is that we're in a function that handles a32,
and I am not checking arm_feature(cpu, ARM_FEATURE_AARCH64) before
checking cpu_isar_feature(aa64_specres, cpu).

At least that's my recollection.


r~

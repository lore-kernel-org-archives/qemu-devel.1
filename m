Received: from eggs.gnu.org ([2001:4830:134:3::10]:41120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fqNUM-0007me-01
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:59:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fqNUG-0007er-J7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:59:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36595)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fqNUG-0007eQ-A3
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:59:12 -0400
References: <20180811082328.11268-1-laurent@vivier.eu>
	<7195617a-1f47-00e1-638f-50d20c21ba9e@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7cd759fa-8d2b-f63b-3bd9-75fe528373a8@vivier.eu>
Date: Thu, 16 Aug 2018 20:58:17 +0200
MIME-Version: 1.0
In-Reply-To: <7195617a-1f47-00e1-638f-50d20c21ba9e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Riku Voipio <riku.voipio@iki.fi>

Le 11/08/2018 à 17:26, Richard Henderson a écrit :
> On 08/11/2018 01:23 AM, Laurent Vivier wrote:
>> This fixes java in a linux-user chroot:
>>   $ java --version
>>   qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion `use_icount' failed.
>>   qemu: uncaught target signal 6 (Aborted) - core dumped
>>   Aborted (core dumped)
>>
>> In gen_conditional_jump() in the GUSA_EXCLUSIVE part, we must reset
>> base.is_jmp to DISAS_NEXT after the gen_goto_tb() as it is done in
>> gen_delayed_conditional_jump() after the gen_jump().
>>
>> Bug: https://bugs.launchpad.net/qemu/+bug/1768246
>> Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
>>        ("target/sh4: Convert to DisasJumpType")
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>
>> Notes:
>>     v2:
>>       don't revert the part of the original patch,
>>       but fixes the state problem in gen_conditional_jump()
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Aurélien,

do you agree if I push this patch through a linux-user pull request?

Thanks,
Laurent

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEuAW-00083P-Ox
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEuAT-00070T-NM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:39:40 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEuAT-0006zG-Go
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:39:37 -0500
Received: by mail-wm0-x235.google.com with SMTP id z3so1637827wme.3
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 01:39:37 -0800 (PST)
References: <20171114094203.28030-1-richard.henderson@linaro.org>
	<87inecallt.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c42d0659-4ffd-5e9c-270e-61b61bf3efbd@linaro.org>
Date: Wed, 15 Nov 2017 10:39:32 +0100
MIME-Version: 1.0
In-Reply-To: <87inecallt.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Record code_gen_buffer address for
 user-only memory helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 11/14/2017 05:09 PM, Alex Bennée wrote:
>> -    /* Now we have a real cpu fault.  Since this is the exact location of
>> -     * the exception, we must undo the adjustment done by cpu_restore_state
>> -     * for handling call return addresses.  */
>> -    cpu_restore_state(cpu, pc + GETPC_ADJ);
>> +    /* Now we have a real cpu fault.  */
>> +    cpu_restore_state(cpu, pc);
> 
> I can't help thinking when we get it wrong we should be doing something
> here, maybe a LOG_UNIMP? Otherwise we silently fail or at least the
> user-space falls off a cliff later.

Oh we silently get it wrong in so many ways.  E.g. zero callers of
cpu_restore_state_from_tb check its return status.  Anyway, I think this sort
of cleanup has to wait til next cycle.


r~

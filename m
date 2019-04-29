Received: from eggs.gnu.org ([209.51.188.92]:57614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL857-0002bW-W6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL857-0001dm-5P
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:37 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL855-0001Vb-HL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:20:36 -0400
Received: by mail-pg1-x543.google.com with SMTP id l18so5307130pgj.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:20:32 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-29-richard.henderson@linaro.org>
	<CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
Date: Mon, 29 Apr 2019 08:20:16 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 28/36] target/xtensa: Use
 env_cpu, env_archcpu
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

On 4/29/19 7:36 AM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 23:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> @@ -712,10 +707,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
>>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
>>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
>>
>> +typedef CPUXtensaState CPUArchState;
>> +typedef XtensaCPU ArchCPU;
>> +
>> +#include "exec/cpu-all.h"
> 
> Shouldn't this bit be in an earlier patch ?

The diff is just funny here.

As with cris, it's really moving the following function below
exec/cpu-all.h, so that env_archcpu is defined.


r~

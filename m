Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxy-0002nY-OY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxv-00011l-LL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:49:22 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhfxv-00011O-Gj
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 13:49:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id q66so1338691qki.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 10:49:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815145714.17635-1-richard.henderson@linaro.org>
	<20170815145714.17635-4-richard.henderson@linaro.org>
	<c30ad9c1-bd1c-0fdf-085e-2449d9034dd6@amsat.org>
	<8846d546-5dc3-4d71-ff57-f1978ae91528@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a411caa-d9f9-93df-6223-41c1d9b952d1@amsat.org>
Date: Tue, 15 Aug 2017 14:49:14 -0300
MIME-Version: 1.0
In-Reply-To: <8846d546-5dc3-4d71-ff57-f1978ae91528@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/3] target/arm: Require
 alignment for load exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair.francis@xilinx.com

On 08/15/2017 01:32 PM, Richard Henderson wrote:
> On 08/15/2017 08:56 AM, Philippe Mathieu-Daudé wrote:
>>> @@ -1885,7 +1886,7 @@ static void gen_load_exclusive(DisasContext *s, int rt,
>>> int rt2,
>>>                tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
>>>            }
>>>        } else {
>>> -        memop |= size;
>>> +        memop |= size | MO_ALIGN;
>>
>> MO_ALIGN_8 here too?
>>
>>>            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
>>>            tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
> 
> Peter already pointed out that MO_ALIGN_N should be reserved for those cases
> where an explicit size really needed.  You should note that using MO_ALIGN_8
> would be actively wrong here -- it would incorrectly require 8 byte alignment
> for the single byte access of LDXRB.

Indeed I didn't think of that, thanks!

> 
> 
> r~
> 

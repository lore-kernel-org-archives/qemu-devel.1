Received: from eggs.gnu.org ([209.51.188.92]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkcA4-0001u5-M7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkcA2-0005z5-P3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:58:48 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkcA0-0005uR-TH
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:58:46 -0500
Received: by mail-pg1-x542.google.com with SMTP id n2so6676276pgm.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:58:44 -0800 (PST)
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
	<20181211151945.29137-15-aaron@os.amperecomputing.com>
	<8683c2c4-0111-492c-c6f9-1b2dcc937405@linaro.org>
	<20190118214052.GD5213@quinoa.localdomain>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7df09386-0581-5e21-2dab-588662b0e89b@linaro.org>
Date: Sat, 19 Jan 2019 08:58:36 +1100
MIME-Version: 1.0
In-Reply-To: <20190118214052.GD5213@quinoa.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 14/14] target/arm: Send interrupts on
 PMU counter overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <alindsay@codeaurora.org>

On 1/19/19 8:40 AM, Aaron Lindsay wrote:
> In practice, I think only the 32nd bit would ever need to be cleared,
> but I agree it is more correct to clear them all.
> 
>> Given that it is architecturally defined to 32-bits, I think you could really
>> just drop the define and use
>>
>>     uint32_t new_pmevcntr = ...;
>>     if (env->cp15.c14_pmevcntr[counter] & ~new_pmevcntr & INT32_MIN)
>>
>> with equal clarity.
> 
> I don't know whether it is important for the resolution of this patch,
> but what did you mean by the following?:
> 
>> The type of new_pmevcntr means you don't have to clear any
>> high bits either.

If you use uint32_t, then no *explicit* clearing of the high bits is necessary,
and is implied by the assignment back to env->cp15.c14_pmevcntr[counter].


r~

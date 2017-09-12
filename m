Received: from eggs.gnu.org ([2001:4830:134:3::10]:51846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drlcR-0000Ug-PV
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drlcO-0005gi-Nx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:52:51 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1drlcO-0005gR-Hc
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:52:48 -0400
Received: by mail-pg0-x22d.google.com with SMTP id u18so4771181pgo.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:52:48 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-9-richard.henderson@linaro.org>
	<87377xijkt.fsf@linaro.org> <871snhibdr.fsf@linaro.org>
	<889b3e05-64f6-8eb6-0c22-87b09b86b7b8@linaro.org>
	<877ex5bo31.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54b956b7-0fbc-a71e-2dd3-38f77abd4aa5@linaro.org>
Date: Tue, 12 Sep 2017 06:52:44 -0700
MIME-Version: 1.0
In-Reply-To: <877ex5bo31.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/8] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 09/11/2017 02:07 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 09/08/2017 06:10 AM, Alex Bennée wrote:
>>> Also this commit breaks RISU:
>>>
>>>  qemu-aarch64 build/aarch64-linux-gnu/risu
>>>     testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin \
>>>     -t testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin.trace
>>>
>>> Gives:
>>>
>>> mismatch detail (master : apprentice):
>>>   V29   : 000000000000000005388083c1444242 vs 00000000000000002a000e0416a30018
>>>
>>> The insn is:
>>>
>>>   37c:       6f56a29d        umull2  v29.4s, v20.8h, v6.h[1]
>>>
>>> Which is odd because I didn't think we'd touched that.
>>
>> Indeed we didn't.  Still, I'll check it out next week.
> 
> OK it would help if I had objdumped the right file:
> 
>      36c:       0e781fdd        bic     v29.8b, v30.8b, v24.8b
>      370:       00005af0        .inst   0x00005af0 ; undefined

Thanks.  The sse pandn operand order is ... surprising.
Even though I know that I still managed to get it wrong.
Fixed for v2.


r~

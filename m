Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drKgx-0006ju-V1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1drKgo-0001G0-Jx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:07:39 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1drKgo-0001Eh-DF
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:07:34 -0400
Received: by mail-wr0-x231.google.com with SMTP id o42so13106619wrb.3
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 02:07:33 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-9-richard.henderson@linaro.org>
	<87377xijkt.fsf@linaro.org> <871snhibdr.fsf@linaro.org>
	<889b3e05-64f6-8eb6-0c22-87b09b86b7b8@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <889b3e05-64f6-8eb6-0c22-87b09b86b7b8@linaro.org>
Date: Mon, 11 Sep 2017 10:07:30 +0100
Message-ID: <877ex5bo31.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 09/08/2017 06:10 AM, Alex Bennée wrote:
>> Also this commit breaks RISU:
>>
>>  qemu-aarch64 build/aarch64-linux-gnu/risu
>>     testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin \
>>     -t testcases.aarch64/insn_ANDSi_RES8_ANDS_RES_ANDv_ASRV__INC.risu.bin.trace
>>
>> Gives:
>>
>> mismatch detail (master : apprentice):
>>   V29   : 000000000000000005388083c1444242 vs 00000000000000002a000e0416a30018
>>
>> The insn is:
>>
>>   37c:       6f56a29d        umull2  v29.4s, v20.8h, v6.h[1]
>>
>> Which is odd because I didn't think we'd touched that.
>
> Indeed we didn't.  Still, I'll check it out next week.

OK it would help if I had objdumped the right file:

     36c:       0e781fdd        bic     v29.8b, v30.8b, v24.8b
     370:       00005af0        .inst   0x00005af0 ; undefined

--
Alex Bennée

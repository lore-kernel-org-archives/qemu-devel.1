Received: from eggs.gnu.org ([209.51.188.92]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGT80-0002ei-Ph
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGT7y-0002vP-Pa
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGT7y-0002gy-9m
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so10761612pgl.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:48:17 -0700 (PDT)
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<20190416083150.19649-3-richard.henderson@linaro.org>
	<6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d5aea2d-15fd-ad52-a6b4-fb6b74b231e4@linaro.org>
Date: Tue, 16 Apr 2019 08:48:11 -1000
MIME-Version: 1.0
In-Reply-To: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 4/16/19 7:47 AM, Eric Blake wrote:
> On 4/16/19 3:31 AM, Richard Henderson wrote:
>> If a TB generates too much code, try again with fewer insns.
>>
>> Fixes: https://bugs.launchpad.net/bugs/1824853
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
>>  tcg/tcg.c                 |  4 ++++
>>  2 files changed, 37 insertions(+), 6 deletions(-)
>>
> 
>> +             * Try again with half as many insns as we attempted this time.
>> +             * If a single insn overflows, there's a bug somewhere...
>> +             */
>> +            max_insns = tb->icount;
>> +qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
> 
> Leftover debugging? Or should it be kept but properly indented?

Debugging that I thought I had not committed at all.
That's annoying...


r~

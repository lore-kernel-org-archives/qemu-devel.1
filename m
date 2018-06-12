Received: from eggs.gnu.org ([2001:4830:134:3::10]:33908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSoYU-0004vG-Nf
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSoYT-0008PW-Ud
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:02:10 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSoYT-0008PN-Q7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 15:02:09 -0400
Received: by mail-qk0-x243.google.com with SMTP id c131-v6so35909qkb.0
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:02:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-16-richard.henderson@linaro.org>
	<769b367a-c384-b551-b60a-2e891bd430bd@amsat.org>
	<09a5e057-84d7-11e3-3f62-1145e0a2973c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89e29fec-f817-09d3-2455-88c164724df6@amsat.org>
Date: Tue, 12 Jun 2018 16:02:06 -0300
MIME-Version: 1.0
In-Reply-To: <09a5e057-84d7-11e3-3f62-1145e0a2973c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/19] linux-user: Split out pread64,
 pwrite64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu

On 06/12/2018 02:44 PM, Richard Henderson wrote:
> On 06/12/2018 06:37 AM, Philippe Mathieu-Daudé wrote:
>>>  /* Both preadv and pwritev merge args 4/5 into a 64-bit offset.
>>>   * Moreover, the parts are *always* in little-endian order.
>>>   */
>>>  #if TARGET_ABI_BITS == 32
>>>  SYSCALL_ARGS(preadv_pwritev)
>>>  {
>>> -    /* We have already assigned out[0-3].  */
>>> -    abi_ulong lo = in[4], hi = in[5];
>>> -    out[4] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
>>> +    /* We have already assigned out[0-2].  */
>>> +    abi_ulong lo = in[3], hi = in[4];
>>> +    out[3] = ((hi << (TARGET_ABI_BITS - 1)) << 1) | lo;
>> Why this change? If correct, can you update the comment?
>> Also this seems related to your previous patch #14: "Split out preadv,
>> pwritev, readv, writev", not this one.
>>
> 
> You're right, this hunk should be folded back into the previous patch.

So for this patch without this hunk:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

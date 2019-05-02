Received: from eggs.gnu.org ([209.51.188.92]:34539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDnd-0003SF-VO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDnd-00072Y-5j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDnc-00072L-UF
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:39:05 -0400
Received: by mail-pf1-x444.google.com with SMTP id t87so738523pfa.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:39:04 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-14-richard.henderson@linaro.org>
	<87d0l156hp.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a308f32-83cf-c5d7-3025-7181ffcc944b@linaro.org>
Date: Thu, 2 May 2019 08:38:59 -0700
MIME-Version: 1.0
In-Reply-To: <87d0l156hp.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/29] tcg: Add INDEX_op_dup_mem_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/2/19 6:30 AM, Alex Bennée wrote:
>> +static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
>> +                         uint32_t maxsz, TCGv_vec t_vec)
>> +{
>> +    uint32_t i = 0;
>> +
>> +    switch (type) {
>> +    case TCG_TYPE_V256:
>> +        /*
>> +         * Recall that ARM SVE allows vector sizes that are not a
>> +         * power of 2, but always a multiple of 16.  The intent is
>> +         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
>> +         */
> 
> The c&p comment explains the fall-through  although in this case we are
> only mxing and matching V256/V128?

Err.. that's all we ever do.  2x32 + 1x16 + 1x8 is not allowed, and is
validated by check_size_align.


r~

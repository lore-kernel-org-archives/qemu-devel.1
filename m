Received: from eggs.gnu.org ([209.51.188.92]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBeCb-0004xu-Ql
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBeCa-0001Op-UG
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:37:09 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBeCa-0001Ni-IX
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 07:37:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id 85so8197414pgc.3
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 04:37:08 -0700 (PDT)
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-3-richard.henderson@linaro.org>
	<CAFEAcA8JwtiBSgUg_8kg52GETGd3vbX86nvziXa6ZyvqDPLt5g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a17fffd5-6242-8efc-a8a6-2ca5a8ae9c3d@linaro.org>
Date: Wed, 3 Apr 2019 18:37:00 +0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8JwtiBSgUg_8kg52GETGd3vbX86nvziXa6ZyvqDPLt5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] tcg: Add INDEX_op_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On 3/26/19 8:35 PM, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 14:47, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This will let backends implement the double-word shift operation.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> diff --git a/tcg/README b/tcg/README
>> index 603f4df659..ddabf33017 100644
>> --- a/tcg/README
>> +++ b/tcg/README
>> @@ -343,6 +343,11 @@ at bit 8.  This operation would be equivalent to
>>
>>  (using an arithmetic right shift).
>>
>> +* extract2_i64 dest, t1, t2, pos
>> +
>> +Extract a 64-bit quantity from the concatenation of t2:t1,
>> +beginning at pos.
>> +
> 
> I think we should document the valid values of 'pos'.
> My guess is "0 <= pos <= 63".

How about

----
* extract2_i32/i64 dest, t1, t2, pos

For N = {32,64}, extract an N-bit quantity from the concatenation
of t2:t1, beginning at pos.  The tcg_gen_extract2_* expander allows
values 0 <= pos <= N, but will expand 0 and N with mov, so only
1 <= pos <= N-1 will be seen by the host tcg_out_op.
----

?


r~

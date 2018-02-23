Received: from eggs.gnu.org ([2001:4830:134:3::10]:51290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKYS-0004kt-7D
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKYP-0005nW-2r
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:06:56 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:35293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKYO-0005mu-RE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:06:52 -0500
Received: by mail-pf0-x231.google.com with SMTP id y186so3324542pfb.2
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:06:52 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-41-richard.henderson@linaro.org>
	<CAFEAcA8vFOjA8OST2237SybD-187Bhke3DmBPLUy7ZLCcXSEhw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f314cd23-8dd6-94fb-7eef-4f41a4809506@linaro.org>
Date: Fri, 23 Feb 2018 13:06:48 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vFOjA8OST2237SybD-187Bhke3DmBPLUy7ZLCcXSEhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 40/67] target/arm: Implement SVE Integer
 Compare - Scalars Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 09:00 AM, Peter Maydell wrote:
>> +
>> +uint32_t HELPER(sve_while)(void *vd, uint32_t count, uint32_t pred_desc)
> 
> This could really use a comment about what part of the overall
> instruction it's doing.

Ok.

>> +
>> +    /* For the helper, compress the different conditions into a computation
>> +     * of how many iterations for which the condition is true.
>> +     *
>> +     * This is slightly complicated by 0 <= UINT64_MAX, which is nominally
>> +     * 2**64 iterations, overflowing to 0.  Of course, predicate registers
>> +     * aren't that large, so any value >= predicate size is sufficient.
>> +     */
...

> I got confused by this -- it is too far different from what the
> pseudocode is doing. Could we have more explanatory comments, please?

Ok.  I guess the comment above wasn't as helpful as I imagined.  I'll come up
with something for the next round.


r~

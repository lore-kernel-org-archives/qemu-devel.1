Received: from eggs.gnu.org ([2001:4830:134:3::10]:46330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffdfp-00012D-KG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 00:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffdfm-0002k6-IK
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 00:02:45 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffdfm-0002i5-An
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 00:02:42 -0400
Received: by mail-pf0-x244.google.com with SMTP id k21-v6so1528221pff.11
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 21:02:42 -0700 (PDT)
References: <20180716133302.25989-1-peter.maydell@linaro.org>
	<57aa2f3f-aa32-bcdb-f971-32709e717833@linaro.org>
	<CAFEAcA8FnSP35scTZmLG6_qFOBsu1wRC0mLq5isz+Y_r907i5w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f26dbe0-9999-f9ea-103f-d5dde6c52dc0@linaro.org>
Date: Tue, 17 Jul 2018 21:02:37 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8FnSP35scTZmLG6_qFOBsu1wRC0mLq5isz+Y_r907i5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Correctly handle
 overlapping small MPU regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Adithya Baglody <adithya.nagaraj.baglody@intel.com>, "patches@linaro.org" <patches@linaro.org>

On 07/17/2018 12:40 PM, Peter Maydell wrote:
> On 17 July 2018 at 18:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> I don't understand why this is necessary in the v8m case.
>>
>>                AP                 APL
>>     <----B1----|----L1-B2-A-------|---L2--->
>>
>>
>> Your comment posits two regions [B1,L1] and [B2,L2], that A is not within
>> [B1,L1] but is within [B2,L2] (otherwise we would not report a hit at all).
>> Further, that [B1,L1] intersects [AP,APL] but does not intersect [B2,L2]
>> (otherwise we would report a fault for overlapping regions).
>>
>> Surely this combination of ranges implies that [B2,L2] must itself set
>> IS_SUBPAGE (otherwise the first region would not overlap the page of A, or
>> would not overlap the second region).
> 
> (a) the overlap fault is only for addresses which are actually in the
> overlap (ie "you asked about address X and it hits in R1 and R2"); it
> doesn't imply that other addresses which are only in R1 fault just
> because some part of R1 overlaps with R2.

Ah, that wasn't clear from the manual.

> So for instance:
> 
>        AP                        APL
>    [B1                                L1]
>                  [B2       L2]
>              A1^     A2^

Thanks for the example,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

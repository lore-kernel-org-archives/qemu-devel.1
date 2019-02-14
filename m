Received: from eggs.gnu.org ([209.51.188.92]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOZ1-0006Ak-Ew
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOZ0-0000Bf-6D
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:28:59 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guOYk-0008KU-2p
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:28:48 -0500
Received: by mail-pl1-x641.google.com with SMTP id 101so3808268pld.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 13:28:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190206052857.5077-1-richard.henderson@linaro.org>
	<CAFEAcA9oyJ5RxTqJdptK6bmMwFe++NLn15XTxdBkZbsfOUT_NQ@mail.gmail.com>
	<0334b231-fa3e-210c-ea9e-9d7bb7b21d1f@linaro.org>
Message-ID: <28da85ff-c718-bd3e-ddca-18772decd777@linaro.org>
Date: Thu, 14 Feb 2019 13:28:14 -0800
MIME-Version: 1.0
In-Reply-To: <0334b231-fa3e-210c-ea9e-9d7bb7b21d1f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2/14/19 1:10 PM, Richard Henderson wrote:
> On 2/14/19 5:53 AM, Peter Maydell wrote:
>> On Wed, 6 Feb 2019 at 05:29, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Changes since v1:
>>>   * Typo fixed in patch 2, which had scrogged FMOV
>>>   * Return 0 for NaN, as for any other ARM fp conversion.
>>>
>>>
>>> r~
>>>
>>>
>>> Richard Henderson (3):
>>>   target/arm: Force result size into dp after operation
>>>   target/arm: Restructure disas_fp_int_conv
>>>   target/arm: Implement ARMv8.3-JSConv
>>
>> I've applied patches 1 and 2 to target-arm.next; 3 has a bug in it,
>> I think.
> 
> Please dequeue patch 2; patch 3 has more than one bug in it, and I need to
> rewrite patch 2 as well.

Grr.  That's patch 1, "force result size into dp" that I want dequeued.
Of course, now I've seen your pull request, so if that's already gone through,
I guess I can smoosh a revert with my rewrite?


r~

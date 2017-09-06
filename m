Received: from eggs.gnu.org ([2001:4830:134:3::10]:47326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpemq-0008KQ-SN
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpemm-0002Zs-8q
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:10:52 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:34616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpemm-0002Zd-0z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:10:48 -0400
Received: by mail-pg0-x234.google.com with SMTP id q68so713089pgq.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 11:10:47 -0700 (PDT)
References: <1502196172-13818-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA9MLp8kUihyujJKBLUr=HNtHhy+d2VCE_6NdyxVe6RXwA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f781530-bddd-e78d-e66b-c5110892c1cc@linaro.org>
Date: Wed, 6 Sep 2017 11:10:44 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9MLp8kUihyujJKBLUr=HNtHhy+d2VCE_6NdyxVe6RXwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/alpha: Switch to
 do_transaction_failed() hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 09/05/2017 08:54 AM, Peter Maydell wrote:
> On 8 August 2017 at 13:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Switch the alpha target from the old unassigned_access hook
>> to the new do_transaction_failed hook. This allows us to
>> resolve a ??? in the old hook implementation.
>>
>> The only part of the alpha target that does physical
>> memory accesses is reading the page table -- add a
>> TODO comment there to the effect that we should handle
>> bus faults on page table walks. (Since the palcode
>> doesn't actually do anything useful on a bus fault anyway
>> it's a bit moot for now.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Based-on: 1501867249-1924-1-git-send-email-peter.maydell@linaro.org
>> This patch sits on top of the series adding the new hook.
> 
> The prerequisites for this patch are now all in git master.

Thanks.  Queued to tgt-axp.


r~

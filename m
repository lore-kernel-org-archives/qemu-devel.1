Received: from eggs.gnu.org ([2001:4830:134:3::10]:50371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAI9-00016g-LM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLAI8-0002QD-QQ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:37:41 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLAI8-0002Px-Ka
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:37:40 -0400
Received: by mail-oi0-x242.google.com with SMTP id e80-v6so16784992oig.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:37:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d022028c-624d-ed88-9ba6-d0fe88d8adcf@twiddle.net>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-10-peter.maydell@linaro.org>
	<d022028c-624d-ed88-9ba6-d0fe88d8adcf@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 17:37:19 +0100
Message-ID: <CAFEAcA8V_8xOpGuVKSQQYUZ=GZ+a21Mom5=dq+Nj=t5nyrYJWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/27] Make flatview_access_valid() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 22 May 2018 at 17:33, Richard Henderson <rth@twiddle.net> wrote:
> On 05/21/2018 07:03 AM, Peter Maydell wrote:
>> As part of plumbing MemTxAttrs down to the IOMMU translate method,
>> add MemTxAttrs as an argument to flatview_access_valid().
>> Its callers now all have an attrs value to hand, so we can
>> correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>>              /* When our callers all have attrs we'll pass them through here */
>> -            if (!memory_region_access_valid(mr, xlat, l, is_write,
>> -                                            MEMTXATTRS_UNSPECIFIED)) {
>> +            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {
>
> Kill the temporary comment too.

Oops, yes.

thanks
-- PMM

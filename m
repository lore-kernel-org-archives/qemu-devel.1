Received: from eggs.gnu.org ([2001:4830:134:3::10]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKkze-0001NB-64
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gKkzY-00040M-6p
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:09:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gKkzX-0003zE-Um
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:09:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so1399093wmc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:09:03 -0800 (PST)
References: <20181108125256.30986-1-peter.maydell@linaro.org>
	<7a7929a8-74d3-ed14-b284-f420afe824ea@redhat.com>
	<CAFEAcA9NSzcDP6UwLYRfOSq=NZE3+4+vF6wNCXjJ7LQ9mMZLwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b61339a-2dd5-5d08-c5b1-ac305662a0aa@redhat.com>
Date: Thu, 8 Nov 2018 15:08:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NSzcDP6UwLYRfOSq=NZE3+4+vF6wNCXjJ7LQ9mMZLwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tcg-op.h: Add multiple include guard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 8/11/18 14:17, Peter Maydell wrote:
> On 8 November 2018 at 13:08, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 8/11/18 13:52, Peter Maydell wrote:
>>>
>>> The tcg-op.h header was missing the usual guard against multiple
>>> inclusion; add it.
>>>
>>> (Spotted by lgtm.com's static analyzer.)
>>
>>
>> I'm pretty sure there are more occurences.
> 
> The only other ones the analyzer spotted all seemed to be
> "deliberately multiply included" (like
> include/exec/memory_ldst_phys.inc.h), though we don't in
> all cases use the ".inc.h" convention that sort-of
> indicates that).
> 
> https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=tree
> is probably the most convenient url if you want to
> go looking for other stuff. Some of its issues are
> definitely false-positives, but there may be some other
> easy to fix things in there (eg the "local variable
> hides global variable" ones -- though if we care about
> these we should enable -Wshadow and fix the compile
> failures).
> 
> Notably, lgtm does checks on python, which Coverity does not,
> so that is more likely to be a source of real issues to fix,
> I think.

Thanks for the pointer.

This stats are funny^H^H^H^Hscary:
https://lgtm.com/blog/best_email_domain#What%20about%20the%20free%20email%20providers?

> 
> thanks
> -- PMM
> 

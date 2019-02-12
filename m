Received: from eggs.gnu.org ([209.51.188.92]:42806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtXHt-0005FE-7q
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtX5o-0000cL-Mg
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:23:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtX5o-0000Wt-CM
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:23:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so2466554wrs.4
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 04:23:16 -0800 (PST)
References: <20190212105201.13795-1-peter.maydell@linaro.org>
	<1df0da56-7abd-4688-0fed-6dc2bf10ebb6@redhat.com>
	<CAFEAcA9Jds9wLwJUqe4kJrDszL__KoWpKm5ajh0HCcR+mSH8tg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b2226550-15ac-2f2a-1584-64a24d944923@redhat.com>
Date: Tue, 12 Feb 2019 13:23:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Jds9wLwJUqe4kJrDszL__KoWpKm5ajh0HCcR+mSH8tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/armsse: Fix miswiring of expansion
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 2/12/19 12:06 PM, Peter Maydell wrote:
> On Tue, 12 Feb 2019 at 11:05, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 2/12/19 11:52 AM, Peter Maydell wrote:
>>> In commit 91c1e9fcbd7548db368 where we added dual-CPU support to
>>> the ARMSSE, we set up the wiring of the expansion IRQs via nested
>>> loops: the outer loop on 'i' loops for each CPU, and the inner loop
>>> on 'j' loops for each interrupt. Fix a typo which meant we were
>>> wiring every expansion IRQ line to external IRQ 0 on CPU 0 and
>>> to external IRQ 1 on CPU 1.
>>>
>>> Fixes: 91c1e9fcbd7548db368 ("hw/arm/armsse: Support dual-CPU configuration")
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>> ---
>>> It turns out that the ARM-TFM image I was using to test that
>>> I hadn't broken the mps2-an505 doesn't actually rely on any
>>> interrupts from the external devices...
>>
>> How did you notice that, simply reviewing? Via 'info qtree'?
> 
> I'm working on a model of a different board (Musca) which also
> uses the SSE-200, and the test code I had for that does happen
> to care about the interrupts.

OK, welcome Musca!

If you are testing Open Source code, please add a few notes on the wiki
or in a mail (or the cover when you introduce the Musca), so we can add
an acceptance test.

Thanks,

Phil.

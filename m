Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gNK56-000394-S2
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gNK4s-0000yG-TC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:01:17 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-6-peter.maydell@linaro.org>
	<3ac12d41-2095-f0ad-db1b-0e3ceea8f44e@redhat.com>
	<7e05e89a-6eec-257d-03af-78a2d2b60628@twiddle.net>
	<CAFEAcA-cE1cBe3BAxMRbdNjtHde3XGf842rqdc8gV8bN7WHNHQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <243861e9-322f-bbab-4206-70ccd815edfb@twiddle.net>
Date: Thu, 15 Nov 2018 17:00:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-cE1cBe3BAxMRbdNjtHde3XGf842rqdc8gV8bN7WHNHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] accel/tcg: Return -1 for execution
 from MMIO regions in get_page_addr_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/15/18 2:53 PM, Peter Maydell wrote:
>>      switch (offset) {
>> -    case 0x0000 ... 0xc000:
>> +    case 0x0000 ... 0xbfff:
>>          return lduw_le_p(s->boot[0] + addr);
>>
>>      case 0xf000:       /* Manufacturer ID */
>>
>> as the memory segment has size 0xc000.
> 
> Presumably it should be ... 0xbffe, since we are
> doing a 16-bit load ?

Ah, true.

> Yeah, I'll put together a patch which makes it use the qemu_log
> facilities rather than fprintf() and hw_error(). With that
> plus the case statement fix then QEMU correctly just sits there
> as the guest execution races through memory...

Excellent, thanks.


r~

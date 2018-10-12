Received: from eggs.gnu.org ([2001:4830:134:3::10]:43595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAm4T-0003Pl-C6
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAm4O-0005ck-Gk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:16:53 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:38034)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAm4N-0005ZN-S3
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 21:16:48 -0400
References: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
	<20181011090007.1103-5-maozhongyi@cmss.chinamobile.com>
	<997db16e-3da8-b66a-b29b-517674ae860f@redhat.com>
	<CAFEAcA9+zzccFDQpGYTp8iwBR8u5wMuh8_R_d2m6BZXui2wOKQ@mail.gmail.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <6d415b7d-1592-71bb-0894-4eb48aa3dd64@cmss.chinamobile.com>
Date: Fri, 12 Oct 2018 09:16:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+zzccFDQpGYTp8iwBR8u5wMuh8_R_d2m6BZXui2wOKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] audio: use existing macros istead
 ofhardcoded strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, Gerd Hoffmann <kraxel@redhat.com>



On 10/11/18 7:05 PM, Peter Maydell wrote:
> On 11 October 2018 at 11:45, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 11/10/2018 11:00, Mao Zhongyi wrote:
>>> Cc: Jan Kiszka <jan.kiszka@web.de>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> To: qemu-arm@nongnu.org
>>>
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>> ---
>>>   hw/arm/musicpal.c          | 16 ++++++++--------
>>>   hw/audio/marvell_88w8618.c |  3 +--
>>>   include/hw/audio/wm8750.h  |  1 +
>>>   3 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
>>> index ac266f9253..6425f1d50f 100644
>>> --- a/hw/arm/musicpal.c
>>> +++ b/hw/arm/musicpal.c
>>> @@ -406,7 +406,7 @@ static void mv88w8618_eth_realize(DeviceState *dev, Error **errp)
>>>   }
>>>
>>>   static const VMStateDescription mv88w8618_eth_vmsd = {
>>> -    .name = "mv88w8618_eth",
>>> +    .name = TYPE_MV88W8618_ETH,
>>
>> I understand TYPE_device name might changed, but once used,
>> VMStateDescription shouldn't, else this would break migration.
>> Thus I wouldn't recommend using TYPE_name in VMStateDescription.name.
>>
>> Since I'm not sure I cc'ed the migration maintainers.
> 
> Yes, that's the usual approach -- the vmstate struct names
> aren't inherently the same as the QOM type names, and so
> we keep them decoupled to avoid accidentally breaking migration.

OK, I got it, will fix it in the next, thanks for the clarification.

thanks
Mao

> 
> thanks
> -- PMM
> 

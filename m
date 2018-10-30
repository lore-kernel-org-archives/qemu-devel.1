Received: from eggs.gnu.org ([2001:4830:134:3::10]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHcfi-0008Da-KO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHcfc-00078d-9H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:39:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHcfa-00075v-Bo
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:39:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so12799121wmf.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 15:39:27 -0700 (PDT)
References: <20181029223207.31878-1-philmd@redhat.com>
	<20181029223207.31878-4-philmd@redhat.com>
	<20181030063830.edjacusffvgwvnt2@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fc4b00b2-dda0-a0fb-e7b8-487065dbf6cc@redhat.com>
Date: Tue, 30 Oct 2018 23:39:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181030063830.edjacusffvgwvnt2@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] arm: allwinner: Enable USB EHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Icenowy Zheng <icenowy@aosc.xyz>, Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>

Hi Gerd,

On 30/10/18 7:38, Gerd Hoffmann wrote:
> On Mon, Oct 29, 2018 at 11:32:07PM +0100, Philippe Mathieu-Daudé wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> [PMD: Intented tabs -> space]
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   hw/arm/allwinner-a10.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>> index 0a8ac929f5..92ab66354a 100644
>> --- a/hw/arm/allwinner-a10.c
>> +++ b/hw/arm/allwinner-a10.c
>> @@ -116,6 +116,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>>       if (machine_usb(current_machine)) {
>>           sysbus_create_simple("sysbus-ohci", 0x01c14400, s->irq[64]);
>>           sysbus_create_simple("sysbus-ohci", 0x01c1c400, s->irq[65]);
>> +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c14000, s->irq[39]);
>> +        sysbus_create_simple(TYPE_AW_A10_EHCI, 0x01c1c000, s->irq[40]);
> 
> Hmm, is this a companion controller setup?  If so, then this is a bit
> more complicated  (see ehci_create_ich9_with_companions()).

I don't have enough USB knowledge. Can we have companion setup without PCI?

Per the datashit [1] p. 215 "21. USB Host Controller", each controller 
share the same PHY. There is no mention of companion setup:

   The USB host controller includes the following features:
   ..
   - Complies with EHCI Specification, Version 1.0,
   - and  the OHCI Specification, Version 1.0a.
   ..
   - Support only 1 USB Root Port shared between EHCI and OHCI.


[1] http://linux-sunxi.org/images/1/1e/Allwinner_A10_User_manual_V1.5.pdf

> 
> cheers,
>    Gerd
> 

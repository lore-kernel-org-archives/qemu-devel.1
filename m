Received: from eggs.gnu.org ([2001:4830:134:3::10]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1eCc6j-000842-9e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:58:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1eCc6i-0005j6-F3
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:58:17 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:48815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1eCc6i-0005ig-7c
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 20:58:16 -0500
Received: by mail-wm0-x242.google.com with SMTP id p75so14032915wmg.3
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 17:58:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2fd2077a-9823-41e0-0deb-4142b20259d5@advancedtelematic.com>
References: <cb94e9b2-d7c6-68ab-bb25-42f7d8113e03@advancedtelematic.com>
	<CAEUhbmVTaJmL1jG8aBPPcJ-d+vKba8xhLgc=+7Fd8HHUvVW+-Q@mail.gmail.com>
	<9b2efc90-3b0e-b13b-27bb-117473c8b41b@advancedtelematic.com>
	<2fd2077a-9823-41e0-0deb-4142b20259d5@advancedtelematic.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 9 Nov 2017 09:58:14 +0800
Message-ID: <CAEUhbmXJZnLZgx8b2ZHV1wfqZvO=agSsp0Yvi7FQQfV6MM1cnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [U-Boot] Support of latest qemux86-64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Gerasimov <anton@advancedtelematic.com>, Igor Mammedov <imammedo@redhat.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, qemu-devel@nongnu.org

On Wed, Nov 8, 2017 at 9:05 PM, Anton Gerasimov
<anton@advancedtelematic.com> wrote:
> Adding Igor Mammedov to the loop.
>

Really add Igor Mammedov.

Igor, can you help look at this?

> On 11/08/2017 01:59 PM, Anton Gerasimov wrote:
>> To whoever might be interested: I've bisected qemu and the breaking
>> commit is 208fa0e43645edd0b0d8f838857dfc79daff40a8 (pc: make 'pc.rom'
>> readonly when machine has PCI enabled). It's just three lines added,
>> I'll paste the whole patch here. Not quite sure what can we do here though.
>>
>>
>>   diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>   index 22e16031b0..59435390ba 100644
>>   --- a/hw/i386/pc.c
>>   +++ b/hw/i386/pc.c
>>   @@ -1443,6 +1443,9 @@ void pc_memory_init(PCMachineState *pcms,
>>        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>>        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>>                               &error_fatal);
>>   +    if (pcmc->pci_enabled) {
>>   +        memory_region_set_readonly(option_rom_mr, true);
>>   +    }
>>        memory_region_add_subregion_overlap(rom_memory,
>>                                            PC_ROM_MIN_VGA,
>>                                            option_rom_mr,
>>
>>

Regards,
Bin

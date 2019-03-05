Received: from eggs.gnu.org ([209.51.188.92]:57854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0zkW-0007mA-MG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0zkV-0006NG-Tx
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:24:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0zkV-0006Ig-N3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 21:24:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so1029607wma.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 18:24:07 -0800 (PST)
References: <1515509463-2675-1-git-send-email-mst@redhat.com>
	<d29cfb63-233a-f9ae-c326-8ff7c1b490f3@redhat.com>
	<20190304210359-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f89bdfa8-0027-843f-1751-6a8e1ef59812@redhat.com>
Date: Tue, 5 Mar 2019 03:24:04 +0100
MIME-Version: 1.0
In-Reply-To: <20190304210359-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] isa/piix: move to mips malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 3/5/19 3:11 AM, Michael S. Tsirkin wrote:
> On Tue, Mar 05, 2019 at 01:53:45AM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Michael,
>>
>> On 1/9/18 3:59 PM, Michael S. Tsirkin wrote:
>>> This device is only used on mips malta, move it to the maintainer
>>> that's actually testing it.
>>
>> Slighly related to this patch, since I included it while working on
>> Kconfig/MIPS.
>> I splitted PIIX3/PIIX4 (Actually PIIX3 was mixed with I440FX).
>> These are indeed 2 different chipsets, PIIX4 is an improved PIIX3.
>>
>> I compiled MIPS with PIIX4 and it works, however when I ran all the
>> testsuite X86 failed due to PIIX4_PM missing.
>> I looked where it is used:
>>
>> $ git grep PIIX4_PM
>> docs/interop/firmware.json:96:#           enabled with "-global
>> PIIX4_PM.disable_s3=0" and disabled
>> docs/interop/firmware.json:97:#           with "-global
>> PIIX4_PM.disable_s3=1". On the "pc-q35-*"
>> docs/interop/firmware.json:105:#           can be enabled with "-global
>> PIIX4_PM.disable_s4=0" and
>> docs/interop/firmware.json:106:#           disabled with "-global
>> PIIX4_PM.disable_s4=1". On the
>> hw/i386/pc.c:282:    { "PIIX4_PM", "memory-hotplug-support", "off" },
>> hw/i386/pc.c:299:    { "PIIX4_PM",
>> "acpi-pci-hotplug-with-bridge-support", "off" },
>>
>> So now I'm confused, looking at git history I see you introduced this in
>> commit 9e047b98245.
>>
>> What chipset do use the PC machine? An unreal hybrid of PIIX3/PIIX4?
>>
>> Thanks,
>>
>> Phil.
> 
> Yes I think it does not match any real hardware at this point.

This is unfortunate :( I'll try to sort this out.

> 
> Not sure what does grep above show: to create piix4 pm
> pc_init1 calls piix4_pm_init.

Indeed, which makes me wonder what I'm running =)

Thanks for the quick answer,

Phil.

>>>
>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>> Cc: Yongbok Kim <yongbok.kim@mips.com>
>>> Cc: Hervé Poussineau <hpoussin@reactos.org>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>
>>> Aurelien, pls feel free to merge this or v1.
>>>
>>>  MAINTAINERS | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 0255113..0b8a5e7 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -641,6 +641,7 @@ Malta
>>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>>  S: Maintained
>>>  F: hw/mips/mips_malta.c
>>> +F: hw/isa/piix4.c
>>>  
>>>  Mipssim
>>>  M: Yongbok Kim <yongbok.kim@mips.com>
>>> @@ -849,7 +850,6 @@ F: hw/pci-host/q35.c
>>>  F: hw/pci-host/pam.c
>>>  F: include/hw/pci-host/q35.h
>>>  F: include/hw/pci-host/pam.h
>>> -F: hw/isa/piix4.c
>>>  F: hw/isa/lpc_ich9.c
>>>  F: hw/i2c/smbus_ich9.c
>>>  F: hw/acpi/piix4.c
>>>

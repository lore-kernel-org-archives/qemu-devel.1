Received: from eggs.gnu.org ([209.51.188.92]:53373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLDJp-0002ws-9j
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLDJo-0006ks-6L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLDJo-0006je-09
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:56:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so1058910wml.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:56:07 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-11-thuth@redhat.com>
	<377a2033-504b-a84d-0eb0-765de81af730@redhat.com>
	<fe977ebc-3ec7-fbf5-7a72-c9418286f0f1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d06a1288-277f-050e-e16f-e62b82a284c9@redhat.com>
Date: Mon, 29 Apr 2019 22:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <fe977ebc-3ec7-fbf5-7a72-c9418286f0f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 10/29] hw/arm: Express
 dependencies of stellaris with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/29/19 9:25 PM, Thomas Huth wrote:
> On 25/04/2019 23.41, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 4/18/19 8:00 PM, Thomas Huth wrote:
>>> This patch is slightly based on earlier work by Ákos Kovács (i.e.
>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak |  7 +------
>>>  hw/arm/Kconfig                  | 10 ++++++++++
>>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>> index b7ed3c530b..3f82d635e4 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -16,6 +16,7 @@ CONFIG_MUSCA=y
>>>  CONFIG_CHEETAH=y
>>>  CONFIG_SX1=y
>>>  CONFIG_NSERIES=y
>>> +CONFIG_STELLARIS=y
>>>  
>>>  CONFIG_VGA=y
>>>  CONFIG_NAND=y
>>> @@ -24,16 +25,10 @@ CONFIG_SERIAL=y
>>>  CONFIG_MAX7310=y
>>>  CONFIG_TMP421=y
>>>  CONFIG_PCA9552=y
>>> -CONFIG_STELLARIS=y
>>> -CONFIG_STELLARIS_INPUT=y
>>> -CONFIG_STELLARIS_ENET=y
>>> -CONFIG_SSD0303=y
>>> -CONFIG_SSD0323=y
>>>  CONFIG_DDC=y
>>>  CONFIG_SII9022=y
>>>  CONFIG_ADS7846=y
>>>  CONFIG_MAX111X=y
>>> -CONFIG_SSI_SD=y
>>>  CONFIG_SSI_M25P80=y
>>>  CONFIG_ALLWINNER_EMAC=y
>>>  CONFIG_IMX_FEC=y
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index 71126254ff..b91503f5a6 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -91,6 +91,16 @@ config REALVIEW
>>>  
>>>  config STELLARIS
>>>      bool
>>> +    select ARM_V7M
>>> +    select I2C
>>> +    select PL011 # UART
>>> +    select PL022 # Serial port
>>> +    select PL061 # GPIO
>>> +    select SSD0303 # OLED display
>>> +    select SSD0323 # OLED display
>>> +    select SSI_SD
>>> +    select STELLARIS_INPUT
>>> +    select STELLARIS_ENET # ethernet
>>
>> This one misses CMSDK_APB_WATCHDOG:
>>
>> $ qemu-system-aarch64 -M lm3s811evb
>> qemu-system-aarch64: Unknown device 'luminary-watchdog' for default sysbus
>> Aborted (core dumped)
> 
> Oh, well, looks like this has just been added recently in commit
> 566528f823d1a2e9e, likely after I assembled and tested the initial
> version of this patch...

Ah yes, correct! This happens when we take too long to review a series,
and since this one is huge, I was keeping procrastinating...

> Thanks for catching it, I'll apply your fix in v6!
> 
>  Thomas
> 

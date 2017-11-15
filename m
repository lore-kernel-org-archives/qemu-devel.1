Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eExa9-00013V-FL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eExa8-0000yT-Id
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:18:21 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eExa8-0000xj-BN
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:18:20 -0500
Received: by mail-wm0-x242.google.com with SMTP id r68so21803836wmr.0
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 05:18:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bf2bbd4b-b26f-cf44-6bb1-47c80e4e6a88@linux.vnet.ibm.com>
References: <20171106115347.19873-1-marcandre.lureau@redhat.com>
	<bf2bbd4b-b26f-cf44-6bb1-47c80e4e6a88@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Nov 2017 14:18:18 +0100
Message-ID: <CAJ+F1CL29Cb53DxJxB98W5QLQEzri3YiHiaPDZ9oHHd6PFx36w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: restrict vmcoreinfo to
 fw_cfg+dma capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Michael,

Could you pick this patch for 2.11 ?

thanks

On Mon, Nov 6, 2017 at 1:40 PM, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
>
>
> On 11/06/2017 09:53 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> vmcoreinfo is built for all targets. However, it requires fw_cfg with
>> DMA operations support (write operation). Restrict vmcoreinfo exposure
>> to architectures that are supporting FW_CFG_DMA, that is arm-virt and
>> x86 only atm.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>
>
> Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
>
>
>>   default-configs/arm-softmmu.mak    | 2 ++
>>   default-configs/i386-softmmu.mak   | 1 +
>>   default-configs/x86_64-softmmu.mak | 1 +
>>   hw/misc/Makefile.objs              | 2 +-
>>   4 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak
>> b/default-configs/arm-softmmu.mak
>> index 5059d134c8..d37edc4312 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -130,3 +130,5 @@ CONFIG_SMBIOS=3Dy
>>   CONFIG_ASPEED_SOC=3Dy
>>   CONFIG_GPIO_KEY=3Dy
>>   CONFIG_MSF2=3Dy
>> +
>> +CONFIG_FW_CFG_DMA=3Dy
>> diff --git a/default-configs/i386-softmmu.mak
>> b/default-configs/i386-softmmu.mak
>> index a685c439e7..95ac4b464a 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
>>   CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>>   CONFIG_PXB=3Dy
>>   CONFIG_ACPI_VMGENID=3Dy
>> +CONFIG_FW_CFG_DMA=3Dy
>> diff --git a/default-configs/x86_64-softmmu.mak
>> b/default-configs/x86_64-softmmu.mak
>> index ea69e8289e..0221236825 100644
>> --- a/default-configs/x86_64-softmmu.mak
>> +++ b/default-configs/x86_64-softmmu.mak
>> @@ -60,3 +60,4 @@ CONFIG_SMBIOS=3Dy
>>   CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
>>   CONFIG_PXB=3Dy
>>   CONFIG_ACPI_VMGENID=3Dy
>> +CONFIG_FW_CFG_DMA=3Dy
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 19202d90cf..10c88a84b4 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
>>   common-obj-$(CONFIG_EDU) +=3D edu.o
>>     common-obj-y +=3D unimp.o
>> -common-obj-y +=3D vmcoreinfo.o
>> +common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
>>     obj-$(CONFIG_VMPORT) +=3D vmport.o
>>
>
>
>



--=20
Marc-Andr=C3=A9 Lureau

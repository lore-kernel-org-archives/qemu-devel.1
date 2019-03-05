Received: from eggs.gnu.org ([209.51.188.92]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1HC4-0007ep-TV
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1HC2-0008SZ-UT
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:01:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1HC0-0008OL-6N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:01:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id c13so2980137wmb.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 13:01:38 -0800 (PST)
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-2-philmd@redhat.com>
	<b7a09e97-093e-6e27-4c7f-cc5244d63726@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5c595af2-e9c6-61eb-ab83-bdbc59b37967@redhat.com>
Date: Tue, 5 Mar 2019 22:01:35 +0100
MIME-Version: 1.0
In-Reply-To: <b7a09e97-093e-6e27-4c7f-cc5244d63726@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/arm/virt: Remove null-check in
 virt_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

Hi Laszlo,

On 12/10/18 5:02 PM, Laszlo Ersek wrote:
> On 12/07/18 18:03, Philippe Mathieu-Daudé wrote:
>> Since af1f60a4022, the fw_cfg field is always created in machvirt_init().
>> There is no need to null check it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/arm/virt.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index f69e7eb399..36303ed59c 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1279,10 +1279,6 @@ static void virt_build_smbios(VirtMachineState *vms)
>>      size_t smbios_tables_len, smbios_anchor_len;
>>      const char *product = "QEMU Virtual Machine";
>>  
>> -    if (!vms->fw_cfg) {
>> -        return;
>> -    }
>> -
>>      if (kvm_enabled()) {
>>          product = "KVM Virtual Machine";
>>      }
>>
> 
> This patch looks correct to me; however, the fact that fw_cfg is always
> present on the virt board does not seem related to commit af1f60a4022
> af1f60a40226 ("hw/arm/virt: remove VirtGuestInfo", 2017-01-09). Said
> commit only flattened the contents of VirtGuestInfo into
> VirtMachineState; the conditions under which fw_cfg would be created
> were not changed.

This is certainly not related to commit af1f60a4022... This is not the
commit I remember I wanted to refer to, I suppose I did a copy/paste
mistake, thanks for carefully reviewing me and catching this!

> As far as I can see (from a number of git-blame / git-show commands),
> fw_cfg was added unconditionally to the virt board in commit
> 578f3c7b0835 ("arm: add fw_cfg to "virt" board", 2014-12-22). And the
> check that you are now (correctly) removing has always been superfluous
> -- it was superfluous already when it was first added in commit
> c30e15658b1b ("smbios: implement smbios support for mach-virt", 2015-09-07).
> 
> As far as I can tell, anyway.
> 
> If you agree, I suggest mentioning commit c30e15658b1b in the commit
> message, rather than commit af1f60a4022.

Yes, this one makes more sense ;)

> 
> With such an update:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

Phil.

> 
> Thanks
> Laszlo
> 

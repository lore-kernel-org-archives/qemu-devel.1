Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87389C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D69B2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFdpXHST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D69B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNdv-0007vq-K9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNdI-0007Pn-Qg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:52:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58980
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjNdH-0000QW-5N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591883558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WngnxMge2iJUNevldnjez5iR4SBPDN7K5MCVtiSWxd4=;
 b=cFdpXHSTKCEk+FzQfGw8EGacXIyvtw44XLMnk+N1xJ4oRd9QVcl4fuzIMWBGsAAaOEC+Yg
 cODia2w1CUvFgAjHjJAEHddTtBA62Wiq1QwHwcQorPFjaiSEIgnbZVvgn+nj+iBVplejX/
 aFHXm9eqhBsM6dccGc+rRirn/4nLhDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-jVmaWkzuPGmm9N9yBmtQKg-1; Thu, 11 Jun 2020 09:52:36 -0400
X-MC-Unique: jVmaWkzuPGmm9N9yBmtQKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 574361005512;
 Thu, 11 Jun 2020 13:52:35 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D2315C3E7;
 Thu, 11 Jun 2020 13:52:29 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] arm/acpi: Add the TPM2.0 device under the DSDT
To: Igor Mammedov <imammedo@redhat.com>
References: <20200601095737.32671-1-eric.auger@redhat.com>
 <20200601095737.32671-5-eric.auger@redhat.com>
 <20200605164517.25e6521c@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <20da41f3-3513-0561-88b1-00debeab759c@redhat.com>
Date: Thu, 11 Jun 2020 15:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200605164517.25e6521c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, drjones@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 eric.auger.pro@gmail.com, lersek@redhat.com, ardb@kernel.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 6/5/20 4:45 PM, Igor Mammedov wrote:
> On Mon,  1 Jun 2020 11:57:37 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> In case it is dynamically instantiated, add the TPM 2.0 device object
>> under the DSDT table in the ACPI namespace. Its HID is MSFT0101
>> while its current resource settings (CRS) property is initialized
>> with the guest physical address and MMIO size of the device.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> ---
>>
>> v2 -> v3:
>> - use SYS_BUS_DEVICE() instead of
>>   (SysBusDevice *)object_dynamic_cast(OBJECT())
>>
>> v1 -> v2:
>> - use memory_region_size
>> - fix mingw compilation issue by casting to uint32_t
>> - added Stefan's R-b
>> ---
>>  hw/arm/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 6d152ab481..05a3028500 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -46,6 +46,7 @@
>>  #include "hw/pci/pci.h"
>>  #include "hw/arm/virt.h"
>>  #include "hw/mem/nvdimm.h"
>> +#include "hw/platform-bus.h"
>>  #include "sysemu/numa.h"
>>  #include "sysemu/reset.h"
>>  #include "sysemu/tpm.h"
>> @@ -364,6 +365,36 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>>      aml_append(scope, dev);
>>  }
>>  
>> +static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>> +{
>> +    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
>> +    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
>> +    MemoryRegion *sbdev_mr;
>> +    SysBusDevice *sbdev;
>> +    hwaddr tpm_base;
>> +
>> +    sbdev = SYS_BUS_DEVICE(tpm_find());
>> +
>> +    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
>> +    assert(tpm_base != -1);
>> +
>> +    tpm_base += pbus_base;
>> +
>> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
>> +
>> +    Aml *dev = aml_device("TPM0");
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>> +
>> +    Aml *crs = aml_resource_template();
>> +    aml_append(crs,
>> +               aml_memory32_fixed(tpm_base,
>> +                                  (uint32_t)memory_region_size(sbdev_mr),
>> +                                  AML_READ_WRITE));
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +    aml_append(scope, dev);
>> +}
>> +
>>  static void
>>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>  {
>> @@ -758,6 +789,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>      }
>>  
>>      acpi_dsdt_add_power_button(scope);
>> +    acpi_dsdt_add_tpm(scope, vms);
> shouldn't be this guarded by check if TPM device is present?
Yes I should. the check was in v2 and was dropped in v3.

thanks

Eric
> 
> perhaps pass found here tpm to acpi_dsdt_add_tpm() as an argument
> 
>>  
>>      aml_append(dsdt, scope);
>>  
> 



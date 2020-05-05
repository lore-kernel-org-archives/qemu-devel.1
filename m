Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12607C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E845206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3h1bxMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E845206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzqS-0003JI-Ia
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jVzej-0005GX-IR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:38:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jVzee-0004Pj-EV
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:38:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id v4so2778763wme.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B00Hid8G7TjVnfx+5SCe4k0H7fl4psiLYOU9YENlSXk=;
 b=J3h1bxMJPQwrMwc0+Iv62f5vMT/HmbffWgFYhNyPiE6jCx16EOhZq8tULM8axodSrj
 MaYug+dmlRyU62yaIW4u49uxm6HPguaWHkyrvC5bOFX76DA/cNK+rd/zQCG/R7SJDknH
 HYwn5Dq3ylWxQNr8NnHzLN1omF4Tplsv6ynYmwp/hqG0S5j8cHoDEZtqyJffDaJqGE7o
 8FG3rv3quieESVK/UdlKZZhqxVBXUpJWgp3u3l6SAqjFvi9W8nep2dKWU553VMjrdum9
 dCHWs7y3hRWCaqL50k8Kflmn81+6uGJZjDpP0oq1HdYdkheJ4TyhygbrqT+BB1McGKu5
 HePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B00Hid8G7TjVnfx+5SCe4k0H7fl4psiLYOU9YENlSXk=;
 b=O0y40N7murV7x4xHesI0TdPvHFA3Zss6csKGS7lr2AAsaWVbB7ZkIv6CqdBVRdXUoY
 7FSP9ACQ+1f3K0U7rgk/22mbXJI0EgJI6YuBWp+GoNd/wDLqWIAs6qoOEdI2klNcU1lR
 Mo40T9aSUgutbq+rLtC2i19b07dYds8ftC+mwodg5e79D36/3NC1RDrmQJXmUp1avDXT
 15grMPE7KsLOX0hlhvkLfMmtkgsiq3zcYzpB2NcAItA+OddpY5TH+rS8DWn+v2hTDYk7
 nyFkJVfk+7yxFAka5bFURQIEw6JM5udgv+P7giwjD7f4g9FKpLgcVmlvwOnxianqOoQT
 SZbA==
X-Gm-Message-State: AGi0PuaNi5I3s6EoFpXZCeqDzCORnhDOzGCzlkV9GS451jKHwExXYQKC
 sMSBZW4pGlsyfAoj1Rac/Ag=
X-Google-Smtp-Source: APiQypLexOuP0xGt7FVTN6HqoVwNcA9Kq/PG79jVtOU4Ze9cRgYffbYgbXKNM10qOGHPt7kAUx1dYQ==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr3860038wme.115.1588693120333; 
 Tue, 05 May 2020 08:38:40 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id s24sm4572390wmj.28.2020.05.05.08.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 08:38:39 -0700 (PDT)
Date: Tue, 5 May 2020 18:38:38 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200505153838.GC2862@jondnuc>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200505150637.7131e79b@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/2020, Igor Mammedov wrote:

I dont know what were the original intentions of the original patch 
authors (at this point I simply rebased it, and to be honest I did not 
need this patch to get where I was going to, but it was part of the 
original patchset).

But I'm willing to do any changes so we can keep going forward with 
this.

>On Fri, 24 Apr 2020 15:34:43 +0300
>Jon Doron <arilou@gmail.com> wrote:
>
>> Guest OS uses ACPI to discover VMBus presence.  Add a corresponding
>> entry to DSDT in case VMBus has been enabled.
>>
>> Experimentally Windows guests were found to require this entry to
>> include two IRQ resources. They seem to never be used but they still
>> have to be there.
>>
>> Make IRQ numbers user-configurable via corresponding properties; use 7
>> and 13 by default.
>well, it seems that at least linux guest driver uses one IRQ,
>abeit not from ACPI descriptior
>
>perhaps it's what hyperv host puts into _CRS.
>Could you dump ACPI tables and check how hyperv describes vmbus in acpi?
>
>

I can no longer get to the HyperV computer I had (in the office so 
hopefully if someone else has access to HyperV machine and willing to 
reply here with the dumped ACPI tables that would be great).

>also what if vmbus irq collides with an irq that is already taken,
>it would be better to initialize and consume irqs it climes to use
>so in case if conflict one would get a error.
>

Sounds right. I tried to see if there is any place in acpi that checks 
if an IRQ is taken or not but could not find any, can you point me out 
to a place where it's done?

If not then I guess we need a function that iterates through all 
registered IRQs so we can find if we have a conflict.
Probably the best places to put it is where you build the acpi aml, but 
that would really make the code more complicated (i.e 
build_append_int_noprefix and aml_interrupt).

In case I have not understood you right please let me know.


>> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> Signed-off-by: Jon Doron <arilou@gmail.com>
>> ---
>>  hw/hyperv/vmbus.c                |  7 ++++++
>>  hw/i386/acpi-build.c             | 43 ++++++++++++++++++++++++++++++++
>>  include/hw/hyperv/vmbus-bridge.h |  3 +++
>>  3 files changed, 53 insertions(+)
>>
>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>> index 1f5873ab60..0df7afe0ca 100644
>> --- a/hw/hyperv/vmbus.c
>> +++ b/hw/hyperv/vmbus.c
>> @@ -2641,6 +2641,12 @@ static const VMStateDescription vmstate_vmbus_bridge = {
>>      },
>>  };
>>
>> +static Property vmbus_bridge_props[] = {
>> +    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
>> +    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
>> +    DEFINE_PROP_END_OF_LIST()
>> +};
>> +
>>  static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *k = DEVICE_CLASS(klass);
>> @@ -2651,6 +2657,7 @@ static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
>>      sk->explicit_ofw_unit_address = vmbus_bridge_ofw_unit_address;
>>      set_bit(DEVICE_CATEGORY_BRIDGE, k->categories);
>>      k->vmsd = &vmstate_vmbus_bridge;
>> +    device_class_set_props(k, vmbus_bridge_props);
>>      /* override SysBusDevice's default */
>>      k->user_creatable = true;
>>  }
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 2a7e55bae7..d235074fb8 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -50,6 +50,7 @@
>>  #include "hw/mem/nvdimm.h"
>>  #include "sysemu/numa.h"
>>  #include "sysemu/reset.h"
>> +#include "hw/hyperv/vmbus-bridge.h"
>>
>>  /* Supported chipsets: */
>>  #include "hw/southbridge/piix.h"
>> @@ -1270,9 +1271,47 @@ static Aml *build_com_device_aml(uint8_t uid)
>>      return dev;
>>  }
>>
>> +static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>> +{
>> +    Aml *dev;
>> +    Aml *method;
>> +    Aml *crs;
>> +
>> +    dev = aml_device("VMBS");
>> +    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
>> +    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
>> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
>> +
>> +    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
>> +                                     aml_name("STA")));
>> +    aml_append(dev, method);
>> +
>> +    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
>> +                                     aml_name("STA")));
>> +    aml_append(dev, method);
>> +
>> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>> +    aml_append(method, aml_return(aml_name("STA")));
>> +    aml_append(dev, method);
>
>do you reaaly need all that _STA/_DIS/_PS0,
>does it work without thouse methods?
>
>> +
>> +    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
>should be method
>
>> +
>> +    crs = aml_resource_template();
>> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
>> +    /* FIXME: newer HyperV gets by with only one IRQ */
>then why are you adding the second IRQ, does it work with 1 IRQ?
>
>> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
>> +    aml_append(dev, aml_name_decl("_CRS", crs));
>> +
>> +    return dev;
>> +}
>> +
>>  static void build_isa_devices_aml(Aml *table)
>>  {
>>      ISADevice *fdc = pc_find_fdc0();
>> +    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>>      bool ambiguous;
>>
>>      Aml *scope = aml_scope("_SB.PCI0.ISA");
>> @@ -1296,6 +1335,10 @@ static void build_isa_devices_aml(Aml *table)
>>          build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
>>      }
>>
>> +    if (vmbus_bridge) {
>> +        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
>> +    }
>it seems that bridge is sysbus device, why it's put under ISA bus?
>

That's where the original author put it, where would you prefer it will 
go?

>>      aml_append(table, scope);
>>  }
>>
>> diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
>> index 9cc8f780de..c0a06d832c 100644
>> --- a/include/hw/hyperv/vmbus-bridge.h
>> +++ b/include/hw/hyperv/vmbus-bridge.h
>> @@ -19,6 +19,9 @@ typedef struct VMBus VMBus;
>>  typedef struct VMBusBridge {
>>      SysBusDevice parent_obj;
>>
>> +    uint8_t irq0;
>> +    uint8_t irq1;
>> +
>>      VMBus *bus;
>>  } VMBusBridge;
>>
>

For your other questions I have no clue like I said I have only rebased 
the latest revision (which was about 1-2 years old).

-- Jon.


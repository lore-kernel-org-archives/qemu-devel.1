Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C00C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200322078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpqgBewB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200322078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxNs-00026R-3r
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxHm-0006oL-H5
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:06:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVxHl-0007Lr-3f
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588684016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERPKtdOoduG++tNFYyETNxyJ1etzc0GvGsxVvXUNVhM=;
 b=OpqgBewBhSuyN3CBfyNq858rGsG/cDBc6j42gSzWXPStpqf0wkr6K0GQQzhNgVXseeVWJ6
 5bJPdp+xTFoShRorlVk/FfZAR6+OZHCfNpdOESni78RCdd+DDGL2VFi2GLxvX2DMmn/e4b
 bCFAG1OMREzjyqVZHwAsQumdQeVom1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-qAeEPJNpOIi4vG77sG81IA-1; Tue, 05 May 2020 09:06:48 -0400
X-MC-Unique: qAeEPJNpOIi4vG77sG81IA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884E980183C;
 Tue,  5 May 2020 13:06:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB4662E02D;
 Tue,  5 May 2020 13:06:39 +0000 (UTC)
Date: Tue, 5 May 2020 15:06:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200505150637.7131e79b@redhat.com>
In-Reply-To: <20200424123444.3481728-6-arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

On Fri, 24 Apr 2020 15:34:43 +0300
Jon Doron <arilou@gmail.com> wrote:

> Guest OS uses ACPI to discover VMBus presence.  Add a corresponding
> entry to DSDT in case VMBus has been enabled.
> 
> Experimentally Windows guests were found to require this entry to
> include two IRQ resources. They seem to never be used but they still
> have to be there.
> 
> Make IRQ numbers user-configurable via corresponding properties; use 7
> and 13 by default.
well, it seems that at least linux guest driver uses one IRQ,
abeit not from ACPI descriptior

perhaps it's what hyperv host puts into _CRS.
Could you dump ACPI tables and check how hyperv describes vmbus in acpi?


also what if vmbus irq collides with an irq that is already taken,
it would be better to initialize and consume irqs it climes to use
so in case if conflict one would get a error.

> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/hyperv/vmbus.c                |  7 ++++++
>  hw/i386/acpi-build.c             | 43 ++++++++++++++++++++++++++++++++
>  include/hw/hyperv/vmbus-bridge.h |  3 +++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 1f5873ab60..0df7afe0ca 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -2641,6 +2641,12 @@ static const VMStateDescription vmstate_vmbus_bridge = {
>      },
>  };
>  
> +static Property vmbus_bridge_props[] = {
> +    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
> +    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k = DEVICE_CLASS(klass);
> @@ -2651,6 +2657,7 @@ static void vmbus_bridge_class_init(ObjectClass *klass, void *data)
>      sk->explicit_ofw_unit_address = vmbus_bridge_ofw_unit_address;
>      set_bit(DEVICE_CATEGORY_BRIDGE, k->categories);
>      k->vmsd = &vmstate_vmbus_bridge;
> +    device_class_set_props(k, vmbus_bridge_props);
>      /* override SysBusDevice's default */
>      k->user_creatable = true;
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2a7e55bae7..d235074fb8 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -50,6 +50,7 @@
>  #include "hw/mem/nvdimm.h"
>  #include "sysemu/numa.h"
>  #include "sysemu/reset.h"
> +#include "hw/hyperv/vmbus-bridge.h"
>  
>  /* Supported chipsets: */
>  #include "hw/southbridge/piix.h"
> @@ -1270,9 +1271,47 @@ static Aml *build_com_device_aml(uint8_t uid)
>      return dev;
>  }
>  
> +static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
> +{
> +    Aml *dev;
> +    Aml *method;
> +    Aml *crs;
> +
> +    dev = aml_device("VMBS");
> +    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
> +
> +    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_name("STA")));
> +    aml_append(dev, method);

do you reaaly need all that _STA/_DIS/_PS0,
does it work without thouse methods?

> +
> +    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
should be method

> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
> +    /* FIXME: newer HyperV gets by with only one IRQ */
then why are you adding the second IRQ, does it work with 1 IRQ?

> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    return dev;
> +}
> +
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> +    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>      bool ambiguous;
>  
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
> @@ -1296,6 +1335,10 @@ static void build_isa_devices_aml(Aml *table)
>          build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
>      }
>  
> +    if (vmbus_bridge) {
> +        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
> +    }
it seems that bridge is sysbus device, why it's put under ISA bus?

>      aml_append(table, scope);
>  }
>  
> diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
> index 9cc8f780de..c0a06d832c 100644
> --- a/include/hw/hyperv/vmbus-bridge.h
> +++ b/include/hw/hyperv/vmbus-bridge.h
> @@ -19,6 +19,9 @@ typedef struct VMBus VMBus;
>  typedef struct VMBusBridge {
>      SysBusDevice parent_obj;
>  
> +    uint8_t irq0;
> +    uint8_t irq1;
> +
>      VMBus *bus;
>  } VMBusBridge;
>  



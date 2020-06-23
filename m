Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BFBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0AD20723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpBOtB3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0AD20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkQr-0004ev-OW
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkNe-0000vF-R0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:58:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34919
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkNd-0004R3-2c
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592924312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUBs5+JKlyJtdULGxedpuQNXfn9HPkiPWBVdnn7V3c4=;
 b=LpBOtB3wplvOyjRPGu8rDK4ONEMtCI7/jSs/VWmFh33sGgvreJ2hCOYowfpUrIwZmIbtPE
 V3kdXPVgApYkeEzwS/iJXiBOSYa2rp0tFTXM/MS4EygvFGoN3kdnThJlDI9PMDknE+jbxC
 Anbx9gxUCljno8JiUkEn74CyWOCP8aI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-MM_7eBD6NF-D8GDoMdvv0g-1; Tue, 23 Jun 2020 10:58:28 -0400
X-MC-Unique: MM_7eBD6NF-D8GDoMdvv0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ECC7805EE3;
 Tue, 23 Jun 2020 14:58:27 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E061F5C3E7;
 Tue, 23 Jun 2020 14:58:23 +0000 (UTC)
Date: Tue, 23 Jun 2020 16:58:22 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v3 1/3] hyperv: vmbus: Remove the 2nd IRQ
Message-ID: <20200623165822.2fd73965@redhat.com>
In-Reply-To: <20200618030027.759594-2-arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-2-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, vkuznets@redhat.com,
 mail@maciej.szmigiero.name, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 06:00:25 +0300
Jon Doron <arilou@gmail.com> wrote:

> It seems like Windows does not really require 2 IRQs to have a
> functioning VMBus.
> 
> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/hyperv/vmbus.c                | 3 +--
>  hw/i386/acpi-build.c             | 4 +---
>  include/hw/hyperv/vmbus-bridge.h | 3 +--
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index f371240176..a8bcb41026 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -2741,8 +2741,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
>  };
>  
>  static Property vmbus_bridge_props[] = {
> -    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
> -    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
> +    DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08..91af0d2d0d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1082,9 +1082,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>      aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
>  
>      crs = aml_resource_template();
> -    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
> -    /* FIXME: newer HyperV gets by with only one IRQ */
> -    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
>      return dev;
> diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
> index c0a06d832c..33f93de64d 100644
> --- a/include/hw/hyperv/vmbus-bridge.h
> +++ b/include/hw/hyperv/vmbus-bridge.h
> @@ -19,8 +19,7 @@ typedef struct VMBus VMBus;
>  typedef struct VMBusBridge {
>      SysBusDevice parent_obj;
>  
> -    uint8_t irq0;
> -    uint8_t irq1;
> +    uint8_t irq;
>  
>      VMBus *bus;
>  } VMBusBridge;



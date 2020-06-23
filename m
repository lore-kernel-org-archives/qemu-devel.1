Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0200CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4C92073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYdHLXuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4C92073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkb6-0002J8-1L
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkYv-0008Uv-7e
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:10:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkYs-00042v-Ae
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 11:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592925008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RGwLTMh557i9eYUW7REGF96qLnJ0L6G/wEg1q0P6YDE=;
 b=WYdHLXufcmXoTSuGz3YrjdlvvsO2w+7MzomBP2pXhzeGPd6CCDAc6dq3PZTfd+2Eg+P0h+
 irbGl5OyXMJvK6PghfOPGxufmQf1IfDX64IezU7wd19bzqYnNjByk3UQNz3L3shcmq4cLE
 DVvEHkZja89ZQ0RUucHvi/eP/t8oV8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-eduePZ8KPySyTx5Fu4OYRQ-1; Tue, 23 Jun 2020 11:10:01 -0400
X-MC-Unique: eduePZ8KPySyTx5Fu4OYRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AEF5107AFB6;
 Tue, 23 Jun 2020 15:10:00 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C269060F8D;
 Tue, 23 Jun 2020 15:09:56 +0000 (UTC)
Date: Tue, 23 Jun 2020 17:09:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v3 3/3] acpi: i386: Move VMBus DSDT entry to SB
Message-ID: <20200623170955.0a4f3ae7@redhat.com>
In-Reply-To: <20200618030027.759594-4-arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-4-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 06:00:27 +0300
Jon Doron <arilou@gmail.com> wrote:

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/i386/acpi-build.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6d9df38e31..38be9e5a58 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1092,7 +1092,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> -    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>      bool ambiguous;
>  
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
> @@ -1113,10 +1112,6 @@ static void build_isa_devices_aml(Aml *table)
>          isa_build_aml(ISA_BUS(obj), scope);
>      }
>  
> -    if (vmbus_bridge) {
> -        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
> -    }
> -
>      aml_append(table, scope);
>  }
>  
> @@ -1661,6 +1656,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      PCIBus *bus = NULL;
>      TPMIf *tpm = tpm_find();
>      int i;
> +    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>  
>      dsdt = init_aml_allocator();
>  
> @@ -1675,6 +1671,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>          aml_append(sb_scope, dev);
> +        if (vmbus_bridge) {
> +            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
> +        }
>          aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
> @@ -1692,6 +1691,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>          aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
> +        if (vmbus_bridge) {
> +            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
> +        }
>          aml_append(dsdt, sb_scope);
>  
>          build_hpet_aml(dsdt);
why are you duplicating instead of putting one if () block after

if (misc->is_piix4) {
} else {
}

?



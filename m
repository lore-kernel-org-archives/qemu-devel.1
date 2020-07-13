Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E82C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D132065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIuag64H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D132065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutzK-0008WP-0q
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jutyh-0007ot-EB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jutyf-0008UF-Sw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594629500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9hankbEvoDgUtF4ycOc5a6GOWS9oVV25slQNXk1KS8=;
 b=OIuag64HT4/QK54hc00d0iQoSdi4kha1oG6c0krNcnR9FQcBFd6al7YkF/IOpPEb2Btrl2
 haw6vONRYy9zG0RrSev0BkJw2Ejy++MX1DVIcyCeQu3OkoRXTklAnFJgKqMriq9AeuxvZE
 voEl6noGHzZQTBlmX0q8EtH9eWUBahs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-_psldmvVNWe-sEyS396-pg-1; Mon, 13 Jul 2020 04:38:19 -0400
X-MC-Unique: _psldmvVNWe-sEyS396-pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AB8918FF679;
 Mon, 13 Jul 2020 08:38:17 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 579FA6FEDF;
 Mon, 13 Jul 2020 08:38:13 +0000 (UTC)
Date: Mon, 13 Jul 2020 10:38:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v4 2/2] acpi: i386: Move VMBus DSDT entry to SB
Message-ID: <20200713103809.66e94131@redhat.com>
In-Reply-To: <20200625045011.1075314-3-arilou@gmail.com>
References: <20200625045011.1075314-1-arilou@gmail.com>
 <20200625045011.1075314-3-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 25 Jun 2020 07:50:11 +0300
Jon Doron <arilou@gmail.com> wrote:

> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 91af0d2d0d..1f938a53b2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1091,7 +1091,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> -    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>      bool ambiguous;
>  
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
> @@ -1112,10 +1111,6 @@ static void build_isa_devices_aml(Aml *table)
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
> @@ -1660,6 +1655,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      PCIBus *bus = NULL;
>      TPMIf *tpm = tpm_find();
>      int i;
> +    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
>  
>      dsdt = init_aml_allocator();
>  
> @@ -1702,6 +1698,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          }
>      }
>  
> +    if (vmbus_bridge) {
> +        sb_scope = aml_scope("_SB");
> +        aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
> +        aml_append(dsdt, sb_scope);
> +    }
> +
>      if (pcmc->legacy_cpu_hotplug) {
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {



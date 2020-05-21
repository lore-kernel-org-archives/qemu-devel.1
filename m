Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC805C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE4C2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWo1q9A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE4C2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbh9o-000118-Rm
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh6m-0007DP-Hr
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:03:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh6l-0004E4-NL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590051798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lupebLF3ENs6eM+ptyevS1ppMGHpywHCSanbT8aN7P0=;
 b=TWo1q9A++DL3Id42CkMPraiAf717uh9XZ+6AY8+6oDMcysjMR8Hka3j9TSJnB9TGMYQz5m
 q0/EyHjytFdtuSlLZGyPP9C9N0FbzA4S9sHu8vpRJozFDxvROfzKUQZCKXCk0aKCloRmSR
 1V5CJ3JONY2jGMFEioEH+sshfXlQyLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-XN_HIBg0MqKEukP5iGLj5A-1; Thu, 21 May 2020 05:03:17 -0400
X-MC-Unique: XN_HIBg0MqKEukP5iGLj5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1264C80183C;
 Thu, 21 May 2020 09:03:16 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB5F95EE0E;
 Thu, 21 May 2020 09:03:03 +0000 (UTC)
Date: Thu, 21 May 2020 11:03:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 12/22] acpi: move acpi_dsdt_add_power_button() to ged
Message-ID: <20200521110302.36f21084@redhat.com>
In-Reply-To: <20200520132003.9492-13-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-13-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 15:19:53 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Allow reuse for microvm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/generic_event_device.h | 1 +
>  hw/acpi/generic_event_device.c         | 8 ++++++++
>  hw/arm/virt-acpi-build.c               | 8 --------
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 9687cb524258..ebed1ffe4231 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -113,5 +113,6 @@ typedef struct AcpiGedState {
>  
>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
>                     uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
> +void acpi_dsdt_add_power_button(Aml *scope);
>  
>  #endif
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 3072fb4ab32b..cde50da5b3ca 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -142,6 +142,14 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>      aml_append(table, dev);
>  }
>  
> +void acpi_dsdt_add_power_button(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(scope, dev);
> +}
> +
>  /* Memory read by the GED _EVT AML dynamic method */
>  static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
>  {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1b0a584c7b62..49eacc622219 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -354,14 +354,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>      aml_append(scope, dev);
>  }
>  
> -static void acpi_dsdt_add_power_button(Aml *scope)
> -{
> -    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -    aml_append(scope, dev);
> -}
> -
>  static void
>  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  {



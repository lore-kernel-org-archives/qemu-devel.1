Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582A9C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FB520663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhG0oOAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FB520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEu7C-0002Gv-9r
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEu6R-0001s2-K7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEu6Q-0007J3-FI
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:16:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEu6Q-0007Gx-A8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584620205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbMQAHh7wrNYhB/oUBUf+MxWDoSyZ2w/8FG7Q664oTs=;
 b=BhG0oOAKqpYKte/NbAD4KTMRQiWnIlF6gS6JIYrR4ACoY4YxG7hvQQdySGG/wFLd7oCwbu
 X6wVbKQlCAn2wGQaVyC9NV/1nNe0sIeCXVl8jtGP6S27hI7vhvQ62TvasKM9g4sNnFquWK
 cLol1n3zp4QTI4vSgqGUKXP8NJUfaUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-rxSg8BmOOhm8tY4F1v2q5w-1; Thu, 19 Mar 2020 08:16:44 -0400
X-MC-Unique: rxSg8BmOOhm8tY4F1v2q5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA8D1088382;
 Thu, 19 Mar 2020 12:16:42 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.194.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC83460BF1;
 Thu, 19 Mar 2020 12:16:33 +0000 (UTC)
Date: Thu, 19 Mar 2020 13:16:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 02/13] acpi: factor out acpi_dsdt_add_fw_cfg()
Message-ID: <20200319131629.6ad37426@office.mammed.net>
In-Reply-To: <20200319080117.7725-3-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-3-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 09:01:06 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add helper function to add fw_cfg device.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-build.c | 50 ++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1b0684c433e3..9c98b07116cc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1822,6 +1822,32 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
>      aml_append(table, scope);
>  }
>  
> +static void acpi_dsdt_add_fw_cfg(Aml *scope, Object *fw_cfg)
I'd pass fwcfg type as is and then cast to OBJECT inside of this function

> +{
> +    /*
> +     * when using port i/o, the 8-bit data register *always* overlaps
> +     * with half of the 16-bit control register. Hence, the total size
> +     * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
> +     * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
> +     */
> +    uint8_t io_size = object_property_get_bool(fw_cfg, "dma_enabled", NULL) ?
> +        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
> +        FW_CFG_CTL_SIZE;
> +    Aml *dev = aml_device("FWCF");
> +    Aml *crs = aml_resource_template();
> +
> +    aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> +
> +    /* device present, functioning, decoding, not shown in UI */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> +
> +    aml_append(crs,
> +        aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_size));
> +
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -2101,30 +2127,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  
>      /* create fw_cfg node, unconditionally */
>      {
> -        /* when using port i/o, the 8-bit data register *always* overlaps
> -         * with half of the 16-bit control register. Hence, the total size
> -         * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
> -         * DMA control register is located at FW_CFG_DMA_IO_BASE + 4 */
> -        uint8_t io_size = object_property_get_bool(OBJECT(x86ms->fw_cfg),
> -                                                   "dma_enabled", NULL) ?
> -                          ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
> -                          FW_CFG_CTL_SIZE;
> -
>          scope = aml_scope("\\_SB.PCI0");
> -        dev = aml_device("FWCF");
> -
> -        aml_append(dev, aml_name_decl("_HID", aml_string("QEMU0002")));
> -
> -        /* device present, functioning, decoding, not shown in UI */
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -
> -        crs = aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, FW_CFG_IO_BASE, FW_CFG_IO_BASE, 0x01, io_size)
> -        );
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -        aml_append(scope, dev);
> +        acpi_dsdt_add_fw_cfg(scope, OBJECT(x86ms->fw_cfg));
>          aml_append(dsdt, scope);
>      }
>  



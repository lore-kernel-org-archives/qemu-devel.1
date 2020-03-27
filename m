Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CCC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E826120658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4VbkSLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E826120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHpsS-000537-6Z
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHprv-0004eU-2N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHprt-00015e-OZ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:21:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57837)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHprt-00011U-KC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585318911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dq+OpDvLcGmpxE4zpe3EBegNKiezMtYa1W0FOCs89cE=;
 b=U4VbkSLipgQDWpYCee+wM57o33Hj2XVLr+FiCW+Hsg4nwBhg8rHFKJ9bALG397E6KY8a3Q
 ByiG8e502SugoOxcdvaD9AuXK8lr29Y0E+EKZlH7YqpmTf3SX5Mtv5f4i0CQfMY0GNoIYu
 qoYhdzgyzWmpymDtyvOo5ryeEyyTqvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-VxR_dmWSMXyqDRhyZ-hRLQ-1; Fri, 27 Mar 2020 10:21:47 -0400
X-MC-Unique: VxR_dmWSMXyqDRhyZ-hRLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FF2801E67;
 Fri, 27 Mar 2020 14:21:46 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF5735C1C3;
 Fri, 27 Mar 2020 14:21:38 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:21:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 4/6] acpi: drop pointless _STA method
Message-ID: <20200327152137.41fb1e51@redhat.com>
In-Reply-To: <20200327121111.1530-5-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-5-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 13:11:09 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> When returning a constant there is no point in having a method
> in the first place, _STA can be a simple integer instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

nice,

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

ps:

maybe somewhere in earlier patches s/acpi-build-pc.c/pc-acpi.c/

> ---
>  hw/i386/acpi-build-pc.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
> index 3fdae2984b91..18ca2fd46961 100644
> --- a/hw/i386/acpi-build-pc.c
> +++ b/hw/i386/acpi-build-pc.c
> @@ -1137,14 +1137,11 @@ static Aml *build_kbd_device_aml(void)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *method;
>  
>      dev = aml_device("KBD");
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
>  
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_return(aml_int(0x0f)));
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> @@ -1159,14 +1156,11 @@ static Aml *build_mouse_device_aml(void)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *method;
>  
>      dev = aml_device("MOU");
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
>  
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_return(aml_int(0x0f)));
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_irq_no_flags(12));
> @@ -2229,9 +2223,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                                             TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
>          aml_append(dev, aml_name_decl("_CRS", crs));
>  
> -        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -        aml_append(method, aml_return(aml_int(0x0f)));
> -        aml_append(dev, method);
> +        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  
>          tpm_build_ppi_acpi(tpm, dev);
>  



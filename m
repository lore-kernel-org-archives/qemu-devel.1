Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6973FC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7A8206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpdGLg6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7A8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEDP-0003b9-8e
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYEBq-0002I8-Ng
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:34:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24057
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYEBp-00067A-Am
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589225652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFde+1YE9ngXEbf2YWxS762JAhaTIMlbOaHsRqLoZyY=;
 b=hpdGLg6f4H54K2aaJ8kC/7D4HMZwXAcE+SoyzZlOVHIHs7sxDCF875uBvzZhDHMuc3D1JQ
 wFpuFOCf5qDqPsqGiXPFOcjgAIL83t09hDeEhu3mXWYEG8Dp2iuzKtbLkq2rd/4TUyIvt7
 A4X04Os05RKB3mO76iaVeRL3uvel07c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-2oJJBliwOTG59xEuth3TBw-1; Mon, 11 May 2020 15:34:08 -0400
X-MC-Unique: 2oJJBliwOTG59xEuth3TBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5667B19067E0;
 Mon, 11 May 2020 19:34:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F33497526E;
 Mon, 11 May 2020 19:33:54 +0000 (UTC)
Date: Mon, 11 May 2020 21:33:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 12/15] acpi: drop serial/parallel enable bits from dsdt
Message-ID: <20200511213353.7a264424@redhat.com>
In-Reply-To: <20200507131640.14041-13-kraxel@redhat.com>
References: <20200507131640.14041-1-kraxel@redhat.com>
 <20200507131640.14041-13-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  7 May 2020 15:16:37 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The _STA methods for COM+LPT used to reference them,
> but that isn't the case any more.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  hw/i386/acpi-build.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 1922868f3401..765409a90eb6 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1437,15 +1437,6 @@ static void build_q35_isa_bridge(Aml *table)
>      aml_append(field, aml_named_field("LPTD", 2));
>      aml_append(dev, field);
>  
> -    aml_append(dev, aml_operation_region("LPCE", AML_PCI_CONFIG,
> -                                         aml_int(0x82), 0x02));
> -    /* enable bits */
> -    field = aml_field("LPCE", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> -    aml_append(field, aml_named_field("CAEN", 1));
> -    aml_append(field, aml_named_field("CBEN", 1));
> -    aml_append(field, aml_named_field("LPEN", 1));
> -    aml_append(dev, field);
> -
>      aml_append(scope, dev);
>      aml_append(table, scope);
>  }
> @@ -1469,7 +1460,6 @@ static void build_piix4_isa_bridge(Aml *table)
>  {
>      Aml *dev;
>      Aml *scope;
> -    Aml *field;
>  
>      scope =  aml_scope("_SB.PCI0");
>      dev = aml_device("ISA");
> @@ -1478,19 +1468,6 @@ static void build_piix4_isa_bridge(Aml *table)
>      /* PIIX PCI to ISA irq remapping */
>      aml_append(dev, aml_operation_region("P40C", AML_PCI_CONFIG,
>                                           aml_int(0x60), 0x04));
> -    /* enable bits */
> -    field = aml_field("^PX13.P13C", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> -    /* Offset(0x5f),, 7, */
> -    aml_append(field, aml_reserved_field(0x2f8));
> -    aml_append(field, aml_reserved_field(7));
> -    aml_append(field, aml_named_field("LPEN", 1));
> -    /* Offset(0x67),, 3, */
> -    aml_append(field, aml_reserved_field(0x38));
> -    aml_append(field, aml_reserved_field(3));
> -    aml_append(field, aml_named_field("CAEN", 1));
> -    aml_append(field, aml_reserved_field(3));
> -    aml_append(field, aml_named_field("CBEN", 1));
> -    aml_append(dev, field);
>  
>      aml_append(scope, dev);
>      aml_append(table, scope);



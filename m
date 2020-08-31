Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA67C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6582073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B++aROmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6582073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCefw-0006Xe-AR
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kCefH-0005t9-JV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kCefG-00024h-2o
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598860540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7b2LyFHhtm4vWXXZDTl9wBLfLDjWZif/08S3Aao3XQ=;
 b=B++aROmS6kksfHfkfEjf65t2Yj5A9a6JJoppdAazb/aMgWVp7LwHwgDt0k9CcK7JEdDBQM
 u4rXkVW1+h1AVe/9wZ1w1CkIBKZuPb+SOnVtNg/FFaI3//M6EEnk+1XdKfMNbfcy8E7lDD
 7BuVUUaY/O3hMGujcwvuVV0MnRHrljA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-8w0UvtRNNhiW2Kl3J2Rr8A-1; Mon, 31 Aug 2020 03:55:36 -0400
X-MC-Unique: 8w0UvtRNNhiW2Kl3J2Rr8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D6A6801AC3;
 Mon, 31 Aug 2020 07:55:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AF1E5C225;
 Mon, 31 Aug 2020 07:55:24 +0000 (UTC)
Date: Mon, 31 Aug 2020 09:55:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 13/20] x86: constify x86_machine_is_*_enabled
Message-ID: <20200831095523.44526dca@redhat.com>
In-Reply-To: <20200826105254.28496-14-kraxel@redhat.com>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-14-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Aug 2020 12:52:47 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/x86.h | 4 ++--
>  hw/i386/x86.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index b79f24e28545..a350ea3609f5 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -110,8 +110,8 @@ void x86_load_linux(X86MachineState *x86ms,
>                      bool pvh_enabled,
>                      bool linuxboot_dma_enabled);
>  
> -bool x86_machine_is_smm_enabled(X86MachineState *x86ms);
> -bool x86_machine_is_acpi_enabled(X86MachineState *x86ms);
> +bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
> +bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
>  
>  /* Global System Interrupts */
>  
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index cf384b974318..31a82885d735 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -845,7 +845,7 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
>                                  bios);
>  }
>  
> -bool x86_machine_is_smm_enabled(X86MachineState *x86ms)
> +bool x86_machine_is_smm_enabled(const X86MachineState *x86ms)
>  {
>      bool smm_available = false;
>  
> @@ -887,7 +887,7 @@ static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
>      visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
>  }
>  
> -bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
> +bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
>  {
>      if (x86ms->acpi == ON_OFF_AUTO_OFF) {
>          return false;



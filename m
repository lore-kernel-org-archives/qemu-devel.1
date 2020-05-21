Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE30C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A6520721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5l+McUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A6520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbiR3-00056O-NL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbiQ0-00043J-VC
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:27:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbiPz-000345-6g
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590056834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tkd4068jEvlVmaDuNEwMVaaScmhaQF7nSydtATQuXNU=;
 b=M5l+McUlHpY/b3QSTLgPFY2OOaTqhNSXEGYS1LXpowwHcWEO4E/vfgPw9rm6JFoCq0fPDm
 XyW+CoqdAS6ollkfRRp3x3EI1g6V1nTjUcUKodi7oiTBSqRPxlq8qjYpx3Rj+OfJdssuOp
 p1sMzvKprrIMDC6jYnokcR3j8bdtq8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-iHzHyRbQMyi_iNtWqZgUuQ-1; Thu, 21 May 2020 06:27:10 -0400
X-MC-Unique: iHzHyRbQMyi_iNtWqZgUuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4827E460;
 Thu, 21 May 2020 10:27:09 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB435C1B0;
 Thu, 21 May 2020 10:26:57 +0000 (UTC)
Date: Thu, 21 May 2020 12:26:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 21/22] [RfC] acpi: add per machine type acpi default
Message-ID: <20200521122654.455d47dc@redhat.com>
In-Reply-To: <20200520132003.9492-22-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-22-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 20 May 2020 15:20:02 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Allow setting acpi default value for each machine type.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/x86.h |  1 +
>  hw/i386/x86.c         | 21 ++++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index b52285481687..d2fffa8252ff 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -37,6 +37,7 @@ typedef struct {
>      bool save_tsc_khz;
>      /* Enables contiguous-apic-ID mode */
>      bool compat_apic_id_mode;
> +    bool acpi_default;
>  } X86MachineClass;
>  
>  typedef struct {
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ac7a0a958781..3a56a157c5f0 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -940,10 +940,22 @@ static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
>  
>  bool x86_machine_is_acpi_enabled(X86MachineState *x86ms)
>  {
> -    if (x86ms->acpi == ON_OFF_AUTO_OFF) {
> -        return false;
> +    X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
> +    bool enabled;
> +
> +    switch (x86ms->acpi) {
> +    case ON_OFF_AUTO_ON:
> +        enabled = true;
> +        break;
> +    case ON_OFF_AUTO_OFF:
> +        enabled = false;
> +        break;
> +    case ON_OFF_AUTO_AUTO:
> +    default:
> +        enabled = x86mc->acpi_default;
> +        break;
>      }
> -    return true;
> +    return enabled;

why not make x86ms->acpi a boolean and move logic from here to x86_machine_[get|set]_acpi()
to avoid extra helper, the external users would use property acessesors and
internal (microvm  code) can just access  x86ms->acpi directly

>  }
>  
>  static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
> @@ -991,6 +1003,9 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
>      x86mc->save_tsc_khz = true;
>      nc->nmi_monitor_handler = x86_nmi;
>  
> +    /* acpi is on by default */
> +    x86mc->acpi_default = true;
> +
>      object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
>          x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g,
>          NULL, NULL);



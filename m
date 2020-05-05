Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8625C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86521206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRpi30PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86521206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyge-0001ST-LR
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyfr-0000yS-Jp
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:35:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38184
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVyfp-0006D9-U7
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588689352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrWdsCuCHniSjPCOc/vYePw/eoWhvrEeH6fYELMhL4M=;
 b=XRpi30PUhivvEZECRCFmeHEvuvrA//JFca7EYbDmH8k08U/MXovLhRPIDoWZKxh2GTJ0Mb
 BdhlTsFK2a7mT+P68z6s5yVj03PUQhxtNe56UcQ8frLzR930hCMthXfww2NOcjcjaXbJ7P
 DO4S1fgDE5oWaavsh/YXjnKlRzZuVAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-_yysxQYHP_efdxCVLGZZkw-1; Tue, 05 May 2020 10:35:51 -0400
X-MC-Unique: _yysxQYHP_efdxCVLGZZkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E943B8064D1;
 Tue,  5 May 2020 14:35:49 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABB954233;
 Tue,  5 May 2020 14:35:36 +0000 (UTC)
Date: Tue, 5 May 2020 16:35:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 07/13] acpi: fadt: add hw-reduced sleep register support
Message-ID: <20200505163535.3ca376fc@redhat.com>
In-Reply-To: <20200505134305.22666-8-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-8-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:42:59 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add fields to struct AcpiFadtData and update build_fadt() to properly
> generate sleep register entries.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/acpi-defs.h | 2 ++
>  hw/acpi/aml-build.c         | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index c13327fa7867..3be9ab504968 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -88,6 +88,8 @@ typedef struct AcpiFadtData {
>      struct AcpiGenericAddress pm_tmr;    /* PM_TMR_BLK */
>      struct AcpiGenericAddress gpe0_blk;  /* GPE0_BLK */
>      struct AcpiGenericAddress reset_reg; /* RESET_REG */
> +    struct AcpiGenericAddress sleep_ctl; /* SLEEP_CONTROL_REG */
> +    struct AcpiGenericAddress sleep_sts; /* SLEEP_STATUS_REG */
>      uint8_t reset_val;         /* RESET_VALUE */
>      uint8_t  rev;              /* Revision */
>      uint32_t flags;            /* Flags */
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2c3702b8825b..c159b0d30022 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1863,9 +1863,9 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>      }
>  
>      /* SLEEP_CONTROL_REG */
> -    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
> +    build_append_gas_from_struct(tbl, &f->sleep_ctl);
>      /* SLEEP_STATUS_REG */
> -    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
> +    build_append_gas_from_struct(tbl, &f->sleep_sts);
>  
>      /* TODO: extra fields need to be added to support revisions above rev5 */
>      assert(f->rev == 5);



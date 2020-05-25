Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A767DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8502070A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JosIrdcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8502070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdGEW-0006Sv-Lk
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 12:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdGDT-0005lH-Lv
 for qemu-devel@nongnu.org; Mon, 25 May 2020 12:44:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdGDR-0001VJ-U7
 for qemu-devel@nongnu.org; Mon, 25 May 2020 12:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590425080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gf3r9sqNSSn4m3BfQM2aytPpmei85VMCCiWrZAZUNPA=;
 b=JosIrdcDR9PdYDNSuhdUOeSB+nhAcFb9Kp18G8w58c5SMQCKHs/+32jCclDuZB1BCqIzZF
 UDWG4NXOw/FJnCtcCJSje/oDM11Ai9EiJlKnWBbWNxaGA6L8096A+yCYHiXp+y6N/4GHMz
 Rnjf/4M2kDKB9h1DL75+KimVZBCMhL8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-mGYFXRtsMlmM_ZNaSHYefQ-1; Mon, 25 May 2020 12:44:38 -0400
X-MC-Unique: mGYFXRtsMlmM_ZNaSHYefQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F9B18B6424;
 Mon, 25 May 2020 16:44:37 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4BA96EDA4;
 Mon, 25 May 2020 16:44:22 +0000 (UTC)
Date: Mon, 25 May 2020 18:44:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/3] microvm: drop max-ram-below-4g support
Message-ID: <20200525184418.1c91e340@redhat.com>
In-Reply-To: <20200525134101.24740-3-kraxel@redhat.com>
References: <20200525134101.24740-1-kraxel@redhat.com>
 <20200525134101.24740-3-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 15:41:00 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Not useful for microvm and allows users to shot themself
s/shot/shoot/

> into the foot (make ram + mmio overlap).
also see my toher reply to previous version, parhaps we can drop some more logic here

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/microvm.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 44c08f8a5ab0..4b6ec2bbe331 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -173,25 +173,6 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>      ram_addr_t lowmem = 0x80000000; /* 2G */
>      int i;
>  
> -    /*
> -     * Handle the machine opt max-ram-below-4g.  It is basically doing
> -     * min(qemu limit, user limit).
> -     */
> -    if (!x86ms->max_ram_below_4g) {
> -        x86ms->max_ram_below_4g = 4 * GiB;
> -    }
> -    if (lowmem > x86ms->max_ram_below_4g) {
> -        lowmem = x86ms->max_ram_below_4g;
> -        if (machine->ram_size - lowmem > lowmem &&
> -            lowmem & (1 * GiB - 1)) {
> -            warn_report("There is possibly poor performance as the ram size "
> -                        " (0x%" PRIx64 ") is more then twice the size of"
> -                        " max-ram-below-4g (%"PRIu64") and"
> -                        " max-ram-below-4g is not a multiple of 1G.",
> -                        (uint64_t)machine->ram_size, x86ms->max_ram_below_4g);
> -        }
> -    }
> -
>      if (machine->ram_size > lowmem) {
>          x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>          x86ms->below_4g_mem_size = lowmem;



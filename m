Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A9C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76DD208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76DD208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZE2Q-0003kX-2T
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hZDCV-0007gL-7d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hZDCU-00057N-2U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:38:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hZDCT-0004qq-UZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:38:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so1803105qtk.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cbzjPFG73YJuCTjtKclk+G3hiD8fMMcy1zXtY3e4oQQ=;
 b=nk+pafWrrSoEf3XZ0JQGfokTXiCjyK/rO8iXRTlmARm/haogFYOtKdwSuDf5UZAGDa
 bTyrDM+pX01OoMJDOCP3L1N7J5qXRo9DlaldH3cxm2ZOXGB1OUQUc4ueoqsAqZI1Jmxq
 qU5sANMXlUDFcPQvfTEVVd4CB+HfFX+ZRCA8WM7ommVR4M0qcCskohmhQG054k1mj+ck
 eLGQ0dkBFrepdFWCW0j+5347JEQHGlReDUmDGcLKuFXElkrjklf0O1CTA4QwjIr+eZ2I
 PeCh6RWUAHi195TYF1VRAMw8zmHBGN+iwYqkFVSeIXSZv5WiM3dL//XbrN+z3mlI1CaX
 Tl7w==
X-Gm-Message-State: APjAAAVGhFWVAEGv+JGwcOWB1FYgESc18doCFH33YsYyiqDuZjkj71c4
 uYye13ajCDnhHRJsqlXc+83C8g==
X-Google-Smtp-Source: APXvYqz98UW8YoNxvsyoDwBdiAqkRJ30XBK/6T+OTy6KO4gG9i0z/G+VAQpbGe3ZUibVqvtLS+wchQ==
X-Received: by 2002:a0c:b929:: with SMTP id u41mr43516207qvf.50.1559907498251; 
 Fri, 07 Jun 2019 04:38:18 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id p1sm923476qti.83.2019.06.07.04.38.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 04:38:17 -0700 (PDT)
Date: Fri, 7 Jun 2019 07:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190607073416-mutt-send-email-mst@kernel.org>
References: <20190607073721.4960-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607073721.4960-1-kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH v2] q35: split memory at 2G
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 09:37:21AM +0200, Gerd Hoffmann wrote:
> Original q35 behavior was to split memory at 2.75 GB, leaving space for
> the mmconfig bar at 0xb000000 and pci I/O window starting at 0xc0000000.
> 
> Note: Those machine types have been removed from the qemu codebase
> meanwhile because they could not be live-migrated so there was little
> value in keeping them around.
> 
> With the effort to allow for gigabyte-alignment of guest memory that
> behavior was changed:  The split was moved to 2G, but only in case the
> memory didn't fit below 2.75 GB.
> 
> So today the address space between 2G and 2,75G is not used for guest
> memory in typical use cases, where the guest memory is sized at a power
> of two or a gigabyte number.  But if you configure your guest with some
> odd amount of memory (such as 2.5G) the address space is used.
> This patch removes that oddity for 4.1+ machine types.  The memory is
> split at 2G no matter what.

And that's done on the assumption that it's a good idea such that 32
guests can address it.

Could you maybe add an explanation about why this is a problem?

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  include/hw/i386/pc.h | 1 +
>  hw/i386/pc.c         | 1 +
>  hw/i386/pc_q35.c     | 7 ++++++-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 5d5636241e34..dfe3e6104181 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -120,6 +120,7 @@ typedef struct PCMachineClass {
>  
>      /* RAM / address space compat: */
>      bool gigabyte_align;
> +    bool gigabyte_split;
>      bool has_reserved_memory;
>      bool enforce_aligned_dimm;
>      bool broken_reserved_end;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index edc240bcbf59..3cc9432bd187 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2722,6 +2722,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->smbios_defaults = true;
>      pcmc->smbios_uuid_encoded = true;
>      pcmc->gigabyte_align = true;
> +    pcmc->gigabyte_split = true;
>      pcmc->has_reserved_memory = true;
>      pcmc->kvmclock_enabled = true;
>      pcmc->enforce_aligned_dimm = true;
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index dcddc6466200..57d06d55ef4d 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -143,8 +143,10 @@ static void pc_q35_init(MachineState *machine)
>       * If it doesn't, we need to split it in chunks below and above 4G.
>       * In any case, try to make sure that guest addresses aligned at
>       * 1G boundaries get mapped to host addresses aligned at 1G boundaries.
> +     *
> +     * qemu 4.1+ machines: split at 2G unconditionally (gigabyte_split = true)
>       */
> -    if (machine->ram_size >= 0xb0000000) {
> +    if (machine->ram_size >= 0xb0000000 || pcmc->gigabyte_split) {
>          lowmem = 0x80000000;
>      } else {
>          lowmem = 0xb0000000;
> @@ -376,8 +378,11 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
>  
>  static void pc_q35_4_0_1_machine_options(MachineClass *m)
>  {
> +    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> +
>      pc_q35_4_1_machine_options(m);
>      m->alias = NULL;
> +    pcmc->gigabyte_split = false;
>      compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
>      compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
>  }
> -- 
> 2.18.1


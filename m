Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60075C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDC52083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDC52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49546 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzGD-0006YH-Am
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49469)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hdz2B-0003D2-IX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hdz2A-0005qa-7d
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:31:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hdz28-0005cs-PY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:31:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so3549159qtn.13
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4XM6fArIUsV/+pZkhNcBinvKGNGJit6kYMRWjAvyWFE=;
 b=g355WtAFxvMGuOyFCP11+rLX/A3DMrPW7gp0uq+6uVuRtO96ULl4Nh37Wz/MXzQFYu
 HBPKD4IhYptZasehEKZGJ9UW+s0KZmE8dRtRW/NgMegZ72Hh7kx9DofSkw4i6ff/Lj0m
 nBr90MK1yU9sP3jXx4ifUI/iEoQ+ZVlt9y6GRHLvCQ1HW529XzJETMu1GqsBJZKsN8Gi
 JEKayL5B32hSNHsKsSa3NIFjCDaUKgGsoFiBD4HcPmGOGM0DQ6J9jeCyZM0dcNBR+bAY
 mR/iNj5xywVFQdmGkolR5iQ3cRKi+sNAB2FR+1ceTjRbwp15eoYTZeEemjI7OGqmNi1/
 9uZg==
X-Gm-Message-State: APjAAAWjaRzDkQvgy97H9GoX0qSvVP/Tvf4/XaLzG37KESJs5LmuAJJg
 p2MyLak6OEZYsuuhdiHqIFAlBA==
X-Google-Smtp-Source: APXvYqzlLc1a02kX0TMAY2AR0gScGuRHJJ9T1TVoHK3QN7iau25wMPt8qzcI/8HL92pN2hP6+HBG3w==
X-Received: by 2002:aed:3c2e:: with SMTP id t43mr114614953qte.39.1561044678015; 
 Thu, 20 Jun 2019 08:31:18 -0700 (PDT)
Received: from redhat.com (173-166-0-186-newengland.hfc.comcastbusiness.net.
 [173.166.0.186])
 by smtp.gmail.com with ESMTPSA id r39sm16438930qtc.87.2019.06.20.08.31.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 08:31:17 -0700 (PDT)
Date: Thu, 20 Jun 2019 11:31:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190620112913-mutt-send-email-mst@kernel.org>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613143446.23937-5-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PATCH v2 04/20] hw/i386/pc: Add the E820Type enum
 type
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 13, 2019 at 04:34:30PM +0200, Philippe Mathieu-Daudé wrote:
> This ensure we won't use an incorrect value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

It doesn't actually ensure anything: compiler does not check IIUC.

And OTOH it's stored in type field in struct e820_entry.

> ---
> v2: Do not cast the enum (Li)
> ---
>  hw/i386/pc.c         |  4 ++--
>  include/hw/i386/pc.h | 16 ++++++++++------
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5a7cffbb1a..86ba554439 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -872,7 +872,7 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>  
> -ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
>  {
>      unsigned int index = le32_to_cpu(e820_reserve.count);
>      struct e820_entry *entry;
> @@ -906,7 +906,7 @@ size_t e820_get_num_entries(void)
>      return e820_entries;
>  }
>  
> -bool e820_get_entry(unsigned int idx, uint32_t type,
> +bool e820_get_entry(unsigned int idx, E820Type type,
>                      uint64_t *address, uint64_t *length)
>  {
>      if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index c56116e6f6..7c07185dd5 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -282,12 +282,16 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
>  
> -/* e820 types */
> -#define E820_RAM        1
> -#define E820_RESERVED   2
> -#define E820_ACPI       3
> -#define E820_NVS        4
> -#define E820_UNUSABLE   5
> +/**
> + * E820Type: Type of the e820 address range.
> + */
> +typedef enum {
> +    E820_RAM        = 1,
> +    E820_RESERVED   = 2,
> +    E820_ACPI       = 3,
> +    E820_NVS        = 4,
> +    E820_UNUSABLE   = 5
> +} E820Type;
>  
>  ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
>  size_t e820_get_num_entries(void);
> -- 
> 2.20.1


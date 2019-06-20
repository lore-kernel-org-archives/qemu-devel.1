Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAFEC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7D220673
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7D220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzD1-0003Ed-N6
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hdz02-0001GV-LH
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hdyzz-0003F3-Ml
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:29:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hdyzz-000354-Ft
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:29:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so3560902qto.10
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=66vLEJcM7c6Ep0GWTtMY1vHR3Uhe7+FRj6/BTTNykpU=;
 b=ssXn28PcMDoinbo7QpC+I9ota9H0ZZPX7sj/WI7c+4azVw7kYCF5GdVhNGehRY6Bmq
 3SCJzxQD4JxooTcgHeAQMPMa8bBlxeLfkdIMia6DNpM99PH1FweBHp33jI6Bo8r6Fhgl
 AuncMQen/+OU7LOV75vMwCBOZupBOnMeNFfJS7XfK2FsoJo609AM7FZwBpomIFOQ4Sgn
 b2w5J8+QlGmkHMlvARYqV7LxZpgQomdTlKCO8w6Qxs3vm7VrgvKyNEJDOpU7WyfXC52G
 xNtW5ktGKcm7q08cwilHUvewdH9BFhbCi45ML0ze4quI2D7oRTWTY7C5vVVUxqXbe7vD
 wvlQ==
X-Gm-Message-State: APjAAAVzQkPAgAJTM2t5pPNo4y8NS92iuaoKdwi5XlGQ6sZld1KO4//0
 JpJ7gCGvJKQf5jPWH2IpMNoTxw==
X-Google-Smtp-Source: APXvYqxugr5bD/uY7lQvjgwQjgESKc22Rg9fEIHfFOndZ8gi3MhgZvAJPFXwICtfeMN624qAMoTrXw==
X-Received: by 2002:ac8:444c:: with SMTP id m12mr16690819qtn.306.1561044549837; 
 Thu, 20 Jun 2019 08:29:09 -0700 (PDT)
Received: from redhat.com (173-166-0-186-newengland.hfc.comcastbusiness.net.
 [173.166.0.186])
 by smtp.gmail.com with ESMTPSA id j22sm7730qtp.0.2019.06.20.08.29.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 08:29:08 -0700 (PDT)
Date: Thu, 20 Jun 2019 11:29:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190620112844-mutt-send-email-mst@kernel.org>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613143446.23937-4-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v2 03/20] hw/i386/pc: Let e820_add_entry()
 return a ssize_t type
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
 Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 13, 2019 at 04:34:29PM +0200, Philippe Mathieu-Daudé wrote:
> e820_add_entry() returns an array size on success, or a negative
> value on error.

So what's wrong with int? Does it overflow somehow?

> 
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/i386/pc.c         | 2 +-
>  include/hw/i386/pc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ff0f6bbbb3..5a7cffbb1a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -872,7 +872,7 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>  
> -int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>  {
>      unsigned int index = le32_to_cpu(e820_reserve.count);
>      struct e820_entry *entry;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fc29893624..c56116e6f6 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -289,7 +289,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>  #define E820_NVS        4
>  #define E820_UNUSABLE   5
>  
> -int e820_add_entry(uint64_t, uint64_t, uint32_t);
> +ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
>  size_t e820_get_num_entries(void);
>  bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>  
> -- 
> 2.20.1


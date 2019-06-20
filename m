Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C69C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B1D2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B1D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzLK-0002Ec-6C
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hdyzN-0000ij-LY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hdyzM-0002Bp-I8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hdyzM-0002BJ-CV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:36 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so3557946qtj.8
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OXpyqTPfcCFAyup/Rem/hnqL4o2lUHl+0SS7S+RDPtQ=;
 b=joc3lXTG+TNXpLO0RnXLzXGMUdT5jHVMra2tgaIHPfC8slpGzYJAHR45Nd+6STpvl2
 IWyze5QoWE8pLE83RmyD28OVZ7Z+sspeoP7gEr4JEGwAck+bWVqW9kF8AR6MIsz9wy2C
 CFXG19ptByDyUR+KSYzl2y7MITWUe3AwEi24ereNhaPFRFzcXxm6jJFuzQJv4r/wQQV4
 3BSFKYbUkeEM1+fdkH9PNsxQB1yqTOXgOBOQDCQB0FfSKEnXW9dprffHhLoNHEdXlPVF
 8IQRCXC6WPa3MsZn7HDC3NAcfqzJnAdGTBdyb5l12WhiFqWbwC6WndR+l+E5Tn22XgRI
 dlHw==
X-Gm-Message-State: APjAAAUDc4Ce3mqu75IVM5HR3VFSCWs6xXt+yxdHAdCeioMynl6nKEZX
 dpDR7oftb5Vh5IHpKgRWBLL9GA==
X-Google-Smtp-Source: APXvYqw6U+ujCDYl8JDjyAvOha99GgNxtK3nTZ98iWonOXXm4upHK15s2RBeRUfwLEN01Xt787R1xQ==
X-Received: by 2002:ac8:323a:: with SMTP id x55mr21388069qta.211.1561044515947; 
 Thu, 20 Jun 2019 08:28:35 -0700 (PDT)
Received: from redhat.com ([64.63.146.106])
 by smtp.gmail.com with ESMTPSA id j66sm12441042qkf.86.2019.06.20.08.28.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 08:28:35 -0700 (PDT)
Date: Thu, 20 Jun 2019 11:28:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190620112805-mutt-send-email-mst@kernel.org>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613143446.23937-3-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH v2 02/20] hw/i386/pc: Use size_t type to
 hold/return a size of array
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

On Thu, Jun 13, 2019 at 04:34:28PM +0200, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Motivation? do you expect more than 2^31 entries?

> ---
>  hw/i386/pc.c         | 4 ++--
>  include/hw/i386/pc.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bb3c74f4ca..ff0f6bbbb3 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -105,7 +105,7 @@ struct e820_table {
>  
>  static struct e820_table e820_reserve;
>  static struct e820_entry *e820_table;
> -static unsigned e820_entries;
> +static size_t e820_entries;
>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> @@ -901,7 +901,7 @@ int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>      return e820_entries;
>  }
>  
> -int e820_get_num_entries(void)
> +size_t e820_get_num_entries(void)
>  {
>      return e820_entries;
>  }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 3b3a0d6e59..fc29893624 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -290,7 +290,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>  #define E820_UNUSABLE   5
>  
>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
> -int e820_get_num_entries(void);
> +size_t e820_get_num_entries(void);
>  bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>  
>  extern GlobalProperty pc_compat_4_0_1[];
> -- 
> 2.20.1


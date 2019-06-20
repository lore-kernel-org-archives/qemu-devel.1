Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA38C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246182084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246182084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzGq-0007Lk-89
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hdyyu-0000Cx-F1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hdyys-0001Xg-H0
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hdyys-0001Ht-Ao
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:28:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so3631645qtu.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JAcKHy1FRAtW0JEnhHKGbjx3Sy0ZWxrGVRh9A8UVyZY=;
 b=N6RICRjwxtVtQHW4hZVavWnXa+oGwZX17FaDnxPA3Xerod7BvGMaUCfpT5BD4Wd34j
 uU1FGHBoHwmRzwCFzwORomMQFIJzH011io6dIeYNezZX7SlrJUIncK8UNUil4cVpNri/
 FlLJShHrME4YIuGtTaoeKlza6sTWWSOVmS0Q/cCmRD2uBs9SLXIw9vETtdf+ronU6MWe
 8Ew0A/4yNS8HOAurmKmg577FVNJQ/JY+CxQlnvBCqAzf30FjdwMNO/LKroX0ZzJ5Tib0
 cI0wdIQPmo/7H09D+ASanWh8v3y75LMMtG/Yk9NWxgwTgmkYxiVhMcblYGzY/YpM9wB1
 kDNg==
X-Gm-Message-State: APjAAAURTo2UYiUY2yFOezLz3y1tVl6AO5ZhekvZ4mB1Y2iun+BNYeq4
 LAwA3psT8jM/GUxCmESuYnyWUQ==
X-Google-Smtp-Source: APXvYqxpLs2C5Gy8h4gWf0WS9cA4AFjodndt+QmKZvo4EmyB20KX1/URQU2oRJ3ithnPgGiwltjNCQ==
X-Received: by 2002:ac8:70cf:: with SMTP id
 g15mr106409493qtp.254.1561044474136; 
 Thu, 20 Jun 2019 08:27:54 -0700 (PDT)
Received: from redhat.com ([64.63.146.106])
 by smtp.gmail.com with ESMTPSA id e18sm1247qkm.49.2019.06.20.08.27.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 08:27:53 -0700 (PDT)
Date: Thu, 20 Jun 2019 11:27:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190620112729-mutt-send-email-mst@kernel.org>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613143446.23937-2-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH v2 01/20] hw/i386/pc: Use unsigned type to
 index arrays
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

On Thu, Jun 13, 2019 at 04:34:27PM +0200, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Motivation?  Is this a bugfix?


> ---
>  hw/i386/pc.c         | 5 +++--
>  include/hw/i386/pc.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2c5446b095..bb3c74f4ca 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -874,7 +874,7 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
>  
>  int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>  {
> -    int index = le32_to_cpu(e820_reserve.count);
> +    unsigned int index = le32_to_cpu(e820_reserve.count);
>      struct e820_entry *entry;
>  
>      if (type != E820_RAM) {
> @@ -906,7 +906,8 @@ int e820_get_num_entries(void)
>      return e820_entries;
>  }
>  
> -bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t *length)
> +bool e820_get_entry(unsigned int idx, uint32_t type,
> +                    uint64_t *address, uint64_t *length)
>  {
>      if (idx < e820_entries && e820_table[idx].type == cpu_to_le32(type)) {
>          *address = le64_to_cpu(e820_table[idx].address);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a7d0b87166..3b3a0d6e59 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -291,7 +291,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>  
>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
> -bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> +bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>  
>  extern GlobalProperty pc_compat_4_0_1[];
>  extern const size_t pc_compat_4_0_1_len;
> -- 
> 2.20.1


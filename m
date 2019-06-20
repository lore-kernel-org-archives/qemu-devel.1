Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E415BC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FBC2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 15:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FBC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdzMz-0003pi-UT
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hdzJ3-000077-Pm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hdz7P-00037N-59
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:36:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hdz7P-00036U-0x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 11:36:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so3639458qtl.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 08:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vtY4pO6pnEy7zUizy6kb7ppyyGMbiZZTG+R8FaWK93c=;
 b=pthsWjE6wHqxZLvdDOUjEdvBCMWQXUjP7Q39fHW3NwQZANfguTUAg7t+Mhc4EYJnJf
 XJwHWKScVGZ8JpyHQUXUTHFimfclG/bkiRDCH9zX1Iu2quHLwO5hucjUtP3Sa62jkqAz
 zaKEfS2T+0kHALQOOvq3NgI2NJEyMrpqHVoa1grqV4QVyYQ91ksN5LR/k0Kxvj/2mejH
 ThN4dzx6qyJfhhZM7NPkMoAoQIKQSzO/bopwnavlcfOVnADVLdsG6lJBndgakhEoB/xe
 sEkb2RRWaVfk+qW2tF87jf3lSAM1gfU6mseuckDMXXhs3b2w1lkF+1lv1kezw4Gnjgia
 Kzog==
X-Gm-Message-State: APjAAAUir2SkKdJlioQ5CKDEtgK31pEg9iSIZHudjXexqgZpbfulLFBK
 MrejTynbu37kwwTz/tWiFOYKAg==
X-Google-Smtp-Source: APXvYqyK6gIa2B32mpauKI9zUONgbUKtzrXACDNvM5CtwsIRGmI3o1w95PMCi4LZiUFmb/XM9BNnXA==
X-Received: by 2002:a0c:960e:: with SMTP id 14mr39349569qvx.31.1561045013865; 
 Thu, 20 Jun 2019 08:36:53 -0700 (PDT)
Received: from redhat.com ([64.63.146.106])
 by smtp.gmail.com with ESMTPSA id c23sm1449qke.111.2019.06.20.08.36.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 08:36:53 -0700 (PDT)
Date: Thu, 20 Jun 2019 11:36:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190620113132-mutt-send-email-mst@kernel.org>
References: <20190613143446.23937-1-philmd@redhat.com>
 <20190613143446.23937-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613143446.23937-6-philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH v2 05/20] hw/i386/pc: Add documentation to
 the e820_*() functions
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

On Thu, Jun 13, 2019 at 04:34:31PM +0200, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/i386/pc.h | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 7c07185dd5..fc66b61ff8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -293,9 +293,42 @@ typedef enum {
>      E820_UNUSABLE   = 5
>  } E820Type;
>  
> -ssize_t e820_add_entry(uint64_t, uint64_t, uint32_t);
> +/**
> + * e820_add_entry: Add an #e820_entry to the @e820_table.
> + *
> + * Returns the number of entries of the e820_table on success,
> + *         or a negative errno otherwise.
> + *
> + * @address: The base address of the structure which the BIOS is to fill in.
> + * @length: The length in bytes of the structure passed to the BIOS.
> + * @type: The #E820Type of the address range.
> + */
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type);
> +
> +/**
> + * e820_get_num_entries: The number of entries of the @e820_table.
> + *
> + * Returns the number of entries of the e820_table.
> + */
>  size_t e820_get_num_entries(void);
> -bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
> +
> +/**
> + * e820_get_entry: Get the address/length of an #e820_entry.
> + *
> + * If the #e820_entry stored at @index is of #E820Type @type, fills @address
> + * and @length with the #e820_entry values and return @true.
> + * Return @false otherwise.
> + *
> + * @index: The index of the #e820_entry to get values.
> + * @type: The @E820Type of the address range expected.
> + * @address: Pointer to the base address of the #e820_entry structure to
> + *           be filled.
> + * @length: Pointer to the length (in bytes) of the #e820_entry structure
> + *          to be filled.
> + * @return: true if the entry was found, false otherwise.

I don't actually care whether it's @E820Type, #E820Type or just type,
we should be consistent. I also find this style of documentation
underwhelming. what is to be filled? length or the structure?
upper case after : also looks somewhat wrong.

Same applies to other comments too.

> + */
> +bool e820_get_entry(unsigned int index, E820Type type,
> +                    uint64_t *address, uint64_t *length);
>  
>  extern GlobalProperty pc_compat_4_0_1[];
>  extern const size_t pc_compat_4_0_1_len;
> -- 
> 2.20.1


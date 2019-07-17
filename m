Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2131EC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E861720818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E861720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hng4c-0003AZ-5Q
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hng4Q-0002lP-NE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hng4P-00058C-KQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:17:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hng4P-00057p-Di
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:17:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so23955237wrr.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hRSgNggC5MO/pKX0wqtZ3M8AfV7ZNE9QpaieoPKK6pk=;
 b=RuQr6It3WTEGkWTVl/7gOsgNA3RAziL9wlcy+d0DVkJshRzaLUumln2pSC4bcCRgoC
 B4qF/NDiWV+1ykuj4SjPiTLU/o9yKPpe+8zsXdrlHH5LcqFp2kUu9K3jlQdM2C8mSSqQ
 JnAK0ayFLDDZQAohfZlVkEQ42NBWarUuQqRcaCQhVdEJutyNhPnq+pbC6xB+z6bgxyvI
 0QwrPMspVA1a5N8yMfFVn3Dx5zSKdGCQAXzcBSW7e8HLNnQQBpU4r1M77m77EP1iEAhE
 wqI9dGYQjkZC3c7Ps65+lNM//VJ1aRgkHxG2pwLSSLVDGmbxXER+hpHLazCkQ9Jp7zql
 ULcQ==
X-Gm-Message-State: APjAAAW7II9JONuAjrlaBUzPjPWio3eCINUmUAqa5meoPg3/T2vtYfEC
 D1maXAMrDjaRbUvfsXUTDUg5pw==
X-Google-Smtp-Source: APXvYqzmniCxdB2LGOP6h9vhnNGJ8JFJzeiq2tB8r8EB6IAGsIb1E8OEsgCQ91Aof2i4fPup4jV9Cw==
X-Received: by 2002:a5d:4ac3:: with SMTP id y3mr12691367wrs.187.1563355072364; 
 Wed, 17 Jul 2019 02:17:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id l8sm39932245wrg.40.2019.07.17.02.17.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 02:17:51 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190430034412.12935-1-richardw.yang@linux.intel.com>
 <20190430034412.12935-4-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <dd14052c-b3ed-88b0-b7f4-69dae2a7a660@redhat.com>
Date: Wed, 17 Jul 2019 11:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190430034412.12935-4-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 3/3] ram: RAMBlock->offset is always
 aligned to a word
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/04/19 05:44, Wei Yang wrote:
> RAMBlock->offset is calculated by find_ram_offset, which makes sure the
> offset is aligned to a word.
> 
> This patch removes the alignment check on offset and unnecessary
> variable *word*.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

I would add an assertion instead, but overall leaving the condition
there is harmless.  You still need the "else" part for the case where
the length is unaligned.

Paolo

> ---
>  include/exec/ram_addr.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 3dfb2d52fb..a7c81bdb32 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -413,18 +413,21 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                                 uint64_t *real_dirty_pages)
>  {
>      ram_addr_t addr;
> -    unsigned long word = BIT_WORD(rb->offset >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
>  
> -    /* offset and length is aligned at the start of a word? */
> -    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) == (rb->offset) &&
> -        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
> +    /*
> +     * Since RAMBlock->offset is guaranteed to be aligned to a word by
> +     * find_ram_offset(), if length is aligned at the start of a word, go the
> +     * fast path.
> +     */
> +    if (!(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
>          int k;
>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>          unsigned long * const *src;
> -        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
> -        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
> +        unsigned long idx = (rb->offset >> TARGET_PAGE_BITS) /
> +                            DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = BIT_WORD((rb->offset >> TARGET_PAGE_BITS) %
>                                          DIRTY_MEMORY_BLOCK_SIZE);
>  
>          rcu_read_lock();
> 



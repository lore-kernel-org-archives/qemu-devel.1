Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF77EC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDC6206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDC6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWPs-0001sg-VC
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hxWOE-0000ee-CN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hxWOA-0007qm-Vw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:59:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hxWO9-0007kg-0y
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:58:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so107648688wrf.11
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fSDobMtrpv7uqqhpc8Qfk8Z5RIRCnX2/FhJvlis3IsY=;
 b=t/NJAZai+KArghiY4bvO3wdyW7taZf8aiDhDQ+uPwB/c/93S8JRp1bOSLgpBCH6XJ7
 bJ5+iV5qwkghvP9NsfiSknOS/Tz/UArsqjbs60zL+8De57qXeIXG14vtML8zXF/fkLV2
 gjBs6Bm35qtbDde2eR+uBNkgssfdi3R2PiGvPCozOmjam2g2eHT273vARoW9kLjf4ALx
 m+oJHKX8KgZUj4+2fHeJXVh1h9pPGYr4Uf8Yc9vufKsCGDbthINj0OzRqkwZd23nRbzY
 jwL9XON4tOq+Gx8Ohvn6hjw7gJ9aN3JwJmMaPJstWHA+WGl5euKd3Ze1K+CywbSYjhaZ
 iUhQ==
X-Gm-Message-State: APjAAAU+nL00Y3YjGyum0BqexNOT6Jn8VuSzY0+ehyrNNtRTU5PcjzBn
 bop7lJzZBPjn6P3IGLwCRGBC9g==
X-Google-Smtp-Source: APXvYqypUCRbAXcXrdc7OfF17O5O/lHk5Qybk5vl+i1dLZ9Q6OLjoNvcFEnMHYJzB8cvRcQ5WtnltA==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr24505610wrv.95.1565701135069; 
 Tue, 13 Aug 2019 05:58:55 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o11sm9337864wrw.19.2019.08.13.05.58.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 05:58:54 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com
References: <20190813102936.32195-1-dgilbert@redhat.com>
 <20190813102936.32195-2-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f87ef58d-a549-54cf-4a3a-8e4712c699e1@redhat.com>
Date: Tue, 13 Aug 2019 14:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190813102936.32195-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Align and add helper for
 comparing MemoryRegionSections
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 8/13/19 12:29 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> MemoryRegionSection includes an Int128 'size' field;
> on some platforms the compiler causes an alignment of this to
> a 128bit boundary, leaving 8 bytes of dead space.
> This deadspace can be filled with junk.
> 
> Move the size field to the top avoiding unnecsssary alignment

"unnecessary"

This is enough change to be in its own commit.

---

> and provide an 'eq' routine to safely compare MRS's.

This is another change, and should be squashed in the next patch IMO.
Doesn't Clang warn about unused 'static inline' btw?

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/exec/memory.h | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 606250172a..ce62e847bd 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -487,15 +487,27 @@ static inline FlatView *address_space_to_flatview(AddressSpace *as)
>   * @nonvolatile: this section is non-volatile
>   */
>  struct MemoryRegionSection {
> +    Int128 size;
>      MemoryRegion *mr;
>      FlatView *fv;
>      hwaddr offset_within_region;
> -    Int128 size;
>      hwaddr offset_within_address_space;
>      bool readonly;
>      bool nonvolatile;
>  };
>  
> +static inline bool MemoryRegionSection_eq(MemoryRegionSection *a,
> +                                          MemoryRegionSection *b)
> +{
> +    return a->mr == b->mr &&
> +           a->fv == b->fv &&
> +           a->offset_within_region == b->offset_within_region &&
> +           a->offset_within_address_space == b->offset_within_address_space &&
> +           int128_eq(a->size, b->size) &&
> +           a->readonly == b->readonly &&
> +           a->nonvolatile == b->nonvolatile;
> +}
> +
>  /**
>   * memory_region_init: Initialize a memory region
>   *
> 


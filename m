Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0FC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FBE2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riLg93O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FBE2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybKp-0002eq-O7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1iybJe-0001m0-UA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1iybJd-0006Av-Pv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:59:02 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1iybJd-00069b-Ie; Mon, 03 Feb 2020 07:59:01 -0500
Received: by mail-pl1-x644.google.com with SMTP id p11so5833888plq.10;
 Mon, 03 Feb 2020 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0udO5OtzU9wGtXvITcHqztyauPQz5Nqju/UkdO+kwDw=;
 b=riLg93O3iGNlwDIEmFQmHgwbM7L4zAFzelmRw2/MaHtuUXazB+k6hxA9MuGy47zhky
 aMEHsJC2i9+WzxfRnAUf8XXvfnHIj8SQrmgOIii7obvwlBol+IrtfScTb3AQKErqtiGq
 Pt2SX+JKMZqIeSICAQVY88mL4EqWCXgnZ9S7NqMsufiTnYFRTWuHw4qC81Z/k4lHphnX
 ZAqxlmOZ4bdXy58FaekpeaOvP4/p8uZhEhfiTJJ/dqMc9/6iRHDQiCOm5RTP4/i7nGXF
 eaSxKWdxVF9HmmpLZ2S8fr21UCx5dcv+iAKf5jF3yF+kbZ4kG3sOdwVN7YsCqW9qG/dA
 VLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0udO5OtzU9wGtXvITcHqztyauPQz5Nqju/UkdO+kwDw=;
 b=dqjRp6ZP1dZffJVsdmn50lm1oAsNoBU7JbtOx0/G0PljHYKyDdaG3stWgC0+eF9uGw
 bZ3UhMDIHJfeslfdu6L5rxhGIdq+INicwhsejF5GkK9dgaGKbYVYT9XDvp2OHHDC/8q8
 gnFiEwAHyOtfZn9XERDzaPVaXE6doRNP3D/pzTVh38XAlkgRAceQ8tM6h+S5Y1g51vxY
 6KRX0JL/3kgenv6ssZ5ld2nMfhRcmG+LH18yDz2FK4hr0Tshan2TJfmxe4pZvbbPhQ2d
 N0WKEtp74jhFjwaWhFyNOq375YD7m3+TbuAh2MTskD17yumLYsZB32L2k4imIX3RBT6S
 6DXg==
X-Gm-Message-State: APjAAAWrNsDgqSOySFK+rWfnvgNtTSCD7m1ZtCf1qabhaVT8k7441SE6
 /CYAnnQ9lCZEFGcah0uRMwA=
X-Google-Smtp-Source: APXvYqybFDGAI3zsXT3oy8JDukvF3EzuJC8s8WHsAqEc5YVQLbb8HpanaLf+AKdP88ZfR8KIAfXYSQ==
X-Received: by 2002:a17:90b:28f:: with SMTP id
 az15mr28810058pjb.4.1580734739114; 
 Mon, 03 Feb 2020 04:58:59 -0800 (PST)
Received: from mail.google.com ([149.28.162.63])
 by smtp.gmail.com with ESMTPSA id x10sm21000874pfi.180.2020.02.03.04.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 04:58:58 -0800 (PST)
Date: Mon, 3 Feb 2020 20:58:49 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] tcg: gdbstub: Fix missing breakpoint issue
Message-ID: <20200203125847.nayzwehemrkgszak@mail.google.com>
References: <20200124021728.32518-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124021728.32518-1-changbin.du@gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
Any review?
Thanks!

On Fri, Jan 24, 2020 at 10:17:28AM +0800, Changbin Du wrote:
> When inserting breakpoints, we need to invalidate related TBs to apply
> helper call. This is done by breakpoint_invalidate(). But many users
> found the BPs sometimes never hit.
> 
> In system mode emulation, the BPs are global in guest but not particular
> address space. The issue is that the current implementation only trys to
> invalidate TB of paddr corresponding to the target vaddr in current MMU
> context. Then some cached TBs continue running without BPs applied.
> 
> To fix this issue, we can just invalidate all TBs as what step mode does.
> (For old version users, issuing a step command can workaround this problem.)
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  exec.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 67e520d18e..9d9fd48519 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -997,36 +997,9 @@ static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
>      tb_invalidate_phys_addr(pc);
>  }
>  #else
> -void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
> -{
> -    ram_addr_t ram_addr;
> -    MemoryRegion *mr;
> -    hwaddr l = 1;
> -
> -    if (!tcg_enabled()) {
> -        return;
> -    }
> -
> -    RCU_READ_LOCK_GUARD();
> -    mr = address_space_translate(as, addr, &addr, &l, false, attrs);
> -    if (!(memory_region_is_ram(mr)
> -          || memory_region_is_romd(mr))) {
> -        return;
> -    }
> -    ram_addr = memory_region_get_ram_addr(mr) + addr;
> -    tb_invalidate_phys_page_range(ram_addr, ram_addr + 1);
> -}
> -
>  static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
>  {
> -    MemTxAttrs attrs;
> -    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    if (phys != -1) {
> -        /* Locks grabbed by tb_invalidate_phys_addr */
> -        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
> -                                phys | (pc & ~TARGET_PAGE_MASK), attrs);
> -    }
> +    tb_flush(cpu);
>  }
>  #endif
>  
> -- 
> 2.24.0
> 

-- 
Cheers,
Changbin Du


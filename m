Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD0AC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F6520674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOpfwEkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F6520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIUD-0005nz-HN
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izISu-00041U-Jl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izISt-0002ep-9P
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izISs-0002TG-Vu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:03:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id t23so1980919wmi.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Es2aXQfRMIezlUraJGnt3K0JaMMJkyg+l7QDLSSVRNY=;
 b=fOpfwEkT+51kJLp+7+I9YmQYREBuF3bBAHmAuuiTyLmey2yfaFJEeQ/wJgGCi8jxqB
 GkEYOL5PLB4q2A3xq58sJXqQwT5g+7DO19YSS8Tm7cCZ8fsjgs/5Bpluh+HoCyWDBjof
 WP9vgvca3VBz3DUCCLONkTUekOQmL92ezN9Fy0kUB7IdYhsjmm113UpX/E0Hpnsdf3Ik
 ThJrnI2e9XQxJZvhuhXDmT47UG6LrOyvZOV2IaytoiGiWpxKjL1lH8ljzaOJBgvzfgcb
 QC8Pov5qFZ9x7yGZj+4QMQTCCYrfgCIPaI0pyLZKEbUui5EriAT81L0qduSO3BlDtZmO
 9hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Es2aXQfRMIezlUraJGnt3K0JaMMJkyg+l7QDLSSVRNY=;
 b=jGMvdB/JSdYgqOWQx8PIsuXZ0tcKbrFTyj9UfJ+/NOyH8v0GAl2sXQWSKepHZXz0tG
 MmBJVXishtuMWh+0oorgEUFEcV12H/BCR4ewpEzkJk/k9gNPYOTrR/3FViE01pz/6qrO
 r8cSviNvkvz+I//okqFHdqbO7MQGllW6uKZyZAbRBYHcrJ+3D3YF8n4tNUptISvk+ftz
 bvX++ARa3YS0sWb5YDedkNbhGaH/X7PlTTLViSsd9zKixXaCKTogORPU+ZK2hYGSSViK
 UvG5fps2aTdNMGQWEwFN5HtbNrLlAHiizc442MzM8GZTep+kokJnzd3IfVcKnpEqvLKo
 RFNg==
X-Gm-Message-State: APjAAAXm1DO0QZ+IYngcDRddhkqxw9DPC7Lh9b3CO6fwq8KTOu0WFteN
 QxJg9Z0rX+1LNlxzZUjiT8G6qw==
X-Google-Smtp-Source: APXvYqyjltM04267hs5WRr/KW/opTrGW/XJgHNH3Xx1XDlcgriHWu5frwK+6hToWhZ2D1dGrUwnGDA==
X-Received: by 2002:a05:600c:2c50:: with SMTP id
 r16mr5049257wmg.74.1580900605701; 
 Wed, 05 Feb 2020 03:03:25 -0800 (PST)
Received: from [172.27.246.193] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id s8sm7664769wmh.26.2020.02.05.03.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 03:03:25 -0800 (PST)
Subject: Re: [PATCH] tcg: gdbstub: Fix missing breakpoint issue
To: Changbin Du <changbin.du@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200124021728.32518-1-changbin.du@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c765091-54dc-1ea5-ef25-ec4786506fb4@linaro.org>
Date: Wed, 5 Feb 2020 11:03:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124021728.32518-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 2:17 AM, Changbin Du wrote:
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

You can't remove this function yet.
You should have seen that xtensa-softmmu no longer builds.

I've cc'd you into Max Filippov's thread that addresses the same problem, and
I'm going to apply his fix for now.


r~

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
> 



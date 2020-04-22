Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C6C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924FF20672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWv/JZza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924FF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR75F-00010J-Lf
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jR748-00005v-UY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jR748-0003Yp-Bu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:32:52 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jR747-0003R3-Rf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:32:52 -0400
Received: by mail-lj1-x244.google.com with SMTP id m8so831012lji.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A5QcfjCn4RHqxFiUd6PW5P9dUEa7LK3ItDiWItR+ENY=;
 b=LWv/JZzafay7oRFFZtJqFGtvMDPsNV5bw77dhIFOOeJBjFTu5zh4OpuCyAMv0Y217U
 51SeLdsd6xu3q4qprVgI2FWMiFXF/kFr1q6JtNDSkpLZAePfLFixYyxELG0RznpYIZWl
 oX0MlD8JslD6H1f/UHsdRUZJa3f/cLrNbv2vRgUN4tALvynmTdC9i0FN9PzwV8isMUFL
 xjYza4n00Glv4eRD3aYOE326OhwNLa0hzQOWMxrdfHkEIU1Masj9YSAgBKmCSBdao0fl
 0Zt99AuMLkH3trLAVBKxLLDBj9VchEUyziShKVeDk8zrLxziV41IVHVyPjDSUk7U6yw8
 1aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A5QcfjCn4RHqxFiUd6PW5P9dUEa7LK3ItDiWItR+ENY=;
 b=iTzBpwbpwOSYHF+pXjyzRM0C1Q1JZfQUDpNzZxQ9FSGKgag8+LCbDSAlm/gUPNPzdc
 NjD8LyVzV9cvogd5JfiZd0Kehv1/BAhH5bCwW9QhAhfsLnMWHkCJeQ1rJyY7whElOrEI
 JRAQEHa82e6ruc52piG+bCjf+PjLNTYCIYZfRZZOmodXein0hZNYHUklDr0sSsOnReky
 EJTqWjgjAaxcN7ReTk7D0WWT6GhKjpgo20RSm3T4bBlq1vz2i1hE9Luwdf8HQPtTkxJz
 XgjbT7AoEW0U1VOXww0rHSUo3vD39S8YVlE+zSl/0GnUJZKSFxldMpPpmVbEO+2fznTz
 osjw==
X-Gm-Message-State: AGi0Pub62dE4WidE/hWaolxrI7rgKwaUXrNGjGMp/wRpjK1VPnmiGcYY
 mQnYzVUfXYwHDExvtBIWYyCdc6V0MZ2rkur38/w=
X-Google-Smtp-Source: APiQypLk+D7TFlox7KCXYhUtX1tRIYss0/OkVkleKJZEfuLyIcHMqz3bBCjV80gtvPEUDaLqY+jwZQ+PgnR7cvHkUuY=
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr618934lji.272.1587529968454; 
 Tue, 21 Apr 2020 21:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586763024-12197-3-git-send-email-chenhc@lemote.com>
 <20200421195611.49A4A206E9@mail.kernel.org>
In-Reply-To: <20200421195611.49A4A206E9@mail.kernel.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Wed, 22 Apr 2020 12:40:10 +0800
Message-ID: <CABDp7Vo_rKn2x8zmrNQzdcFHC_1sxXDot1t_ZEt+Y=Q=jo+wOQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] KVM: MIPS: Define KVM_ENTRYHI_ASID to
 cpu_asid_mask(&boot_cpu_data)
To: Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::244
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
Cc: kvm@vger.kernel.org, qemu-level <qemu-devel@nongnu.org>,
 stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Xing Li <lixing@loongson.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Sasha,

On Wed, Apr 22, 2020 at 9:40 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.6.5, v5.5.18, v5.4.33, v4.19.116, v4.14.176, v4.9.219, v4.4.219.
>
> v5.6.5: Build OK!
> v5.5.18: Build OK!
> v5.4.33: Build OK!
> v4.19.116: Build OK!
> v4.14.176: Build OK!
> v4.9.219: Build OK!
> v4.4.219: Failed to apply! Possible dependencies:
>     029499b47738 ("KVM: x86: MMU: Make mmu_set_spte() return emulate value")
>     19d194c62b25 ("MIPS: KVM: Simplify TLB_* macros")
>     403015b323a2 ("MIPS: KVM: Move non-TLB handling code out of tlb.c")
>     7ee0e5b29d27 ("KVM: x86: MMU: Remove unused parameter of __direct_map()")
>     9fbfb06a4065 ("MIPS: KVM: Arrayify struct kvm_mips_tlb::tlb_lo*")
>     ba049e93aef7 ("kvm: rename pfn_t to kvm_pfn_t")
>     bdb7ed8608f8 ("MIPS: KVM: Convert headers to kernel sized types")
>     ca64c2beecd4 ("MIPS: KVM: Abstract guest ASID mask")
>     caa1faa7aba6 ("MIPS: KVM: Trivial whitespace and style fixes")
>     e6207bbea16c ("MIPS: KVM: Use MIPS_ENTRYLO_* defs from mipsregs.h")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?
Please ignore this patch in linux-4.4 branch and even below.
>
> --
> Thanks
> Sasha
>
Thanks,
Huacai


-- 
Huacai Chen


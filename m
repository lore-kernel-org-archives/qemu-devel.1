Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F16DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48805207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr908fvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48805207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFar-0006sF-BQ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFZw-00069b-RP; Tue, 13 Oct 2020 04:22:40 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSFZu-0003Df-PU; Tue, 13 Oct 2020 04:22:40 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so20824271wme.1;
 Tue, 13 Oct 2020 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h1E2HVic7xBh6Dv/vkSYBNUycLf7aL4E08DCiV+4DuM=;
 b=lr908fvi2z0y6gQ+AbecEGAqGgXHzH1C08STQnODk7S92Zp2drVW9wEQVMYog9SsoH
 KOyYRuPcqBNKMq9CuaLaZcy0tdKa7R0tNhOfbEsJQsd45lTWJfwCt3QJB2z+TM+qcTMP
 csxX0suMlg2NoU8tiUHuDMaADZ8+5EUSm3eQnVzYcBoq0DDEffDWsUQMgFrVhGpSAbKR
 CW3eC/IVUnKBEH4w6OkFgWua88l2rb34nxG3TFzex3RiYSpCLjAu0RnG3fSabY5TLAiq
 r9lK81JZeHFsfcoEzZ9zMXaLk24jNwrwRaDjlgKNqZHJAs0FAmmlqHi5X+3zFMlXsIea
 IkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h1E2HVic7xBh6Dv/vkSYBNUycLf7aL4E08DCiV+4DuM=;
 b=PCB9/JxkuL5RLKiS9kWQBC/bV6lZW6EW/mayYNt5oMhwxGXEVPCJBYZJFH8mUwhJDY
 BZQwfcfExKhyhAJgy0+BjdDYKfWcnV2jKSROV/S0iEyrFUIYjxFzTN9Vm7MYdFIcb39S
 58yPLd4OVXmV+QPh4I/p2AAcCtdWkU9decCZXmuIic4Bgr6JYJcRB3lLF85i5FVO17hH
 QyWkNu6yKS+uBkQ1E+Tptf6LIPmhAqdEaoQVak5czhxVSBdtVOQK1EqsZiy+K7V/o+Ap
 2t4vXAvnFO3LiSljvwbbOkKGycSrf/kW8RAEVbPM0BDb4RnpwcfgljbffJ+1lzRcQKhS
 p1uw==
X-Gm-Message-State: AOAM531jJqSf954kDZQMJKkl62bKw4DF671+Y+rY9/7FKw6uSN7W5Tm0
 RuDYjvHE0+NegDQwCQ5Pj9Q=
X-Google-Smtp-Source: ABdhPJx5rOBC8YVSo8jiyNaXxZyph+CyVmG0RQ7d0QuSB4gDJGORHNSd+ki7P9A2KMijMwtfYJYB9w==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr14258587wme.18.1602577355716; 
 Tue, 13 Oct 2020 01:22:35 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z11sm27610905wrh.70.2020.10.13.01.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:22:34 -0700 (PDT)
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f836dc90-99bc-d3ce-dd33-e0d51bb4b979@amsat.org>
Date: Tue, 13 Oct 2020 10:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012232939.48481-8-j@getutm.app>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:S390 TCG target" <qemu-s390x@nongnu.org>,
 "open list:AArch64 TCG target" <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Joelle,

On 10/13/20 1:29 AM, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
> 
> On iOS, we cannot allocate RWX pages without special entitlements. As a
> workaround, we can a RX region and then mirror map it to a separate RX
> region. Then we can write to one region and execute from the other one.
> 
> To better keep track of pointers to RW/RX memory, we mark any tcg_insn_unit
> pointers as `const` if they will never be written to. We also define a new
> macro `TCG_CODE_PTR_RW` that returns a pointer to RW memory. Only the
> difference between the two regions is stored in the TCG context.

^ one change,

v another change. Consider splitting in 2 patches to ease review.

> 
> To ensure cache coherency, we flush the data cache in the RW mapping and
> then invalidate the instruction cache in the RX mapping (where applicable).
> Because data cache flush is OS defined on some architectures, we do not
> provide implementations for non iOS platforms (ARM/x86).
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   accel/tcg/cpu-exec.c         |  7 +++-
>   accel/tcg/translate-all.c    | 78 ++++++++++++++++++++++++++++++++++--
>   configure                    |  1 +
>   docs/devel/ios.rst           | 40 ++++++++++++++++++
>   include/exec/exec-all.h      |  8 ++++
>   include/tcg/tcg.h            | 18 +++++++--
>   tcg/aarch64/tcg-target.c.inc | 48 +++++++++++++---------
>   tcg/aarch64/tcg-target.h     | 13 +++++-
>   tcg/arm/tcg-target.c.inc     | 33 ++++++++-------
>   tcg/arm/tcg-target.h         |  9 ++++-
>   tcg/i386/tcg-target.c.inc    | 28 ++++++-------
>   tcg/i386/tcg-target.h        | 24 ++++++++++-
>   tcg/mips/tcg-target.c.inc    | 64 +++++++++++++++++------------
>   tcg/mips/tcg-target.h        |  8 +++-
>   tcg/ppc/tcg-target.c.inc     | 55 ++++++++++++++++---------
>   tcg/ppc/tcg-target.h         |  8 +++-
>   tcg/riscv/tcg-target.c.inc   | 51 +++++++++++++----------
>   tcg/riscv/tcg-target.h       |  9 ++++-
>   tcg/s390/tcg-target.c.inc    | 25 ++++++------
>   tcg/s390/tcg-target.h        | 13 +++++-
>   tcg/sparc/tcg-target.c.inc   | 33 +++++++++------
>   tcg/sparc/tcg-target.h       |  8 +++-
>   tcg/tcg-ldst.c.inc           |  2 +-
>   tcg/tcg-pool.c.inc           |  9 +++--
>   tcg/tcg.c                    | 60 +++++++++++++++++----------
>   tcg/tci/tcg-target.c.inc     |  8 ++--
>   tcg/tci/tcg-target.h         |  9 ++++-
>   27 files changed, 481 insertions(+), 188 deletions(-)
>   create mode 100644 docs/devel/ios.rst

When posting big series, consider using scripts/git.orderfile.

Regards,

Phil.


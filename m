Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81971C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6962084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6962084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7g3E-0001l2-B9
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i7g0h-0000A4-Ae
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i7g0g-0006fO-5x
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i7g0g-0006f1-0h
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:16:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so20174832wra.6
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 06:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=z9JvWVeEbyWm2+to6czdf1YkWTTv0yFivC2PxELEm94=;
 b=hi2OlPc+ZkRjelqKlxTFEwv3jBWrmzv57mXN34148caoEEflI6dB4DzxB7E0GEioEc
 3u8nIvMXS7s1VovpVFfVOyE2RfdTzFGfyyxFeL4bUjiZ50bdnnv2x/Uce489+Aq6Kf1e
 km62b9VrfjPyHu24QKSvXgzfkEZ9fKAk92uQtklAQRNpbaFxykm1oiWGs1bG4al0E8QE
 5P3ht9h77bz0s0BbFHkf7K5PsKn0GF1pXT+mvJTmfSab5Cytrakg342UoajovQ4muJS2
 HE/pHc96nD3Pdk/8SGYmaXHJtZQSS6Cv7NwL8Im5CLLi3WwTb8/8vq9aUImfcsfaIb+L
 PssA==
X-Gm-Message-State: APjAAAV7d1nzFYQ1M7nyV3P+HwbL8yyICiBxGW21aYQtifGZbJWA7V3n
 QQ1P8oxDVMR6nz7daeLScUPRE5tq5IpoWg==
X-Google-Smtp-Source: APXvYqwDmhwDhs3WKG34RsEKvgP/Y5dPP7xlaHnoJVhfHzy5tbCIjgRPjR95sMtfnrwC6tmY9dMjLg==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr26116154wrj.168.1568121400402; 
 Tue, 10 Sep 2019 06:16:40 -0700 (PDT)
Received: from localhost ([148.69.85.38])
 by smtp.gmail.com with ESMTPSA id o22sm32214327wra.96.2019.09.10.06.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 06:16:34 -0700 (PDT)
Date: Tue, 10 Sep 2019 06:16:34 -0700 (PDT)
X-Google-Original-Date: Tue, 10 Sep 2019 06:15:11 PDT (-0700)
In-Reply-To: <cover.1566573576.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-d54ccfda-315c-4d9b-8b29-dd6cc43818e6@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 0/7] RISC-V: Hypervisor prep work part 2
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, bmeng.cn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 08:21:06 PDT (-0700), Alistair Francis wrote:
>
> The first three patches are ones that I have pulled out of my original
> Hypervisor series at an attempt to reduce the number of patches in the
> series.
>
> These three patches all make sense without the Hypervisor series so can
> be merged seperatley and will reduce the review burden of the next
> version of the patches.
>
> The fource patch is a prep patch for the new v0.4 Hypervisor spec.
>
> The fifth patch is unreleated to Hypervisor that I'm just slipping in
> here because it seems easier then sending it by itself.
>
> The final two patches are issues I discovered while adding the v0.4
> Hypervisor extension.
>
> v4:
>  - Drop MIP change patch
>  - Add a Floating Point fixup patch
> v3:
>  - Change names of all GP registers
>  - Add two more patches
> v2:
>  - Small corrections based on feedback
>  - Remove the CSR permission check patch
>
>
>
> Alistair Francis (6):
>   target/riscv: Don't set write permissions on dirty PTEs
>   riscv: plic: Remove unused interrupt functions
>   target/riscv: Create function to test if FP is enabled
>   target/riscv: Update the Hypervisor CSRs to v0.4
>   target/riscv: Fix mstatus dirty mask
>   target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point
>
> Atish Patra (1):
>   target/riscv: Use both register name and ABI name
>
>  hw/riscv/sifive_plic.c         | 12 ------------
>  include/hw/riscv/sifive_plic.h |  3 ---
>  target/riscv/cpu.c             | 19 ++++++++++--------
>  target/riscv/cpu.h             |  6 +++++-
>  target/riscv/cpu_bits.h        | 35 +++++++++++++++++-----------------
>  target/riscv/cpu_helper.c      | 16 ++++++++++++----
>  target/riscv/csr.c             | 22 +++++++++++----------
>  7 files changed, 58 insertions(+), 55 deletions(-)

Aside from that PTE patch, I've applied

    target/riscv: Use both register name and ABI name
    target/riscv: Fix mstatus dirty mask
    target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point

on top of Bin's patch set, as the rest had made it into for-master.  Like we 
talked about at lunch, I'm not sure the PTE one is actually correct -- it might 
just be paranoia, though.


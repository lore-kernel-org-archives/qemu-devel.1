Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC29C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D883020578
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/q7JgTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D883020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxOG-00028z-W2
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jIxME-00083H-Qc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jIxMD-0003q0-Of
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:33:50 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:44313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jIxMB-0003mQ-1K; Mon, 30 Mar 2020 12:33:47 -0400
Received: by mail-vs1-xe44.google.com with SMTP id e138so11395671vsc.11;
 Mon, 30 Mar 2020 09:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rDH/q2GpPZxjL8l3Amg8ZAoZYm6+vI648wqMKokJJFg=;
 b=r/q7JgTQmNyPD06a384M5qxfFGk2tt9KzDvtC1YSWWtzR4XQev6ayWeO6e0p1oT4MO
 nREmp7J3/r+GYGwVAgv715sNwMAxp4+RO7X5OocKFHw/fEzFjrLgptOIz/BrddFIqXPe
 myz0Zf1MrOPG5EfM8vNdjhaywaJPQVqxA0aCTuVtiKz43SARQ4DedxfkhUiEtj32HNW8
 A6n3jIpCDpSrrIDC+hQZriPX2Ic9JKz+9Bbr8AN5DN1s7LrFsfPIuY+4vJJ4au0Yvom4
 99Ws1HIRDZyqhkHvoHNVn0V4s9QboPyrzaQjIbFq1Oofjs6ynoK851dF9rWlg88mkbLv
 Oe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rDH/q2GpPZxjL8l3Amg8ZAoZYm6+vI648wqMKokJJFg=;
 b=jFMNlTMJtLe8vG/84pdejQNbSfwP2aEoPeadgOpczW6vDBWFvJU9/Y95n0pQALUnHL
 aaO/xdGKD58OALTgivY8lJxPh1JhiU1QW+tIuLsosPPsW8DzLxxuaWlkPNO1e/cd08II
 u6JPhetzjruqXaXiiM0y1jp2ub8JnoKuC0N9GG16AFxv0Zs4MkQGagQm2dcObdCGu5Sz
 DEIyXdeoeTGxEiiBfKf6W2npfOYvXc3xLens4wny2VgDOIvsu8BaaLvujZvnHPakG31g
 vzUhGLvpTD4yrT3dHudvGNd6X0h9skOwfHLO9+oQNOueOJVrIhqmSsitxXgfKCSPFr9/
 qrgA==
X-Gm-Message-State: AGi0PuY8SoS/x80JMPT9G11OAs6RYUcR22tfwZuAlLkwffLQB9uwZa9I
 dFybPPYlBhzCKC0T/zQU4dZB9hQ7E4h7/FSVmU0=
X-Google-Smtp-Source: APiQypLiIa5AVHmRz+e8Dme7+u8bT0kZDsMioNK0dq3p281EOcak8sWZGhT2CTUqHv1craNa+Fs1OINKLU+9lp7MYR4=
X-Received: by 2002:a05:6102:730:: with SMTP id
 u16mr1893152vsg.70.1585586026088; 
 Mon, 30 Mar 2020 09:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200330082724.120444-1-anup.patel@wdc.com>
In-Reply-To: <20200330082724.120444-1-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Mar 2020 09:25:38 -0700
Message-ID: <CAKmqyKMwso5-O3kZVt2oBA9y1BAGNYttzKqWkoU2V5VXi63uHg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix Stage2 SV32 page table walk
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 1:28 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> As-per RISC-V H-Extension v0.5 draft, the Stage2 SV32 page table has
> 12bits of VPN[1] and 10bits of VPN[0]. The additional 2bits in VPN[1]
> is required to handle the 34bit intermediate physical address coming
> from Stage1 SV32 page table. The 12bits of VPN[1] implies that Stage2
> SV32 level-0 page table will be 16KB in size with total 4096 enteries
> where each entry maps 4MB of memory (same as Stage1 SV32 page table).
>
> The get_physical_address() function is broken for Stage2 SV32 level-0
> page table because it incorrectly computes output physical address for
> Stage2 SV32 level-0 page table entry.
>
> The root cause of the issue is that get_physical_address() uses the
> "widened" variable to compute level-0 physical address mapping which
> changes level-0 mapping size (instead of 4MB). We should use the
> "widened" variable only for computing index of Stage2 SV32 level-0
> page table.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 50e13a064f..bc80aa87cf 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -559,12 +559,7 @@ restart:
>              /* for superpage mappings, make a fake leaf PTE for the TLB's
>                 benefit. */
>              target_ulong vpn = addr >> PGSHIFT;
> -            if (i == 0) {
> -                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
> -                             PGSHIFT;
> -            } else {
> -                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> -            }
> +            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
>
>              /* set permissions on the TLB entry */
>              if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
> --
> 2.17.1
>
>


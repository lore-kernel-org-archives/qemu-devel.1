Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEADC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C983217D7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvhIiFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C983217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwGWE-0005lw-KI
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 21:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwGVj-0005KL-V4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwGVi-00005P-SM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:49:35 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwGVi-00004r-Ij; Fri, 09 Aug 2019 21:49:34 -0400
Received: by mail-lj1-x244.google.com with SMTP id x4so1541729ljj.6;
 Fri, 09 Aug 2019 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y9QH/w9l5qJnuHMWLHU+oaiciYxpU02we5mfBx6Z8Sk=;
 b=nqvhIiFRjOaqdtUUBBSUg+r8aIBM1h6zDK2BH3U1xBVyEZ6nPfDFz57ymTe06uQ1BS
 tXCSmPRFrI88zCkzEMnVTe9mO+F+95f6lSvZ7Wu2o50+AQoZMq7sOaCkswK4aVo34Jy8
 zs6r/r0hEmD4NLtQEO3ofn13Pe/6u63Bd1w3vms6gaJdv6ApAHQzRC4Gc8zr8tEguknE
 TRrCpmpbuFx2GNxuM44zQyBlG6S1lTh4TDgvld8+4eN4lHtjkCk06KiHnz2eN0axGq8j
 Nqb38yjx9kxbJdVRyjBRApNO3rQCuUuJ8EhEJUvbSTHJYMAwUI2uTNl2Eor4igPyKnMH
 e8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y9QH/w9l5qJnuHMWLHU+oaiciYxpU02we5mfBx6Z8Sk=;
 b=DZ5ROetgCbG5RaZ+PWtItv1skCaWs4XyJ7Qov1Pi//bY6GKh7eSjzu269Afth2RSAs
 N+bUeXvEOBmdNcJkKSWaQvUYUwwUpGXX0svUihcked90efcxqPHi5HqYgndUvkt7A/yu
 aJF4BoYu16X+NfDm6qS2UOH2y3x5UF184kmZqCRHSvlV4DDgeUMontwzaKl8vLYWelas
 zmCo65QCB+GYM1jsPA20BYUyZvjob6svGfc9vGiU0iCHdDY2oS8FPI6ukz8hAO3QR+16
 u9hX9u32Jkg6z7x0XMaUP6ejm+BxCWfURXQeodKhtUgyVDa9Pj3LzoAIR0Xv+ulTd9LV
 /wGw==
X-Gm-Message-State: APjAAAU/vROEcZ6vrHeQ5A0LgIa6/mbv6KeYWYDmlNkHkjKWXPpCvAvN
 /muOuWQrDc4ujspyiXPT1Qy+yD56OVkAfLjxwhA=
X-Google-Smtp-Source: APXvYqz4490Al0TsQSvB5U1w5hgxDoR4JeL9yDJNF4rcbvkRhBFCOZPiZDakFwOdIwBdEIbZigPsTIYeWp+UfIC6WTk=
X-Received: by 2002:a2e:b4c9:: with SMTP id r9mr11145450ljm.196.1565401772211; 
 Fri, 09 Aug 2019 18:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
 <1565232570-29296-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565232570-29296-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Aug 2019 18:49:05 -0700
Message-ID: <CAKmqyKPQ0z-VtiebdtBqhBocgGkgeLLbtcawhwss0YpoYZyH2A@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2] riscv: rv32: Root page table address
 can be larger than 32-bit
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 7:50 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> For RV32, the root page table's PPN has 22 bits hence its address
> bits could be larger than the maximum bits that target_ulong is
> able to represent. Use hwaddr instead.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - promote ppn, env->satp/env->sptbl to hwaddr otherwise the page
>   table base will not be correctly calculated
>
>  target/riscv/cpu_helper.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e32b612..b2b4f3a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -176,12 +176,12 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>
>      *prot = 0;
>
> -    target_ulong base;
> +    hwaddr base;
>      int levels, ptidxbits, ptesize, vm, sum;
>      int mxr = get_field(env->mstatus, MSTATUS_MXR);
>
>      if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> -        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
> +        base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
>          sum = get_field(env->mstatus, MSTATUS_SUM);
>          vm = get_field(env->satp, SATP_MODE);
>          switch (vm) {
> @@ -201,7 +201,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>            g_assert_not_reached();
>          }
>      } else {
> -        base = env->sptbr << PGSHIFT;
> +        base = (hwaddr)(env->sptbr) << PGSHIFT;
>          sum = !get_field(env->mstatus, MSTATUS_PUM);
>          vm = get_field(env->mstatus, MSTATUS_VM);
>          switch (vm) {
> @@ -239,7 +239,7 @@ restart:
>                             ((1 << ptidxbits) - 1);
>
>          /* check that physical address of PTE is legal */
> -        target_ulong pte_addr = base + idx * ptesize;
> +        hwaddr pte_addr = base + idx * ptesize;
>
>          if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>              !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> @@ -251,7 +251,7 @@ restart:
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
>  #endif
> -        target_ulong ppn = pte >> PTE_PPN_SHIFT;
> +        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>
>          if (!(pte & PTE_V)) {
>              /* Invalid PTE */
> --
> 2.7.4
>
>


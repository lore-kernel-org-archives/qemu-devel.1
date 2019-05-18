Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE703C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 21:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB77D20873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 21:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMujSkON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB77D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39047 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS7FC-0007pG-Ls
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 17:51:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hS7EO-0007Mi-Mi
	for qemu-devel@nongnu.org; Sat, 18 May 2019 17:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fintelia@gmail.com>) id 1hS7EN-0008Gm-Bd
	for qemu-devel@nongnu.org; Sat, 18 May 2019 17:51:04 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fintelia@gmail.com>)
	id 1hS7EK-0008Bp-3L; Sat, 18 May 2019 17:51:00 -0400
Received: by mail-lf1-x144.google.com with SMTP id y19so7686159lfy.5;
	Sat, 18 May 2019 14:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=TGYcq3uL2t5IesqkvoIlD28a6haYO9HahMhUN4ZmhBA=;
	b=CMujSkON83qVIW5+8i/88Q7kwknN2U80FAVIGoqEINYwQXLo9g76yv5EIdipr5e1HK
	nsYTpe5eBqtR9fRhEcr5rAb8Mv9A8pQ6Fg/U3OkpGe1bW6xUYhDhpQCoG8Hn0xT3Ha1L
	z2SJxwGnzl4VvKv/jEG7ubfcLlzLdsf01Q9OrStNcWStSjo8cXXWVhr/EiAyun1aKBh3
	fUgFuYG/9L2mzXCxY4O+GYgoIMWk1rrou+I4Y4L0HalaIcLhYfWKBh74PqM/xRLy4qws
	j7PGx3rSqLgL4ffMGmfWodnYHAA1Sn1Ohti9Yf9OeaqsYpXbra5l8jt0+BB0JYXtcEgZ
	uw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=TGYcq3uL2t5IesqkvoIlD28a6haYO9HahMhUN4ZmhBA=;
	b=EZM1CsHWB8R6vO6xqpQGUmmtqvPILJnBridmxW2VTiAuB7jzc+OjqIImef+TmaolkJ
	YbfXPfTL0/K6TCy3lJN2z0hJ8bSPTLrom7RuOVqAlEtFY8u4nficltBDfax3WCoz8W34
	LbTO3eWFSWAcZ4jsd1+mcdmW9m2tLOBV65+ENXCBkRmQxF2A51752AlIYaQIHtNW319R
	/WYddHRI0tb92655jtzojbNcSnWwHlHcT7rlXUCRiXkQdUCeK2fsyvxGWCV3J3Kasbyf
	dH58vMyL2V0ymrkmZPxoU4azXRTQD5EZMeUSR2r3wciokowHQ8azTRspLcA/I1XmwCT1
	iyvA==
X-Gm-Message-State: APjAAAUWW+47eZmUYT2mifZ17akJiXmIpLQLWL24nTFX8Hb+jWp/DFlm
	NSvTkVjqwuK6tD7ATUPmaJCWlJaTzqouNyapU0I=
X-Google-Smtp-Source: APXvYqwGyPG+j1NA7+y8PGXBReZStyTMYwKbrA9UMP748w3qUuZX8txoPyOjRNFSm+mNfNdyTna8MHoXz3Qfa89jzGE=
X-Received: by 2002:ac2:528f:: with SMTP id q15mr13859490lfm.37.1558216257484; 
	Sat, 18 May 2019 14:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191323.4907-1-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190518191323.4907-1-Hesham.Almatary@cl.cam.ac.uk>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Sat, 18 May 2019 17:50:31 -0400
Message-ID: <CANnJOVHoc3fAx=_iuOxaKjtWoUg2_npXu+CzQ+CcppevBmddtA@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH 1/2] RISC-V: Raise access
 fault exceptions on PMP violations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch assumes that translation failure should always raise a paging
fault, but it should be possible for it to raise an access fault as well
(since according to the spec "PMP  checks  are  also  applied  to
page-table  accesses  for  virtual-address translation, for which the
effective privilege mode is S."). I think the code to actually do the PMP
checking during page table walks is currently unimplemented though...

Jonathan

On Sat, May 18, 2019 at 3:14 PM Hesham Almatary <
Hesham.Almatary@cl.cam.ac.uk> wrote:

> Section 3.6 in RISC-V v1.10 privilege specification states that PMP
> violations
> report "access exceptions." The current PMP implementation has
> a bug which wrongly reports "page exceptions" on PMP violations.
>
> This patch fixes this bug by reporting the correct PMP access exceptions
> trap values.
>
> Signed-off-by: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
> ---
>  target/riscv/cpu_helper.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 41d6db41c3..b48de36114 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -318,12 +318,13 @@ restart:
>  }
>
>  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> -                                MMUAccessType access_type)
> +                                MMUAccessType access_type, bool
> pmp_violation)
>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
>      int page_fault_exceptions =
>          (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> -        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
> +        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> +        !pmp_violation;
>      switch (access_type) {
>      case MMU_INST_FETCH:
>          cs->exception_index = page_fault_exceptions ?
> @@ -389,6 +390,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>      CPURISCVState *env = &cpu->env;
>      hwaddr pa = 0;
>      int prot;
> +    bool pmp_violation = false;
>      int ret = TRANSLATE_FAIL;
>
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> @@ -402,6 +404,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type))
> {
> +        pmp_violation = true;
>          ret = TRANSLATE_FAIL;
>      }
>      if (ret == TRANSLATE_SUCCESS) {
> @@ -411,7 +414,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address,
> int size,
>      } else if (probe) {
>          return false;
>      } else {
> -        raise_mmu_exception(env, address, access_type);
> +        raise_mmu_exception(env, address, access_type, pmp_violation);
>          riscv_raise_exception(env, cs->exception_index, retaddr);
>      }
>  #else
> --
> 2.17.1
>
>
>

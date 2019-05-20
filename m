Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE996C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98827216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4jZHMWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98827216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42580 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqJ8-0008KV-OK
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:58:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqII-0007pp-5P
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqIH-0002qD-0d
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:58:06 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSqIE-0002oP-Ol; Mon, 20 May 2019 17:58:02 -0400
Received: by mail-lf1-x144.google.com with SMTP id x132so11482038lfd.0;
	Mon, 20 May 2019 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=M6qMObBAkscLuAOv22PkbXDv/eymZ80GxzTPN5ZaAGU=;
	b=H4jZHMWstN9+nBGIsm6NQE9JsWlZzbu1YF/Xq56BsgwFCx25koI68ZZRh67pE9X4bN
	OFHpomQrg7ROSCLRPMevZtjyAQ2KDP6zUJVEdqqgC8ZBnT9F8p/OD/FcDkbPn6c5TzgE
	zHiXp4GOf6fnEBGmkzntKEGmDJiBODi9ELB5+curJfYjy+A/Vy7q+im0KxHcEypQOBEX
	2e4tsi5zHobGf38oe57RB/nOG7MfBv2OIVIIPbZAVPUmtkonvqyAjgB5yE9NVjAtSMtC
	r32OLJzeTCwBypaENGo9DXhkrfKovZ3B6KAWvZwFOdvq+qRMdNItnn5pOlYW/MkpPHRg
	w/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=M6qMObBAkscLuAOv22PkbXDv/eymZ80GxzTPN5ZaAGU=;
	b=EFtbe69mj3chaW3qS7I3QM4trCTfCRM8anOWV0sfldI0AnhKeFBvFY1DR1isbxRIbV
	JSXYg1HBEHgCf7wJcWA5jsiB+YdH943/yO7jyUOLfohmihyvN7+h+n3U9XEL3Pf5x6F6
	/PQNXhIyx7WfQF5gPQdEvKUmscTZFeo+hijiOpniMiQNZYkS1q0PlfssSbMdlv75J/V7
	Z2gD0Uy5iHHTvw1nftc/pM8qZSZRiXXm86AP8jPFQTUmlvNFt0ec3951xT37ypr4NdLN
	RQB3C0D9DuiNFoi3pWlCW9ZgpE7Jn9aeDWtqELwiZ+f8aT8BR3N98BPtILicN1M8pQf6
	eGWQ==
X-Gm-Message-State: APjAAAWzhGJTReMCWo1+xUmc6p5oM1pkAKxo9gNb09BSF25nhaqbx/y4
	flLm8jxO/e+rAD4odpA9W9Wcs6XMD7h9xrcgh0Y=
X-Google-Smtp-Source: APXvYqzrxEFSVPHFC6sDQZcgFH4qxix6PpsnR9oSCUJA1bYJVS3KzfzmbB6Yei1/OdYQ6EonqJ0VmlD+XWVFVZW9BRQ=
X-Received: by 2002:a19:4cd5:: with SMTP id
	z204mr23321738lfa.113.1558389481043; 
	Mon, 20 May 2019 14:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190518232502.5201-1-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190518232502.5201-1-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 14:55:46 -0700
Message-ID: <CAKmqyKPuRKXQt7jRaEqMDZZc0HjFRPj9C6Mo5Ht=ZQ5ssBawCA@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCHv2 1/3] RISC-V: Raise access fault
 exceptions on PMP violations
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

On Sat, May 18, 2019 at 6:35 PM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> Section 3.6 in RISC-V v1.10 privilege specification states that PMP violations
> report "access exceptions." The current PMP implementation has
> a bug which wrongly reports "page exceptions" on PMP violations.
>
> This patch fixes this bug by reporting the correct PMP access exceptions
> trap values.
>
> Signed-off-by: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> +                                MMUAccessType access_type, bool pmp_violation)
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
> @@ -389,6 +390,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      CPURISCVState *env = &cpu->env;
>      hwaddr pa = 0;
>      int prot;
> +    bool pmp_violation = false;
>      int ret = TRANSLATE_FAIL;
>
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> @@ -402,6 +404,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> +        pmp_violation = true;
>          ret = TRANSLATE_FAIL;
>      }
>      if (ret == TRANSLATE_SUCCESS) {
> @@ -411,7 +414,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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


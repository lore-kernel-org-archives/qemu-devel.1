Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA78FC072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FA021773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNKstpYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FA021773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60425 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTDRg-0000YA-P2
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 18:41:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDQu-0000EB-11
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDQs-000496-P7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:40:31 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hTDQf-0003xJ-Cd; Tue, 21 May 2019 18:40:18 -0400
Received: by mail-lj1-x243.google.com with SMTP id j24so285123ljg.1;
	Tue, 21 May 2019 15:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/Mi+xmKHJT7YLsvelawAkPJ+CVrsDjcpYoMp5rF25dA=;
	b=FNKstpYPFYDfu2nlqcB25mVSqUAB2NmH68eoiVrtaYKapLA3B18hW3CmccrJq5sd3/
	QOlLXxDNJFFN5Yt2gHQbu+C7AMxonrzPY4awxzlQTvpAHWjJJA+mQsEi5j1B80ksFvK1
	smx/OG26/JCNtpHoECEDU9pL+GymZzjhHplts1CAb8RTRpiCvOtVuTUVKynVd3tuebpP
	hCdjf3BdDPsX0hbu1tayM33Xt2e+WBgT32P3T4SBra0KtiNbHwsuSJj15b8bgDRTJ+7r
	/z0yTDGb2YrY/nCs3mXklOEyto6A1L+wNb6RPvC5ELtnDnidAq2oiDo5lnc694E8r8xd
	3Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/Mi+xmKHJT7YLsvelawAkPJ+CVrsDjcpYoMp5rF25dA=;
	b=NxW7G7PZSNcDViXnBhWVoBeuRWC/aTEmmVt6L1HBUjF4jFiTQ1zwDRlLLaLdJCzX7e
	Ymg5kDwk3BeY2n/5YKOlu0lFVTdm00pzzCBxyrZmvBRQO1vLbHDpyGHli4jygworiJVf
	j4eCzcQKVblDH5hDkg1rjBYJuHqJQoHt2gB80B4zGv//ce6lCTfGMwA0KLb3BDjBIQ4N
	aNeh8QnOyp5Q5My/czDmaR1zs2kEOoppJElVi+TaVbs7bSLCpHqXDjrRmQ/3XzryavFr
	+poPpEurUVEXZXvKucW/BYn7I+KPp66IeZ/ysiJu9yz56TcDJQRxydCLBeYsb+2+IprU
	VLwA==
X-Gm-Message-State: APjAAAXhERAEeduy8U1Ab5ZCq+/F+olpV30q/4Q2xRBwnXMfnVKDBXng
	z+dPu9nspLUXqmLcSlHfRs15RDUMlCDt3Fe2iq4=
X-Google-Smtp-Source: APXvYqy16+kmDEl1XBrFuFo+hcOwLXfX+iYhQRTcMBsZpDEzUnR1bR0FSD2N5Z0hPq7QEPGXiHaJhszNQdhtPzdAL9s=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr28597998ljw.153.1558478414735;
	Tue, 21 May 2019 15:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-3-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190521104324.12835-3-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 May 2019 15:37:58 -0700
Message-ID: <CAKmqyKOT_15kFNjHkUgk+bs6GwGrDrAOPoe+t0u3T6hg6TqiPQ@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCHv3 3/5] RISC-V: Check PMP during Page Table
 Walks
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

On Tue, May 21, 2019 at 3:44 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The PMP should be checked when doing a page table walk, and report access
> fault exception if the to-be-read PTE failed the PMP check.
>
> Suggested-by: Jonathan Behrens <fintelia@gmail.com>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> ---
>  target/riscv/cpu.h        |  1 +
>  target/riscv/cpu_helper.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c17184f4e4..ab3ba3f15a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -94,6 +94,7 @@ enum {
>  #define PRIV_VERSION_1_09_1 0x00010901
>  #define PRIV_VERSION_1_10_0 0x00011000
>
> +#define TRANSLATE_PMP_FAIL 2
>  #define TRANSLATE_FAIL 1
>  #define TRANSLATE_SUCCESS 0
>  #define NB_MMU_MODES 4
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 7c7282c680..d0b0f9cf88 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -211,6 +211,12 @@ restart:
>
>          /* check that physical address of PTE is legal */
>          target_ulong pte_addr = base + idx * ptesize;
> +
> +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> +            1 << MMU_DATA_LOAD)) {

I see a problem here.

pmp_hart_has_privs() checks permissions based on the current value of
env->priv. This might not always be the correct permissions to check,
we should instead use the current mode to check permissions.

The best way to do this to me is to probably provide a privileged mode
override to the function, can you add that?

Alistair

> +            return TRANSLATE_PMP_FAIL;
> +        }
>  #if defined(TARGET_RISCV32)
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>  #elif defined(TARGET_RISCV64)
> @@ -405,8 +411,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> +        ret = TRANSLATE_PMP_FAIL;
> +    }
> +    if (ret == TRANSLATE_PMP_FAIL) {
>          pmp_violation = true;
> -        ret = TRANSLATE_FAIL;
>      }
>      if (ret == TRANSLATE_SUCCESS) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> --
> 2.17.1
>
>


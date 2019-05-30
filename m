Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C453EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F33C2446F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbNXp+eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F33C2446F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWBRD-0000Vh-GA
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 23:09:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBQ7-0008QZ-Ex
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBQ6-0005gj-Df
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:07:59 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:46231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hWBQ3-0005ec-RM; Wed, 29 May 2019 23:07:56 -0400
Received: by mail-lf1-x143.google.com with SMTP id l26so3737642lfh.13;
	Wed, 29 May 2019 20:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=t85CKhLxL2SAcqiX2wUpra55YKWZv+z9N12AhtQFjI4=;
	b=vbNXp+eIuRok5+cU9QiImSIVgMt2onlfKqIMG5p1FHBV0q2Igz6EBiYfSZgqB0QMUf
	GDZvMbJ2AiX+cxp9Cvk8rd5ShJgt5BgzK9G7lmdFfpIOJL/ZQ+QBWJ26UjM5fZp5t675
	/a8evcCpt2LxxwAKX1Tic1D873yz85VqHwC0J7WipFNM5Yd6KCpuYuB4q6Zf5goVcKme
	QZdeFSqiky8jZStEmKLPe3f6TN9BdsN2bmklw0HLm9VRieK4bS71miZaKcB6NIzCmCj/
	vqS1A+DnbB5rm38EqA4dirHV9rgYohwf+IIotDGYlVg4cr4xit8luHEcEbGTJ7bZ50TT
	oMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=t85CKhLxL2SAcqiX2wUpra55YKWZv+z9N12AhtQFjI4=;
	b=ookV1KW1eA0Qmy86wBLs9YNA0uHAxQg3ViWMBAyWdtOr48UyGvlp9Ml/ByUwidVKFS
	au8gccIfMyKIsdUt1fkhg8oGbex0JFHUioUUCAyyAtUZY1lljXBxwZulF5Y9TTAndU4Z
	HcE4kBez3sesCgVGRj5ZP1jujW99uMazonx1qM8BEIctg89e8PZZyzaBm+AeonWUcCJj
	gVqXwwR+gezEhKJNXgpZopdx9KA/ZLNaAJJBPF1PYzWisQ2i7VCTs9dBcJBHwUIfgzVI
	haoqZOWFHZAA+rRf7lXLi064V2KfRrmGw7Q3sF4VxLZN21x5zEfolK5ZPlKO4gqkDL9S
	RJkw==
X-Gm-Message-State: APjAAAWwSWO/gC7IKR9AScu/QKg1r2noiUGl+Y9CdbdtxBg9oyYUfJWI
	T81DgfxD6uPwdsLC8qEqBYhoyUvGUA6cnjyx57M=
X-Google-Smtp-Source: APXvYqwNSEyI3XCgOsG1oLNpD+st0hjcdgZ/20iA7C6GlR1BmCdpGwZKxJq2F5iZJjOt2O28EAYbU9P5H8wCU61MKdA=
X-Received: by 2002:a19:7003:: with SMTP id h3mr619522lfc.135.1559185673859;
	Wed, 29 May 2019 20:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-3-Hesham.Almatary@cl.cam.ac.uk>
	<CAKmqyKOT_15kFNjHkUgk+bs6GwGrDrAOPoe+t0u3T6hg6TqiPQ@mail.gmail.com>
	<CA+wsVCDgogUXBDNiWm7R19fAyNw-3ybPiW4O8yA=Wt8oqyShFg@mail.gmail.com>
In-Reply-To: <CA+wsVCDgogUXBDNiWm7R19fAyNw-3ybPiW4O8yA=Wt8oqyShFg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 May 2019 20:07:26 -0700
Message-ID: <CAKmqyKNN-R1jJB3DXQqvPQsu+8W3jH+mrCD+iBbdH+J_JwRbgg@mail.gmail.com>
To: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
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

On Wed, May 22, 2019 at 2:27 AM Hesham Almatary
<hesham.almatary@cl.cam.ac.uk> wrote:
>
> On Tue, 21 May 2019 at 23:40, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, May 21, 2019 at 3:44 AM Hesham Almatary
> > <Hesham.Almatary@cl.cam.ac.uk> wrote:
> > >
> > > The PMP should be checked when doing a page table walk, and report access
> > > fault exception if the to-be-read PTE failed the PMP check.
> > >
> > > Suggested-by: Jonathan Behrens <fintelia@gmail.com>
> > > Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> > > ---
> > >  target/riscv/cpu.h        |  1 +
> > >  target/riscv/cpu_helper.c | 10 +++++++++-
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index c17184f4e4..ab3ba3f15a 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -94,6 +94,7 @@ enum {
> > >  #define PRIV_VERSION_1_09_1 0x00010901
> > >  #define PRIV_VERSION_1_10_0 0x00011000
> > >
> > > +#define TRANSLATE_PMP_FAIL 2
> > >  #define TRANSLATE_FAIL 1
> > >  #define TRANSLATE_SUCCESS 0
> > >  #define NB_MMU_MODES 4
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index 7c7282c680..d0b0f9cf88 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -211,6 +211,12 @@ restart:
> > >
> > >          /* check that physical address of PTE is legal */
> > >          target_ulong pte_addr = base + idx * ptesize;
> > > +
> > > +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> > > +            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> > > +            1 << MMU_DATA_LOAD)) {
> >
> > I see a problem here.
> >
> > pmp_hart_has_privs() checks permissions based on the current value of
> > env->priv. This might not always be the correct permissions to check,
> > we should instead use the current mode to check permissions.
> >
> That is not clear to me. Isn't env->priv the current privildge mode?
> Could you please elaborate on what other cases this might not be the case?

Sorry for the delay. The RISC-V Hypervisor Extension allows load/store
operations to be carried out as a previous privilege. The mstatus.MPRV
and hstatus.SPRV allow this.

Alistair

>
> > The best way to do this to me is to probably provide a privileged mode
> > override to the function, can you add that?
> >
> > Alistair
> >
> > > +            return TRANSLATE_PMP_FAIL;
> > > +        }
> > >  #if defined(TARGET_RISCV32)
> > >          target_ulong pte = ldl_phys(cs->as, pte_addr);
> > >  #elif defined(TARGET_RISCV64)
> > > @@ -405,8 +411,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > >      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> > >          (ret == TRANSLATE_SUCCESS) &&
> > >          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> > > +        ret = TRANSLATE_PMP_FAIL;
> > > +    }
> > > +    if (ret == TRANSLATE_PMP_FAIL) {
> > >          pmp_violation = true;
> > > -        ret = TRANSLATE_FAIL;
> > >      }
> > >      if (ret == TRANSLATE_SUCCESS) {
> > >          tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> > > --
> > > 2.17.1
> > >
> > >


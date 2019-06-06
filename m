Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635CC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611D320684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN4EErxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611D320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1WK-0003ip-Lw
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40040)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hZ1Ra-0007Mw-Vu
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hZ1Ob-0000K3-LP
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:02:10 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hZ1Oa-0000GG-5E; Thu, 06 Jun 2019 19:02:08 -0400
Received: by mail-lf1-x141.google.com with SMTP id m15so161627lfh.4;
 Thu, 06 Jun 2019 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wMAd7XoZVa4u3lEJXMplu8dFmMqEkJSkW7xUBdkVIdo=;
 b=bN4EErxrsWnoKLKfBMU8tZyGh73eQl6w5+YoeUAB9o/soaTy2sa6V9tu6GAiodd1DA
 i7ENw1Nr9HSC+KIWkuA6pedMZKzEPAyMsNCrG4ovFcX6+QEx5jSqsGM2cx/SNteA7wgY
 WQPuD0r/ouLg13slsbfI0ekHstpn2fwHvJncJrOjSSFecfPHRwHaM2pC3juOtDnO2x1X
 CQMuHPmaRGkDjmxvCJM9/EdloWSXk0yTQVOU7JzTmFdZlmidXvbZh0/oQ+YcVUoVxt9w
 o6QYEDyY4oa/+IdVC7YJ6vrlb49joiWw9Tv9aQ0CutH8QovZIM9lsSTItO/MBeugQYbv
 D/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wMAd7XoZVa4u3lEJXMplu8dFmMqEkJSkW7xUBdkVIdo=;
 b=GIADqGktNGrg0gQIsyQhasZgiDxemaN0E83YyU+Yt91bCeLZYjJNigC203dM2u50N2
 c/4RGw3YSimVeWgDSsJsGafhvSITZ/j2G4NtRKjm7FPgl9397DnwcLJICz94fQQkIOOy
 wJeIy/YfaesOiyVXll6xlq1lASbJnUZzTyh8kPGo4n054GdpbsErRemXN9daWl1RR1DK
 v8Lm/2MCCjOgN7XiZcDmfIPx9A7drT/vnuTBiV0bRCCfTrU4ox2o36jTGc5sOvvfFtvz
 leztJ35uM74OQCb/P869/QmrSWRnD2nZnrw0+FdR8q+cY4+wtoH4kjdD3NsJj1BCNPQV
 6qZA==
X-Gm-Message-State: APjAAAUJ6oVSYThQCJ4tCq3xxa1PFkmNbLp2HL3jeuqXJzK598rvFTrB
 gtJPmE5L9PxkevvBVgX/ertXva4pGIffafpVl8Q=
X-Google-Smtp-Source: APXvYqxguDs05bhQoQTe8+TYUC1BI1qSko5laJK6Hofh/eU4qP9v4HmOP1O94kLueYnSYPqVngspEUawPQdIC/UM2qg=
X-Received: by 2002:ac2:4899:: with SMTP id x25mr22509812lfc.44.1559862126271; 
 Thu, 06 Jun 2019 16:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190530135135.19715-1-Hesham.Almatary@cl.cam.ac.uk>
 <20190530135135.19715-4-Hesham.Almatary@cl.cam.ac.uk>
 <CAKmqyKNwec3HaNZ_=vsA1eYa3yjRWe8Q9ZaNcQ9AXZcGvbsQdw@mail.gmail.com>
 <CA+wsVCDMHpM0BCvoWVz1mFPGpjMRSGZ8boGhBF5p2VTAAJaGNw@mail.gmail.com>
In-Reply-To: <CA+wsVCDMHpM0BCvoWVz1mFPGpjMRSGZ8boGhBF5p2VTAAJaGNw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2019 15:59:31 -0700
Message-ID: <CAKmqyKPE3pn15hQnhYu78HnnSNBfugO9R1EgXe+0t31YATHL9w@mail.gmail.com>
To: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCHv4 4/6] RISC-V: Check PMP during Page Table
 Walks
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 5, 2019 at 3:59 PM Hesham Almatary
<hesham.almatary@cl.cam.ac.uk> wrote:
>
> On Wed, 5 Jun 2019 at 23:07, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, May 30, 2019 at 6:52 AM Hesham Almatary
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
> > > index 5a1cd7cf96..00bc4f1712 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -211,6 +211,12 @@ restart:
> > >
> > >          /* check that physical address of PTE is legal */
> > >          target_ulong pte_addr = base + idx * ptesize;
> > > +
> > > +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> > > +            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> > > +            1 << MMU_DATA_LOAD, PRV_S)) {
> >
> > Shouldn't we be passing mode in here?
> >
> I actually thought this way at the start. But then I made it PRV_S for
> intentionality; as in PTW (in the current master, without hypervisor
> extensions) always goes under PMP protection in S-Mode.

Yep, you are right, I see this in the spec:

"PMP checks are also applied to page-table accesses for
virtual-address translation, for which the effective privilege mode is
S."

In which case:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> This also aligns with Spike implementation here [1].
>
> [1] https://github.com/riscv/riscv-isa-sim/blob/8ac902f6ff877e976af434bfe8fa8445930174a1/riscv/mmu.cc#L288
>
>
> > Alistair
> >
> > > +            return TRANSLATE_PMP_FAIL;
> > > +        }
> > >  #if defined(TARGET_RISCV32)
> > >          target_ulong pte = ldl_phys(cs->as, pte_addr);
> > >  #elif defined(TARGET_RISCV64)
> > > @@ -413,8 +419,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > >          (ret == TRANSLATE_SUCCESS) &&
> > >          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
> > >          mode)) {
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


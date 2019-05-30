Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14087C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EB025952
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="MINGF1A8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EB025952
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWKq0-0008AP-Pt
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 09:11:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hWKpE-0007kX-8i
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hWKpC-0003Te-DH
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:10:32 -0400
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:37046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hmka2@hermes.cam.ac.uk>)
	id 1hWKp3-0003M7-Ad; Thu, 30 May 2019 09:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
	s=20180806.ppsw;
	h=Sender:Content-Type:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qUpRepGQOt/XAQs+elq3yyHkbiLJfY8ZvXaWCQVA4t0=;
	b=MINGF1A8ONF8BOCYmJqjvbsMP9
	jEsXyYo70KR8bF06IKMtJL3sK8QWTT20SqxERJwdGR7AQUG4C/MkMpkt6OshaVvsrt/vhLEDLI9yh
	Y2HjeFK9pz5tDx2YuufXUlThjNuXy9CO0AskvB6iSNVQhilcwAMJjApjBGMwdn5bu9Z0=; 
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41406)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:hmka2) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	id 1hWKp0-0013gu-Re (Exim 4.91)
	(return-path <hmka2@hermes.cam.ac.uk>); Thu, 30 May 2019 14:10:18 +0100
Received: by mail-lf1-f43.google.com with SMTP id 136so4973471lfa.8;
	Thu, 30 May 2019 06:10:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVH5beLq3pu7j5w/Rn/6bDOyA1y1BFagdV1YBI84HQvOyOm0kB7
	0a4DLPGgnUAZrQRMTPrvWwhnnnwbLxgbeJ5GZJY=
X-Google-Smtp-Source: APXvYqwaPsVJx1kMtWL8CMB8ZJxgjHxb3ij6MH8SOVOuGYszQ3HIpdHZi5/AG5ad4BsXmkoiPxYyzUGo8GFFrJ8p7h0=
X-Received: by 2002:a19:488e:: with SMTP id v136mr2031057lfa.192.1559221814232;
	Thu, 30 May 2019 06:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-3-Hesham.Almatary@cl.cam.ac.uk>
	<CAKmqyKOT_15kFNjHkUgk+bs6GwGrDrAOPoe+t0u3T6hg6TqiPQ@mail.gmail.com>
	<CA+wsVCDgogUXBDNiWm7R19fAyNw-3ybPiW4O8yA=Wt8oqyShFg@mail.gmail.com>
	<CAKmqyKNN-R1jJB3DXQqvPQsu+8W3jH+mrCD+iBbdH+J_JwRbgg@mail.gmail.com>
In-Reply-To: <CAKmqyKNN-R1jJB3DXQqvPQsu+8W3jH+mrCD+iBbdH+J_JwRbgg@mail.gmail.com>
From: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
Date: Thu, 30 May 2019 15:09:37 +0200
X-Gmail-Original-Message-ID: <CA+wsVCBgEQUCHeBAe84ZkCeRb9bNw3xQ6gbSORQ9Oc0_YPM66A@mail.gmail.com>
Message-ID: <CA+wsVCBgEQUCHeBAe84ZkCeRb9bNw3xQ6gbSORQ9Oc0_YPM66A@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.111.8.141
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
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 at 05:07, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, May 22, 2019 at 2:27 AM Hesham Almatary
> <hesham.almatary@cl.cam.ac.uk> wrote:
> >
> > On Tue, 21 May 2019 at 23:40, Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Tue, May 21, 2019 at 3:44 AM Hesham Almatary
> > > <Hesham.Almatary@cl.cam.ac.uk> wrote:
> > > >
> > > > The PMP should be checked when doing a page table walk, and report access
> > > > fault exception if the to-be-read PTE failed the PMP check.
> > > >
> > > > Suggested-by: Jonathan Behrens <fintelia@gmail.com>
> > > > Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> > > > ---
> > > >  target/riscv/cpu.h        |  1 +
> > > >  target/riscv/cpu_helper.c | 10 +++++++++-
> > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > > index c17184f4e4..ab3ba3f15a 100644
> > > > --- a/target/riscv/cpu.h
> > > > +++ b/target/riscv/cpu.h
> > > > @@ -94,6 +94,7 @@ enum {
> > > >  #define PRIV_VERSION_1_09_1 0x00010901
> > > >  #define PRIV_VERSION_1_10_0 0x00011000
> > > >
> > > > +#define TRANSLATE_PMP_FAIL 2
> > > >  #define TRANSLATE_FAIL 1
> > > >  #define TRANSLATE_SUCCESS 0
> > > >  #define NB_MMU_MODES 4
> > > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > > index 7c7282c680..d0b0f9cf88 100644
> > > > --- a/target/riscv/cpu_helper.c
> > > > +++ b/target/riscv/cpu_helper.c
> > > > @@ -211,6 +211,12 @@ restart:
> > > >
> > > >          /* check that physical address of PTE is legal */
> > > >          target_ulong pte_addr = base + idx * ptesize;
> > > > +
> > > > +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> > > > +            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
> > > > +            1 << MMU_DATA_LOAD)) {
> > >
> > > I see a problem here.
> > >
> > > pmp_hart_has_privs() checks permissions based on the current value of
> > > env->priv. This might not always be the correct permissions to check,
> > > we should instead use the current mode to check permissions.
> > >
> > That is not clear to me. Isn't env->priv the current privildge mode?
> > Could you please elaborate on what other cases this might not be the case?
>
> Sorry for the delay. The RISC-V Hypervisor Extension allows load/store
> operations to be carried out as a previous privilege. The mstatus.MPRV
> and hstatus.SPRV allow this.
>
No problem, thanks for the clarification.
You are right, I haven't considered MPRV. I fixed that in a separate
commit in a v4 series of patches.
> Alistair
>
> >
> > > The best way to do this to me is to probably provide a privileged mode
> > > override to the function, can you add that?
> > >
> > > Alistair
> > >
> > > > +            return TRANSLATE_PMP_FAIL;
> > > > +        }
> > > >  #if defined(TARGET_RISCV32)
> > > >          target_ulong pte = ldl_phys(cs->as, pte_addr);
> > > >  #elif defined(TARGET_RISCV64)
> > > > @@ -405,8 +411,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> > > >      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> > > >          (ret == TRANSLATE_SUCCESS) &&
> > > >          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> > > > +        ret = TRANSLATE_PMP_FAIL;
> > > > +    }
> > > > +    if (ret == TRANSLATE_PMP_FAIL) {
> > > >          pmp_violation = true;
> > > > -        ret = TRANSLATE_FAIL;
> > > >      }
> > > >      if (ret == TRANSLATE_SUCCESS) {
> > > >          tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
> > > > --
> > > > 2.17.1
> > > >
> > > >


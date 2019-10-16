Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2FDECE599
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3753B2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQOh/9Gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3753B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKqtt-00016r-AY
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 17:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iKqsL-0008PH-UK
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iKqsK-0001Mv-0R
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:30:33 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iKqsG-0001MF-6p; Wed, 16 Oct 2019 17:30:30 -0400
Received: by mail-lj1-x244.google.com with SMTP id b20so258625ljj.5;
 Wed, 16 Oct 2019 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XUlea2DSAEKe346P1bx5HoBWo3c3p+mbjpfa8oZZRD0=;
 b=FQOh/9GzHqr3SoL8SuIK02YCXqoPg+hMkfNOh2T3lV3X7x5DbBRbsNXAmhxC36BfKi
 W18ilXDNMyPvCVGZIXplDbEyBtNvrzlGUqQCn+StOz480NaLjTGYxp+xFH6zZr4VUIHQ
 Mkj9xFS202Q9da1pEgFY09DH/2hb6I/JXs0NhpCI00bd4xff+Lq1LDxhgMuoM6oo/rPu
 oCdmHFVTLVdWhfvi6KY4EhDgkQhzHCRrSpUaoQvl93vvXRbt0dPBOPYi0uvXKeRRx+Ro
 F+oqA3fKTac76BvZ4WSwiC+30pWJxfWBIEOUUEs6tvwuSnnSystU/tdwYecoMOluRwNv
 WsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XUlea2DSAEKe346P1bx5HoBWo3c3p+mbjpfa8oZZRD0=;
 b=DfAITVhdjozX7vDjI0OHnHweY80KOm6h9FUD3B8vgspj3qq0o2W2Id7cBsGGeazz3l
 XEqTAJAGjID7+rX0LWKRlKDgNSnERxaUaZ3TF4n6D2qbtZSZJ+sXtimdymu98yjb2BRh
 Hw22sB2g97Xszhieeaz49fHSQWr95qARGSdmXt6/PsG3votdjrlTLi0s4hS1fh1MvLKm
 yiGe4pUMbpRJ9he3ppsuz68G6ceLvbB6pT4QtGq23LD9IcJbWGvuZlFyH5fYud6g7aDU
 o09RzOU8MwygppKX2ys4ZF+0DpWg4QAKnvpTK/O4mBi0ClV3U67DeyHl4kyzSoavLXB9
 o0Hg==
X-Gm-Message-State: APjAAAW4K3rG9NxuHY0+vD/J1F5Myc11qg+f2m58Dagyk3WEsw97WVdF
 Zv9dZh0+X446OkJl2xjRsWHefjNe7QxNKx1NPUg=
X-Google-Smtp-Source: APXvYqxTan272op6Ym5ZyK29amK3gPEEMtLXTfsrijfZhCc6ypUZQ3tW90W49pvFeA8XR/xbbTxIQQQmzMMwGFmTI6o=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr179727ljj.4.1571261425599;
 Wed, 16 Oct 2019 14:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKOV0J3w3fPUF3CGAip=j_+D_M+7X9r+2TwEZwkapsQZMQ@mail.gmail.com>
 <mhng-8a742b0f-e79f-4da0-81fc-b91d184b6279@palmer-si-x1e>
In-Reply-To: <mhng-8a742b0f-e79f-4da0-81fc-b91d184b6279@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Oct 2019 14:25:17 -0700
Message-ID: <CAKmqyKPin+yU2C973rtUVoKr452GX8Bq7fqKeuOqNER5hO4CfA@mail.gmail.com>
Subject: Re: [PATCH v1 22/28] target/riscv: Allow specifying MMU stage
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 12:02 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 07 Oct 2019 11:05:33 PDT (-0700), alistair23@gmail.com wrote:
> > On Thu, Oct 3, 2019 at 8:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Fri, 23 Aug 2019 16:38:47 PDT (-0700), Alistair Francis wrote:
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> >  target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
> >> >  1 file changed, 30 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> > index 098873c83e..9aa6906acd 100644
> >> > --- a/target/riscv/cpu_helper.c
> >> > +++ b/target/riscv/cpu_helper.c
> >> > @@ -318,10 +318,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> >> >   *
> >> >   * Adapted from Spike's mmu_t::translate and mmu_t::walk
> >> >   *
> >> > + * @env: CPURISCVState
> >> > + * @physical: This will be set to the calculated physical address
> >> > + * @prot: The returned protection attributes
> >> > + * @addr: The virtual address to be translated
> >> > + * @access_type: The type of MMU access
> >> > + * @mmu_idx: Indicates current privilege level
> >> > + * @first_stage: Are we in first stage translation?
> >> > + *               Second stage is used for hypervisor guest translation
> >> >   */
> >> >  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >> >                                  int *prot, target_ulong addr,
> >> > -                                int access_type, int mmu_idx)
> >> > +                                int access_type, int mmu_idx,
> >> > +                                bool first_stage)
> >> >  {
> >> >      /* NOTE: the env->pc value visible here will not be
> >> >       * correct, but the value visible to the exception handler
> >> > @@ -518,13 +527,23 @@ restart:
> >> >  }
> >> >
> >> >  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> >> > -                                MMUAccessType access_type, bool pmp_violation)
> >> > +                                MMUAccessType access_type, bool pmp_violation,
> >> > +                                bool first_stage)
> >> >  {
> >> >      CPUState *cs = env_cpu(env);
> >> > -    int page_fault_exceptions =
> >> > -        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> >> > -        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> >> > -        !pmp_violation;
> >> > +    int page_fault_exceptions;
> >> > +    if (first_stage) {
> >> > +        page_fault_exceptions =
> >> > +            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> >> > +            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> >> > +            !pmp_violation;
> >> > +            riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
> >>
> >> It might just be email, but the indentation looks wrong here.
> >
> > Yep, fixed.
> >
> >>
> >> > +    } else {
> >> > +        page_fault_exceptions =
> >> > +            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
> >> > +            !pmp_violation;
> >> > +            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
> >> > +    }
> >> >      switch (access_type) {
> >> >      case MMU_INST_FETCH:
> >> >          cs->exception_index = page_fault_exceptions ?
> >> > @@ -551,7 +570,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> >> >      int prot;
> >> >      int mmu_idx = cpu_mmu_index(&cpu->env, false);
> >> >
> >> > -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
> >> > +    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
> >> > +                             true)) {
> >> >          return -1;
> >> >      }
> >> >      return phys_addr;
> >> > @@ -613,7 +633,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >> >      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> >> >                    __func__, address, access_type, mmu_idx);
> >> >
> >> > -    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
> >> > +    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
> >> > +                               true);
> >> >
> >> >      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> >> >          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> >> > @@ -640,7 +661,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >> >      } else if (probe) {
> >> >          return false;
> >> >      } else {
> >> > -        raise_mmu_exception(env, address, access_type, pmp_violation);
> >> > +        raise_mmu_exception(env, address, access_type, pmp_violation, true);
> >> >          riscv_raise_exception(env, cs->exception_index, retaddr);
> >> >      }
> >> >  #else
> >>
> >> I don't think it makes sense to split off these two (23 and 24, that add the
> >> argument) out from the implementation.
> >
> > The goal was just to make it easier to review. If you want them
> > combined I can easily combine them.
>
> It's making it harder to read on my end :)

Ha ok. I have squashed all three.

Alistair


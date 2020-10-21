Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1400C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5902416E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hS1BaLAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5902416E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJsX-00062l-6W
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 15:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVJqy-0005Xk-Rc; Wed, 21 Oct 2020 15:32:56 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:36778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kVJqw-0004gO-V8; Wed, 21 Oct 2020 15:32:56 -0400
Received: by mail-il1-x141.google.com with SMTP id p10so3640619ile.3;
 Wed, 21 Oct 2020 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UVBGRVqXtb9qyDZKTva0g6fGnQk+yo3i+XjcadbRUMY=;
 b=hS1BaLANYgREUNmbAtvI50W6MXUH/hbFqkRvmhUYx9G8zRLAXW13hXqyat37uX9Lop
 LhD4QLWymFQmZ0hXM3RDsFymIMwgSwodyiJ9Ea16CAGfxjTZdrUrGMCVcmilDjaiFWX7
 8VMGbS7dICm5+PZCPwjVZ3Vc9Nci27yCxZ74PP8m/6TJeCXN5e4/R6xOPpXeI6S99oBx
 Alj094o8ZWLxyUntElZdB32QJXH9wvwDufNpCeJSCVOsAGYDR6b4hQ+grXGH/2YD7lz2
 8HaVkYJKH9tEqLmNJzzTOs0VCwNvuSn5h+MC6U+xY69rb13CZTDJc6+/Jsjie/s0qsVb
 O+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UVBGRVqXtb9qyDZKTva0g6fGnQk+yo3i+XjcadbRUMY=;
 b=hxrdiiBVF/kGNVNRCVF/+5DB2wYZxmfDCNpPrx38jnkhBzsQRHJ4D8brYalBahcdFo
 /m3rdgvxURztUTl97uGJcmpzFwCp0ph0crnIorL76INZD2dC6qAmRtKpQ6sQ4QTQr/Ie
 hwA4OMlQs74TMQ8Hj5cIdp9utm35HVA4/YlRmi8ca2vfDmIxL5xMcd0W2fRDBnWevqQD
 Hp9InayuxXUNTrE7pvSWcnAuC1WwSU0DHISOzsQeR3/6xwAcHqYTCA7GOBbwGY4J45jw
 3wGpRnFM8xFa4Scv4+CKwMGG8S6TSkS5QyzGhtey61aN8wFSTMRK2BI8FLi5CfUju8th
 LhKA==
X-Gm-Message-State: AOAM531T0WGn49cBbDMaw8Rfkqw1Ww4xxM5VA3m8+cXr27YoRjSTr7np
 jiBPTU06a9zgP11yJ2YHWNEloX6HxG5K2jDXv4M=
X-Google-Smtp-Source: ABdhPJwRSNUUizuMFwQKwYeY2wi5YRh+zpgCagccW4u1SDvAsjHRIyZXxqVI+ejORvixyg9eRjDE/hXxPG4iFMDwjNA=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr3810938ilr.177.1603308768532; 
 Wed, 21 Oct 2020 12:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201018120308.1712054-1-georg.kotheimer@kernkonzept.com>
 <bb17cae6-68eb-af14-0d08-1140e83cabcd@linaro.org>
In-Reply-To: <bb17cae6-68eb-af14-0d08-1140e83cabcd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Oct 2020 12:21:04 -0700
Message-ID: <CAKmqyKOaTEX0G5AxW31rYXfHi8rH1jjj6OQFtmmAUJaurPFtJQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Adjust privilege level for HLV(X)/HSV
 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Georg Kotheimer <georg.kotheimer@kernkonzept.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 18, 2020 at 8:58 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/18/20 5:03 AM, Georg Kotheimer wrote:
> > According to the specification the "field SPVP of hstatus controls the
> > privilege level of the access" for the hypervisor virtual-machine load
> > and store instructions HLV, HLVX and HSV.
> >
> > We introduce the new virtualization register field HS_HYP_LD_ST,
> > similar to HS_TWO_STAGE, which tracks whether we are currently
> > executing a hypervisor virtual-macine load or store instruction.
> >
> > Signed-off-by: Georg Kotheimer <georg.kotheimer@kernkonzept.com>
>
> Well, let me start by mentioning the existing implementation of hyp_load et al
> is broken.  I guess I wasn't paying attention when Alistair implemented them.
>
> Here's the problem: When you change how riscv_cpu_tlb_fill works, as you are by
> modifying get_physical_address, you have to remember that those results are
> *saved* in the qemu tlb.
>
> So by setting some flags, performing one memory operation, and resetting the
> flags, we have in fact corrupted the tlb for the next operation without those
> flags.
>
> You need to either:
>
> (1) perform the memory operation *without* using the qemu tlb machinery (i.e.
> use get_physical_address directly, then use address_space_ld/st), or
>
> (2) add a new mmu index for the HLV/HSV operation, with all of the differences
> implied.
>
> The second is imo preferable, as it means that helper_hyp_load et al can go
> away and become normal qemu_ld/st opcodes with the new mmu indexes.

Ok, I have some patches to fix this. I'll send them soon.


>
> Annoyingly, for the moment you wouldn't be able to remove helper_hyp_x_load,
> because there's no qemu_ld variant that uses execute permission.  But it can be
> done with helpers.  I'll note that the current implementation is broken,
> because it uses cpu_lduw_data_ra, and not cpu_lduw_code_ra, which is exactly
> the difference that uses execute permissions.  After the conversion to the new

I have tried to fix this as well, but it seems to break a virtual
Linux guest booting.

> mmuidx, you would use cpu_lduw_mmuidx_ra.  I would also split the function into
> two, so that one performs HLVX.HU and the other HLVX.WU, so that you don't have
> to pass the size as a parameter.

I'm not clear what you mean here.

Alistair

>
> Finally, this patch, changing behaviour when hstatus.SPVP changes... depends on
> how often this bit is expected to be toggled.
>
> If the bit toggles frequently, e.g. around some small section of kernel code,
> then one might copy the SPVP bit into tlb_flags and use two different mmu
> indexes to imply the state of the SPVP bit.
>
> If the bit does not toggle frequently, e.g. whatever bit of kernel code runs
> infrequently, or it only happens around priv level changes, then simply
> flushing the qemu tlb when the SPVP bit changes is sufficient.  You then get to
> look at SPVP directly within tlb_fill.
>
>
> r~
>


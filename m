Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5368C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904FC2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx4DP8tL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904FC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXJV-0005LJ-M5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joXIT-0004RH-Nc; Thu, 25 Jun 2020 15:12:29 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1joXIS-0000ZW-3d; Thu, 25 Jun 2020 15:12:29 -0400
Received: by mail-il1-x143.google.com with SMTP id k6so6334417ili.6;
 Thu, 25 Jun 2020 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zO3MmrpcjuV25Jzf8+6bs2iEgnVSEVoU/K9kpd78Mss=;
 b=nx4DP8tLK+ng9V8qjpbkPVn75cFsfYXH7dtVjJH32G4UjVcp8c2RhnrI7mAiAq0zHx
 lkbAQRP7RSeG4/nkC4cuFx/HG+O1bpQoMrJUqWAdljj7gYSw2FwQRb+xeHQdvEGHTxC8
 DqdGTgqShL8oHCCgQ4dJTlZPLpmQr0YpOdIH5NyA+JiYezcnLAdDsQjG/kKOpf+HuUI8
 RHFi981FdWnKttBYrT7lk4461D7V+CX1+xOS+mSWW/9VXrkRZTrQUsdePKd4RIgfHbbN
 /0f5FVyRuCBF49B0nGxR9jeNGGL2yAFOPPA78yWpdVg7TD9kEwpd8V6Q99R8Sg0cVBcC
 BJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zO3MmrpcjuV25Jzf8+6bs2iEgnVSEVoU/K9kpd78Mss=;
 b=ZdquKFp93FQQmA4Lq0IaTZ/0qZh52UvppI7SE/uW++n+/MLTNkVQfJn3rbSlHU7uhK
 6UODQa9mmwYHFMq0c6tEl98JaAEHvUY9u8XFeoiMSqgkvzg/hZFKjUkPBPgCrMSayQ0W
 3f2DaFkUQ+st1B/+zQ3oPxhlnor3vMdkaUQe4+hhPnfmzfrtfVbFjj7TJYqCpcntw1LF
 MMl5O92zirF87XPlRqAFI8wUd5YOLxBuNhYIRmm+XXDJ0BOqSp++KAHosF4nuHm5Exwf
 kTybO2hpWnwaNmSrs24K2Aib6nhf3BVwip7ZrtInAQGyil4m4SSBu/oNi7e6ZpNhWGXV
 PsyA==
X-Gm-Message-State: AOAM532vt/r61WUM9dmoYyDYL6SvG/lpWxEQkuQ51OLbtOp0iiFRldKT
 3jkQ7OSfHrQWKCQEUI1YvCTuZ4lpKi1aDTq/Zwo=
X-Google-Smtp-Source: ABdhPJyE6cBRk/ZrWiKIptVXTUwYb4H/Jqs2qA+qAM7ADDpnkZ9ooth+sIbKZhyTwpnmaGROqlfVqNMao65UqZojzzQ=
X-Received: by 2002:a92:c213:: with SMTP id j19mr29061908ilo.40.1593112346675; 
 Thu, 25 Jun 2020 12:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585262586.git.alistair.francis@wdc.com>
 <931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com>
 <a7f32084-2060-1de5-8308-987bcddf1e6d@linaro.org>
In-Reply-To: <a7f32084-2060-1de5-8308-987bcddf1e6d@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Jun 2020 12:02:50 -0700
Message-ID: <CAKmqyKPdGp+5n_fRuzi74JK8z8rcXMU+KiJw5v2nTMApHqXauA@mail.gmail.com>
Subject: Re: [PATCH for 5.0 v1 1/2] riscv: Don't use stage-2 PTE lookup
 protection flags
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 4:50 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/26/20 3:44 PM, Alistair Francis wrote:
> > When doing the fist of a two stage lookup (Hypervisor extensions) don't
> > set the current protection flags from the second stage lookup of the
> > base address PTE.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_helper.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index d3ba9efb02..f36d184b7b 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -452,10 +452,11 @@ restart:
> >          hwaddr pte_addr;
> >
> >          if (two_stage && first_stage) {
> > +            int vbase_prot;
> >              hwaddr vbase;
> >
> >              /* Do the second stage translation on the base PTE address. */
> > -            get_physical_address(env, &vbase, prot, base, access_type,
> > +            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
> >                                   mmu_idx, false, true);
> >
> >              pte_addr = vbase + idx * ptesize;
> >
>
> Certainly stage2 pte lookup has nothing to do with the original lookup, so
> using a new variable for prot is correct.
>
> So as far as this minimal patch,
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> However, this bit of code doesn't look right:

Thanks for the comments here. Coming back to this after a while.

>
> (1) Similarly, what has the original access_type got to do with the PTE lookup?
>  Seems like this should be MMU_DATA_LOAD always.

Fixed in master now

>
> (2) Why is the get_physical_address return value ignored?  On failure, surely
> this should be some sort of PTE lookup failure.

Also fixed in master now

>
> (3) Do we need to validate vbase_prot for write before updating the PTE for
> Access or Dirty?  That seems like a loop-hole to allow silent modification of
> hypervisor read-only memory.

That's a good point.

Updating the accessed bit seems correct to me as we did access it and
that doesn't then provide write permissions.

Updating the dirty bit would provide write permissions, but we would
only change the dirty bit on a store and vbase_prot is now always a
load.

If the PTE was already dirty then we might incorrectly provide write
access though.

>
> I do wonder if it might be easier to manage all of this by using additional
> TLBs to handle the stage2 and physical address spaces.  That's probably too
> invasive for this stage of development though.

Do you mean change riscv_cpu_mmu_index() to take into account
virtulisation and have more then the current 3 (M, S and U) MMU
indexes?

Alistair

>
>
> r~


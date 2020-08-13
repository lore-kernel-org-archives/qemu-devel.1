Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1920768
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 21:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVJG/L9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1920768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6KvJ-0003y3-VG
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 17:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6KuN-00038P-TR; Thu, 13 Aug 2020 17:37:11 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6KuM-0005sN-4L; Thu, 13 Aug 2020 17:37:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id v6so8783527iow.11;
 Thu, 13 Aug 2020 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qAPSL5AnTtEcutN0VXFUZ9Lh2cXgd+XdsyrlfR4lfgE=;
 b=hVJG/L9wuVEuyMlgIuOktkgM8tydpUhHygriRNETtc3XsgW5P4eDZbXZ7Z3tWxIJEk
 345NQukamJ6NHJ3JaRTGMByGq67OLp+s1tZt9KC5JVGF5oi1Q9XjmT9Y9Z0nr7Q3r1sY
 ispIeQlVI5IjB2mrN56PBm/52K0IcbrhnM6O2AvGUQTfcG8SXK7fzPBfsG3MvgsGSTVG
 bRj4M1H01H/8UF5PJpLMji4+oUmyLWVjNW6+gKOQ7L/PPeMiioQn1CFo0oGzDJRUqb8g
 TyYZEt68vHsoyPxKYu20SPN/GOJBqN3sisl3bqCqx6tJ8XkSEmHkuFz/NDrVIkQBhjQ0
 VZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qAPSL5AnTtEcutN0VXFUZ9Lh2cXgd+XdsyrlfR4lfgE=;
 b=f7zVAm2dh9tjcGSvHgDx1Iq3QKEZ18X481de1v0z8vu1nT7f0t+AvOKmmxM1caAkoz
 qd13tZLPXMLvarT0qrt5oP07m01m4opvHb7Xgsgky0SC8UFTX3rAabN95kUmjVkndJny
 X/WnUOciTXWGIIOKHyNXooLT4PBW9PAZZ2tDnc3f3V98g+478u/r1UE0mkZHXLEz4HHr
 wy8apgo4DS1DbqsdozmCueArtTyu5QGjG1SZZg3h8lX4lgmmdq8aXj8gk2WSTjBRuCbw
 f3zWyAmRokwYa29IJk70Mj76c6t360c0IDm8OjMt6kvoWE7/itAeD6b14vxnPoEJaUBU
 3ToA==
X-Gm-Message-State: AOAM531koTgYphhBxWAJCaHep7tsc8+OooiMUK6R0hziNllVlALDC/L+
 q8RL65tMB+xURHLH1Zt7a87LvcF3GuE4/PjyZzQ=
X-Google-Smtp-Source: ABdhPJzeL92sKeX0OhRXJlhpaAD1B5426drD2uSOQiE6/4pWUDyFytv9r+1o3Lq3zMs1k5RnuhXqC7+1a/m75R5yMTs=
X-Received: by 2002:a05:6638:248e:: with SMTP id
 x14mr6949360jat.135.1597354628734; 
 Thu, 13 Aug 2020 14:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597259519.git.alistair.francis@wdc.com>
 <6e40b9b8-5883-7b49-e63e-2e24e8f5baec@c-sky.com>
In-Reply-To: <6e40b9b8-5883-7b49-e63e-2e24e8f5baec@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Aug 2020 14:26:40 -0700
Message-ID: <CAKmqyKNSzQpnZpMT5DXS8iU1XnvtE=vBMCJv2oS2LmbLRkr3rQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] RISC-V: Update the Hypervisor spec to v0.6.1
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 7:26 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/8/13 3:13, Alistair Francis wrote:
> > This series updates the experimental QEMU RISC-V Hypervisor spec to the
> > v0.6.1 draft implementation.
> >
> > THis includes support for the new 2-stage lookup instructions and the new
> > CSRs.
> >
> > It also includes the new 0.6.1 support for the virtual instruction
> > fault.
> >
> > This was tested by running 32-bit and 64-bit Xvisor on QEMU and starting
> > Linux guests.
> Hi Alistair,
>
> I am reading Christoper Dall's article on ARM virtualization.  As far as
> I can see,  Xvisor is type 1 hypervisor.

Yep, it's a bare metal Hypervisor.

>
> I want to  try this patch set. Could you share the method? Thanks very much.

There are some details in the origins submission, you can see them
here: https://patchew.org/QEMU/cover.1580518859.git.alistair.francis@wdc.com/

I'm also working on improving the support in meta-virtualisation to
help as well.

Thanks for helping test.

Alistair

>
> Best Regards,
> Zhiwei
> > v3:
> >   - Rebase on master
> > v2:
> >   - Update to v0.6.1
> >
> >
> >
> > Alistair Francis (13):
> >    target/riscv: Allow setting a two-stage lookup in the virt status
> >    target/riscv: Allow generating hlv/hlvx/hsv instructions
> >    target/riscv: Do two-stage lookups on hlv/hlvx/hsv instructions
> >    target/riscv: Don't allow guest to write to htinst
> >    target/riscv: Convert MSTATUS MTL to GVA
> >    target/riscv: Fix the interrupt cause code
> >    target/riscv: Update the Hypervisor trap return/entry
> >    target/riscv: Update the CSRs to the v0.6 Hyp extension
> >    target/riscv: Only support a single VSXL length
> >    target/riscv: Only support little endian guests
> >    target/riscv: Support the v0.6 Hypervisor extension CRSs
> >    target/riscv: Return the exception from invalid CSR accesses
> >    target/riscv: Support the Virtual Instruction fault
> >
> >   target/riscv/cpu.h                      |   2 +
> >   target/riscv/cpu_bits.h                 |  25 +-
> >   target/riscv/helper.h                   |   4 +
> >   target/riscv/insn32-64.decode           |   5 +
> >   target/riscv/insn32.decode              |  11 +
> >   target/riscv/cpu_helper.c               | 123 +++++----
> >   target/riscv/csr.c                      | 171 ++++++++++--
> >   target/riscv/insn_trans/trans_rvh.inc.c | 342 +++++++++++++++++++++++-
> >   target/riscv/op_helper.c                | 176 +++++++++++-
> >   target/riscv/translate.c                |  10 -
> >   10 files changed, 761 insertions(+), 108 deletions(-)
> >
>


Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BEC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219612078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVf3xBhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219612078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJJf-0000pQ-FH
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juJIp-0000KL-VG; Sat, 11 Jul 2020 13:28:43 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:46365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1juJIk-0000gs-VS; Sat, 11 Jul 2020 13:28:43 -0400
Received: by mail-il1-x142.google.com with SMTP id p15so142331ilh.13;
 Sat, 11 Jul 2020 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7RVP8Reptsl69FVo8Kg+s9KUvL4PHpu0EKM4Bsps12o=;
 b=PVf3xBhRRvSZBOOXdz8ejLnm51tIjbuapVedDL62pkQR/c0gny/8Y7uDdFSt2QK4p+
 V0zsOx9djmXti4z+XbTcMg46X9MNTI7LrTia1phodXvR+9IW+T5O+M691H6aNg8msbMY
 dxZUKIE0G7lgt9v/iT7IvyXsg2hHC3W6YkjtsUQDS+Vm1akVcLJpQBDLRBDcCLysZvLK
 3falV1Gy9RJW6ELk86+3B+31o0lsxk4l2nbKWz5BS+mjtcMImzvPtA8ao3VL4f7yaYvv
 4x9IO7ED7pOLm+4t3TBmfKJZkDgYTk5xWZHqn5GFGWGwXLEjv0C/1LW6ViLoyfqmvD1r
 VDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7RVP8Reptsl69FVo8Kg+s9KUvL4PHpu0EKM4Bsps12o=;
 b=LruBSr6XMzTQuCEbhWt+fv8hjD1SIVtd+1p+k0PZQOFuxGr1sokfXjCppkJj20TFPG
 gpmNjUuSelfg7oOpXBdXrDJfPnlVIe39k57RrP3RFqiG30RqshyFPv49hC8dLR7uXFF4
 U11VezW0jvfCvUDmua6UKzKrzx25PPH45wH6lX7RnR/mF6KMer9c3YiTKaAHCeiB3oLa
 E/z1Vg8B39xM2FjogmXlUxTfrzsQ5Xwag8urNwdT7fqzWYW/63RMY4hptCpSYR2PGEuQ
 oLBFy4MwQvwhNdDR1oJl6l4+7CbJ4PRWQRjDJ/kbkAe3DxgfVdgnKccjCyZWWdohyWNb
 CAdg==
X-Gm-Message-State: AOAM532uRc2RxJLbAs5KFFpmzUUc2wJ0OAWRx+R2zP3QcyavP2E0bpZV
 xPJBRRcYsUrl9qtYFnSuLkni+6aC53XZsIpdZZc=
X-Google-Smtp-Source: ABdhPJxr/pNlLtXmJOePLgRdOJNBMJt6HwqlCLEI69T+VZflo9B5jonY54dh0bgU4iUaT0QwNz/LSWDnqCdc+u9ZdQc=
X-Received: by 2002:a92:d186:: with SMTP id z6mr61038175ilz.227.1594488517108; 
 Sat, 11 Jul 2020 10:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-8-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPf4YH9Ut1mTLRoRdk-aja6wTKS-FhA-5LynbCeajh-_Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPf4YH9Ut1mTLRoRdk-aja6wTKS-FhA-5LynbCeajh-_Q@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sat, 11 Jul 2020 10:18:42 -0700
Message-ID: <CAKmqyKOQM4pZLAnt42m-MC2cFOxM_+_-tw7FHxe1RbDf84q0Nw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] Makefile: Ship the generic platform bios images
 for RISC-V
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 11:36 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 10:11 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Update the install blob list to include the generic platform
> > fw_dynamic bios images.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> You didn't address the comments in v3.
>
> Thinking about this more though it looks like we currently don't
> install anything, so this is an improvement.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Nope, I was wrong. This should be squashed into patch 4 where you
remove the installed binaries.

Alistair

>
> Alistair
>
> >
> > ---
> >
> > (no changes since v3)
> >
> > Changes in v3:
> > - change fw_jump to fw_dynamic in the Makefile
> >
> > Changes in v2:
> > - new patch: Makefile: Ship the generic platform bios images for RISC-V
> >
> >  Makefile | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f06b3ae..05e05bb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -840,7 +840,9 @@ palcode-clipper \
> >  u-boot.e500 u-boot-sam460-20100605.bin \
> >  qemu_vga.ndrv \
> >  edk2-licenses.txt \
> > -hppa-firmware.img
> > +hppa-firmware.img \
> > +opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv32-generic-fw_dynamic.elf \
> > +opensbi-riscv64-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.elf
> >
> >
> >  DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> > --
> > 2.7.4
> >
> >


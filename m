Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA4DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C9B206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXdlfEo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C9B206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RuM-0003FK-4e
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k0Rtm-0002nC-2i; Tue, 28 Jul 2020 11:52:14 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:36001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k0Rtk-0006RP-Ia; Tue, 28 Jul 2020 11:52:13 -0400
Received: by mail-yb1-xb41.google.com with SMTP id n141so8671407ybf.3;
 Tue, 28 Jul 2020 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RKJHMsgu+06hv7tSS5g0PUnJiQ+GlE2pYZFpfIL3dDQ=;
 b=mXdlfEo2EFw+T8D6+bRiqGQfBMY/AJcRkrfGQ1QsZwFnCpSUWHzIzXq4mv0nNINSFm
 r/FDGDmwUj3gL/7BQsaPnzCvFClXH6u3pGXriOZ+rfpxLtOLyaD4ApxmgSaBtYG972X4
 GTGS+71RKvB2mLCUMQU08gUQpjUfSNeEvwdha64XbCVVtSspS7tImwy+Oj/AX07gZ6G9
 MmQoXpiPLNiumwD7IVTokiDrOiCGNrk5+vi4dx+kY+uD2LGmkWSlbvIM5KuFeOOXQNOD
 B4Ln8zXw2IG7O26j/ZEgRUChPakrbZIta93X9NR5BKgJOCOBs/2seztbsxbdkg3gMBn5
 aBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RKJHMsgu+06hv7tSS5g0PUnJiQ+GlE2pYZFpfIL3dDQ=;
 b=Zu4+9g+HdhKJr9p67iGipv0lm3sGxEM8VPp1fi0W/ImXlB5Q9s7fH8dHrPQIvm1OjO
 qzpY5tzMjZANhYgxNjiSmhCcMN+8qZc5UjmCoEAhTV4JMcjyVHNh82VSkrx0pLpcQQb5
 B2iFNpx5WBdXX/CBCUCA6cRut07yyCwCqKwXYiL/d2N5PD3QvBZpEhu9h5ByfFbcRXdm
 OdCsxh0NZIogz4wFMuicCEi77D9ga8DUHxXMtwN8vrtQilTk6B5TCQDLIJArB9YAXjui
 qKw7eNUfuGFoKRc4G74HeqMnHGJgMFsUy2XbWg5REAJ4YMYfOavOhqrvz9GOGZunavi1
 H1kA==
X-Gm-Message-State: AOAM532wr89nngG41AL/P7qtsukhei92y2tCDKi8ChaKaVkjP++FmxH1
 YAuq6LAxV/8ye5YjLXgxnHxwUEaZjEWAKnrdmU0=
X-Google-Smtp-Source: ABdhPJyxYXKXaxYSvkAhr8DDfgUw4P0vx/4YwDfUMbyGfqGclYsL9fc/oHgyC8VEX4OFOmvrI/I/vwDURRTxZUjVB44=
X-Received: by 2002:a25:d006:: with SMTP id h6mr42046802ybg.122.1595951531024; 
 Tue, 28 Jul 2020 08:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
 <1594878971-26050-8-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOFXGbW3ubNc4RHOh_4ujDSqKS_3GGMnyno2S7gDL-+Ow@mail.gmail.com>
In-Reply-To: <CAKmqyKOFXGbW3ubNc4RHOh_4ujDSqKS_3GGMnyno2S7gDL-+Ow@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 28 Jul 2020 23:51:58 +0800
Message-ID: <CAEUhbmV4VNPax7GmowsT6Jc+d5-qtqi9bOXymn9XKC9SdsuhcQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] Makefile: Ship the generic platform bios ELF
 images for RISC-V
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alistair,

On Tue, Jul 28, 2020 at 11:37 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 11:01 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present only the generic platform fw_dynamic bios BIN images
> > are included in the 'make install' target for 'virt' and 'sifive_u'
> > machines. This updates the install blob list to include ELF images
> > which are needed by the 'spike' machine.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
> This commit should be squashed into patch 5.

I actually considered this before, and I was thinking that patch 5 is
only for "fixing" the missing binaries for Spike machine, and this
patch addresses the "make install" issue, hence separate patch.

>
> Do you want me to do that when applying?

Sure, please do then if you feel this is the correct way.

Regards,
Bin


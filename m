Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D472067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJkUfqRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D472067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jun5V-0001Ok-H3
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jun4t-0000mv-Tu; Sun, 12 Jul 2020 21:16:19 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:46554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jun4s-0001Nl-6f; Sun, 12 Jul 2020 21:16:19 -0400
Received: by mail-yb1-xb43.google.com with SMTP id 2so5623423ybr.13;
 Sun, 12 Jul 2020 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZFZ0/xnaFA7vslJ3xXNw6jGIxziben2ebs31BAxhUws=;
 b=UJkUfqRMLZThUphFs98Ezxn4+uG57DoOanZVGo/GnZfKtkD6yD08iSLS4zy0Jib6S8
 xR651qQWxdevrX/7aNKJFKN3iigzDVPAupyh6/eMv13jv9pBSAj3CZDwCIueCvds6+mn
 UeYLooSCWeVbt3WOrJ3hNN3W/EovNru08z3shVvoMY9crYtkQFfxSOcgkpfdsxl2KVjB
 9XR3pSM+q+a5Bq9zrCDgac3v/Y8mooNAEhijJlSP/aRe5sdLBUYeoY9x02UX8FCuzBtU
 BbaVfhRxELZS2NG6bz5DS2hfuUMhn/VfMnXUiq5QiU2j8yvSx5qUM+S3Iw3WrUA1p9Xs
 udkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZFZ0/xnaFA7vslJ3xXNw6jGIxziben2ebs31BAxhUws=;
 b=L1Lc3LeE9fXmAWDFHIluOAz6LNwkmUkhPoiNFbI2nCUdLAmKuJkGL8bLRJ/bzY/3P9
 fYrFrLlpAQPGXW9sT1h3boHvVdeWijKYZ1i1BM5BOOBsBCyVlgBPg4NLjKxV7f8Xq9mc
 oLQ5oYwBwcIxT8ywTXHOQpo5Wrr/4/ILA6ZT3qW1Q6ExjclOU4FCD9npsCk9l9J4T2uB
 AeoNGbm12YyT7z6NqEZTsg6HFY4b5sI9ti5E3ABbu1XYlX8gjoHY8tlgCkz1GkDAf1Vr
 E8AZfP7xGT49FAqRhlVvDjrVv8/sm1YmA2NwNMhNWiggMYlI/qmLFtJbV14O548SeazK
 KKLQ==
X-Gm-Message-State: AOAM530Dw2JGPESCWROMFT820bDpGzYSnjOuqLIPj1aMFDEqtcni/D12
 TGFyP9QwSGbudrWxlyEtXukSrYFlEHwziBv7zERe0Q==
X-Google-Smtp-Source: ABdhPJwpR9JLdYLhHOR1gCEjTORK9VmOSW3xNxdXSDWAVqVpThEGrrHzmC9Ev27qtai9CG8aThTUqY+dcd8a+AGALxg=
X-Received: by 2002:a25:46:: with SMTP id 67mr41082587yba.517.1594602976910;
 Sun, 12 Jul 2020 18:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
 <mhng-842d31db-ac34-4bab-a523-808f1f542101@palmerdabbelt-glaptop1>
 <CAEUhbmUPxCmo-4SPm8JwG7emD0YfLeAMSgd7mWaCH2VDZJTtsA@mail.gmail.com>
 <CAKmqyKN=HfpTs=d8RzXcaVYZQ-pH_kvO9VV5h4CKAtLSKaVqyQ@mail.gmail.com>
In-Reply-To: <CAKmqyKN=HfpTs=d8RzXcaVYZQ-pH_kvO9VV5h4CKAtLSKaVqyQ@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Jul 2020 09:16:05 +0800
Message-ID: <CAEUhbmXUa-bSMXcHZyV=FybP9gxYsHFhbUPm15tw70+hNQfNEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Sun, Jul 12, 2020 at 12:04 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 5:50 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Palmer,
> >
> > On Fri, Jul 10, 2020 at 8:45 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> > >
> > > On Thu, 09 Jul 2020 15:09:18 PDT (-0700), alistair23@gmail.com wrote:
> > > > On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >>
> > > >> From: Bin Meng <bin.meng@windriver.com>
> > > >>
> > > >> The reset vector codes are subject to change, e.g.: with recent
> > > >> fw_dynamic type image support, it breaks oreboot again.
> > > >
> > > > This is a recurring problem, I have another patch for Oreboot to fix
> > > > the latest breakage.
> > > >
> > > >>
> > > >> Add a subregion in the MROM, with the size of machine RAM stored,
> > > >> so that we can provide a reliable way for bootloader to detect
> > > >> whether it is running in QEMU.
> > > >
> > > > I don't really like this though. I would prefer that we don't
> > > > encourage guest software to behave differently on QEMU. I don't think
> > > > other upstream boards do this.
> > >
> > > I agree.  If you want an explicitly virtual board, use the virt board.  Users
> > > of sifive_u are presumably trying to do their best to test against what the
> > > hardware does without actually using the hardware.  Otherwise there should be
> > > no reason to use the sifive_u board, as it's just sticking a layer of
> > > complexity in the middle of everything.
> >
> > Understood. Then let's drop this patch.
> >
> > >
> > > > Besides Oreboot setting up the clocks are there any other users of this?
> > >
> > > IIRC we have a scheme for handling the clock setup in QEMU where we accept
> > > pretty much any control write and then just return reads that say the PLLs have
> > > locked.  I'd be in favor of improving the scheme to improve compatibility with
> > > the actual hardware, but adding some way for programs to skip the clocks
> > > because they know they're in QEMU seems like the wrong way to go.
> > >
> >
> > Yep, that's my question to Oreboot too.
> >
> > U-Boot SPL can boot with QEMU and no problem was seen with clock
> > settings in PRCI model in QEMU.
>
> I don't think it's an unsolvable problem. There is just little work on
> Oreboot to run on QEMU. I can dig into it a bit and see if I can find
> a better fix on the Oreboot side.
>

Can we remove the QEMU detect logic completely in Oreboot? Except the
QSPI controller QEMU should be able to run Oreboot since it runs
U-Boot SPL.

Regards,
Bin


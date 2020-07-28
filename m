Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86803C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52460206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leE4JFqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52460206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Rhu-0005yy-Li
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0RhM-0005XG-As; Tue, 28 Jul 2020 11:39:24 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0RhK-0004PQ-N5; Tue, 28 Jul 2020 11:39:24 -0400
Received: by mail-il1-x142.google.com with SMTP id y18so8127196ilp.10;
 Tue, 28 Jul 2020 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AlFAHbvBMe1/3aJyicAFUwcKPg8m/q78N+I7X1st6Go=;
 b=leE4JFqDxQvLG9dXoiLRiToOt24+AABSefNMsaeUJjWLsW6oph3UrOtcKD757pgoAR
 Utp1XW9WviNiw41M2MVlgDJ5iJzfH20jyLQkmjuGtOoLVU5gA+KjdYsWABRA8QWtGCzP
 dmwgz+O/KNHN1KT/Ugvl8L1BIGIIJsA5QX6G0iJv5MIofMioag7GD5rmXtHkDA97Ylw9
 vPD9uj940CHCru1swAw7BTUk/wDbx2TRSOioLY0fHjvJT84gaQLUctTV0Pn3DOSq4M0a
 2fNg1rtmtEXamgMOfd7G1mP/DYuWDVptAbiS9b5uBZoSb+18ve8MY4gf7jfbtQDk2Fro
 mJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AlFAHbvBMe1/3aJyicAFUwcKPg8m/q78N+I7X1st6Go=;
 b=ZSkQvoz2E4C6ZasyJjwGBDFy2iEg3gPNWaM05fFo7YVvcdXmGCFPZwi/O6sL/U1xNQ
 ACF6zuBSlZjkCiR4Ehah79WZe9rcee4TcJ6aUY0drwJONsuhh7fxcPofo5jd3upwZ9X7
 tWRCAqAwv40vqNIzsv981NqtzDAriTmWGD6v0+H5lmhJWDM5Cy8l8U8ZBPybffLyaFoR
 bFPpyKuYj46yShoSBJtd3fr0DkToPVlYIvFJPL9sHKO0Xi8DbUk2Tp5vND4o1GBzYGKY
 2BUw9JHVMwxsA+Si0m3wS428a5iZj3zn6yaylnJQvKHLWdoalKn7EG67Y/oxaSGVcRlp
 k0EA==
X-Gm-Message-State: AOAM533HaHFULweiZ++mL3TFy4POxQte8OCJwNf75ni/nS+NIUhV5isr
 bd2TlZmEWC0nUj3lg/3I1eywHY4qUXO8T5Sv/LY=
X-Google-Smtp-Source: ABdhPJyga/XwPAw3JzAiWUH/HeVHhYulsuVI9chlp5eWIn2yxZ3Z6beg4svLPD0AgpW54K+nGHluLwayvLGl7oJ21nw=
X-Received: by 2002:a92:cf50:: with SMTP id c16mr9491175ilr.131.1595950761273; 
 Tue, 28 Jul 2020 08:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
 <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
 <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
In-Reply-To: <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 08:29:00 -0700
Message-ID: <CAKmqyKNJA0_5Qsfe6FZXSgNydxSHRXQQtqk8nB6-kR-yNpFHCQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
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

On Wed, Jul 15, 2020 at 9:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Mon, Jul 13, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > > > image built for the generic FDT platform.
> > > >
> > > > Remove the out-of-date no longer used bios images.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
> > >
> >
> > It looks only Linux boot on sifive_u is broken. On our side, we have
> > been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
> > gets unnoticed. I will take a look.
>
> I've figured out the issue of 32-bit Linux booting failure on
> sifive_u. A patch has been sent to Linux upstream:
> http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html

Thanks for that. What change in QEMU causes this failure though?

There are lots of people not running the latest Linux from master that
this will cause breakages for.

Alistair

>
> Regards,
> Bin


Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198D620691
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pk13FKa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198D620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSltL-0003eC-Sp
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSls9-00036B-UQ; Wed, 14 Oct 2020 14:51:37 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kSls7-0005uI-Rb; Wed, 14 Oct 2020 14:51:37 -0400
Received: by mail-io1-xd43.google.com with SMTP id y20so312017iod.5;
 Wed, 14 Oct 2020 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ToVSk/78mP2+vZVQ+Bz/goWCd3v7EGwDBrrY5QgM6ec=;
 b=pk13FKa3zjMUZ1PRvc/bec9zq2gBfcvxhGBdgzQuv4CeVOuYPTZt3ZhlmCLbTpLhsR
 qmun57izwxFwjzQ66lNj9c+fopA4TLZFpg5akQgKL+LecFkYPqNoidKKIkby/YQKaewl
 +0i8R6BRFbvWyAwgKd6/5FNXfcRFD8j9RgIORmaw2jF4+PL5Y9shVuq1gAWlv2SLYhsj
 kr3b9no/o4tp1P5lYXBFkuv6LkIPs3hGR5iQ0z64XtxyWA4dCfkVv95rs5UHKCSmB7A4
 F9CUj8uE4Nju95IkowcuT9gHPO1+QXkV7GkwnniqJP2y1Lo/cCx3fB8+170hp4GQ+gsi
 JfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ToVSk/78mP2+vZVQ+Bz/goWCd3v7EGwDBrrY5QgM6ec=;
 b=sAIx4pi+Pii+TZmhZIIwOgdIW8eAyEBTdUC7Q6aXA6p8TvSlohNEF6m2pjoayS+X1m
 rWi9Hp2Th8eCjB1PudI1739LqSural5J/NUoRdaZqFONJrKd8y2LHk6D9UARSyX41wsK
 s1bzwf4HmlO492YdRN1qizGvfe/fQ6NQEmQOlWglSgh0dDeYpYSwtzWsdZxa8N06zVkB
 SvMgtdaY4wTBcKeG6Yv9/jBFWialx5GvlAQZHRbiYyDEsTufaKLKCdKOijuvK4NAKMaR
 4z6TTlnOF/6xZGbyLmc0LJrUeJiLgB/3dLn89uYY4ma14zDUiTLvMDDbL586K80b0QN5
 Twcw==
X-Gm-Message-State: AOAM533qd96VEdfw7BOBgRiEqZmfELacLOzLrd+laPjBUQpjou5UyLS1
 gnP6hIoX+fAJzCzGUI+hW5RvHt1CxBhPfT+iheE=
X-Google-Smtp-Source: ABdhPJyh7bDuw+BawFP4QEJ8/8ywXcCeygPW1LxZg+O5Pen5Ni1WPamrMSE+e3vJtI8rZkdUy7mXXMCDiwGGIRmQr9k=
X-Received: by 2002:a05:6638:1696:: with SMTP id
 f22mr811179jat.8.1602701493983; 
 Wed, 14 Oct 2020 11:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-3-green.wan@sifive.com>
 <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
 <CAJivOr4xLP1n4eVFyWHi=ckg17C_j76f=+o+YPztsYuaPDwCCw@mail.gmail.com>
 <CAKmqyKPFbfbXSryWW40kW=RF-mx4V_nVqmdOveQ-fuLQgFbARQ@mail.gmail.com>
 <CAJivOr7PVXi430SzPgbyFtFPqAsufy_xs1O7gfWQAS1ktTwb1A@mail.gmail.com>
 <CAKmqyKNC5K5MEvVGaZPisTEyrePNV3jWrSYzuUcY3p62ws2VXg@mail.gmail.com>
 <CAEUhbmWJsrcvShaeb-q8Q5W25yhPKtsQaKEYRqgyGgCogrFaQg@mail.gmail.com>
In-Reply-To: <CAEUhbmWJsrcvShaeb-q8Q5W25yhPKtsQaKEYRqgyGgCogrFaQg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 14 Oct 2020 11:39:54 -0700
Message-ID: <CAKmqyKPnk7ZGH_XQvywb1zvC1UqQ8Yab3P37QMwNWtTS-OsD_A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 8:02 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Wed, Oct 14, 2020 at 10:46 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 12:10 AM Green Wan <green.wan@sifive.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 1:08 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Mon, Sep 28, 2020 at 2:18 AM Green Wan <green.wan@sifive.com> wrote:
> > > > >
> > > > > Hi Alistair,
> > > > >
> > > > > Thanks for the review. See the reply inline below.
> > > > >
> > > > >
> > > > > On Sat, Sep 26, 2020 at 5:52 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 1, 2020 at 8:49 AM Green Wan <green.wan@sifive.com> wrote:
> > > > > > >
> > > > > > > Add '-drive' support to OTP device. Allow users to assign a raw file
> > > > > > > as OTP image.
> > > > > >
> > > > > > Do you mind writing an example command line argument in the commit message?
> > > > > >
> > > > > > Also, do you have a test case for this? I would like to add it to my CI.
> > > > > >
> > > > >
> > > > > Do you mean qtest? I run uboot and use uboot driver to test it and
> > > > > didn't create a qemu test case.
> > > >
> > > > No, I just mean how are you running and testing this.
> > > >
> > > > So you are booting U-Boot, then how do you test it in U-Boot?
> >
> > Hey,
> >
> > Sorry, this email didn't send and I only just noticed.
> >
> > >
> > > Correct, I just enabled the configuration for
> > > ./drivers/misc/sifive-otp.c in uboot for normal booting access to OTP.
> > > And manually modify some failures write case to test write-once
> > > feature.
> >
> > Can you document this? I would like to include this in my tests.
> >
>
> See `QEMU Specific Instructions` in
> https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md

Hmm... I am missing something. I don't see any details on how you
access the OTP and verify that reads/writes have occured. That link
just seems to document how to build OpenSBI with a U-boot payload.

Does U-Boot run the tests automatically after boot?

Alistair

>
> Regards,
> Bin


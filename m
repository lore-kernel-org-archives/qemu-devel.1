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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2199C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1E922201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooD+/iOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1E922201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiNf-0003ho-Vs
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSiIt-0007Ga-BF; Wed, 14 Oct 2020 11:03:00 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:38663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSiIr-0001ik-E4; Wed, 14 Oct 2020 11:02:59 -0400
Received: by mail-yb1-xb42.google.com with SMTP id b138so2914882yba.5;
 Wed, 14 Oct 2020 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9lckDwDGHDonEE+b0YESBAy/a098US/Cfuu0xpUEu5E=;
 b=ooD+/iOWMKa9dKMvhFTqs7xp0Lpyp9RLcENiUSKGP5wNkRXS34fK6a6poJ1QD95AZI
 RaD0EtcI++l+tsv5o7rVYZb48xf/F8JyN7/FWsoucS/VSdCMKuJhpLnaoqxot/Kb/EvT
 gjEXxKaGGw6v6CsBFrlEFdKA0IDd0qjhDBtcIObnrARpkHvQUau9uCBmwPzGdDkGFwux
 43gNErzZF3FJRLhIMWFHKglbKTFekdGToTvi3mnjh6ccxAEDWKkL6Z6QEusOcTEv1uAg
 IxuqCgqgKr5lZbSQAdo5ggzBWOlHhtKGC1qYMtrFBznD5qZE72VT+cpBxye6RH5NDF/A
 jIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9lckDwDGHDonEE+b0YESBAy/a098US/Cfuu0xpUEu5E=;
 b=WpB8OP7rBOos08Oafs6mqHnDJhQcp/oO27uM72/3QqDynY/PSRnOzFvHXJimXg32wm
 vVYNVqHDqK6cl4xaaqJRsY30Y7c1qWWmS5PN4erwXc5NeaXOoaG22g1yLfz8As+Msqz/
 iDN/VYhobPOdvCasUw/E6Q7j4dIy6pDxfykOjhwyZXNO4IyDznLFL+fpyW4sFeVFBJD6
 PtfsfZ7WBfmcYSmiur1dhfKcMbaRzSA0bYZIZxjLHxb0hLhRa8+c86Fgs2fONdzqnUjv
 DcZ9UtYnasM1Qo4RETzpcFR48JWJ6kh7jCyCXLEgoPY49SA5dsrr1m+sufhZmn9WDWG6
 fJYA==
X-Gm-Message-State: AOAM532d0bv2gn/df/o6NJ5r020uiFQ5WPaoTJtlqsFeYqbe/c2/i7Al
 nIAq9KI0lgDhSATnSBd7mS6rZJ8eU2tQtu14iQ8=
X-Google-Smtp-Source: ABdhPJxZI2md67fMq4m7FAkcjQ4f9I2DzeKFnRTWsTEz92eZVyRPjML3dljiLsPSE2oBBGKWDObr8toaagEAANNp2/8=
X-Received: by 2002:a05:6902:690:: with SMTP id
 i16mr7380860ybt.122.1602687775309; 
 Wed, 14 Oct 2020 08:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-3-green.wan@sifive.com>
 <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
 <CAJivOr4xLP1n4eVFyWHi=ckg17C_j76f=+o+YPztsYuaPDwCCw@mail.gmail.com>
 <CAKmqyKPFbfbXSryWW40kW=RF-mx4V_nVqmdOveQ-fuLQgFbARQ@mail.gmail.com>
 <CAJivOr7PVXi430SzPgbyFtFPqAsufy_xs1O7gfWQAS1ktTwb1A@mail.gmail.com>
 <CAKmqyKNC5K5MEvVGaZPisTEyrePNV3jWrSYzuUcY3p62ws2VXg@mail.gmail.com>
In-Reply-To: <CAKmqyKNC5K5MEvVGaZPisTEyrePNV3jWrSYzuUcY3p62ws2VXg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2020 23:02:44 +0800
Message-ID: <CAEUhbmWJsrcvShaeb-q8Q5W25yhPKtsQaKEYRqgyGgCogrFaQg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Green Wan <green.wan@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Wed, Oct 14, 2020 at 10:46 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Sep 30, 2020 at 12:10 AM Green Wan <green.wan@sifive.com> wrote:
> >
> > On Wed, Sep 30, 2020 at 1:08 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 2:18 AM Green Wan <green.wan@sifive.com> wrote:
> > > >
> > > > Hi Alistair,
> > > >
> > > > Thanks for the review. See the reply inline below.
> > > >
> > > >
> > > > On Sat, Sep 26, 2020 at 5:52 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 1, 2020 at 8:49 AM Green Wan <green.wan@sifive.com> wrote:
> > > > > >
> > > > > > Add '-drive' support to OTP device. Allow users to assign a raw file
> > > > > > as OTP image.
> > > > >
> > > > > Do you mind writing an example command line argument in the commit message?
> > > > >
> > > > > Also, do you have a test case for this? I would like to add it to my CI.
> > > > >
> > > >
> > > > Do you mean qtest? I run uboot and use uboot driver to test it and
> > > > didn't create a qemu test case.
> > >
> > > No, I just mean how are you running and testing this.
> > >
> > > So you are booting U-Boot, then how do you test it in U-Boot?
>
> Hey,
>
> Sorry, this email didn't send and I only just noticed.
>
> >
> > Correct, I just enabled the configuration for
> > ./drivers/misc/sifive-otp.c in uboot for normal booting access to OTP.
> > And manually modify some failures write case to test write-once
> > feature.
>
> Can you document this? I would like to include this in my tests.
>

See `QEMU Specific Instructions` in
https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md

Regards,
Bin


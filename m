Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E449C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29CF206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 01:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJL8MixO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29CF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jba9c-0005mv-6r
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 21:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jba95-0005KD-Lf; Wed, 20 May 2020 21:37:15 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:41883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jba94-0002Fv-7X; Wed, 20 May 2020 21:37:15 -0400
Received: by mail-yb1-xb41.google.com with SMTP id n10so1991606ybn.8;
 Wed, 20 May 2020 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iDLvSJPzswZP86nI4KCVCt50Y98l854i5jopwJEM1TA=;
 b=UJL8MixOSfNe/BcpW2v5OrVvZ3+uwkVPcJF7RVHUXgRRKQOynMYXrTB+D+8StW5Zg8
 WCLubGN4e2EcDIwj/LEKMplFquFR2DT/XXrlefduLe+7aTueDaBN2mZurAzSpZ52LFDe
 UQrlM1BHsiySK2Y8VkdRKKppDs3VJUKnW5BvJpDZCdc6ylqEjUE3aIC2nLCa9HdZvRPR
 ItDmDQCc2QZ/9CfeaMU8k682dWSZ5GGefd7pKNFM2ezSIhyjNCSaOPZ79GzhjSEaV/SH
 oHhKD4qiQAuza/ZJHVo0GgHhYTIQjrVPtAkQbAu0NMk62q2qY4PXoK5eRFLhAGoGQx6G
 EnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iDLvSJPzswZP86nI4KCVCt50Y98l854i5jopwJEM1TA=;
 b=AEh56snqVGmfvveL9sndJTm5uBUPfSgRdxylvrb7qosqW367iLqX/4g6YGphSv4x+u
 /XDrPvhyccvNbSrU9JrrfRqmO1WkDqWJJaVDyoMekOlFqYuCnneJtd4i4yZmhH/oM/8L
 R82DEtg0osE0Ife/dWFNf5DCbQtOBcEY0fvNMo0L7a5aGtDjlnpSdtGJNrIAPUVyVvH9
 rWSwkdchgQjXcXTGgz7GK0mDNUuuDqF4bt3j9So9lxOlBbF6l+j2ccr0c2qktGHkgzk5
 YP7HV5iBnFO+Pl9ikaTeX81uTEmr/KYakkz2EKBCZUsYcX9juFF8P1qExh1WkU09rj34
 xgog==
X-Gm-Message-State: AOAM532T0J8HBniUD+UVMRwoy1G5XEfASgWg4x+ixj5rmdoi54tT6ovT
 n21frKtt7nI7t3cGDIlg3J8CwFQRf/bvF1J+afM=
X-Google-Smtp-Source: ABdhPJyj6EJiPJDYDyb1ajT2kh8fYZrHtVuSCp5MkRNV9FLcpy1oBt1Jol1M9iYbWtCesc1Ydyeq7a26mOPdi7gChfQ=
X-Received: by 2002:a25:593:: with SMTP id 141mr1065369ybf.517.1590025032838; 
 Wed, 20 May 2020 18:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <1588335545-649-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMdmVrvYDNVtm6_iviDT_mofGZO9DC2vtZdZaHN31T07A@mail.gmail.com>
 <CAKmqyKO6HGQrMxsNovPkoB4TncEmeD=uFV_oXEpQ0t+=g20Wfw@mail.gmail.com>
 <CAEUhbmVTg+521EHutukOod_PKx0RQ-s=EgnKu=JM-vduMn4mNA@mail.gmail.com>
 <CAKmqyKPdjBFmPcQY+O4zsaTHYeLVC9zanXhS5CBovfn4LLRdJg@mail.gmail.com>
In-Reply-To: <CAKmqyKPdjBFmPcQY+O4zsaTHYeLVC9zanXhS5CBovfn4LLRdJg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 May 2020 09:37:01 +0800
Message-ID: <CAEUhbmXPRN=1QCfr=ekG_m5wiWkQoG7pb-OzR-guixRutYJOEg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Change the default behavior if no -bios option is
 specified
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Thu, May 7, 2020 at 5:02 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 6:34 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Wed, May 6, 2020 at 6:37 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Tue, May 5, 2020 at 1:34 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Fri, May 1, 2020 at 5:21 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > >
> > > > > Per QEMU deprecated doc, QEMU 4.1 introduced support for the -bios
> > > > > option in QEMU for RISC-V for the virt machine and sifive_u machine.
> > > > > The default behavior has been that QEMU does not automatically load
> > > > > any firmware if no -bios option is included.
> > > > >
> > > > > Now 2 releases passed, it's time to change the default behavior to
> > > > > load the default OpenSBI firmware automatically. The firmware is
> > > > > included with the QEMU release and no user interaction is required.
> > > > > All a user needs to do is specify the kernel they want to boot with
> > > > > the -kernel option.
> > > > >
> > > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > Thanks!
> > > >
> > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > >
> > > > Applied to the RISC-V tree.
> > >
> > > This fails `make check`
> > >
> > > qemu-system-riscv64: Unable to load the RISC-V firmware
> > > "opensbi-riscv64-spike-fw_jump.elf"
> > > Broken pipe
> > > /scratch/alistair/software/qemu/tests/qtest/libqtest.c:166:
> > > kill_qemu() tried to terminate QEMU process but encountered exit
> > > status 1 (expected 0)
> > > ERROR - too few tests run (expected 7, got 2)
> > > make: *** [/scratch/alistair/software/qemu/tests/Makefile.include:637:
> > > check-qtest-riscv64] Error 1
> > >
> >
> > Please apply this patch to fix the "make check" as well.
> >
> > [5/5] riscv: Suppress the error report for QEMU testing with
> > riscv_find_firmware()
> > http://patchwork.ozlabs.org/project/qemu-devel/patch/1588348254-7241-6-git-send-email-bmeng.cn@gmail.com/
>
> In future please send all related patches in a single series.
>
> I have applied those two patches.

I checked https://github.com/alistair23/qemu/ but could not find where
these 2 patches applied. Just make sure I was not looking at the wrong
place?

Regards,
Bin


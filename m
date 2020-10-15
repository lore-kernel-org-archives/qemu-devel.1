Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606C7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443A122255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DaSrvQu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443A122255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSsjE-0006qZ-An
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 22:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSsib-0006Jz-Ue
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:10:13 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:37080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSsiZ-0002Kp-Mk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:10:13 -0400
Received: by mail-qv1-xf43.google.com with SMTP id t6so517427qvz.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 19:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xHlFRk4mrLccSdGcV0eiV2DtySs0dmJJZ21295/6zLA=;
 b=DaSrvQu6edI6lpxClNMDQH2qeDotMJvDydsJsNyTckxInvQbG9+M/sGi43S/lLWREP
 +23vBv+enyRR44fv1BkzjfwHFVWg9Q3e4R9IMtblbImUE1Y4k9mCuTOlqdR3WiGuxF1h
 JACwuvrjcbmV2BQ55PtzIf9mghDYeXIYu6JvQ7MoFSnNm5KU3mdbXiqIrhcAsR4cTeew
 PG21tce8odko77u++ou6MwHuTr7FT5d0epycIHepzex+8NE709z43ubQ24S94kHEN5oP
 pCcL46e2j02ukYk2qmvd2P3nU717UnmiEOA/OrkombxEkoxe142KmTTNPekQ3sTdCUJ6
 XPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xHlFRk4mrLccSdGcV0eiV2DtySs0dmJJZ21295/6zLA=;
 b=QxwJlu9QmKP5/RFUzZNMe/KUAxJiFvNhezo1RpfRkLFeurR2hfqfLKKZb4j193HSh1
 Tm7QBzUWfLWYQ9t81xs3Hesl12/L2Ltxk4mL6dtJsr4pUEVXwd5Ni7qKShpNDr8jrO3P
 QORPf7i5jw/XY7Qw7ZlAnIjKbLXd6BXU+8/U3c092GIEITpQzC+BaMblKK7SZeT5klgv
 pyoYLKbTEtPyymuUeCuM75OuVHBG2PclhZe0XT5uRQEgF4VWBLteqt4C4JOyfl6BeK0k
 IzMivYucTAZS+2lfepErWvNI5+x1iuQOwM+nf4ra1WCz4cUnDHCVneyO8Ld1SJ2pW0Ff
 Mdtg==
X-Gm-Message-State: AOAM533Arm1XiSLPs+eNDR6yaJhagyJQKYNkRyDTk5ZNbQJoUVOCkSMn
 ZsYLIbx1U1Bz4GgBCu3Xvl+opl6c6ez9Fc8xuk98Ow==
X-Google-Smtp-Source: ABdhPJwjQA+dCs//nTLdpkjAQPk5oxDCDd/lRCQSUiL3DAk4X0hTxM2+ImdbuXGqtUpMobLZZY/ISYl7D1sq8l54qOw=
X-Received: by 2002:a05:6214:1351:: with SMTP id
 b17mr2274349qvw.11.1602727810063; 
 Wed, 14 Oct 2020 19:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101146.12786-1-green.wan@sifive.com>
 <20200928101146.12786-2-green.wan@sifive.com>
 <CAEUhbmWxPmhZhEFECXO5oLTbf+r1E-rBuFQrC_e+D6YbmMDmag@mail.gmail.com>
 <CAJivOr7mr_poapw5Okga1uLo7Zq+gs3oiJxuMPpbnAsQMNgzfg@mail.gmail.com>
 <CAEUhbmVUSJd1E9r4O+ziVbbH3RgSqaLe7q0CtgCqbhD+mjCurQ@mail.gmail.com>
In-Reply-To: <CAEUhbmVUSJd1E9r4O+ziVbbH3RgSqaLe7q0CtgCqbhD+mjCurQ@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Thu, 15 Oct 2020 10:09:58 +0800
Message-ID: <CAJivOr7wUtXjLYKGdm7Z4xiq2RNJ_sPxUJ1iyyquyh+temUnrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=green.wan@sifive.com; helo=mail-qv1-xf43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 3:17 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Green,
>
> On Wed, Oct 14, 2020 at 3:02 PM Green Wan <green.wan@sifive.com> wrote:
> >
> > On Wed, Oct 14, 2020 at 1:37 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Green,
> > >
> > > On Mon, Sep 28, 2020 at 6:12 PM Green Wan <green.wan@sifive.com> wrote:
> > > >
> > > >  - Add write operation to update fuse data bit when PWE bit is on.
> > > >  - Add array, fuse_wo, to store the 'written' status for all bits
> > > >    of OTP to block the write operation.
> > > >
> > > > Signed-off-by: Green Wan <green.wan@sifive.com>
> > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
> > > >  include/hw/misc/sifive_u_otp.h |  3 +++
> > > >  2 files changed, 32 insertions(+), 1 deletion(-)
> > > >
> > >
> > > I am not sure how you tested this. I wrote a simple U-Boot command to
> > > call U-Boot sifive-otp driver to test the write functionality, but it
> > > failed.
> > >
> > > => misc write otp@10070000 0 80200000 10
> >                                                       ^^^^^^^^^
> > Quick ask, how about 'md 80200000'?
> >
> > I didn't use 'misc write' command. I can check afterward.
>
> Note 'misc write' is a new U-Boot command I just added for testing
> this QEMU functionality. Please use the U-Boot patch below:
> http://patchwork.ozlabs.org/project/uboot/patch/1602657292-82815-1-git-send-email-bmeng.cn@gmail.com/
>
Thanks for pointing it out.

I've found one bug when I revise the macro of the write function and
the read is correct. It's my mistake. I will include and rerun this
test as well.

> >
> > > => misc read  otp@10070000 0 80400000 10
> > > => md 80400000
> > > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > > 80400010: 00000000 00000000 00000000 00000000    ................
> > > 80400020: 00000000 00000000 00000000 00000000    ................
> > > 80400030: 00000000 00000000 00000000 00000000    ................
> > > 80400040: 00000000 00000000 00000000 00000000    ................
> > > 80400050: 00000000 00000000 00000000 00000000    ................
> > > 80400060: 00000000 00000000 00000000 00000000    ................
> > > 80400070: 00000000 00000000 00000000 00000000    ................
> > > 80400080: 00000000 00000000 00000000 00000000    ................
> > > 80400090: 00000000 00000000 00000000 00000000    ................
> > > 804000a0: 00000000 00000000 00000000 00000000    ................
> > > 804000b0: 00000000 00000000 00000000 00000000    ................
> > > 804000c0: 00000000 00000000 00000000 00000000    ................
> > > 804000d0: 00000000 00000000 00000000 00000000    ................
> > > 804000e0: 00000000 00000000 00000000 00000000    ................
> > > 804000f0: 00000000 00000000 00000000 00000000    ................
> > > => misc write otp@10070000 0 80200010 10
> > > => misc read  otp@10070000 0 80400010 10
> > > => md 80400000
> > > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > > 80400010: ffffffff ffffffff ffffffff ffffffff    ................
> > > 80400020: 00000000 00000000 00000000 00000000    ................
> > > 80400030: 00000000 00000000 00000000 00000000    ................
> > > 80400040: 00000000 00000000 00000000 00000000    ................
> > > 80400050: 00000000 00000000 00000000 00000000    ................
> > > 80400060: 00000000 00000000 00000000 00000000    ................
> > > 80400070: 00000000 00000000 00000000 00000000    ................
> > > 80400080: 00000000 00000000 00000000 00000000    ................
> > > 80400090: 00000000 00000000 00000000 00000000    ................
> > > 804000a0: 00000000 00000000 00000000 00000000    ................
> > > 804000b0: 00000000 00000000 00000000 00000000    ................
> > > 804000c0: 00000000 00000000 00000000 00000000    ................
> > > 804000d0: 00000000 00000000 00000000 00000000    ................
> > > 804000e0: 00000000 00000000 00000000 00000000    ................
> > > 804000f0: 00000000 00000000 00000000 00000000    ................
> > >
> > > But it can read the serial number at offset 0x3f0
> > >
> > > => misc read  otp@10070000 3f0 80400010 10
> > > => md 80400000
> > > 80400000: ffffffff ffffffff ffffffff ffffffff    ................
> > > 80400010: 00000001 fffffffe ffffffff ffffffff    ................
> > > 80400020: 00000000 00000000 00000000 00000000    ................
> > > 80400030: 00000000 00000000 00000000 00000000    ................
> > > 80400040: 00000000 00000000 00000000 00000000    ................
> > > 80400050: 00000000 00000000 00000000 00000000    ................
> > > 80400060: 00000000 00000000 00000000 00000000    ................
> > > 80400070: 00000000 00000000 00000000 00000000    ................
> > > 80400080: 00000000 00000000 00000000 00000000    ................
> > > 80400090: 00000000 00000000 00000000 00000000    ................
> > > 804000a0: 00000000 00000000 00000000 00000000    ................
> > > 804000b0: 00000000 00000000 00000000 00000000    ................
> > > 804000c0: 00000000 00000000 00000000 00000000    ................
> > > 804000d0: 00000000 00000000 00000000 00000000    ................
> > > 804000e0: 00000000 00000000 00000000 00000000    ................
> > > 804000f0: 00000000 00000000 00000000 00000000    ................
>
> Regards,
> Bin


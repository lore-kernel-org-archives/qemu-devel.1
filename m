Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A662C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB4DF20874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 22:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIhaTvXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4DF20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTYVx-0000dR-JH
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 18:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTYTj-0008F1-1O; Fri, 16 Oct 2020 18:45:39 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:42460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTYTh-000089-4T; Fri, 16 Oct 2020 18:45:38 -0400
Received: by mail-il1-x143.google.com with SMTP id l16so4397254ilj.9;
 Fri, 16 Oct 2020 15:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KfuBWLWEZfcCjhlU5SHPE8VPjxmLIxlIhcGyHYX1R00=;
 b=HIhaTvXT6scy1QOyb6/hsV+AyAd3WFvOo16FxEpYriQNsrkYhQHdslomT/k+89huWw
 +WyyvRNjBEO6gsf/GVJaE/yDzFiTb+QO/l0aSzICCRAy2hhnqq7EtgI4Rm6jemHWCKq8
 8cJvASZmL0iSdbUmyKD3MgcHi+Vh3r64LJTIaGPSGemqPoITekQ6z28qcMtZzzPdDXuX
 RUS+DrhNbly3ZFYfV2r6lD6RxLnwP4+fPnIJ8cWbjh89S86w19/GAtWjX5gBB82p2ncg
 65X/Kftawxbd5S/1zUytFNYBK2Oai6C/FDUE9GpBOQWWW4b8jvDTYHB7RkQIxdNoBC8F
 ZR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KfuBWLWEZfcCjhlU5SHPE8VPjxmLIxlIhcGyHYX1R00=;
 b=aiaYsIyYQFN72foJExSHLloYEdyh8UnX57GtZfS0k67uQr/VU4wPZ27teyoZ6Rfun+
 QpMG/OfPL5WtNfnM9ofra+Qaf52MeHdw3cUBTrH1NVVxoz3ccvSADWxv2XEcS1+zPq4g
 praWADUJcGxVgBRMXXBUFwkalW+PpvB3nrZmcM4igRH6289HuRn1StsoQLv90bDEcDrG
 IHOFz6VdVaOp5oe8GsVSRIlAagEDQFfA8vSrxDwlfu8VOElo/g2dCuSq2f01Xm1sbuUq
 8ofwQwTTVSDSKQ73zb8AkOKa4yHLGcYGFa31biKi95YbeglA7aeJUAeWCyj/xp5PL0cI
 DAvA==
X-Gm-Message-State: AOAM5310xLg/8HHugEkZXSL0d31yFWJS5ys3ak756T8zsBVhxZU5AVBI
 UPgX9dqSrZri7Ayq/tTg/QJHn6XLFWN2eMoiR2w=
X-Google-Smtp-Source: ABdhPJwqR1zVuBjCT2HRF+RFJuhF4QV8JoiVoUKbPFTuZnRggu8kZRC7DQb+DZIV0ptoHzb7+MgXfw7MX5a9xJnovGA=
X-Received: by 2002:a05:6e02:1241:: with SMTP id
 j1mr4639302ilq.267.1602888335575; 
 Fri, 16 Oct 2020 15:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <B96DF081-AEDD-470E-A99C-8A9536E0A8CE@hni.upb.de>
 <CAKmqyKPnnLHuTvosMLs+4A8QqR-XvuxgRU33c0f1Q92LJ_x8CA@mail.gmail.com>
 <7F36EF66-D48D-418C-94D2-AA66D86C38CA@hni.upb.de>
In-Reply-To: <7F36EF66-D48D-418C-94D2-AA66D86C38CA@hni.upb.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Oct 2020 15:33:56 -0700
Message-ID: <CAKmqyKMO8oTg8DSHqYyX8eL4SkN5GTMiuO0+VmnRcJkY2daaQQ@mail.gmail.com>
Subject: Re: HTIF tohost symbol size check always fails
To: Peer Adelt <adelt@hni.upb.de>
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 2:35 PM Peer Adelt <adelt@hni.upb.de> wrote:
>
> The solution was even easier: I forgot to load the proxy kernel. As soon as I replaced the command-line parameter "-kernel <ELF>" with "-kernel <PK> -append <ELF>", everything was working as expected.

Even better, you can skip the proxy kernel.

You can run:

`-bios default -kernel <ELF>`

Alistair

>
> Without your hint about my possibly misconfigured toolchain I would have probably continued to search for the error in the QEMU HTIF device. But in fact it was due to the wrong binary.
>
> Thanks a lot! :-)
>
> > On 16. Oct 2020, at 20:03, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 7:59 AM Peer Adelt <adelt@hni.upb.de> wrote:
> >>
> >> Hi,
> >>
> >> I have a problem with the RISC-V HTIF device.
> >>
> >> Every binary I have compiled for Spike on riscv32 fails with the following error message: "HTIF tohost must be 8 bytes"
> >>
> >> This happens regardless of which program I have translated for Spike. This is also the case with the official riscv-compliance tests, for example.
> >>
> >> The query "if (st_size != 8)" in the HTIF device always fails, because st_size seems to be always 0.
> >>
> >> To be able to reproduce it:
> >> - QEMU GIT Hash: d0ed6a69d399ae193959225cdeaa9382746c91cc (tag "v5.1.0")
> >
> > I just checked with this hash and with the current master and on both
> > I can run a ELF executable on the Spike machine for RV32.
> >
> >> - System: Mac OS 10.14.6 (Darwin Kernel Version 18.7.0)
> >> - Compiler: Latest SiFive Build for GCC under OSX
> >
> > Maybe try using an official toolchain instead of a vendor fork.
> >
> > Alistair
> >
> >> - Command: qemu-system-riscv32 -M spike -nographic -bios none -kernel <ANY_SPIKE_ELF_FILE>
> >>
> >> Best regards,
> >> Peer Adelt
>


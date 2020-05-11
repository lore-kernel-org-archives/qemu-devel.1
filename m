Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00944C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3083206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1Daz0e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3083206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY51A-0007fd-SX
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY50L-0006w0-B3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:45:45 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY50J-0002cC-RQ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:45:45 -0400
Received: by mail-qt1-x842.google.com with SMTP id j2so7068925qtr.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BNn7x9TG9KqiQD2g8CFL3lxABrmtxkoTAhj7+BITR6c=;
 b=I1Daz0e9LbkidiNSfVs4hiEcF2ADSgrVAKcz1uuG1E5E0Q1PqKFmEWT4xDzyFNRzWz
 mVPP/yE8ijPJz8KS22V5R0NrUPNFUohBS7pVtneDS0Tz/YVaEAmQCf96NCkrk8cjOlRx
 0ia8uS1s62M1xK8Dz1y4iCQWX7CLfIcC7uvn7NGdlroier4BH5Vpvx8WC15d9sbGr7yx
 HOeHmC9Egh1SmDOqxtlafpKjPf4vnoVW/IhoXUdNQNldCWGAuWMLAgh8iDC3GfW/ldyf
 RdMDnCCiWRXYOq2cSX/lyzWWee8KviEI4TSN/3bHGAvt4SDrJmgWDeK8LslS6woa0xoy
 cBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BNn7x9TG9KqiQD2g8CFL3lxABrmtxkoTAhj7+BITR6c=;
 b=s4/EAM6hwXnu4yrsqtn+iGKTfg3u9lIpwlfn3J0hTOQmvcWrJzBnn0Gs1nqj+FMFIk
 g5lAXWzTANbxn29Wb/RM5PdlRdec/5pLY3BtJmBINraUoXsYpR2VSAS/8bs+zQpNf/hG
 OVsOiFMQP66QQNTHg2vJ0tNlWXVYqWmMi/0MB9Ofk5K9erMlfcMgjZGC8Ck5+42bq7bm
 qV8DYgZnm5ZSf0o3K13J8/56hcwPQVducl02INfSEmmjBKFb4IitdILhToynuWWBDS8U
 qahVU1iFWH8ov7zZTBOVqzWNeJjmd5WsUjeEzo/qFFGklZA0u6uv3EN/bF9m8aLdG5LE
 ncwQ==
X-Gm-Message-State: AGi0PuYeZH7f86JZgyB2c4e/skXtX+u1r5SNPJHX8+x11QhtF/w0E+Mn
 lsb+ptoNCxTv7KMJZ8hqqQDiQchI2e2B7MIbw4o=
X-Google-Smtp-Source: APiQypLR9wn3//8vHuD4EObNyFZNQRJJUolBb4uxgZTFmr3OaFV6iZewPS+/5fdb2uuUeD2Cs41NzFH+jg0NFGrqAWc=
X-Received: by 2002:ac8:4cdc:: with SMTP id l28mr4445326qtv.213.1589190342306; 
 Mon, 11 May 2020 02:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <158901182209.5021.12832610872088111923.malonedeb@soybean.canonical.com>
 <CAJSP0QW6hE=Svo2RrUpLeamsC3LwCPef64923dJZTQA9JnO++A@mail.gmail.com>
In-Reply-To: <CAJSP0QW6hE=Svo2RrUpLeamsC3LwCPef64923dJZTQA9JnO++A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2020 10:45:30 +0100
Message-ID: <CAJSP0QUQu-Uq3W56iT36vb_BVc5yra5VMbWerRTcsJxShyj4bA@mail.gmail.com>
Subject: Re: [Bug 1877716] [NEW] Win10 guest unsuable after a few minutes
To: Bug 1877716 <1877716@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=stefanha@gmail.com; helo=mail-qt1-x842.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>, anatol.pomozov@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 10:12 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, May 9, 2020 at 9:16 AM Xavier <1877716@bugs.launchpad.net> wrote:
> >
> > Public bug reported:
> >
> > On Arch Linux, the recent qemu package update seems to misbehave on some
> > systems. In my case, my Windows 10 guest runs fine for around 5 minutes
> > and then start to get really sluggish, even unresponsive. It needs to be
> > forced off. I could reproduce this on a minimal VM with no passthrough,
> > although my current testing setup involves an nvme pcie passthrough.
> >
> > I bisected it to the following commit which rapidly starts to run sluggishly on my setup:
> > https://github.com/qemu/qemu/commit/73fd282e7b6dd4e4ea1c3bbb3d302c8db51e4ccf
>
> Thanks for bisecting this bug! Arch Linux can work around it in the
> short term by building with ./configure --disable-linux-io-uring
> and/or removing the liburing build dependency.

Hmm...a brief look at the Arch Linux package source suggests QEMU is
not being built with io_uring enabled. Anatol, please confirm whether
this is correct.

If io_uring is not enabled then this bug may affect most existing
users on Linux. Initially I thought it was because Arch Linux had
enabled the new io_uring feature but I was probably mistaken.


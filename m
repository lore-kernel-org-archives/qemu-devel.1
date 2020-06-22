Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D02C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDA42075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdxkPaLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDA42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnUCi-0003cQ-Ti
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnUBu-0002ko-RB; Mon, 22 Jun 2020 17:41:22 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jnUBs-0001Sw-Hv; Mon, 22 Jun 2020 17:41:22 -0400
Received: by mail-io1-xd41.google.com with SMTP id c4so7740222iot.4;
 Mon, 22 Jun 2020 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=84ngPMDCRxQ8rJpuiNXM1KEh+s2z60OgriA8QpWSyeg=;
 b=rdxkPaLOstS1BebkE6r6X92hYnV1FeWeT3TXaDiFpnoYrGA4HAsqV4V1w+8UnRit0N
 PCegK2CUg3QVAo8bIONMIXX44gkdhQB43y4BHF//cKs5CFEnPFyE4C6ypiFL8NCt0w7v
 1ITc//Og/bFxmv3vS3ILnfklqdHiXcoLVWM9zOzMW0MqySiuWJtJwUm2P5zFAGIhShfY
 Kz6xIk2l/au4sNQXWHi/sc+GeyRZdQ7+6KvEhgk1Lno0FMhjZ2owyHQ5goTU0KqvXYkz
 jZmDq3L6VaiLE1T6fBCb7QER1wYKUUHA5FsR6x7pnn7xMy+cITGSlq18d2muOZ+qf61E
 +aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=84ngPMDCRxQ8rJpuiNXM1KEh+s2z60OgriA8QpWSyeg=;
 b=hqL+IoDiK/ZiW8jL3iRLp80cFXwrpqx+O+HaZGwF86CIwxXHyBH9Z0y/me7dQwXWU2
 3TclDVP5lOwS4cEvlBOrPza7yrb3HPCq2pM6Ba6HVSPeGJnwwRbEiKx9vK0sNU2Wn7aH
 qGkCF9XChve3V7kZoX8/oiy1sliPZT6Z40GI461wMQ909VM5awgxI0V03bgxXzS9amsV
 Ys3LsoOXaWtn/xcqrF4zNb6LyUWiy3zXns7u3hQHZoU23QhYVzrMxyVH+CgJMikA9UW1
 3m//Vwez7H9m3+e3HRqncK8Go6JxIlQvXWm9J37JS3cADJ8fWvXlBE5SSWRL71zfRgLP
 eszQ==
X-Gm-Message-State: AOAM532SMF2bZViKW0sMSU7cTKQ3oawA+0dBvBxmF6nEVULb8EDz73Dq
 CRzNRAjkSl44uRUVgd0LoslpadyXeZK6O5mdlu8=
X-Google-Smtp-Source: ABdhPJxYBB3RKHM+0WPGeWGehsDtq1w+2h5KQjdNknfVH2ePXa5f7jBYE9bZgOWGf7PTatuk4wIb+SPTVyT2E2fZgjs=
X-Received: by 2002:a6b:6412:: with SMTP id t18mr2920430iog.175.1592862079097; 
 Mon, 22 Jun 2020 14:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
 <DM6PR04MB620142B152292DD3945E4D3C8D970@DM6PR04MB6201.namprd04.prod.outlook.com>
 <CAEUhbmVhHKy70dA5dyQCiWeYk1nbhXHnZH8JBxmRJP6EUb2z9g@mail.gmail.com>
 <DM6PR04MB62013393F37DC653A1D3F1B28D970@DM6PR04MB6201.namprd04.prod.outlook.com>
 <CAEUhbmUQKv9tJfCeWYnO59AoqOHah8J6T0g2zVBnujmSdYtAfg@mail.gmail.com>
In-Reply-To: <CAEUhbmUQKv9tJfCeWYnO59AoqOHah8J6T0g2zVBnujmSdYtAfg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2020 14:31:45 -0700
Message-ID: <CAKmqyKNsqznVdW1FRgie15b0ufXrRU5hporKFAGbqMRkZzYZgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
 bios images
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 5:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Anup,
>
> On Mon, Jun 22, 2020 at 8:20 PM Anup Patel <Anup.Patel@wdc.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Bin Meng <bmeng.cn@gmail.com>
> > > Sent: 22 June 2020 17:43
> > > To: Anup Patel <Anup.Patel@wdc.com>
> > > Cc: Alistair Francis <Alistair.Francis@wdc.com>; Bastian Koppelmann
> > > <kbastian@mail.uni-paderborn.de>; Palmer Dabbelt
> > > <palmerdabbelt@google.com>; Sagar Karandikar
> > > <sagark@eecs.berkeley.edu>; qemu-devel@nongnu.org; qemu-
> > > riscv@nongnu.org; Anup Patel <anup@brainfault.org>; Bin Meng
> > > <bin.meng@windriver.com>
> > > Subject: Re: [PATCH v2 0/7] riscv: Switch to use generic platform of opensbi
> > > bios images
> > >
> > > Hi Anup,
> > >
> > > On Mon, Jun 22, 2020 at 6:09 PM Anup Patel <Anup.Patel@wdc.com> wrote:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Qemu-riscv <qemu-riscv-
> > > > > bounces+anup.patel=wdc.com@nongnu.org> On Behalf Of Bin Meng
> > > > > Sent: 22 June 2020 12:03
> > > > > To: Alistair Francis <Alistair.Francis@wdc.com>; Bastian Koppelmann
> > > > > <kbastian@mail.uni-paderborn.de>; Palmer Dabbelt
> > > > > <palmerdabbelt@google.com>; Sagar Karandikar
> > > > > <sagark@eecs.berkeley.edu>; qemu-devel@nongnu.org; qemu-
> > > > > riscv@nongnu.org
> > > > > Cc: Anup Patel <anup@brainfault.org>; Bin Meng
> > > > > <bin.meng@windriver.com>
> > > > > Subject: [PATCH v2 0/7] riscv: Switch to use generic platform of
> > > > > opensbi bios images
> > > > >
> > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > >
> > > > > The RISC-V generic platform is a flattened device tree (FDT) based
> > > > > platform where all platform specific functionality is provided based
> > > > > on FDT passed by previous booting stage. The support was added in
> > > > > the upstream OpenSBI
> > > > > v0.8 release recently.
> > > > >
> > > > > This series updates QEMU to switch to use generic platform of
> > > > > opensbi bios images.
> > > > >
> > > > > The patch emails do not contain binary bits, please grab all updates
> > > > > at https://github.com/lbmeng/qemu.git bios branch.
> > > >
> > > > It will be nice to have this series updated to for fw_dynamic.bin .
> > >
> > > Do you mean we include fw_dynamic.bin for virt & sifive_u, and
> > > fw_dynamic.elf for spike?
> > >
> > > But previously we agreed to include only generic platform BIN and ELF files.
> > > See https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg00664.html
> >
> > I am suggesting to use Generic platform fw_dynamic.bin and fw_dynamic.elf
> > for QEMU virt, QEMU spike, and QEMU sifive_u machines.
>
> Do you mean we replace fw_jump.bin with fw_dynamic.bin in QEMU? If
> everyone agrees this is the way to go, I can rebase this series on top
> of Atish's fw_dynamic.bin support series.

I think fw_dynamic makes the most sense. The order doesn't really
matter, but as we are checking in binaries it might be best to avoid
too much churn and rebase this on top of Atish's patches.

Alistair

>
> Regards,
> Bin
>


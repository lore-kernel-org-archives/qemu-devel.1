Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B659FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1351F21D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gomWyIAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1351F21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4Pj-0004mK-5s
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kG4OP-00044t-7b; Wed, 09 Sep 2020 14:00:25 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kG4OM-0001YT-Pe; Wed, 09 Sep 2020 14:00:24 -0400
Received: by mail-il1-x144.google.com with SMTP id p13so3206325ils.3;
 Wed, 09 Sep 2020 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CX+wa3Cw6K12KtlfLiQRHHsZ0quSOvcZN3FfrH23N+Y=;
 b=gomWyIAbQhN0XgcsfPXyYmUh9FAib1iXf7ynvlRy1cNQJ8T6sHJyTDdj5hvn3+smqE
 RyNQ9ZnxR0DrroUDkIiB2EU2z4KsgW4X0xoFk4lcEqot5+DtFp06DXfqjhpv9jyFflAV
 7G2FM3zE+h4R2zlBFCod6Kov4iyJCGCPoeexFJdFwGYS6qH0alQofqeWdZRBzPCLTdfh
 caHnZ2+UZezyvxZWPS0v2iM5AAmUO6DUg6vJfGbciRIrWRHsbD4ZA9Nk+W6P2llbh5E/
 EuuSWCqBu8LTeo0hukeT5HMKExUlHpxAPODff4mj43xiX8nc6iVl57Cb9PWR1iEKrPfY
 9QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CX+wa3Cw6K12KtlfLiQRHHsZ0quSOvcZN3FfrH23N+Y=;
 b=lOBH9/mPhVJLdcQ0klIh5+N0TxnjNoKZxcEhJbewtYkusrtqxHJHsjEUXabInmzFc6
 Dw/DDTwXtj9Sr8uvzfsAh4giHRDqXbHY8bpvtC/GrR+5wJcTaWbV5VYfUVzmNB5n+76M
 CTV9/iyNykvOTj6B0DxSQ3z9ggm9eJ4trDWNuS5LXI+PRFDEsRdCFKcTIuJtGVCm7wWN
 KvM9NuPe3irAin5D7W002jmbe5OnMeAVYamwTrjEzDCrmCOSBLiRnymN4HTijwkyYwAb
 z22xC5vYpzqTUtFWTb+g1ESbNOGcif1IfW08UU8i6XuMG+bRNnOrjbcbLA5Gqztf9hqi
 gCNw==
X-Gm-Message-State: AOAM5321JmgrrwQHm0FV1ohhd/0iXyw4h6lIuDOOINeUpnUQ5mR0lP/b
 hmX1Xo8/YhGhzXjECE98fdnFgRyRQUPiHyzxMuc=
X-Google-Smtp-Source: ABdhPJzsg3B0ctEMLtGUh3SfgRVIZ4Lj6H1GEjOxjR/gP/0iEE5zP/rcaZqpVEuSnwycaWOte1GCa8ZpvO9VWpu3eQs=
X-Received: by 2002:a92:d94b:: with SMTP id l11mr5000880ilq.131.1599674420340; 
 Wed, 09 Sep 2020 11:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704015.git.alistair.francis@wdc.com>
 <0ab3cecbe801f9e14ad1a5447d02483b9008fdbb.1590704015.git.alistair.francis@wdc.com>
 <CAFEAcA83=4=EhtQLmGJn5Z_PVZaDyo7pMwdX-9fTVUkVKe7Acw@mail.gmail.com>
In-Reply-To: <CAFEAcA83=4=EhtQLmGJn5Z_PVZaDyo7pMwdX-9fTVUkVKe7Acw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 9 Sep 2020 10:49:20 -0700
Message-ID: <CAKmqyKPryJP5g4RXq1uCbYKQX3C+9yzjjqEH4i88L6Vf2gW7Zg@mail.gmail.com>
Subject: Re: [PATCH v5 06/11] riscv: Initial commit of OpenTitan machine
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 8, 2020 at 7:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 28 May 2020 at 23:31, Alistair Francis <alistair.francis@wdc.com> wrote:
> >
> > This adds a barebone OpenTitan machine to QEMU.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >  default-configs/riscv32-softmmu.mak |   1 +
> >  default-configs/riscv64-softmmu.mak |  11 +-
>
> Just noticed this, but:
>
> > diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
> > index 1ae077ed87..94a236c9c2 100644
> > --- a/default-configs/riscv32-softmmu.mak
> > +++ b/default-configs/riscv32-softmmu.mak
> > @@ -10,3 +10,4 @@ CONFIG_SPIKE=y
> >  CONFIG_SIFIVE_E=y
> >  CONFIG_SIFIVE_U=y
> >  CONFIG_RISCV_VIRT=y
> > +CONFIG_OPENTITAN=y
> > diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> > index 235c6f473f..aaf6d735bb 100644
> > --- a/default-configs/riscv64-softmmu.mak
> > +++ b/default-configs/riscv64-softmmu.mak
> > @@ -1,3 +1,12 @@
> >  # Default configuration for riscv64-softmmu
> >
> > -include riscv32-softmmu.mak
> > +# Uncomment the following lines to disable these optional devices:
> > +#
> > +#CONFIG_PCI_DEVICES=n
> > +
> > +# Boards:
> > +#
> > +CONFIG_SPIKE=y
> > +CONFIG_SIFIVE_E=y
> > +CONFIG_SIFIVE_U=y
> > +CONFIG_RISCV_VIRT=y
>
> ...shouldn't the riscv64-softmmu config have CONFIG_OPENTITAN too?
> The usual principle is that the 64-bit executable can run the
> 32-bit boards too.

I didn't know that was the general case. I'll send a patch to enable this.

Alistair

>
> thanks
> -- PMM


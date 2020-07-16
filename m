Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19240C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 04:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC46020775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 04:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSzqHyMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC46020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvvvs-0003LU-2K
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 00:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvvvH-0002lE-Jo; Thu, 16 Jul 2020 00:55:07 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:43299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvvvE-0006hc-Qi; Thu, 16 Jul 2020 00:55:07 -0400
Received: by mail-yb1-xb44.google.com with SMTP id y13so2232658ybj.10;
 Wed, 15 Jul 2020 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5UuqnJOSNryh7rl6ROoUmW3hK1EcwSAJsRWP6K/Is3k=;
 b=GSzqHyMbU3ZxrBFdPULkYJps4rW/bvQaABJjHJD7z2GFNkams7tHrp/CjYDQydqMs7
 hbrVwkgQdy53vc7ukYADVfAdbq+6q0lZvef39RyIJCteMBXLg9UmGjQ8hKmlb8DM8PAq
 C5NY1UYA89d4YOtdl3Ma0sUzL0ecwaJu9eu3pOoebnojHcJe1GcTa7F45Xf6oHFkQp54
 5cM7TSitdV97SJ1QBm8m0KOAxJ9vdxaGvMyua8sHLy1RTQMzosCxW9v9D4nUcmUdxz+C
 p6/uZkObWBnsPVTt+pNhbTFPpgvaJ+2Fw03lQvZeITG+k2c0tFjBeGzEb25OTYAXlhyi
 ujPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5UuqnJOSNryh7rl6ROoUmW3hK1EcwSAJsRWP6K/Is3k=;
 b=kWMWiBM4vuE4QcGMzmG0FFpEGM4wwIlAgXFqwpxDnjw+IL4nB4Xn2rZUg1uIfqKIWd
 DlCfvDmBLKoCh6/f0tGg8hNk9T/LgjNTDWDF+7DA65bw5kfyCteUjyiDYeoNodqYr5iN
 MJYwKV+2GxBdLuqBKUT3GPHRuSD6YN8fUOnSP29Ar9YJ5s90rI9MzgELLCcTd6mtLuJB
 9iXeHpct35DMrcYUUxOBJTzSN2l1Fwqef79rfP1aLaw0RTZyq0qCa5y1jGWolekD2xTJ
 qTmywNrt4iEnowOKrbNykJq8/wCPRmsOCn5sQSfqojxqULUOZCqcSN/5MRo899lK828n
 ThjA==
X-Gm-Message-State: AOAM532n2IolFmPWjlLKTCsDSaqc4uGCp0IIoS1wQzuccgKRSa5ge6yN
 K9SwcyWKmcxJCKWuynW8SR39inmYDgpr5D1bsLM=
X-Google-Smtp-Source: ABdhPJzFQ9LNnTiO5MP5ZDwBiBt3fuS5jDwFKqU7R2/ERC971gdJSun37Gp+Nm2cmCy+OwcdeGvHF/WedUx3ZRQxIqg=
X-Received: by 2002:a25:c342:: with SMTP id t63mr3778755ybf.122.1594875303182; 
 Wed, 15 Jul 2020 21:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
 <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
In-Reply-To: <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 16 Jul 2020 12:54:51 +0800
Message-ID: <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alistair,

On Mon, Jul 13, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > > image built for the generic FDT platform.
> > >
> > > Remove the out-of-date no longer used bios images.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
> >
>
> It looks only Linux boot on sifive_u is broken. On our side, we have
> been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
> gets unnoticed. I will take a look.

I've figured out the issue of 32-bit Linux booting failure on
sifive_u. A patch has been sent to Linux upstream:
http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html

Regards,
Bin


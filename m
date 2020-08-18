Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A9AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9752065D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 06:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="gN5EDQ1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9752065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7uwg-0007jG-Kn
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 02:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1k7uw8-0007BK-30
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:17:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1k7uw5-0003dV-Ri
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 02:17:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id c15so17061609wrs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 23:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MIdWO3COCqNdq9aMAydiJRPmw8ayq0kdGOqoDuJJjbk=;
 b=gN5EDQ1y2F3iKrhn8Mzh/7lqjhxrwUIINxNyR7KvPMMKhWe77LozxTnwKM1qzKJKgG
 UcNdokP++rJbAlLNcm7VikdLZwidRMKX06VWFdiHXJkuNKMmQpglHWxTPs50zTE6Dchs
 WLgtivoofLTi1V2Db2i/lXFOR/XPKrzlbohTZDjGwi0bvUFRG5tC5yyMmdHbXK2itaw3
 sbdxRUdpeiGNA7xhXcldaBUe5jgR2aC5qvqx0icemPzSQDjb++VVQl0Tt9+lW8uE+7gO
 TKjym0rKD3BRJNDUDBcIz/KaC9PgxXwsafbkLHO/9GE+6pO9Zo74CQQiYOhu3BbGD1UO
 ohTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MIdWO3COCqNdq9aMAydiJRPmw8ayq0kdGOqoDuJJjbk=;
 b=Wz0YlMoD5BQAa/VKXgON/F/Ao7HcFa1DSZjoUl+btqJqOGepZ51Q3uxP5ThQlkkvON
 ROChU43ZaGX3c8rCqSA6fIaKXrmV+fv47lngLRyzoApiBtSjmav+Zz46MYRtG1dDPiwG
 65FLwn7dec1q4lQIbrx+o9nFm3SSGsYRggp0T1NONkto4DxWrqnu2oqgJ3o3lBZYWIEj
 YdMpXsYa8eDI5eaF2Dype+eEggRaokVXtOAKtpxc+dP3X4ylIUW7Db4fuyfeWvm+JZGk
 9aKJ5UTP3VEj9C6FnhaX0FyQnVJLPe7BakgHNh4H/3Qk0xN3hpyailHDm+NyJN+EfLfg
 lQng==
X-Gm-Message-State: AOAM531WfnSVQswpkSoHyTmy9HaElhoTj2JUVvTLu7BBL+0amzUoohSe
 kZW06Zxt0wNileQ9Ghum7RbAITrHxV/R8TS8LGGRjA==
X-Google-Smtp-Source: ABdhPJyymyoSdwLNSZAXB/cVgy+M4WNK6BiXsZOPS1Y6uWbR3YKi9cmxZbTh9kvnDZIZsUAt65hP4QaOA8uOi8dF6OU=
X-Received: by 2002:adf:f247:: with SMTP id b7mr19606082wrp.128.1597731447614; 
 Mon, 17 Aug 2020 23:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
 <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
 <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
In-Reply-To: <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 18 Aug 2020 11:47:15 +0530
Message-ID: <CAAhSdy32owLO0KytyYsg-zH6JyyfNfGofa4vanqTFJLntPq0=g@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=anup@brainfault.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 1:23 AM <Cyril.Jean@microchip.com> wrote:
>
> On 8/17/20 8:28 PM, Alistair Francis wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Mon, Aug 17, 2020 at 11:12 AM via <qemu-devel@nongnu.org> wrote:
> >> Hi Anup,
> >>
> >> On 8/17/20 11:30 AM, Bin Meng wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> Hi Anup,
> >>>
> >>> On Sat, Aug 15, 2020 at 1:44 AM Anup Patel <anup@brainfault.org> wrote:
> >>>> On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>>> From: Bin Meng <bin.meng@windriver.com>
> >>>>>
> >>>>> This adds support for Microchip PolarFire SoC Icicle Kit board.
> >>>>> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> >>>>> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> >>>> Nice Work !!! This is very helpful.
> >>> Thanks!
> >>>
> >>>> The Microchip HSS is quite convoluted. It has:
> >>>> 1. DDR Init
> >>>> 2. Boot device support
> >>>> 3. SBI support using OpenSBI as library
> >>>> 4. Simple TEE support
> >>>>
> >>>> I think point 1) and 2) above should be part of U-Boot SPL.
> >>>> The point 3) can be OpenSBI FW_DYNAMIC.
> >>>>
> >>>> Lastly,for point 4), we are working on a new OpenSBI feature using
> >>>> which we can run independent Secure OS and Non-Secure OS using
> >>>> U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
> >>>> PolarFire).
> >>>>
> >>>> Do you have plans for adding U-Boot SPL support for this board ??
> >>> + Cyril Jean from Microchip
> >>>
> >>> I will have to leave this question to Cyril to comment.
> >>>
> >> I currently do not have a plan to support U-Boot SPL. The idea of the
> >> HSS is to contain all the silicon specific initialization and
> >> configuration code within the HSS before jumping to U-Boot S-mode. I
> >> would rather keep all this within the HSS for the time being. I would
> >> wait until we reach production silicon before attempting to move this to
> >> U-Boot SPL as the HSS is likely to contain some opaque silicon related
> >> changes for another while.
> > That is unfortunate, a lot of work has gone into making the boot flow
> > simple and easy to use.
> >
> > QEMU now includes OpenSBI by default to make it easy for users to boot
> > Linux. The Icicle Kit board is now the most difficult QEMU board to
> > boot Linux on. Not to mention it makes it hard to impossible to
> > support it in standard tool flows such as meta-riscv.
> >
> > Alistair
>
> If it is such a problem we can add a U-Boot SPL stage and the HSS can be
> treated as standard SoC ROM code.

It's not mandatory for U-Boot SPL to have stable DRAM calibration settings
from the start itself. The initial U-Boot SPL support for most
platforms (accross
architectures) usually include basic working DRAM calibration settings which
is later on updated with separate patches. Also, we don't need all U-Boot
drivers to be upstreamed in one-go as this can be done in phases.

The advantage we have with PolarFire SoC Icicle board is that we already
have a U-Boot S-mode. and we believe the OpenSBI generic platform will
work fine for PolarFire SoC Icicle board so the only thing missing right now
is the U-Boot SPL support for OpenSource boot-flow.

It will certainly accelerate open-source development if we have boot-flow
U-Boot_SPL => OpenSBI (FW_DYNAMIC) => U-Boot_S-mode working
on PolarFire SoC Icicle board. Initially, we just need DRAM, SD/eMMC,
and Serial port support for U-Boot SPL and U-Boot S-mode. Later on,
more patches can add ethernet and other booting device drivers to U-Boot.

Regarding security services of HSS, we are working on a OpenSBI
feature which will allow HSS security services to run as independent
binary in M-mode (not linked to OpenSBI) and OpenSBI FW_DYNAMIC
will be a separate binary acting as a secure monitor.

Regards,
Anup


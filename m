Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4EBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA2420716
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXWPB5dN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA2420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7kyy-0001hr-Fc
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 15:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7kyN-00012R-N1; Mon, 17 Aug 2020 15:39:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7kyM-0003fM-3H; Mon, 17 Aug 2020 15:39:11 -0400
Received: by mail-il1-x143.google.com with SMTP id q14so12132383ilm.2;
 Mon, 17 Aug 2020 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=71Gu2SNl1BTKdiexaub3H5WnX3ygCfwguBJZtlG2y1M=;
 b=MXWPB5dN6NDU8oX1n2QKSoF1GXG9kPgnzqmhC7CE2uv37+2m4MQh1aBvpRnH0l7GA4
 JhiEfPj5gUc3Eyk7YNRxhAfGQizlDui0j/tR2qZ2yYwL/wGW1VTSXCvyj191AD/Vufdj
 w3p5ugbgt6GEp3almKXs3NuUfY1M07U/Bt9o6Itc6KfENdPb9UkND6VAXxsoKRlm7Ulr
 t5hu1gFFigHEsiEScbBF69LRCqw3cuWs4DrJ8PI+S+Ja265viyn9St/HruKe7+myiSYv
 tr9EpgTDhY0La3VPOsbsbjceZfoceb+7cEWJ+ot/U5UozranoVrWQNs9AtAjSoihl7nr
 Al0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=71Gu2SNl1BTKdiexaub3H5WnX3ygCfwguBJZtlG2y1M=;
 b=tMETtUI/ArfD7nrBfx1NQDYk41Rc2Fls1zvssw/gRBIbfClZpMJt6ijoy4D2t0l7nh
 Tqd4Y1ecjlAaBKQp1XxET5V1NL5FDUgPeAbZGOzoD2uy58+JeARkN5xBsckUERpofb7C
 RbktBAnI55ieUts5ms6Eaw/MiPcV20E7v9JWO1/frKNKQkFdMvnv8DWnXEir7m4NhkQV
 0DgDt3Jr9bmJXlp3tHrXXo4OoBseF4LbNjVe+rPAtAu6e2wNRspz1ERdq35nw0cCM//+
 JJd9g1fg3+RwoP9nY8/IFz5NubWF8q/i5aKSSMcH1P/HTKyXR28sb/ih/UY7OvRBXKgL
 5/6A==
X-Gm-Message-State: AOAM53023/l17YUX+Rxoxf4GGs4Hx2DoE20tDT5L6bxRmUpaI4yABA0n
 TDDBOkhXJD/XqOywzyIhx/VNQD+ascOlrF+id0g=
X-Google-Smtp-Source: ABdhPJxYKF9S3Z6zUsmN03DZ0d2L+Nnm9zruc9Ii2upCrvCz/Y+V0d7LQ14sp2Qc7udrcrZZENVJFK9Xvn+TGbf1txg=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr15203022ilk.267.1597693147799; 
 Mon, 17 Aug 2020 12:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
In-Reply-To: <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 12:28:36 -0700
Message-ID: <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Cyril.Jean@microchip.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Anup Patel <anup@brainfault.org>, Jason Wang <jasowang@redhat.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 11:12 AM via <qemu-devel@nongnu.org> wrote:
>
> Hi Anup,
>
> On 8/17/20 11:30 AM, Bin Meng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Hi Anup,
> >
> > On Sat, Aug 15, 2020 at 1:44 AM Anup Patel <anup@brainfault.org> wrote:
> >> On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>> From: Bin Meng <bin.meng@windriver.com>
> >>>
> >>> This adds support for Microchip PolarFire SoC Icicle Kit board.
> >>> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> >>> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> >> Nice Work !!! This is very helpful.
> > Thanks!
> >
> >> The Microchip HSS is quite convoluted. It has:
> >> 1. DDR Init
> >> 2. Boot device support
> >> 3. SBI support using OpenSBI as library
> >> 4. Simple TEE support
> >>
> >> I think point 1) and 2) above should be part of U-Boot SPL.
> >> The point 3) can be OpenSBI FW_DYNAMIC.
> >>
> >> Lastly,for point 4), we are working on a new OpenSBI feature using
> >> which we can run independent Secure OS and Non-Secure OS using
> >> U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
> >> PolarFire).
> >>
> >> Do you have plans for adding U-Boot SPL support for this board ??
> > + Cyril Jean from Microchip
> >
> > I will have to leave this question to Cyril to comment.
> >
> I currently do not have a plan to support U-Boot SPL. The idea of the
> HSS is to contain all the silicon specific initialization and
> configuration code within the HSS before jumping to U-Boot S-mode. I
> would rather keep all this within the HSS for the time being. I would
> wait until we reach production silicon before attempting to move this to
> U-Boot SPL as the HSS is likely to contain some opaque silicon related
> changes for another while.

That is unfortunate, a lot of work has gone into making the boot flow
simple and easy to use.

QEMU now includes OpenSBI by default to make it easy for users to boot
Linux. The Icicle Kit board is now the most difficult QEMU board to
boot Linux on. Not to mention it makes it hard to impossible to
support it in standard tool flows such as meta-riscv.

Alistair

>
>
> Regards,
>
> Cyril.
>


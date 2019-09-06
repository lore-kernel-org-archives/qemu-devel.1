Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EBCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 00:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401EE20820
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 00:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDFiEGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401EE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i62Cb-0001rh-0L
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 20:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i62B7-0001N8-Om
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 20:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i62B4-0003IH-LO
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 20:32:41 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i62B4-0003GJ-3w; Thu, 05 Sep 2019 20:32:38 -0400
Received: by mail-ed1-x544.google.com with SMTP id t50so4676125edd.2;
 Thu, 05 Sep 2019 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2KAecpzkBVNqK2Kl5yJbkKPpukWt6GoSU9zStaci4H0=;
 b=azDFiEGUqZl1PU+5lP32O3OoZN8RKZNPMx/B0vmI0lFMykQFqSmENpMmJ4Q+OBh/Mu
 /iitGi9vsT7SFJrisCMyrxDV4DgX8ATxfjBYCDey4uDOF6jJCpFWvyeI5trw8WsYZ+IQ
 TDw/DcBT0kucotZ4GLilsKxadAYXQEd/HJUkb73N0VLboZHrbJZ/XQa/h+Sfnp9SHENV
 TxfggeT9e9dVWhYyF4DIre59FN07jdFy30I+figXJoQgt04octSqR2SFzSZK/arQ+Tvq
 k385iJYNd54XfX4sJRNc/d3uP9inZa6cr6kQJ0CKA+xaAg4bWfh1pNrJ37YDHWaWKxFF
 NQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2KAecpzkBVNqK2Kl5yJbkKPpukWt6GoSU9zStaci4H0=;
 b=el71GH3llB5YmBSwh6eifqOpaDxfVkcaD9wN9GH7VG5ahSyo59Q3p38ZQfK0Yqt5IQ
 UwWITa/OV+bTPbIX4JdJzxrEECu/o+K8pWhBoil61myFei0SAnb/CNI2y6mNRiQRbU6v
 8gXweeOsRf4GeO4r2Vrc/wixylupcQDtwyRycxsv/1TasARfvvnG0IgnNutZmHP4noEr
 4gqfxJu+JHH42xemPpsFpqNDjX8T2F4rW6ekpl0NpMK1fvPNo4xoxIo5TfJbTwqx1JbB
 MtbaaKHRfT2QpHCRK3ALM+NYKtAifDGDfqkqKy+T3gooHU0HhUhXgZuvDVejLNnl65+y
 bGFQ==
X-Gm-Message-State: APjAAAXZSBkC+kBNSEwCF2yIV3PeWOeF3Rl4g5EykgR1pWMHmcxoSdaY
 nTUm9bcSZnmZWiUnoZBeTH4je3z+ZgkxyZC8vDk=
X-Google-Smtp-Source: APXvYqzosaPWMcVBVhpSSfMu0ZN4qj/JkvIHMQmGOVOTry3kw/pogxBh64ohcZv2GgWDAiC3CBLPgzfK7Y++CEUCfKc=
X-Received: by 2002:aa7:c24b:: with SMTP id y11mr6862674edo.214.1567729956642; 
 Thu, 05 Sep 2019 17:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmWGHbBXO+NtkfxJc1tHNLKY_nLPKQ_L=MVsyuToZ02e9w@mail.gmail.com>
 <mhng-1e0d1887-7084-4997-bcc4-a254d05f629a@palmer-si-x1e>
In-Reply-To: <mhng-1e0d1887-7084-4997-bcc4-a254d05f629a@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 6 Sep 2019 08:32:24 +0800
Message-ID: <CAEUhbmUvn-4DqLXZrz-DPDibRdfnd7ZmMHkfwSqieGeLj9XiGg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v7 00/30] riscv: sifive_u: Improve the
 emulation fidelity of sifive_u machine
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Fri, Sep 6, 2019 at 3:00 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 05 Sep 2019 08:25:46 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Alistair,
> >
> > On Thu, Sep 5, 2019 at 3:50 AM Alistair Francis <alistair23@gmail.com> wrote:
> >>
> >> On Sat, Aug 31, 2019 at 7:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> >
> >> > As of today, the QEMU 'sifive_u' machine is a special target that does
> >> > not boot the upstream OpenSBI/U-Boot firmware images built for the real
> >> > SiFive HiFive Unleashed board. Hence OpenSBI supports a special platform
> >> > "qemu/sifive_u". For U-Boot, the sifive_fu540_defconfig is referenced
> >> > in the OpenSBI doc as its payload, but that does not boot at all due
> >> > to various issues in current QEMU 'sifive_u' machine codes.
> >> >
> >> > This series aims to improve the emulation fidelity of sifive_u machine,
> >> > so that the upstream OpenSBI, U-Boot and kernel images built for the
> >> > SiFive HiFive Unleashed board can be used out of the box without any
> >> > special hack.
> >> >
> >> > The major changes include:
> >> > - Heterogeneous harts creation supported, so that we can create a CPU
> >> >   that exactly mirrors the real hardware: 1 E51 + 4 U54.
> >> > - Implemented a PRCI model for FU540
> >> > - Implemented an OTP model for FU540, primarily used for storing serial
> >> >   number of the board
> >> > - Fixed GEM support that was seriously broken on sifive_u
> >> > - Synced device tree with upstream Linux kernel on sifive_u
> >> >
> >> > OpenSBI v0.4 image built for sifive/fu540 is included as the default
> >> > bios image for 'sifive_u' machine.
> >> >
> >> > The series is tested against OpenSBI v0.4 image for sifive/fu540
> >> > paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
> >> > and Linux kernel v5.3-rc3 image with the following patch:
> >> >
> >> > macb: Update compatibility string for SiFive FU540-C000 [1]
> >> >
> >> > OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
> >> > Boot Linux 64-bit defconfig image, verified that system console on
> >> > the serial 0 and ping host work pretty well.
> >> >
> >> > An OpenSBI patch [2] was sent to drop the special "qemu/sifive_u" platform
> >> > support in OpenSBI. The original plan was to get the drop patch applied
> >> > after this QEMU series is merged. However after discussion in the OpenSBI
> >> > mailing list, it seems the best option for us is to let OpenSBI continue
> >> > shipping the special "qemu/sifive_u" platform support to work with QEMU
> >> > version <= 4.1 and deprecate the support sometime in the future. A patch
> >> > will need to be sent to OpenSBI mailing list to update its document.
> >> >
> >> > v4 is now rebased on Palmer's QEMU RISC-V repo "for-master" branch.
> >> > Dropped the following v3 patch that was already done by someone else.
> >> > - riscv: sifive_u: Generate an aliases node in the device tree
> >> > - riscv: sifive_u: Support loading initramfs
> >>
> >> I'm having trouble applying this. Do you mind sharing a public git branch?
> >
> > So I see Palmer has rebased his "for-master" branch against QEMU
> > master and now this patch series cannot be applied cleanly.
> >
> > Even worse, the current "for-master" branch has build errors for QEMU RISC-V.
>
> Sorry, I haven't gotten around to fixing up the patch queue for now.  It's
> always OK to just send stuff against Peter's master, particularly if it's a big
> patch set like this, as that's more likely to be a stable base for testing.

I was originally using Peter's branch but later I got to know there
was some patch conflicts between my patch series and what was already
applied in the RISC-V queue. Hence I switched to rebase my series on
"for-master" since v4.

I will rebase my patch series again, and send out a v8 (hopefully the
last version) soon.

Regards,
Bin


Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A360822249
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHs1auKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A360822249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu09-0003U5-K2
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kUtzW-0002ts-Og; Tue, 20 Oct 2020 11:56:02 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:38923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kUtzV-0003hW-7i; Tue, 20 Oct 2020 11:56:02 -0400
Received: by mail-io1-xd43.google.com with SMTP id q9so4149893iow.6;
 Tue, 20 Oct 2020 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=83hd+ye/iHHwjZAPOumzN0PKVfzmhUiqzIB84R3ibc8=;
 b=bHs1auKachxRG9sYeAjFj/onbju1Wd1o5PZ6kzGCY32k3DlPr7PnmaFjoBJSDxxSwt
 xIuhDxem0HETWS0JKLIDXxOoX94WGEWC3HODl7/6+MiYt03OB9ooTzbY6Opk88WzdLJm
 q+IfZKEcQLfC0FePw9rQ+pgyIFO5x/njzYCm5HZTaPiw74SQJ1C9pfKWP93xnN1ruAln
 J7Xxvdaq7Krua98qZxpSM1kxu6j9nqpwcDumEcRgKxqKfzfqFESZeG3V2kGfaHncnE6f
 mEaE7ai8mrTP4y3aRk4uS8572KScpfg5qBn9Woc7RBms7TtK6ysMuXYXz7TMEldF66h5
 EonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=83hd+ye/iHHwjZAPOumzN0PKVfzmhUiqzIB84R3ibc8=;
 b=gYL+4TXhIa3lSF+rFGSxhjcXN8L/s6EM9XRMq1dYiClYC6AzufMpa+C45BxA5VFVSc
 l9fzz7cIaNgssrY3D9BDD3rT6eyiM+g6EKKzuqDXoveTt4u6vCFnXSfomR4L3udz7wtN
 sYCsNqRWOZqr47mUDpnqVoPs9B73teVslPrLQXRGG12lQaK9fBhiGbgE0VLC8Mcl0cLW
 oz0cXAk2i6B0TWhNlB/gaoOb4Ns+wEeRQpfvmXemseQDmW9DdI0qIb4/vojhJEMaTDy4
 3TeTqN3zmIs9X+whfaLUvacj0JvscJh+78oKN6Bj/WbEoRIMQdIix9YHGViDJ0qublA5
 FMBg==
X-Gm-Message-State: AOAM533Y8ywJrMR/evARaWpjtUxfITJaS4yg2eW1TDrdEFqzbee6y3Bc
 C+JgRfEjODZfW30oUQsGD3BCNbVlsoTlG5MCBX0=
X-Google-Smtp-Source: ABdhPJwf5oAM0X3aCa0VD2xj1Aw2lQzsRFZrmwQXu52GmL11T4P9FAZHLEIwxbSfEjW04oGkCRQaykAAh2Cv5AMs394=
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr2602920iof.175.1603209359530; 
 Tue, 20 Oct 2020 08:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602634524.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1602634524.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Oct 2020 08:44:15 -0700
Message-ID: <CAKmqyKPP1y3BcVR9csdWO=63=3Eg68q_6CKgf8B8FNMye-9+VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Allow loading a no MMU kernel
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 5:28 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This series allows loading a noMMU kernel using the -kernel option.
> Currently if using -kernel QEMU assumes you also have firmware and loads
> the kernel at a hardcoded offset. This series changes that so we only
> load the kernel at an offset if a firmware (-bios) was loaded.
>
> This series also adds a function to check if the CPU is 32-bit. This is
> a step towards running 32-bit and 64-bit CPUs on the 64-bit RISC-V build
> by using run time checks instead of compile time checks. We also allow
> the user to sepcify a CPU for the sifive_u machine.
>
> Alistair Francis (4):
>   hw/riscv: sifive_u: Allow specifying the CPU
>   hw/riscv: Return the end address of the loaded firmware
>   hw/riscv: Add a riscv_is_32_bit() function
>   hw/riscv: Load the kernel after the firmware

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  include/hw/riscv/boot.h     | 13 ++++++---
>  include/hw/riscv/sifive_u.h |  1 +
>  hw/riscv/boot.c             | 56 ++++++++++++++++++++++++++-----------
>  hw/riscv/opentitan.c        |  3 +-
>  hw/riscv/sifive_e.c         |  3 +-
>  hw/riscv/sifive_u.c         | 28 ++++++++++++++-----
>  hw/riscv/spike.c            | 11 ++++++--
>  hw/riscv/virt.c             | 11 ++++++--
>  8 files changed, 91 insertions(+), 35 deletions(-)
>
> --
> 2.28.0
>


Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B21C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED877205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGr3W9iH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED877205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYw76-0004wz-Bo
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYw6M-0004W2-Hx; Wed, 13 May 2020 14:27:30 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:37239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jYw6L-0004BU-Id; Wed, 13 May 2020 14:27:30 -0400
Received: by mail-io1-xd42.google.com with SMTP id u11so116639iow.4;
 Wed, 13 May 2020 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nR7TRlGZlczMjxePx9kVhUNZSjisCs5/kvp3RzWY+WE=;
 b=qGr3W9iHugFcL+p3nQS4eGtU/ql5PNU1rdIE32oyCofdJYuAAXPcxXsUExIMFBGunn
 uniavoczhTnEg75am9NmwSMKHh11UU7LGkOPpndv9PnD06Kz7QCgYz9RmCMPxQ7YaIp/
 h6AtPj9ABdg6VpGEkFGD4fsyuuIgxMdw2mlLNaHWMyBO8AJPewC+U8H7CYZXmWuMeOsV
 JkOcxnfV38HQajpygwl3t0VmJ8oALAJoivlwBxJr8VV53SwiKLmi9LbuC1MB4oawl3yD
 JoPyO9iJMznaj6we9FmLUeECCEXt8CuWBaiT5vkV1kMhb2TLS9aYNmBIS+X2BOT13F2/
 NNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nR7TRlGZlczMjxePx9kVhUNZSjisCs5/kvp3RzWY+WE=;
 b=NHrBc8fpEWetB0WCLzGZamTGVFSHFALiPbhNdagetZyvzbplYPUaSuXkB+6CFObyYe
 UvCMwh1bK6sAMYxWQLciVJqoXfiNm9gOqWSReLpxlpVuVZhh53CHcX2fOCai3FmhZI0H
 jdjxd3fGXvnOhqVHSwG3AZLTFohfbXkYh1qBdbcbTfP7kch/XU4KQ8FeewLC5Jm/iJ/j
 bkhhI4BFMBxqutyLFau4j2513+/zy4YBJCYSXllLYoUpx/95A+rQeUX/MHRaBbQIxJEv
 fnRNCkLT4RbdJcZWUQqBgip4IjizEYXbHDQO9Q1PszAv2uMdIV/j709GO2trXlXGHbDt
 hV4g==
X-Gm-Message-State: AGi0PuY0/1BLu7a4NGVEqB4HPpUzqR5IbDyZDDPPti7cZxIhLX9CWs/t
 FEEdGt46UQ9QaQGRYzdFkASiWgJVgNr1LOmPufg=
X-Google-Smtp-Source: APiQypKVjBczwQNkp2UndcF5QIZapeVDIunMaBx8KEupdg3trjJkKbjzibAYd6ksv2gwkoWaHO7xor/Zsw+p01ttEz8=
X-Received: by 2002:a02:a887:: with SMTP id l7mr786093jam.91.1589394447638;
 Wed, 13 May 2020 11:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588878756.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1588878756.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2020 11:18:41 -0700
Message-ID: <CAKmqyKNaVRi3u6qe4Obui5NktjemZYHFEbNz6PmsYk+Kf=hOfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] RISC-V Add the OpenTitan Machine
To: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 12:21 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> OpenTitan is an open source silicon Root of Trust (RoT) project. This
> series adds initial support for the OpenTitan machine to QEMU.
>
> This series add the Ibex CPU to the QEMU RISC-V target. It then adds the
> OpenTitan machine, the Ibex UART and the Ibex PLIC.
>
> The UART has been tested sending and receiving data.
>
> With this series QEMU can boot the OpenTitan ROM, Tock OS and a Tock
> userspace app.
>
> The Ibex PLIC is similar to the RISC-V PLIC (and is based on the QEMU
> implementation) with some differences. The hope is that the Ibex PLIC
> will converge to follow the RISC-V spec. As that happens I want to
> update the QEMU Ibex PLIC and hopefully eventually replace the current
> PLIC as the implementation is a little overlay complex.
>
> For more details on OpenTitan, see here: https://docs.opentitan.org/

Ping!

+ Some people who might be able to review this series (or at least ack).

I'll give it another week and if I don't hear anything I'll merge it.

Alistair

>
> v2:
>  - Rebase on master
>  - Get uart receive working
>
> Alistair Francis (9):
>   riscv/boot: Add a missing header include
>   target/riscv: Don't overwrite the reset vector
>   target/riscv: Add the lowRISC Ibex CPU
>   riscv: Initial commit of OpenTitan machine
>   hw/char: Initial commit of Ibex UART
>   hw/intc: Initial commit of lowRISC Ibex PLIC
>   riscv/opentitan: Connect the PLIC device
>   riscv/opentitan: Connect the UART device
>   target/riscv: Use a smaller guess size for no-MMU PMP
>
>  MAINTAINERS                         |  14 +
>  default-configs/riscv32-softmmu.mak |   1 +
>  default-configs/riscv64-softmmu.mak |  11 +-
>  hw/char/Makefile.objs               |   1 +
>  hw/char/ibex_uart.c                 | 490 ++++++++++++++++++++++++++++
>  hw/intc/Makefile.objs               |   1 +
>  hw/intc/ibex_plic.c                 | 261 +++++++++++++++
>  hw/riscv/Kconfig                    |   9 +
>  hw/riscv/Makefile.objs              |   1 +
>  hw/riscv/opentitan.c                | 204 ++++++++++++
>  include/hw/char/ibex_uart.h         | 110 +++++++
>  include/hw/intc/ibex_plic.h         |  63 ++++
>  include/hw/riscv/boot.h             |   1 +
>  include/hw/riscv/opentitan.h        |  79 +++++
>  target/riscv/cpu.c                  |  30 +-
>  target/riscv/cpu.h                  |   1 +
>  target/riscv/pmp.c                  |  19 +-
>  17 files changed, 1281 insertions(+), 15 deletions(-)
>  create mode 100644 hw/char/ibex_uart.c
>  create mode 100644 hw/intc/ibex_plic.c
>  create mode 100644 hw/riscv/opentitan.c
>  create mode 100644 include/hw/char/ibex_uart.h
>  create mode 100644 include/hw/intc/ibex_plic.h
>  create mode 100644 include/hw/riscv/opentitan.h
>
> --
> 2.26.2
>


Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8887BC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535F421537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535F421537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklbO-0003dl-K5
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hklaq-00036C-2z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hklao-0005Jg-Cu
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:35:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hklao-0005Fc-5V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:35:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so18687602ljh.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 01:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=GYMbqe1dcstlszXv15EOGlB7KmvBfKwbQYnSClGpi8g=;
 b=p1yekn3/FnD2omhcuhT2peCJ4ldSP1JyGD3c/imneqBZSlshL3eysKXYUHTRh4529J
 a9YZRF6Kmc/civ5Bz0ngNLu49zHjLO+fpqMFx1Rj0gLCObL/1+vqVXtErEC74kq0kxTi
 757iQvvbC4oe24JGj1Tdq/YGEUYqtus/O72jc/bn4zFgtgf7qohxztjGYqv81wyQnAP5
 j7BOWNb0d/jnqVJND3U2peUgkfHcbKfgh4L6UwZs8diuO681LcrQstEx4t+Jmtwgn6bt
 Rax3mF2mvN79+a+bu/RS+Jey3+Ix1g2QddF1eyV10KByy6VyHreq363B93+AktJYT7Ah
 RGIA==
X-Gm-Message-State: APjAAAUPipVwiLXb98XDaYu9OUydTD34i2M/HfsAbu0ywKH65K1yxvVK
 GI3sbcU6wqSLQumnrN54eYa1ddkxDrZ6udgP
X-Google-Smtp-Source: APXvYqwDImJ+dHC3VPo4FUQ0PYlVNv+jScFOB00nbpJUWs1+6PxVulCNLRrp/lZnmk8d+UtpBMuSVA==
X-Received: by 2002:a2e:a311:: with SMTP id l17mr12676218lje.214.1562661311753; 
 Tue, 09 Jul 2019 01:35:11 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id t1sm2382704lji.52.2019.07.09.01.35.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 01:35:11 -0700 (PDT)
Date: Tue, 09 Jul 2019 01:35:11 -0700 (PDT)
X-Google-Original-Date: Tue, 09 Jul 2019 01:35:06 PDT (-0700)
In-Reply-To: <cover.1562611535.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-2211c89e-80c2-45d7-a471-ec0c30d871a4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
Subject: Re: [Qemu-devel] [PATCH v1 0/2]  RISC-V: Add default OpenSBI ROM
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 codyprime@gmail.com, anup@brainfault.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, stefanha@redhat.com,
 pbonzini@redhat.com, alistair23@gmail.com, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 08 Jul 2019 11:49:35 PDT (-0700), Alistair Francis wrote:
> This series includes the OpenSBI firmware for QEMU RISC-V users.
>
> To avoid breakages we have not changed the default behaviour of QEMU.
> The plan is to change the default though, which is why an entry to the
> qemu-deprecated.texi file has been added as well as a new warning.
>
> After this series QEMU 4.1 has three options:
>  1. ``-bios none`` - This is the current default behavior if no -bios option
>       is included. QEMU will not automatically load any firmware. It is up
>       to the user to load all the images they need.
>  2. ``-bios default`` - In a future QEMU release this will become the default
>       behaviour if no -bios option is specified. This option will load the
>       default OpenSBI firmware automatically. The firmware is included with
>       the QEMU release and no user interaction is required. All a user needs
>       to do is specify the kernel they want to boot with the -kernel option
>  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
>
> All users should transition to using a -bios option. We can start
> updating all documentation after the release of 4.1.

I haven't looked at the code yet, but as the last one was fine it's probably
OK.  My only issue here is the timing: it's after the soft freeze so if I
understand correctly we're not supposed to take any new features into 4.1.
That's kind of unfortunate because it's somewhat unobtrusive and super useful.

Peter: would you be OK taking this some time later this week?  I'd want to dig
through it and then bang on it a bit first.  If not then I'll queue it up for
4.2.

> At the end of this series and the transition period we are in the good
> place of no longer requiring users to build firmware to boot a kernel.
> Instead users can just run QEMU with the -kernel option and everything
> will work. They can also override the firmware with their own using
> the -bios option. Using "-bios none" will result in no firmware being
> loaded (as it is today).
>
> This is based on my original series adding OpenSBI support but now has
> improved documentation changes around the license.
>
> Alistair Francis (2):
>   roms: Add OpenSBI version 0.4
>   hw/riscv: Load OpenSBI as the default firmware
>
>  .gitmodules                                  |   3 ++
>  LICENSE                                      |  21 +++++---
>  Makefile                                     |   5 +-
>  hw/riscv/boot.c                              |  49 +++++++++++++++++++
>  hw/riscv/sifive_u.c                          |   7 +--
>  hw/riscv/virt.c                              |  11 +++--
>  include/hw/riscv/boot.h                      |   3 ++
>  pc-bios/README                               |  11 +++++
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 36888 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 40968 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 40968 bytes
>  qemu-deprecated.texi                         |  20 ++++++++
>  roms/Makefile                                |  48 +++++++++++++-----
>  roms/opensbi                                 |   1 +
>  14 files changed, 152 insertions(+), 27 deletions(-)
>  create mode 100755 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100755 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  create mode 100755 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>  create mode 160000 roms/opensbi


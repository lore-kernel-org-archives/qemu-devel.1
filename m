Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED175C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F56C22210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Aiif18oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F56C22210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSugh-0007Xo-0y
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSufX-0006P3-5T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:15:11 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSufU-0006qc-Pm
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:15:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id l18so1067726pgg.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=qTpg86XwYkoZwo9xPoVFJvjhqmsdJhqPplgwGdxOEHc=;
 b=Aiif18oGWsbS5Qy3D3HrW09KQexkggcyDhfFcmRC5522UNnUfClclW5J1R/+9333Qe
 2NyuyPRlEGgSOlHlSip1KYQJNENQCuf9jrt8cmv6Sc4MMouuSa/3Bu8d545h98O0BA1h
 qt7mZFgikOQe+X4WJsXvXiGFa7NfXxCNvEDprK27t9EzR4UoYf4maEDODuxVlvyUdssp
 aZ6R1bSNsZsmvkXxKqlMCFC3XxsLshr/ur9p5oZG0mLWB+OhsbQsfr4UyhJwyrNrseNu
 aDyna7BOH1KFUHHfhmI5EHiAPU5vFS/vhSHIRuASt6bmYadOQvPxxg7qPMl6tAGVZQqN
 fAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=qTpg86XwYkoZwo9xPoVFJvjhqmsdJhqPplgwGdxOEHc=;
 b=XRlVhAPgn132XCDkWezP8LLbn9ifgOB74NeTjKoAhRLAFKxJpYqHSwpchSvcPXQhjg
 ITmHmRPn9UKSKPLFn7fALhSRdKKH3aCM3zmxSS6CtxppWOwkuM/Sls4stUyCT84MDbQc
 KqovNroQLbTQEIvces41V7Q8I+Y9ArhSIkZEAD9ygwGNCn8oC9G1A8ocT67rpKyHGAmW
 PbrPTZSAC5HHX79Y8MqeOAiZR8LnUNX690QMTq6Pij5qUYfzV9leAcMnJrRgWxSiZ8vL
 x0LFJ1dP5GFse+m7dw2Er7oP7JVw2qH8um0QZDtiSjGLoNyd1TVCsP7mU4fOWpm7jXE3
 GiPw==
X-Gm-Message-State: AOAM533I73xm85csIJO7VxxxhEd68evmZK+MoAGYDAiYeJW2d+LAsB6z
 mDzxp+x6F34loctUQ5yDgRsECvyscaK2nBHq
X-Google-Smtp-Source: ABdhPJxEPqhXYiJADdMsX3h9wPx6b+jadOllUbsxJ02lKc9geFKjtxi72hpcG8G+l38LY7N8z0KIqQ==
X-Received: by 2002:a63:5d07:: with SMTP id r7mr1857785pgb.440.1602735306969; 
 Wed, 14 Oct 2020 21:15:06 -0700 (PDT)
Received: from localhost.localdomain (111-241-103-134.dynamic-ip.hinet.net.
 [111.241.103.134])
 by smtp.gmail.com with ESMTPSA id gd14sm1250191pjb.31.2020.10.14.21.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:15:06 -0700 (PDT)
From: Green Wan <green.wan@sifive.com>
To: 
Subject: [RFC PATCH v7 0/2] Add file-backed and write-once features to OTP
Date: Thu, 15 Oct 2020 12:14:22 +0800
Message-Id: <20201015041424.23090-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=green.wan@sifive.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, green.wan@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

patch [1/2] - add write function and wrire-once feature
patch [2/2] - add file backend support

Test Steps: (should work even only 1/2 is applied)
 1) Follow instructions to prepare fw_payload - https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md
    a) build 1-round opensbi
       $ cd opensbi
       $ OBJCOPY=riscv64-buildroot-linux-gnu-objcopy \
       LD=riscv64-buildroot-linux-gnu-ld \
       CC=riscv64-buildroot-linux-gnu-gcc \
       make PLATFORM=sifive/fu540
    b) build u-boot
       # Make sure the 'CONFIG_SIFIVE_OTP=y' is set
       $ cd u-boot
       $ OPENSBI=/xxx/opensbi/build/platform/sifive/fu540/firmware/fw_dynamic.bin \
       ARCH=riscv \
       CROSS_COMPILE=riscv64-buildroot-linux-gnu- \
       make
    c) generate fw_payload.elf
       $ cd opensbi
       $ OBJCOPY=riscv64-buildroot-linux-gnu-objcopy \
       LD=riscv64-buildroot-linux-gnu-ld \
       CC=riscv64-buildroot-linux-gnu-gcc \
       make PLATFORM=sifive/fu540 FW_PAYLOAD_PATH=/xxx/u-boot/u-boot.bin
 2) Apply uboot test patch - http://patchwork.ozlabs.org/project/uboot/patch/1602657292-82815-1-git-send-email-bmeng.cn@gmail.com/
    Rebuild u-boot and fw_payload.elf
 3) Generate empty otp image. (skip this if only 1/2 is applied.)
    $ dd if=/dev/zero of=./otp.img bs=1k count=16
 4) run qemu with fw_payload.elf
    $ qemu-system-riscv64 -M sifive_u -m 256M -nographic -bios none \
      -kernel ../opensbi/build/platform/sifive/fu540/firmware/fw_payload.elf \
      -d guest_errors -drive if=none,format=raw,file=otp.img 
 5) (uboot otp driver should do some read/write already) Run read/write in u-boot

# dump mem before test
=> md 80200000 10
80200000: 84ae822a 00061297 7642b283 10529073    *.........Bvs.R.
80200010: 10401073 031b52c1 13134010 71330153    s.@..R...@..S.3q
80200020: 850a0053 28c0b0ef 812a81aa 00062297    S......(..*.."..
80200030: 94c2b283 a92f4905 16630862 22970209    .....I/.b.c...."
=> md 80400000 10
80400000: 00000000 00000000 00000000 00000000    ................
80400010: 00000000 00000000 00000000 00000000    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................

# check read function and see if serial is set
=> misc read  otp@10070000 3f0 80400000 10
=> md 80400000 10
80400000: 00000001 fffffffe 00000000 00000000    ................
80400010: 00000000 00000000 00000000 00000000    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................

# check write function
=> misc write otp@10070000 0 80200000 10
=> misc read  otp@10070000 0 80400000 10
=> md 80400000 10
80400000: 84ae822a 00061297 7642b283 10529073    *.........Bvs.R.
80400010: 00000000 00000000 00000000 00000000    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................
=>

Changelogs:
v6 to v7:
 - Fix bug in MACRO, SET_FUSEARRAY_BIT.
 - Add serial initialization in sifive_u_otp_reset().
 - revise write-once error message.

v5 to v6:
 - Rebase to latest. (sifive_u_otp.* are moved to hw/misc)
 - Put the example command to commit message.
 - Refine errp handle when check backend drive.
 - Remove unnecessary debug message.

v4 to v5:
 - Change the patch order
 - Add write operation to update pdin to fuse[] bit by bit 
 - Fix wrong protection for offset 0x0~0x38
 - Add SIFIVE_U_OTP_PWE_EN definition
 - Refine access macro for fuse[] and fuse_wo[]

Summary of Patches 
 - First patch is to add write opertion to update pdin data to fuse[] bit
   by bit. Add 'write-once' feature to block second write to same bit of
   the OTP memory.

 - Second patch is to add file-backed implementation to allow users to use
   '-drive' to assign an OTP raw image file. OTP image file must be bigger
   than 16K.

       For example, '-drive if=none,format=raw,file=otp.img'

Testing
 - Tested on sifive_u for both qemu and u-boot.

Green Wan (2):
  hw/misc/sifive_u_otp: Add write function and write-once protection
  hw/misc/sifive_u_otp: Add backend drive support

 hw/misc/sifive_u_otp.c         | 95 +++++++++++++++++++++++++++++++++-
 include/hw/misc/sifive_u_otp.h |  5 ++
 2 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.17.1



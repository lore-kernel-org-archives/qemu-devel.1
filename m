Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D860C3A5A8
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6962A22CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 02:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6jOqQo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6962A22CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4G5g-0004rv-Sz
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 22:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzc-0007aS-Ga
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzb-0006Iw-8F
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzb-0006HW-1T; Sat, 31 Aug 2019 22:53:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id l21so5497546pgm.3;
 Sat, 31 Aug 2019 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=xlgH8lN38PwpSGAUVEbYDnXmkbyjLfnSXA45vjpEO5E=;
 b=C6jOqQo02nQ63Ai4BrWEMgaZAT/wKv6D1flF4MpgkW36u3B2BMk5rDBql3Mlcrpewc
 j6aJhsTLlvMTNJD2Y1fzzZJm8JBimvvPQe79SRGHrhpLv6ks767OUjf8Bgk+xA+j1zgE
 Mkr6A3acQl0chAHfMo1XKN3Y2a3SDG/wI+PYewpTz0V8a9R9FzUpCT6m2JRkVPo9WSBQ
 82xmc88fpkvMvUddkJynZB4Dg73DzP3X2tBvcJa3YkQrZiwzKJUpJCjzIrsAwBI0Xu8l
 VAqQwYVh9MnteFv4Ym9lPgFytZnd+/UoFL+CkA5tal8Tgxtz0pLDgXAvJbiVQw79oy8N
 JquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=xlgH8lN38PwpSGAUVEbYDnXmkbyjLfnSXA45vjpEO5E=;
 b=XcCYN5FQj/dzm4TMMs6v/sVc8pIhp5yaA9BznWymiObVZSlyhxxhcpDY5PsaHk9rBv
 4Gxx8EzgIx+6u88kCP4c7n2DyaORE9Pfvc8htS5FB4f4/0+u9+Z4FWfBmVVp76E6aBTD
 gn8sH8gaufMyD1bRx3ZE7eqmYUyVtzDX2/f76AMRdaEmVX6ETL9k2OG6WHwJPzDmgNeb
 /1fLECID9RffgmPPKnfPzJFuxZ7bvTA+Gdl2yT0VxjO+ZOp4IrFeOHarR+MSlNd32Yhi
 RPfGAWnwt3wgi+d9bPuCgvNCZuwnQoA21/NJhEmgvEp6MGE4nBv904lX/lNN0FH57fXN
 14LA==
X-Gm-Message-State: APjAAAUH3IETUwWcJnk6wPli2Aq7GG5pUxBTrI6YRShIzzzQr9oFX1lI
 mO8ey1o3gdbqImrKXM1vHKY=
X-Google-Smtp-Source: APXvYqznUefm6O8r8C5nE3acqpcVTIBNzeH9cWD8ZSefTVCcgw1ph6k7qfKOGaWxsLulDxnpkF1yPA==
X-Received: by 2002:a62:174a:: with SMTP id 71mr28097382pfx.140.1567306406309; 
 Sat, 31 Aug 2019 19:53:26 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.25
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:25 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:48 -0700
Message-Id: <1567306391-2682-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v7 07/30] riscv: roms: Remove executable
 attribute of opensbi images
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like other binary files, the executable attribute of opensbi images
should not be set.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4:
- new patch to remove executable attribute of opensbi images

Changes in v3: None
Changes in v2: None

 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 3 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
old mode 100755
new mode 100644
diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi-riscv64-virt-fw_jump.bin
old mode 100755
new mode 100644
-- 
2.7.4



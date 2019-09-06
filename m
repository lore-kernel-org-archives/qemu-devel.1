Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0093C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCCF20838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je/401ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCCF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HV0-0000sr-No
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyp-0004mW-R3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Gyk-0004Yk-Od
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6Gyk-0004Y5-7H; Fri, 06 Sep 2019 12:20:54 -0400
Received: by mail-pl1-x644.google.com with SMTP id y10so3370845pll.7;
 Fri, 06 Sep 2019 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=nzgrwemY2DbkainTePGLmyPcHgmtN7jUCJ7FG5Hsw+M=;
 b=Je/401ld5oblMsFNx9uXXQH72uJanSzv6N8PeYN454DU47+lx7dhIhZcIQGXWR/mpO
 4O5idqpeRd1nYvNEPSUpVQ9+LaEaY92CBuE1aOaILLGpF1tP0l/iesfBBgi0tLuMWvUc
 a2sU9VqtHia2S02CvFK9govUcznUGGLy/mTXFSQA996pubdNlrZHbcZym2Ym88SDVdoC
 VBtC17eAv4PqJf2YH3VWZL79atxXXg4RwNLYNe5hDkQnpKDN8Pdo2TgFMssz9NK46DhL
 GALlxoyEHvIrlIEqhbUu6kEnAknGGVFyb4MjFXrV6Ezetw3rpj56YMcziWxK/mh77/fi
 nRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=nzgrwemY2DbkainTePGLmyPcHgmtN7jUCJ7FG5Hsw+M=;
 b=c5RAl558Zrgz7a9eeNkZAEuG9k6wkXyYH3oU9CrAUjhCu2iASMteXFJ2Wyh5LX7Mxb
 arviY9/UdPLbB2FmAYIkqCyQMx5rgYS+uu7/YNGmwW2Ey5sZLC7iTu6Fqy8boxl50mus
 S1rRsPLnji24j/Ps1InfgJJtNx3PnQFAsAF8qr2Ws9lIIs3PqcUYB4g+QIzLepHGPjMo
 Wg2HKYCRd/qdTIvFx55PzoCX3Q466wggY/VSO5LOousbqdG+C+QgBS5LahSBNv86OdpR
 RHynvViXOiWcsmLEFIXjPANfGwmXQNtTFfdHO3pYIjlHbpPS8k0OFe7ZlDEpbYqL6AhO
 TOJQ==
X-Gm-Message-State: APjAAAVqTsUA+UH+rKCMB2XxWR3fcWN+e0/jEpxs4ElYSMXYeJxabDDf
 eF/ffsUSa5xKtA06ru3hKuQ=
X-Google-Smtp-Source: APXvYqzzYW2kTjripOLgM1Qj8rvfD79AdQpSeZelMPJDvBkBog2amQkpf9naPL4s03pOl6ojAqyybg==
X-Received: by 2002:a17:902:7008:: with SMTP id
 y8mr4191276plk.176.1567786852830; 
 Fri, 06 Sep 2019 09:20:52 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.51
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:14 -0700
Message-Id: <1567786819-22142-28-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 27/32] riscv: roms: Update default bios for
 sifive_u machine
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

With the support of heterogeneous harts and PRCI model, it's now
possible to use the OpenSBI image (PLATFORM=sifive/fu540) built
for the real hardware.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 40968 -> 45064 bytes
 roms/Makefile                                |   4 ++--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
index 5d7a1ef6818994bac4a36818ad36043b592ce309..eb22aefdfb468cfe2804cb4b0bc422d8ebcae93b 100644
GIT binary patch
delta 10830
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

delta 5317
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

diff --git a/roms/Makefile b/roms/Makefile
index 775c963..6cf07d3 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -182,8 +182,8 @@ opensbi64-virt:
 opensbi64-sifive_u:
 	$(MAKE) -C opensbi \
 		CROSS_COMPILE=$(riscv64_cross_prefix) \
-		PLATFORM="qemu/sifive_u"
-	cp opensbi/build/platform/qemu/sifive_u/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+		PLATFORM="sifive/fu540"
+	cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
-- 
2.7.4



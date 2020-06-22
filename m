Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC717C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CE82078E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B45PiL5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CE82078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnG3I-0008SU-U3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1U-0006RS-Kc; Mon, 22 Jun 2020 02:33:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jnG1R-0007uD-Q1; Mon, 22 Jun 2020 02:33:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so3624780wrw.5;
 Sun, 21 Jun 2020 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6N1jZ1+6HSSEfbc/nt6q5ecEC/Qcja+N9BUymVZyGyo=;
 b=B45PiL5Q5pvMakAzx/6cvQYbj15+y5W6pjVphLYSz+3erY68io+KkzvY9y261Cf8Xk
 UQrphtUVhNWr5H7a8CR4sb+13K+dlrzTiGrvlO8a5vFJVnrhUJqqUsIoEabEEQQxXK3P
 /B1Y3SI6LmrEPvgHVDzZYVo2uBImBvGM/wup2z5Vjul+n6zBngxw8FB6wM0pnKDn95oy
 RqNA9c+JI4nSdKflA4b9JYegYTpA0aELXf5qTJprbCilAFrfqB6j2Pgeu1Dbyn2hZsmp
 qEcuN80S9RsJimrTwwB/LKQLOGbbpeF/fB9LdVwbF8BeGPbGkMbZnL6tIblKTAKCInnl
 z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6N1jZ1+6HSSEfbc/nt6q5ecEC/Qcja+N9BUymVZyGyo=;
 b=qYkxjjcoSwtfY5H2/hNeNMU0gjZKRsI4vjxhT1XdNHZdtJpCFUJn4pJ8ssCQOBe0Cj
 rpsPenx6ktBVhPOlGKbz6u9FTka0Wg3Sw8FeaPQe1plSMzQfhjPUf/xLWGGVtKY1qlIA
 NB41/1BnUg/pdq+O+/kHnXwh/oxWBBzTaoEdzaa9oRmbHQukprEjaD8FZ5/ZE0m/n8wE
 jUNmjS32agVAnMwg5K7Mf4eY32NHbgdDfKzfWxX154snoGonB4r81UPReT3y0/RUFOEF
 IJAVid6YQRwz9kmME+gQPN2VmeadC5iYjPuCIQU66hVqHxf/54SOaNGeKBS6uUBxFfiG
 nJ5g==
X-Gm-Message-State: AOAM531A55tCk0HM0+VPzESniULONWrTnphMV296kk5J1z7gA3dobXQ4
 Ieg/omUWYDEn3iHjiG66ke4=
X-Google-Smtp-Source: ABdhPJykUFhAByiso6aoz8U476t9+5VPw3jxDjrWYnvWK+Z3gfMWsVHh+5Ivj8C7di/NGz1DrBiujg==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr17505899wrv.106.1592807615974; 
 Sun, 21 Jun 2020 23:33:35 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id a10sm16684240wrm.21.2020.06.21.23.33.33
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 21 Jun 2020 23:33:35 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 1/7] configure: Create symbolic links for pc-bios/*.elf
 files
Date: Sun, 21 Jun 2020 23:33:18 -0700
Message-Id: <1592807604-20805-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
References: <1592807604-20805-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now we need to ship the OpenSBI fw_jump.elf image for the
RISC-V Spike machine, it requires us to create symbolic
links for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- new patch: configure: Create symbolic links for pc-bios/*.elf files

 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index ba88fd1..4a1514a 100755
--- a/configure
+++ b/configure
@@ -8399,6 +8399,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.7.4



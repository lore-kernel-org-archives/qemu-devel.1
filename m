Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52251C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5A32073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGRkpYex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5A32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrCG7-0004rU-Bg
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 23:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDX-00080B-00; Thu, 02 Jul 2020 23:18:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDV-0005zD-Gu; Thu, 02 Jul 2020 23:18:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id 207so13206906pfu.3;
 Thu, 02 Jul 2020 20:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mYGOqQs+HqwCvvR4hOJZAekFvpPNdREJOjr+cZasMEE=;
 b=PGRkpYexEiqDwFIRhDpwxjs+WSX0N/TICe/qAOBOQb+d9kcxXazQLToA33WXchAslc
 tGLhmBh6R4M+Qbyne8PBdRmAIHbxdJBOT1aDXWVtlqN7EEfZ4KVI3NkYSFCtNM9JInfb
 3lMs+HHnGr7LGhbr0S2gLzaih0pySJ8Mcto/YoCPSUvRzUjpA8gevh+benExlD0HIYUc
 axy8UJtamGVExX/l8JaOQsHXpBG1Bj1bh7k9Js7DFq8/pXkI7waXumcK+GYbDrao52+4
 BIZ7PSBnWaMrSFA8nuGCT/mEYWXMTXI/DJFylruGx/bot0IxLnAU1H0XqDRuIPDRZN/S
 GboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mYGOqQs+HqwCvvR4hOJZAekFvpPNdREJOjr+cZasMEE=;
 b=DMV2pe92akFicLf+wO2KddYRmqF58Y2V8KIobt0Rku/TpZUQNsIXpFm6bbSqTEaSpu
 ew2fjBRiGf7vSI1aH1Is4gXBiCzAAES/sTWrnbs87zkJhyZJkc3Ug6oSjxIaehmmA5RE
 ycZ/c/v8LfXF82P4pBQKDV2bYWIU615wIkKDEceiBHuZJ/Z3vSIHc202Ejzn2R4ghM/v
 G4OqoK5fmSzE7RgoaKo5SgN9bZTUIV/M+W8mYZpGl1DlPgUw3bwHKi5EV1LHhCWnkZ35
 BvBT/695UoWpgjtfyPrq4IVJRf90znJ/5iCs5tTDGYFke8xtkdTC/wDZm4V751DtB+E0
 8Oew==
X-Gm-Message-State: AOAM533Teg41rcDzx4v8c9AAz7oN3sdeu1LeROveCvyCZ3wiDQdzX1Ng
 53NbrAaifreROIGngKzQDsI=
X-Google-Smtp-Source: ABdhPJzuGq9x8ki6jLo3TtgkdBjp5R8VCilf27PhVkUNc+D405FjebWKVO7ZyA22aoV3Bi3buIwLbA==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr27500224pgn.431.1593746299788; 
 Thu, 02 Jul 2020 20:18:19 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id c12sm10165745pfn.162.2020.07.02.20.18.19
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 02 Jul 2020 20:18:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 7/7] Makefile: Ship the generic platform bios images for
 RISC-V
Date: Thu,  2 Jul 2020 20:18:07 -0700
Message-Id: <1593746287-19251-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
References: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x443.google.com
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

Update the install blob list to include the generic platform
fw_dynamic bios images.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v3:
- change fw_jump to fw_dynamic in the Makefile

Changes in v2:
- new patch: Makefile: Ship the generic platform bios images for RISC-V

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b1b8a5a..05e05bb 100644
--- a/Makefile
+++ b/Makefile
@@ -841,8 +841,8 @@ u-boot.e500 u-boot-sam460-20100605.bin \
 qemu_vga.ndrv \
 edk2-licenses.txt \
 hppa-firmware.img \
-opensbi-riscv32-sifive_u-fw_jump.bin opensbi-riscv32-virt-fw_jump.bin \
-opensbi-riscv64-sifive_u-fw_jump.bin opensbi-riscv64-virt-fw_jump.bin
+opensbi-riscv32-generic-fw_dynamic.bin opensbi-riscv32-generic-fw_dynamic.elf \
+opensbi-riscv64-generic-fw_dynamic.bin opensbi-riscv64-generic-fw_dynamic.elf
 
 
 DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
-- 
2.7.4



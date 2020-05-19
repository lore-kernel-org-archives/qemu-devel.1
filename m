Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A458C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF2320C09
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QPIEfPst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF2320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9zF-0006eK-85
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yH-0004Ya-Gt; Tue, 19 May 2020 17:40:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=401675184=alistair.francis@wdc.com>)
 id 1jb9yF-0008RH-PW; Tue, 19 May 2020 17:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589924442; x=1621460442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ABL5sMkVashheNLr/yNOfkXjgnG3gvdYDtNCa+XUzOo=;
 b=QPIEfPste6HLTN7ky0TC0LECZey8y59UV+b8Rp/ZgjunJcMgEs0SsF2a
 1GeN+Wq8Ne5sRhP02TSv7a6Tpu6Ak3wl+PAgQ8m3Ozzb3jiJtZHQk93hd
 jG5eAJOlJFAugSSH02qVcqT6Cjuu0nW2ByntnGO7j4wAIMU3QlCOayk9S
 Sh7ohA53TSPRHrptpERi3NQL3uIbMQ8/4GPkhb6GmNTBhQuduw6Muhj38
 0472PyrKbDdbtECHfTrCSLQiGU/P3wlTNXwJcx5cuZQ/a0x41kIIThG3p
 GxUzyJxoxr1MhLUzQXkNQ+TMEQAhQUu608b5/HfYK7hlhT0LBzsTYCtMz w==;
IronPort-SDR: agD/Qi7Os+qtBQFKL/tiIKViALnqHeD8kNS+UJHzIYi+uboqMd0XiDJsA1FDpWYcFoDWAxoUZo
 3Xumu4VobM4N17JTxPW3YPhjZ9xvkKO7oOo3/MOGhhqWefGqEwyFFd2SSH2NGMtSHyeAr2FHsg
 VNf1KI6ygo+ZhY28jaDlVtKzyK8593eoiOZCLb0uREi0zCZ2KpIhH3pUv7FjmrZLdRTPXGOKQv
 4WRFwh8bV3jFlQfV1tYts6NjTGf4CgGMwR5ybG/m0Tas5mOUJIVZ/YQtfjvQe/ji/M85TNNZTR
 Ni0=
X-IronPort-AV: E=Sophos;i="5.73,411,1583164800"; d="scan'208";a="240814187"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2020 05:40:07 +0800
IronPort-SDR: 4jAx0ku76JW+QtRcYKimel4e7BeaSloQ9/si4vaxfIM0Vg4Afd7nFmhhp1cCd6TH3ZYOJVLJWJ
 19ZdU9+AvO+ShDMFFGYmDdkmlSGAqLRbw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 14:29:27 -0700
IronPort-SDR: 0C8FBXr6DK6GbGzutikX0W/p9ifNC+E0Ns9zM0gh4PhHem5WBnjd/cCjEi1GWDXXjQVgt6uSDV
 IDm2Mdcfvqkw==
WDCIronportException: Internal
Received: from usa005149.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 May 2020 14:39:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 2/9] target/riscv: Don't overwrite the reset vector
Date: Tue, 19 May 2020 14:31:29 -0700
Message-Id: <8ad7eb9be23b7483797f82d58742100ca40bf0b7.1589923785.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589923785.git.alistair.francis@wdc.com>
References: <cover.1589923785.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=401675184=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:39:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The reset vector is set in the init function don't set it again in
realize.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c7..5eb3c02735 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -133,6 +133,7 @@ static void riscv_base32_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
+    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -180,6 +181,7 @@ static void riscv_base64_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
     set_misa(env, 0);
+    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
@@ -399,7 +401,6 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
-    set_resetvec(env, DEFAULT_RSTVEC);
 
     if (cpu->cfg.mmu) {
         set_feature(env, RISCV_FEATURE_MMU);
-- 
2.26.2



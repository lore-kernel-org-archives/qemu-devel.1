Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B4C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE542192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q5s2JV+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE542192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzsh-0008JF-4U
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFW-0002b5-4l; Fri, 23 Oct 2020 11:45:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFU-0003hs-6n; Fri, 23 Oct 2020 11:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467900; x=1635003900;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YLxMCvSaaacd6zqMTliOHR4YoYXTbdCac9rZmNQyna4=;
 b=Q5s2JV+hJYkR1Inud8/AEWGSVLYlt6a4SOTUs5nvYeh9h7Wlyo8+8hph
 kOUgtSt4Qd9bAtVxRme7B1T1DMaOipKJ/cZNFn8NnNxctyTD9Sk3rlySY
 hEmx9qPh/pMk6+NIUGXWXlll3hi2E9ooTjk4S6wk2WLkpVjyuQn25hc5y
 DGwurvS2QkJliq+Ak51O4W+DaXtPtrqz3pmCFwxKoftpJGWz7u7mRP+pz
 gm+xaCVkAwJiV7HApmL5yUD7j082vvGhYsY2nxZZKLvbraIJwWGMPnlnD
 cvVOZihUrdoO7kirK1aTs8od3xAnZqLBCODxin5E5BgFwrDVgCFyJ2/ud Q==;
IronPort-SDR: QFL1dtSfIIgvrJ+MklPugQBENVwwe+lT2J96oLGBTDcOV8F7A4o4kPX1/WwZVmyoNPDwYMtRr4
 otd0p1WqNPDyiqcPhCQo9GeagQs7+S/m1eOi49PuInLmuX77ZWeZYjVNoyLolCWpU7QwpHmCIQ
 7J0t+dgoL0tgyHMUjBc2VG2KE2218V2uJBx9bnju/IJo3jak6vR7wIbtKtNs26iaBrdSD99gOc
 60ssCtXcIJ7oEIwyf7cJIMCwsrU0GUOhqTyIR5Pes1FuJz5awsHRKgGzAsTLk98BJXPmGbsGw0
 cQo=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150653285"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:58 +0800
IronPort-SDR: 8cLqfF6zPaOqDCSvaAdnPmaPnYQGLDKUv8L0CbA9Bk9jGdZW8CxeWp6N0AYq474bGx/HZEjpxU
 eXz9Ju2k33S36qwBf2z1CDW1vXWGZRwfUkYv/3ryNeRRhCbnGqbSEBqv/8jEf0R+XhN71QBYgH
 TeQo07etanXezf/pUETvbPs6BLPgLK9A6WkU1l0Rq5zURdKIIAzIjKuMbKa58pxCanFraYDJYD
 BpGlolUQwTBa8rmcQBJxRvcB6XO9S6tlCj2aMWGQPCyuQhgtKk5011d08Wrx+ursavjrvAm12x
 xBqXMyit0V/8NmTXwLpj5+ix
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:13 -0700
IronPort-SDR: sFpvcQ47bR0fW9UDcqxO5jmzd+wOMD1kGGwXwgNfuXjV/s1C8PUjMKA8ymktzmgHOV0RuVRZIy
 0+09W+OQWGVQ4uqnN6iFZcJyaakdpQ6ggwjzPsjtwqZ0sO3295LCXwBKLrxhbROscvHSf6ozWC
 D4kav14ryctqhaR/szPQMhhVtEILLQ/wLjrZMy5JN3i5jfvPWAkooa/CV2hlUHSTTBeDjDdzvC
 jcXe4350r7y4fUNJ6m7S2T9Z5LObghLqXVQ8lbc6b2PCsxZQ+vipIF1cpzlJI8B/PcEX0rlQ/f
 6jw=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:44:58 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 09/16] target/riscv: Add a riscv_cpu_is_32bit() helper
 function
Date: Fri, 23 Oct 2020 08:33:37 -0700
Message-Id: <6adfabd1e61f13932b99d7a9f6839a5c87ad8ce7.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 ++
 target/riscv/cpu.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 74a236d4bc..86b063543d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -383,6 +383,8 @@ FIELD(TB_FLAGS, LMUL, 3, 2)
 FIELD(TB_FLAGS, SEW, 5, 3)
 FIELD(TB_FLAGS, VILL, 8, 1)
 
+bool riscv_cpu_is_32bit(CPURISCVState *env);
+
 /*
  * A simplification for VLMAX
  * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 0bbfd7f457..32234d4a70 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -107,6 +107,15 @@ const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
     }
 }
 
+bool riscv_cpu_is_32bit(CPURISCVState *env)
+{
+    if (env->misa & RV64) {
+        return false;
+    }
+
+    return true;
+}
+
 static void set_misa(CPURISCVState *env, target_ulong misa)
 {
     env->misa_mask = env->misa = misa;
-- 
2.28.0



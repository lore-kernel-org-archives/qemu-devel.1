Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FCC20885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QN6Yn9X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FCC20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowr5-0002vH-Lm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJa-0005XJ-Ug
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowJY-00033f-Pa
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208530; x=1624744530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W7Bj3HDtMeIedWxLjBsHkQ4m/+FTFewfRfdjawcE8FQ=;
 b=QN6Yn9X6CpPQyGcktnyawSI0SrOgVNt2Wy4UIJnO+TIeFPPeespcBhLp
 UFc18l9kQun3IHMAfggQhXPez2twlR+Qvrd79yicKdr8Ue5aYnbIjTyiq
 pJOjgUgDR5Yhuqf/aoAPVjc4onL1JY9TUU44zf68+mO+FGBgFh8ctkbgr
 7Q6rgCkpcZRV8iKVyNUCAywkfT6K0Xj5h4dnGJkoIV6BRop3Xex2Zm2eF
 UAutpoGdfPk3F6p9hfZ0SCCZnfzqrj4KWR/tec1yPba6NPrwKsOIl1H1m
 Y0CEUSehVb9ltUQIlLJsod4A5fOQNXqONKVxUqs3r2asdbeIsw2+cv922 g==;
IronPort-SDR: Rjyg7pdxrc21lYNCpIAP7HKyy+JJXvXnyOL79N7wnd8gObIQQC/wJ3nY7o6nic7KQLJm6gAO6S
 sOyhLhAy3SB3pbmKm85F/VlIZ585VR4axBLzFVIPib7RxG/ImyjUGlStXHCfDOIKIgio/G7oCg
 MtE+LKiN5qV15ieWTM+K1BFi45BKnqegjl81lesWSaa8YG8q+/z2UMXAHyKEmyofc73kIQdXZx
 wCCbafgNvoYcGMoyCEZsJUJTn/hOd/yqQwiSub4a0vMH4DZWg8w65FZJQBsoxcunMfElP8sbSz
 MX4=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="244048426"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:53 +0800
IronPort-SDR: 6b7h1cC0YUv1d3AE2U9wq//HnbfSIJD/ZK1Yq8OnwFFXxCV44VJ8XjHLweanE/kJ4VHs/2NXrL
 GJNM6n6F8GtuHl/tRGdlzSw8LNbuQBYbw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:50 -0700
IronPort-SDR: fGTX2mw1mXO2QbRrrzImC/iO13eq3toWExK46e+JmQEhPykTdgHrbAWYcjIeE8q/y3r836GLGR
 ya/09ZaRXi1A==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 63/63] target/riscv: configure and turn on vector extension
 from command line
Date: Fri, 26 Jun 2020 14:44:10 -0700
Message-Id: <20200626214410.3613258-64-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Vector extension is default off. The only way to use vector extension is
1. use cpu rv32 or rv64
2. turn on it by command line
   "-cpu rv64,x-v=true,vlen=128,elen=64,vext_spec=v0.7.1".

vlen is the vector register length, default value is 128 bit.
elen is the max operator size in bits, default value is 64 bit.
vext_spec is the vector specification version, default value is v0.7.1.
These properties can be specified with other values.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200623215920.2594-62-zhiwei_liu@c-sky.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  4 +++-
 target/riscv/cpu.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ad51c6580..eef20ca6e5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -92,7 +92,7 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
-#define RV_VLEN_MAX 512
+#define RV_VLEN_MAX 256
 
 FIELD(VTYPE, VLMUL, 0, 2)
 FIELD(VTYPE, VSEW, 2, 3)
@@ -279,12 +279,14 @@ typedef struct RISCVCPU {
         bool ext_s;
         bool ext_u;
         bool ext_h;
+        bool ext_v;
         bool ext_counters;
         bool ext_ifencei;
         bool ext_icsr;
 
         char *priv_spec;
         char *user_spec;
+        char *vext_spec;
         uint16_t vlen;
         uint16_t elen;
         bool mmu;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d525cfb687..228b9bdb5d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -430,6 +430,45 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_h) {
             target_misa |= RVH;
         }
+        if (cpu->cfg.ext_v) {
+            target_misa |= RVV;
+            if (!is_power_of_2(cpu->cfg.vlen)) {
+                error_setg(errp,
+                        "Vector extension VLEN must be power of 2");
+                return;
+            }
+            if (cpu->cfg.vlen > RV_VLEN_MAX || cpu->cfg.vlen < 128) {
+                error_setg(errp,
+                        "Vector extension implementation only supports VLEN "
+                        "in the range [128, %d]", RV_VLEN_MAX);
+                return;
+            }
+            if (!is_power_of_2(cpu->cfg.elen)) {
+                error_setg(errp,
+                        "Vector extension ELEN must be power of 2");
+                return;
+            }
+            if (cpu->cfg.elen > 64 || cpu->cfg.vlen < 8) {
+                error_setg(errp,
+                        "Vector extension implementation only supports ELEN "
+                        "in the range [8, 64]");
+                return;
+            }
+            if (cpu->cfg.vext_spec) {
+                if (!g_strcmp0(cpu->cfg.vext_spec, "v0.7.1")) {
+                    vext_version = VEXT_VERSION_0_07_1;
+                } else {
+                    error_setg(errp,
+                           "Unsupported vector spec version '%s'",
+                           cpu->cfg.vext_spec);
+                    return;
+                }
+            } else {
+                qemu_log("vector verison is not specified, "
+                        "use the default value v0.7.1\n");
+            }
+            set_vext_version(env, vext_version);
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -469,10 +508,14 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     /* This is experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-h", RISCVCPU, cfg.ext_h, false),
+    DEFINE_PROP_BOOL("x-v", RISCVCPU, cfg.ext_v, false),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
+    DEFINE_PROP_STRING("vext_spec", RISCVCPU, cfg.vext_spec),
+    DEFINE_PROP_UINT16("vlen", RISCVCPU, cfg.vlen, 128),
+    DEFINE_PROP_UINT16("elen", RISCVCPU, cfg.elen, 64),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.27.0



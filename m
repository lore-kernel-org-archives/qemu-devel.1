Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6245BC56201
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49F4204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A0TkQRQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49F4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8th-0003FY-Ov
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rx-0001VH-8x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rv-0005fG-7c
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981534; x=1635517534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g+WPltm5YpaGI86/aQt4WJbADi/eUHg46l1ls02OzYI=;
 b=A0TkQRQJ400n4KEG+xzYDYrixv3o+JA+Lnga5+ssfpNtAXTwIi+0TlEV
 PB9ZlYx/pHnOdbVDmZXSiNUlNimbg/wl0IMdKlh7Ao5FVgG+czuSMGWVQ
 ZQanZTKIbATAKX9EbWAjujCNu5zch3+EtGV/f/8z9ab1sJnnh/d9OBBw6
 aFai47+WuE8zLrOz7pyvxj6S6uOpiRfDrWbYTmNkdFBvQqANYQU6RhwFq
 v4UunX9FTTFkDCoI1M56QNNHagt9vUVGWcMk6JtCQJM/VIk5O7sXjuHAR
 ugm+tALKcvnOAlXjZZNLIjp06jDik9UNRrWW6RsSXnjw94NlUKKLYVNwd Q==;
IronPort-SDR: JKIIydD+MvyU+0Ei/130Hz02cJTjr4xPQAg6HjWoKT/Tuyt1j3S3Z1/9af/91vYNc4SMMljQFu
 KUPaczE3mRa4gYVBsw5QsbeexPhjrZZvlN2/DSaZ+E+GHZrtxb3+8ZA4+mdCYh5N5s4v4Ft+up
 uKQAOcnsDBYPe8uowT09HJka8+aHIQjsEufS7XDdDWxWLVKoEolvzVsd9AwfyRXyMUH1c9x8Hf
 7bAPTR5ZsM68HbaoWdbpCTShM+3g6OYKOg6GGS18/YH6kkVVkBWyw+HBzzG0M+Wkeq2zUUNotb
 P3Q=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:27 +0800
IronPort-SDR: H6SvyV8RsIgyCTTp/3yvhiyhJEd/6lDwF37RgM2ACIwnbn1Cgnyt4jyD36Zy2kegeOPIowvUEU
 aWBkg4tyltPsGqVph9tXaREtzkMyLngmVwsBnBxg8xveGEAmxAdEhCuiFVQ/ZfiVo4w+hMFLFx
 lg3qkdDe6oOasSKkrhsCfyFktjBhRjU4gmu9MN31PwKnPCO2mW84Ah1EMnvJQUmcD3FtMBUCL3
 qLBbq4cygtqnPzIqjKF2hXBualxM35rIF8VsJK79jOZMIz0Ihz1+X1lt9RjNPaQstdZuUQ3FMj
 2y46TUt5YbD1xZe7IL3V3Nrw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:42 -0700
IronPort-SDR: abPuG4i59dNyG8dQgvUv55v5S3AXb/v2yuQDBOvN1cErn0n2RTWba/lytZab6hRjk7M0NZpXsI
 557Iu0qb+3rI2qSGVdL4yT/gxxkaFcA6h3sFMFL2679Hfd5M/fPIIHs7qJuzySX1LcrL4Oul+i
 GoI/mrY17FB+4Pk2ghq2cq1JJ9Ugs0wRrEw+FGW6mziAoI114bA0x+WDbXhlsn5E7PpSZGhd8D
 DYhe4Wwt/xBJYpoz/ppcoYFF/Uz2gHQpC2YUfxSOY6uNll5CK6s5Hy+WUoPE31rSm3p3E7B5kk
 bu0=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/18] target/riscv: Add H extension state description
Date: Thu, 29 Oct 2020 07:13:46 -0700
Message-Id: <20201029141358.3102636-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

In the case of supporting H extension, add H extension description
to vmstate_riscv_cpu.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-5-jiangyifei@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index fc1461d88e..ae60050898 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -68,6 +68,52 @@ static const VMStateDescription vmstate_pmp = {
     }
 };
 
+static bool hyper_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return riscv_has_ext(env, RVH);
+}
+
+static const VMStateDescription vmstate_hyper = {
+    .name = "cpu/hyper",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hyper_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
+        VMSTATE_UINTTL(env.hideleg, RISCVCPU),
+        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.htval, RISCVCPU),
+        VMSTATE_UINTTL(env.htinst, RISCVCPU),
+        VMSTATE_UINTTL(env.hgatp, RISCVCPU),
+        VMSTATE_UINT64(env.htimedelta, RISCVCPU),
+
+        VMSTATE_UINT64(env.vsstatus, RISCVCPU),
+        VMSTATE_UINTTL(env.vstvec, RISCVCPU),
+        VMSTATE_UINTTL(env.vsscratch, RISCVCPU),
+        VMSTATE_UINTTL(env.vsepc, RISCVCPU),
+        VMSTATE_UINTTL(env.vscause, RISCVCPU),
+        VMSTATE_UINTTL(env.vstval, RISCVCPU),
+        VMSTATE_UINTTL(env.vsatp, RISCVCPU),
+
+        VMSTATE_UINTTL(env.mtval2, RISCVCPU),
+        VMSTATE_UINTTL(env.mtinst, RISCVCPU),
+
+        VMSTATE_UINTTL(env.stvec_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.sscratch_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.sepc_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.scause_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.stval_hs, RISCVCPU),
+        VMSTATE_UINTTL(env.satp_hs, RISCVCPU),
+        VMSTATE_UINT64(env.mstatus_hs, RISCVCPU),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .version_id = 1,
@@ -119,6 +165,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_pmp,
+        &vmstate_hyper,
         NULL
     }
 };
-- 
2.28.0



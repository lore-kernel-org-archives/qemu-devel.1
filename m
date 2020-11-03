Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5538C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518B120780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kRJjP8Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518B120780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyNs-0008Iv-9j
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJS-0001Us-Ia
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJQ-0001EJ-G9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417613; x=1635953613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g+WPltm5YpaGI86/aQt4WJbADi/eUHg46l1ls02OzYI=;
 b=kRJjP8LxpxLXfVJ5enLpNljfoNCdZp81qbV3vbwLEw/5eqQvonvSjgVb
 GpXxbcpg3M8JEDTsePxvpnucDQt21aw2NBluXN1KjNdpaygOOzX4CwS6y
 ZGdzwDL5USIyryr+wLBT2nJTIC0EUm0fy0slcLp3qhYB780i229svevj7
 Ge+k5kBohk8G+z6hVuBHsXtvwTl5Y6Bis0Lg67O+ae0H0wF7uLuWfn34L
 DMvNybZR/4Ui/5qbayTpSg6G9vxl4McHJKWoAdZKyaBEIrQfV1fNLILCp
 +QkO/2Ih/yuC6azRf7Zb/MsdOtZWNAxogLdcQjClNFAi4tI+6xWSJNyj+ g==;
IronPort-SDR: IwQyMRy8dsdxxz01dHNq/cz6+Xr7dl5XHtVk2+X20lwEb7xr/bf7NTxWFQVwh83I2V92sjPFwB
 Nfd+cMyFEF9KkOyehun2DJ97scy9B/SuGL9HLGR6YZOs3oLUn5jandc4/e4M/1iRaqb8uaTTMK
 ic6BFX258KB7LsvoiFIQqzw7QOErEAipOL//1jN4OQ50ZS+X06t7zauY/z0DbILP7a3OrzX/Jv
 HZ/g7ozwt5RvNDLg70VglxFGbLyehmExz7rh+Z4AoT1WRqe2rDuVon4dd54ebHp+Zs5YMzQsGj
 JIY=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867460"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:25 +0800
IronPort-SDR: knT102/BOyjAbQxhh+d/bP3pSbO++2RAyWQqss5Vnq5oMvNKnCBL9QcH6cBh7sAW7LYFPoZ6VV
 N2ZgVz1PjJvHaKh1dI8+YpHVXy800+P+SJVF+PBb1fTKasbS5rkJUMk9tVRoG0GYZW3rQbiNY/
 1g+Oe0dVRBwUbFXYjzZQd9LNQlN+JA3qbpdCVvbVTesm4KrD9Z4esgOS5aRYQ49C99FXewGou+
 gHSOLWQXHGjyR+Ia3NExXG0y69mKlnfxCd8KTY6yXiRCspngwb5L3wXXXQvSyl1pPGehWHXqlF
 jnnD1dhSgkAKJ97edBJ1Az8D
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:33 -0800
IronPort-SDR: CrAhbIOju9eqJ8nO5DREby+bryE5SEoFSk9LKGRp+jp7C8gWpEv1hu1dY64rNIu5TqbnvqKk0k
 ec6Lv927lxFJoRnEw2tAwr5GRvlMJdZbJ+zNu0/H2Y44QgaspD+MCBSPlVuncnsacJ9Wi5PwGL
 RJWplmisbxq83Z9xd7y83HNOJ6OO/BPZQDyhWju0Ivowpbf7Z7oAmdCcgfQ9xcSmxKuDuqdgC0
 Hbtnq2m0X/M52msg3wktH37KFlEqaWmrh+SU1c/8YQxM3TOcfmQC8NabhB/zttNDQIuaKqW1VX
 OrA=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:25 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 06/19] target/riscv: Add H extension state description
Date: Tue,  3 Nov 2020 07:21:37 -0800
Message-Id: <20201103152150.2677566-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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



Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66038C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F59208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M9hyhgG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F59208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKoa-000344-1K
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUm-0001lB-V3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUl-0004Q3-4x
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586504; x=1624122504;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mNUxJaBqscecrc5iYSnB5gf7mz+p8sMw9gNqAnpXd2M=;
 b=M9hyhgG338vwwudBOd8egHYDVM7ZapHlv6DSmQn8HQUDfOpsvcP4DfTk
 WDVm9hKDkOUOB7FFau1oRB5t2dcUOnDdbTqUsCJUcX/sFarSy6ugS8Yk+
 0CT8/z4HQjp2cuya8FW9//GQJtwXLMtwTERFRkNIkN34HdlR9mZnERYyg
 Tw8j662OTa13qsITO7xpzeEwZdKQ7FTse52nL4O8ABFt08FgLS0NYUK6o
 fyEIoUzDTmMh9I1FSa3ttJ18H4pFFJ8m+78mF4g5CTqhjHTXWxXZBIOH9
 S6ZXkw09NDAboy/aJ+qB/AgQgbCJ8DYn4gkFZEWW1dgPyOxswC1c/I8mR A==;
IronPort-SDR: is6wj0Qnp94Akq2OvB9xy2kZd9NzhG7ecWlsno1miOnqajZ0QdjZ/DXp72i4p9VO+YVy+8/9LJ
 a54AQlcygzJFbyK0H4J0zof1zLYFkrVwhA/Z9TlD17iCLIeLdxMzOww0HlXuw/yoCAebfjgSsM
 DibpDU1UuWGunZmt7DvE45P6Hy1EOp8TE5GFdvvf1QviW46HYKYpYb92PY1TwkP30U9ikTzTb3
 238+lFYYbVEPADcaS416k4wXcFAM7VdQQW+pVkdA8Ag6OkgzCQMqb2FIdMxfX3e6U4tdroHcBe
 IL8=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417018"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:30 +0800
IronPort-SDR: eOrFYqMV2CPwS02EuE14M1wAnHckxwPAcSHMWzHJohaoBQsFgexC5yyZV5Fs5pac4H1Be0Ey21
 6NJ1ByAa3WAOAT5fxvUy0t+G09nU0bihg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:05 -0700
IronPort-SDR: 57eTFWrET4M8r4VoY8A6+MK96EopGp3RWdekN/x7NU4VkYZo+SS+Ibv3zpviMDrxn1v2ttGSd3
 bC8EJMLcnzFQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 28/32] target/riscv: Rename IBEX CPU init routine
Date: Fri, 19 Jun 2020 09:58:13 -0700
Message-Id: <20200619165817.4144200-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Current IBEX CPU init routine name seems to be too generic.
Since it uses a different reset vector from the generic one,
it merits a dedicated name.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1592268641-7478-2-git-send-email-bmeng.cn@gmail.com
Message-Id: <1592268641-7478-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e867766cf0..5f034588ec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -153,7 +153,7 @@ static void rvxx_imacu_nommu_cpu_init(Object *obj)
 
 #if defined(TARGET_RISCV32)
 
-static void rv32_imcu_nommu_cpu_init(Object *obj)
+static void rv32_ibex_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVC | RVU);
@@ -577,7 +577,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
-    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_imcu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rvxx_imacu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rvxx_gcsu_priv1_10_0_cpu_init),
-- 
2.27.0



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1688020780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fgtl1ViN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1688020780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZySu-0008Ei-1B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJU-0001Y6-1w
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJS-0001Fa-7G
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417614; x=1635953614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jn6EIm9hdrR24DW8Li1I2eFglThg87rXwX+el8u4/zc=;
 b=fgtl1ViNkjzT8jsEWwJM1eSKGbOVs732DKUiCK2ZtaE7e7LKsVPyCqhi
 ynVLkWzMJquwhADegQb7L/q4d63+e0fEhYWVljNRZX0O04qnlTckWI+Ft
 DbeL/Nz67GeKzCdg0KecVuVSbjibQ2emah7G4jH4ASIOD8xkacxAMH+J1
 tfydbFqpHtYN1G67Wt4rrvhtipQQpCDe/XtUdC0HfqjEd6J9deHvNqZmh
 6MmQneAregiZQsj4qFumjnnpQAcdTj2AMEYJ8Kdqil9n73FX2b5flknwk
 dklcOyYiyTxXQu21SUx2ngPli7vE5DKvnOmLgYxm5xm0SOPGiHPXKOV/x w==;
IronPort-SDR: fotZ8E+Bm2vFOBh0wL1SWluda+y1UkvzH2O6++kCJzE2+kVFSIFUSZlGpdGX7s3R/wOpzEYk/W
 vvtPG4N1Tpy1cX8Ygas/4DftdUOL/go/a+a1NdKDJurlglLuhrXqDArsRqaLHIZ1fuU+jy+yrq
 eA7NveVoDKDMD+/oPLI8ttx3GJUYE810yovHB4dTMRsmwyYjFIS6NSfdNqpyIFkY63hKv54ojX
 8wuEu/W1OCIith1LxRtYx6eLgyE7qvbW/QargzVAjkO03sf972iSbXPXKCRUeQvIl68UC2rSwt
 5LQ=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867462"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:25 +0800
IronPort-SDR: QKBdmz0z6xZQ/vOmvbyehrLFyEiWfhtJoRkZKjX5v+jCyGwlZmVUbM2aZ4yfoPazV0wZu4xiMK
 ozX3TmR4dMwaPqVdKY8FyBLZ3BBMnLb+KSb2mXs2WpawO5zqjJauuOgyW8nu5rDAd1ik1IZy/j
 iAEMzzCEU199hvAPkX7UdtazKw2mtztovpPD+6suxmk9NYhqFYxIBOFYHNrwYsxajUShp9IjBG
 y7VNkIqUXjo+QkZvyGhmgyaW+HnHwdGvGq7k41gDmgYCQMJbJhhqQOnpgHNvF4hZrrx3+U6/DM
 EXPwiyhu4UlKBNJCg9nbKVXi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:34 -0800
IronPort-SDR: ZK7gctL0dnWybucKtYOqNrSZ6WiEGpaezGj2sEQOZSrsgfpe3YGQONjHu+rThg8rB1VTf1bwhp
 eyGZJ9bkEctGRkgv/OavfQbgPp+vcIddv7ns7dP8k4ZweT4z50brZ34On+jLvGh7LM3iJRswLk
 fbtEEOB8PUjqt1jHJdoxlTaYsbsv2S+FgdIoeTS4iWaPZWx8lwPQ7a5Ihea1plJ19y3nsweHM0
 CBOZEjuHbf2DNiQnNWABBgUR0VJP2xkPrKbbbyNkZEUvqd3rOFCQRKJUShka9BNx73ByosRhvO
 G9I=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:26 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 07/19] target/riscv: Add V extension state description
Date: Tue,  3 Nov 2020 07:21:38 -0800
Message-Id: <20201103152150.2677566-8-alistair.francis@wdc.com>
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
 Richard Henderson <richard.henderson@linaro.org>,
 Yifei Jiang <jiangyifei@huawei.com>, Yipeng Yin <yinyipeng1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yifei Jiang <jiangyifei@huawei.com>

In the case of supporting V extension, add V extension description
to vmstate_riscv_cpu.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201026115530.304-6-jiangyifei@huawei.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/machine.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ae60050898..44d4015bd6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -76,6 +76,30 @@ static bool hyper_needed(void *opaque)
     return riscv_has_ext(env, RVH);
 }
 
+static bool vector_needed(void *opaque)
+{
+    RISCVCPU *cpu = opaque;
+    CPURISCVState *env = &cpu->env;
+
+    return riscv_has_ext(env, RVV);
+}
+
+static const VMStateDescription vmstate_vector = {
+    .name = "cpu/vector",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vector_needed,
+    .fields = (VMStateField[]) {
+            VMSTATE_UINT64_ARRAY(env.vreg, RISCVCPU, 32 * RV_VLEN_MAX / 64),
+            VMSTATE_UINTTL(env.vxrm, RISCVCPU),
+            VMSTATE_UINTTL(env.vxsat, RISCVCPU),
+            VMSTATE_UINTTL(env.vl, RISCVCPU),
+            VMSTATE_UINTTL(env.vstart, RISCVCPU),
+            VMSTATE_UINTTL(env.vtype, RISCVCPU),
+            VMSTATE_END_OF_LIST()
+        }
+};
+
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
     .version_id = 1,
@@ -166,6 +190,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .subsections = (const VMStateDescription * []) {
         &vmstate_pmp,
         &vmstate_hyper,
+        &vmstate_vector,
         NULL
     }
 };
-- 
2.28.0



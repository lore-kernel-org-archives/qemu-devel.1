Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30E1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A1B206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PyvNmtmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A1B206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8yV-0001nT-Vy
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8ry-0001X1-1w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8rv-0005fB-Vb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981535; x=1635517535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jn6EIm9hdrR24DW8Li1I2eFglThg87rXwX+el8u4/zc=;
 b=PyvNmtmh6YWvh5ZgtVIYPOd1Kya8r6SonM3qb70rDUkMmMkgrwae/gI0
 HaVjv7q/873VFdK9dEv8d3yXBqQ8usvty+4kOa+FlE44YwkyZhMnmGt2p
 fUn33Xsmi7IDXno8y2Cce9o2pMIccc6zi/eca1ac8w7vN3nUqR7vBTbRq
 K/hSYMpAsQ0LCmoqzW/lp/vNQY6y1Z65r9Naf4ZeRjAKsYTwdQGWF/VFG
 7PS0DL8XrByq8Isz0FHiFn/N1qCgPRFq12jGAArb578hGg8n911XDwY/3
 +VqwbrQvRYp1qKpyXeKyvhn601vgwPH2DPziEFj9Gjd5jGDf5Ybxj9O6Q A==;
IronPort-SDR: dOaHI68T8EthOhuswjjxqOSG//v4aw04Af/L+UbpyIJKiXuruFGCAolxzAU6U2ATRUwEYu6L3H
 htk+iw/1CIP8kagqK8QZ4kkdzaFvNOL0i5AFOfGv8cJriXAeDXbzhJluqbf3x3ZXoDMmzZv2dS
 WGgF5NycIHKjlFHSWNNffIYMuWd+hiXc29ahUZEbHySjCtdYZaOCRzVZBDE5AhWPJQf80b4Cux
 hKrxkwnh0NCO6HEXqwVU4FjWzXrMawHTHXjbZOkL0vv6cWnw593Eo6XpkFJunWpItI1VwsRzkW
 9gw=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317881"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:27 +0800
IronPort-SDR: QNf8Ok7uLnstUeNogV3gNfpQTeTO18uTMXv9RVzPoWEkxp4y0O3K6lE847PGS9BAkiZJqLQFnU
 ZNmnVqWZBU1YXBRhnVL7XfbesqaC0zx2iA/dDp5689y/QIAK6lgYdKxBcfV85/95bhADviWzzU
 NabU17tBFahnfdNtlHVt7aYG8B1eNb5ZvwsRH41/YDhQsmpEXR92WpQJnN5yfrFV7gqxsKjgCL
 bjYpHhzEFlu3QUVrgLAY4gc5LOdMd+dabxlm6zNV0xSo2wAUEc8VEfmgXTt6D7WKQqPv0athjZ
 nb1DqYX/0Ri6dGh4CDUHdfPo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:43 -0700
IronPort-SDR: z7H7dGFhUWEt/6ep/iDU9Q8oZEcnuwHv2JqhSVjn5ELizf0LcmLxWJuNE8Vg66cooSloI+MMkC
 aQ3Hf3dwImaeUmIi/RunA173qmV0kEVYPoxZSanwajYv49GiNmNV5abiMns/bWdaCwTD1ME8kS
 p7FIXTCjHWGllfWRI4u9P7BrmY2/z+gVKZzdd0w+TR7YK03e4Art7ez0mYZxl1C4jnzDpn5dG0
 HRP2cnD6xAZYq5+Bqn0OdGO0eYlZiV+VDrIkplRlXcOLSSr7QP21S3Wun1hptVVWIg8CXw57hu
 DBk=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 07/18] target/riscv: Add V extension state description
Date: Thu, 29 Oct 2020 07:13:47 -0700
Message-Id: <20201029141358.3102636-8-alistair.francis@wdc.com>
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



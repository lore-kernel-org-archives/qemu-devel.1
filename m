Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1533D20675
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="URcdkar9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1533D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAqs-0006YP-8w
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbt-0005cQ-35
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbl-00028T-L0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548478; x=1624084478;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dMdIIDoCv7W8aOLzjHKqNqNnPV7covUPMRH4EMqR6ec=;
 b=URcdkar9hTM/JiEpFqmaEur5f1xO5h9nra8joRGTdeeL8rcljq3l0/j+
 hWqtcFwPOAbHvmsCFFZPTxdMPceWdgEWnpy0hJ9J2fYIucFGCeaHNETGn
 +UBhCQBYLpskZLsjaGyjxjTanx5UG1c+84H3pPiRm4z2T1XzULA04iaiy
 7gNOzrZ+ICPtaypF+k1nk7fG3P7nReamV1HVI3R6lVh6sBaUbXekp7ElC
 3Ioa4BG4CnF/5GzeDNC5bY9qpl9N+IfViWVzdF78hRadMs98/fGQPRStw
 tS3T4T/cwT/TDesHvwEWte95w09XB9ZNXLVl7BGm9NctaBlFEq/k/1cuF g==;
IronPort-SDR: GPo1ORM+6DD6UrGp5iGX1qzWfh81LiF5++NKx3wH/IFviNqb/uIuVY9YEfvFDSNRo/l6hM/TDe
 OZqNmtgevVr4sXA2rlBQLa0QH+RJF5Ho3ghmDM0Xth+rRVOICWCRnQ3QmGrCefKNDVIWQ5LtJn
 oCM6B4SQ5dQmXy9Qs14zUVlkJKoDdheaKmbocHwAAM7lwzI7AEIFP24afJ0jmKz5qUOdzfJuil
 oOvIbgvYh3xb0brYhMHoy6++ZeqDyd+sIxDWJ7233uWKsbObIU+WhMHEQnwZWyRusAMvYb5qPS
 DPM=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781931"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:31 +0800
IronPort-SDR: dN9CfW0tLmdBjjdAlYy65J/0Kpvo+iREE8FrYrQb791BPzvcyq1XWapY0DqMtR+D+105Szya6j
 CSHnwM0SXf2TdGfXs4Ow/N5ZMt2q4K5iI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:42 -0700
IronPort-SDR: pLrRqrD4IK9zsAvZNTw5NB57TKcOqiyYVv6duzfUXGVMQceD1Pg7vyUz0FBeskxv4+LbDSQ6xx
 6HSgNldwaWWQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 20/32] hw/riscv: sifive_u: Generate device tree node for OTP
Date: Thu, 18 Jun 2020 23:25:06 -0700
Message-Id: <20200619062518.1718523-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
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

Upstream U-Boot v2020.07 codes switch to access SiFive FU540 OTP
based on device tree information. Let's generate the device tree
node for OTP.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-5-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-5-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 20b0276ea3..a6dfce4273 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -207,6 +207,17 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/otp@%lx",
+        (long)memmap[SIFIVE_U_OTP].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "fuse-count", SIFIVE_U_OTP_REG_SIZE);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_OTP].base,
+        0x0, memmap[SIFIVE_U_OTP].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-otp");
+    g_free(nodename);
+
     prci_phandle = phandle++;
     nodename = g_strdup_printf("/soc/clock-controller@%lx",
         (long)memmap[SIFIVE_U_PRCI].base);
-- 
2.27.0



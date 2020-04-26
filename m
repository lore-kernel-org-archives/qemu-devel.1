Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C50C54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFF720700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HqKTLR0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFF720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkKu-0001Ik-It
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8P-0005dF-68
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8O-0004xM-MN
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:28:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8O-0004rb-20; Sun, 26 Apr 2020 12:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918480; x=1619454480;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HcVek/unt7NK3jOyUlLGKE4mVHxoXH4ienfMDbL1JK8=;
 b=HqKTLR0eCTRiIPsnD7JaWLWgNy8UjoOStuSGNJzHmvevekjF75NybaMb
 PTTla/1FFkRG4R+dH8c1OY/fyVp+9kjyI8HnMl9CECCTfGNfBWFI14+Gs
 9b5tDuhfTiqu/G06x9qvQ6qEjDeyjrGLmfyLYNhYDWprOIrPer+eW+Xok
 71XxUTjeyl4/023Xb20XluOOxt+t+F0H0zG2/jzy56usJ0t0FTCSAzj5n
 4biwCIIZDh/zfxEBdOb6He7Pgjc6+/azxskjeYpo1o+UrhPSoruu0J+tu
 qQl6P1NPHNR/8jbkYME7OOTrsvYOiRlsIMTVcf14IWCmMV296emsNFLeu Q==;
IronPort-SDR: C1IQafCCJ+OzWEVIeUNoldkIrl36xGaUCYMGswk8BzI9ThxpuW4mT9fS4CN2N/iII9cvG+MHAO
 4HNDGsRamvjz7iSSCwmDmm/op9TFQmpYi4Baul9BWBbUaawBHKGD5lm1oy6r7fG1ELucU8BNQz
 RuvKTyjMfQHb0YE9aJ7ebws6r/L1t9ntEr4Sl6t5lN5CuGrWAozKUCeGA73MsgdgcW4R5BQwUO
 jeGK/jTRtc2kjRXIKHdKSfxKoP+n5fqMzNYcrMVIz4cLkDk8E0AAnwiU8n5NVv4DlLjOqqgPnG
 wEA=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="136193257"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:58 +0800
IronPort-SDR: d85r4kf8PeT7Idsi3TSw3B1dGd2fyirqpnMfaCl9mVcXmjWATHFDOd//hL8edyHwFdnbg6xMLK
 5mC+uptuq2znu7U7uXZbbE/mCm966l4aA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:09 -0700
IronPort-SDR: iHyN+6Yzcr4y1ZMX4U5nsGVzg24h7K4CvQxcVlnbiDABBqTmKd1yU253Z2UlaUlpgnzUzxXIQF
 qjNMwDhFN2AA==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 13/15] target/riscv: Only support a single VSXL length
Date: Sun, 26 Apr 2020 09:19:48 -0700
Message-Id: <23c98b0c5a3394ce5a98331069383cdb0a4d095f.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6b6080592a..438d0a61ee 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -854,12 +854,21 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
 static int read_hstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->hstatus;
+#ifdef TARGET_RISCV64
+    /* We only support 64-bit VSXL */
+    *val = set_field(*val, HSTATUS_VSXL, 2);
+#endif
     return 0;
 }
 
 static int write_hstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     env->hstatus = val;
+#ifdef TARGET_RISCV64
+    if (get_field(val, HSTATUS_VSXL) != 2) {
+        qemu_log_mask(LOG_UNIMP, "QEMU does not support mixed HSXLEN options.");
+    }
+#endif
     return 0;
 }
 
-- 
2.26.2



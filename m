Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D20C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 421552074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U3WKsFAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421552074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1JM-0007J7-H4
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BR-0002ES-OU; Thu, 04 Jun 2020 21:30:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BQ-00009e-HO; Thu, 04 Jun 2020 21:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320611; x=1622856611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gpdiww6CQEQzO5fQ1sP5VZqoLxUdv32tk/zd6cFv+B0=;
 b=U3WKsFAYdgoACQmfJOf1RJdP1z4rs0EWAGkaYXvDCa3uPS8VqFHURuw5
 Uvy6qBzLeHTAqcoUZTLgUdv5osMn1ACzGkO7CbDE4CHxzHfzttl8brkcd
 nNtyEwXMnV7POjb+WwZ60o/yyybgNL/qzjbhAcdGcM9ZoZjo6fFFtg3EJ
 dc35rCWiAIUY4Ul5hbu6rDSaIrAWC6Wt3aM4JDKgCINfBZgItE760ZioY
 S/V+e3vf1NK7eESJUgVWAgzbyafo8uehV4CjrygRVQAH37hk4oISFfYxC
 sCIEEnCaXTCpQGHep7mrhojRJCGgctF4uW5cj5VaNJy1myguHFY6Bbifm w==;
IronPort-SDR: d3m0AbNUlVruwmZ0KONvtD1oSolm8gkGE2Kthe7n9l1KFqYRstqYpLTWhPhQfgQGEcoy8Yxbnd
 zyGiZqRuHN8YxXE4TIxwEuTj7stBTs96Nxp3qlrAlyoOy97GFdb/aoIlClzuyI7i2d9KiT3VUx
 KCsE9WdXxfExAjErdeJ3dYleWPK0fAiAdur+NyicO6AOgc5WQr0MMG9hNr2FAmoyWNKFIz5ieX
 ZPuIs4MEywetLYp7FPfgE1+PZxQy3Pk0NqfRUxZfLlNsiDbk947jVrJCyW4NjPVDi60RaPNAZ7
 RYk=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127052"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:07 +0800
IronPort-SDR: lxFq0Al4oYITA8IzMaBNE075CAYBJelrxtZtcjMrpYOrjT73LWfDFQVLwqid+D5Ih3tCPSv/zt
 RAJ5qlpkBOGS8Os3RIyItAWkq1+0hTvQk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:42 -0700
IronPort-SDR: jXOfY482oKuw3Yaemoi6CYAjv3XHA35+Kc5+UeOPpMIUHe7IsCL7kv8gA/h8stAfJqxi9F6b15
 rh+YdZcSKxhw==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:30:06 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 13/17] target/riscv: Only support a single VSXL length
Date: Thu,  4 Jun 2020 18:21:18 -0700
Message-Id: <088e016b3f96a9508165ab3d10217041e8a3e536.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 69a3c8379c..973404d0aa 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -768,12 +768,21 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
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



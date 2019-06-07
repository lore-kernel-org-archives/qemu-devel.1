Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9016C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42125212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ccjj2ajv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42125212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN4W-0006Dd-81
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMs3-0004NX-AX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMs2-0001xO-0i
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMs1-0001Pu-Ky; Fri, 07 Jun 2019 17:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944678; x=1591480678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nt/TlQV0czZlJcPhOqA8aU91jDEU2O1aeOXThQhJ34A=;
 b=Ccjj2ajvJ5oKiJqpvEDP1gDH8tZyLu9ZYhvyVB16dbVX2COjXn2Wz9xV
 +WycINolu8FkSgRdY/DXuYXD8KKvUJI8BUKVgEMs3eSyqLHXNDRqD4BJU
 gTyrcmHRHCx/5xlyt4cOJS01cjlYhqp3YTQohP3g0toCoEYRJcsv89e8i
 +KjntORANB/eS4ao8LVzsF2760ZEiwvVaFY49s3paS6ydgQXWWxdX8ZjU
 nRKDQD5iBcjoYXiLX09iXL/LfXqsQeKXQuDzqTkTC8wnEhJ83Aq8EO7Mm
 yMWm++dAWkt8XeO/MA/OYMILzFvsnCe8cUhajjVe+hSnWw2aIkW5HxoAB A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014095"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:57 +0800
IronPort-SDR: QdVyly0RYHz4eMIzbo8mNufi3FOrcNHOpdUrWNKalIZovf4qI9XTZMnoQ86tmE2omY4RGYNLbR
 LTdhqtMLaUOI/2fZY6km8+KKrQ9C+A7ka8GXBJLNwaBYVt3UGtm8wIcV81s2nmGInR2b+y1aJF
 SmXGtI3P/M3mbiEAhLlbQBmnu2HedJL1LRnOPbG4mtHg/5EsfQ7r8f3NhQQfEdoZjX86srvvWO
 aY7Z+UL/AZLm1d1PbB3Fwb2zi5MYVE7v4to+Dt1AnaBhq5Wb7ubStCDR/cAx4pW7obKiHSWpyP
 CWknV9iUxCrDPATRe5ZJSnI8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:13 -0700
IronPort-SDR: N1fLNGkBmcO8KVNs9OZ3yhkdSJjngmIGZqIMOdGC24V6HZ+PvfaXK94fixM1VxzXHjOuYr57R+
 UqcO9PSYFOhAP4a9JHY1pGVLFwvXOY4+E+tIFrvfB0j9jE91RKbhyaoUGf1YwFFnB6HrXfihli
 lRHHGATMcBql37CRV1nzPYRRH49OV84ZOqaCS4LgtYUms/54Mq0eErt0Ygwi5zxHr/smrhhHq+
 01HycWGBP3WRpl/YGONXFxhiZhs2fq8JmXSnn3gu0krk3xa7brOcwUJ7a2534IV5lLrLBbL4Ko
 zAU=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:47 -0700
Message-Id: <f5d5babe27ec9a457c61824e7e7f457157fdbbe3.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 09/27] target/riscv: Add support for
 background interrupt setting
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f51139b543..0116d2499c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,12 +38,27 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
+    target_ulong bsstatus_sie = get_field(env->bsstatus, MSTATUS_SIE);
+
     target_ulong pending = atomic_read(&env->mip) & env->mie;
-    target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
-    target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong hspending = atomic_read(&env->bsip) & env->bsie;
+
+    target_ulong mie  = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
+    target_ulong sie  = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
+    target_ulong bsie = env->priv < PRV_S || (env->priv == PRV_S && bsstatus_sie);
+
     target_ulong irqs = (pending & ~env->mideleg & -mie) |
                         (pending &  env->mideleg & -sie);
 
+    if (riscv_cpu_virt_enabled(env)) {
+        target_ulong pending_hs_irq = hspending & -bsie;
+
+        if (pending_hs_irq) {
+            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
+            return ctz64(pending_hs_irq);
+        }
+    }
+
     if (irqs) {
         return ctz64(irqs); /* since non-zero */
     } else {
-- 
2.21.0



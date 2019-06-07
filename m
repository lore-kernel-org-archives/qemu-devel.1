Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E3DC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D45720840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cDkiEiec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D45720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNF0-0002c1-EO
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMt4-000561-IX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMt1-0002bl-Gl
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:59:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMt0-0002Zm-0m; Fri, 07 Jun 2019 17:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944738; x=1591480738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=J37KwDGOi5pY/Ftm28bdrS5FkijI2Jdfz8xPvHtNcKY=;
 b=cDkiEiecZkM1sQ24rknKJYNMZlb90bIFmZZZV+k2REiwpTaczFMlqieI
 jCuRja6FWluW/c2C2tbcbvQw6wSpXQ6dtdDgQiajfywmiDgzKiNK9CRI9
 divVjnxIOZWiHGv+hkyGpgiYWUxZ2Vm1JQbFtrnE5voON75nXO4QusYX+
 AHfYDsDCaguk+q9riRnGlm+J+t7mp0xb5YNrb/q7SAkIN6/xXzk+OA/Wl
 Q1+6r9tkdhSl1nQnZITNFOvPZ55oA1am3hxSiiVMk/hEvHI5VpMVH3Z6D
 WnYa2zhYOmjwrIaKJ57GTgPlAx/gwIqVB/UPaFLPbIceAiV2sfTq4i/Cd A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014142"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:57 +0800
IronPort-SDR: 9YLZCnyrLaDN25VkKH9zXakSBWTMyhXtzVt3dQBwZQ5MsyzDiyJCARu53zUgn0qFh90qXk5FtD
 c3AOyYInAVgbJwaY0+xW2Byk1fdId92ffsETmF5ekBHvDr/Oc3n3KDY5LIcalYr3VqUxG8OyEj
 ame2WNimVeSHk1gFFvVY3FKonNlthAtxLj0EdCakxKo3gzDQEOQy+fb0nU9XeKldiVV86Qbo5v
 ZWs7DC8lnfyZRKr51tV1OaoyTyNfOenF1i06dkC6sJZB7kotgkIXvjSe8RkCn7w5X/HIMrxsuY
 q/Fz2gvWsm7WfwbL3x3apgJr
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:49 -0700
IronPort-SDR: plml2cvWT6z3yKyoMu2b4rUTvzu/vPVVMTIf1LRZmbSeKM2Il4GfH0wv9uWI/8VBl9wVNPtY3t
 ji+p9a5eByZEGPwtvwndoeOGYJLslceRA0v1q9fQlpn/4TI2ha9eh9T42dlgvFJro6N/vLEtva
 bkLiqHay8oHEB/Nrsle4uEMIjwJMtrdatJhEjMRtmNGSVjlTHIM0/mqHMYehmU7apRB5YNGrIa
 cpg+hlPuO7PSXnR+Opf5jeHpQzEKRQvzFY3SzHNK18JdFJbxga4Bt988POzThyzhX8EJ09ciDE
 z+k=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:46 -0700
Message-Id: <77ba193a34b10576a6f3e6fb9bb63d35b3617732.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 27/27] target/riscv: Allow enabling the
 Hypervisor extension
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
 target/riscv/cpu.c | 4 ++++
 target/riscv/cpu.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6111f0f0bc..38583e7a6e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -436,6 +436,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         if (cpu->cfg.ext_u) {
             target_misa |= RVU;
         }
+        if (cpu->cfg.ext_h) {
+            target_misa |= RVH;
+        }
 
         set_misa(env, RVXLEN | target_misa);
     }
@@ -472,6 +475,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("c", RISCVCPU, cfg.ext_c, true),
     DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
+    DEFINE_PROP_BOOL("h", RISCVCPU, cfg.ext_h, false),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_STRING("user_spec", RISCVCPU, cfg.user_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5b3b32dbbc..342e628379 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -259,6 +259,7 @@ typedef struct RISCVCPU {
         bool ext_c;
         bool ext_s;
         bool ext_u;
+        bool ext_h;
 
         char *priv_spec;
         char *user_spec;
-- 
2.21.0



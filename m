Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F9C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46799205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kg9m4WgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46799205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNHi-0005P3-6f
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsr-00051W-CX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsp-0002SU-CX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsm-0002G5-US; Fri, 07 Jun 2019 17:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944725; x=1591480725;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uDlmyEl8/iyH+a7PIwdMvHr7+FN/0ar1iq3TrAcccO4=;
 b=Kg9m4WgKKiYZxLYWMevtRSXXHzs7JYYHlWqp6LLPKKgIHLZw2gJzyBrH
 vhO5BC/nmY9/2iKik6ebDiARZlVp3jx5MG0tuaEBlzSgpr38xPLslCDGl
 MU2+D2/WQllEgEjqrJVo+xpjeWyvx3xTEqd1QC1FEMrzROr26cs5n7tOr
 skrCdfOFM0T8ikQCUb//+g9RyvAolFfhFlLGpsB0ueZJiEzfyXYhK3v1E
 bOuiH0t22wWaOsjN82mIwT7mPaHVsqy5AcTqnwtLufW579HkyLAGJMXzQ
 uXzDN2LLnWBS7jpHPagSzsfTHRWPu7Ep9TyqXkVHY7O05mp9arB++Xp+r A==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059650"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:39 +0800
IronPort-SDR: ZgAqnItII89zxnu94ZEh4GZCO8GxZDNMu8i54sUaaMiFH574c7nOyje6FrwxX6syVGkJj48CJB
 PcffX2bobHzkHvE2b23jveM6DQYhfduAw/OTZohJp2Dart9O0WUJJvNrTkFyfdnhESQtwR3JPp
 qR8gTfJ612bsxrjJVH1mCXpWWa0lgIwlXAyqwvi5nRX2wBD7lnrP4EL/0iwGNzk39rYKNAsrXV
 if+m3bd4yTM+8fdBHdDgcOAHa+JwzGsdxcKjLKTBdtyJNmqkwtSpzZbbxg6IgE0oQDgbi8PGna
 rH3gRL6McP+WWvIoItSfdWye
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 07 Jun 2019 14:33:31 -0700
IronPort-SDR: 9ojSvJkkTuW2yyR2ktj+CMPmT3xUGvoWl3WnoCR92Izxnu2vnla4M24AqgiQshUqe6SMTEvVBv
 WwuEaCKf26ym49dfbUcSVT8UAcfnNEaeL7iEroclnn9UOAzfFgEI5W3CWgiQF4DrkjEzntpM0B
 OUrEy1zC1D2ZTymRX2UNQW9bcVvZcbYu16tbHkGBhwMaHeRpV34L7ijqYjjSF+LLBEFdljL3hw
 uUmhMQ0ygqnriG0vRivyY1p5QUZXKppc1WghBsYm1eKQjRLI5IntjCl15FtaSoMTBdUw5gamxy
 Ep4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2019 14:58:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:29 -0700
Message-Id: <a670be188dcc9e07b189280689588f9eb5e5f457.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 22/27] target/riscv: Respect MPRV and SPRV
 for floating point ops
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

Respect the contents of MSTATUS.MPRV and HSTATUS.SPRV when performing
floating point operations when V=0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1c3cd1c94b..d4fa7d056d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -765,7 +765,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
-    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+    if (riscv_has_ext(env, RVH)) {
+        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+        if (env->priv_ver == PRV_M &&
+            get_field(env->mstatus, MSTATUS_MPRV) &&
+            get_field(env->mstatus, MSTATUS_MPV)) {
+            ctx->virt_enabled = true;
+        } else if (env->priv == PRV_S &&
+                   !riscv_cpu_virt_enabled(env) &&
+                   get_field(env->hstatus, HSTATUS_SPRV) &&
+                   get_field(env->hstatus, HSTATUS_SPV)) {
+            ctx->virt_enabled = true;
+        }
+    } else {
+        ctx->virt_enabled = false;
+    }
 #else
     ctx->virt_enabled = false;
 #endif
-- 
2.21.0



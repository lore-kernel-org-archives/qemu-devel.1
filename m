Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF5C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A9F2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GPCnUwIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNmk-0008F6-6h
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbJ-00080R-4c
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbH-0007kC-L6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbH-0007jP-Cn; Mon, 09 Dec 2019 13:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915484; x=1607451484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ul2PecweUl3c79MlLRmaZ7UEHyFoZ32Y3/ct8Gyc2pQ=;
 b=GPCnUwIJmu9PstSNuBR5uRXB7ydAQq5GzpHkd49LpiKI2nK+onG1UIy/
 s+FHUYlUAXNZRlqcAq8UqVzwzxq8u7bcrLqxEoDIRvQjxJqjvNQwUmc6w
 A1z+mM7jf4mOd85kGo2+epF+ESSLvx9qdsp/93tHGy/PZWXNwjx00iO4y
 KF3Hm+Ox9XzJwr2s1rAchYfXuxyksvI+2pvuP42HD/i9s8S62qOzp0NYG
 Z3aCkZ77rM7sx88MDjgDFmkxEhoa7xK1H6fGj7tVnkSbjKnipT2pGp/Pp
 hDxmHMNB/nIZM2AdoEzhaPMLnlf8Jkxc/mfvqnEnVa4EM4JjeI9LLH5HS w==;
IronPort-SDR: QrEtSSAn5RDIbqDRTyu6Vj/IB4QZ9aopfVv1D6RbTeRPktdW/F9juWjW/gHS7qYEblm3eWeONw
 D9VZY3gkqg/eQ1zacyRhetK592P8ZqQu+4PfnMogPgPQRrVy3CdHZq9EgGCmPrxDA+G7P3Jq/s
 3QpTPDWxkeglaqV8yzsmLqn/E/uJxMDE/u7ZXd/Nd3qzrpwpMrxGnfP7iMkd3OesGvtGzJCSst
 bTsraW/Zslc077gBz5c5JqL2LqcB64TdVMHWvuFwSrUqBLyjSe5pbT9OW6Zb3ZqiVIlvZh2gML
 P6Y=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412024"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:18:02 +0800
IronPort-SDR: PR/IbmW9OU433kN2rsK1o8twAJVzaa0ShBkyaLz+OtqC7VuRVA0rM9ol15WfnBWe6o/dal/VUj
 qdES5XtnecehH5ZJEwFnn71+/Kq0uBdenGEIyROz66Dq2DtivufrjzacPJ4tMws6S6xouhSkvF
 sHNC3RWAve4uFaE451+A6K0fAP4DJc6ACKzeaXOQIWTIaLtHgKaF+GJs0jTg1xhglXe4TOjTfd
 4l1VHBSJMBA14Ab4KO/kkIpTKVyyCcUyBdX8fveVy4U8OZgqNIoHpuMNkZP8Hk55uv03s1kb/P
 H+j729sMBDLRtgTF1eNcR9Wg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:16 -0800
IronPort-SDR: w4BaxIQBnOhe+nZ1X5fmU0XfRk0u0qiTL4LUZPuK5ohjznEPaFsMM+pG/8+fu1DlrfnAmFYbn5
 7Fi0qsc4UJPFPM5JwKkfByNOrnt0HcMXZ1TPz72KGtiTJbcSZxR4tquB5eQ2MnDDeBDuDKwyhU
 9Pk1xb9XeV1rXYPhkWaMonfdkedEYta/gzBTKII0aHMVnay2XXZtpo+lIecPu3NtsTs9cvgUAe
 WPEn5CYIMO/KKlJLvW2WlqRgu9o7kKW3nQGX2jMtsHDJBesz2mJq7dbVdb+FA+tTNuHdfM+1Nh
 k1E=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:38 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 29/36] target/riscv: Respect MPRV and SPRV for floating
 point ops
Date: Mon,  9 Dec 2019 10:11:56 -0800
Message-Id: <f1725ddb8d69edf68ddd2d6e1b6688cd7b2ba550.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

mark_fs_dirty() is the only place in translate.c that uses the
virt_enabled bool. Let's respect the contents of MSTATUS.MPRV and
HSTATUS.SPRV when setting the bool as this is used for performing
floating point operations when V=0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1d879b34db..dd93e12b45 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -748,7 +748,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
     ctx->priv_ver = env->priv_ver;
 #if !defined(CONFIG_USER_ONLY)
-    ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+    if (riscv_has_ext(env, RVH)) {
+        ctx->virt_enabled = riscv_cpu_virt_enabled(env);
+        if (env->priv_ver == PRV_M &&
+            get_field(*env->mstatus, MSTATUS_MPRV) &&
+            get_field(*env->mstatus, MSTATUS_MPV)) {
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
2.24.0



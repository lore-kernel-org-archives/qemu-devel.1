Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BAEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5516720850
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QK10wwnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JeK-0005ag-Dk
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCO-00018W-5S
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCN-0000JX-1D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCM-0000Il-LN; Fri, 23 Aug 2019 19:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603747; x=1598139747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zk6i3nobuH9a+yzfXQLxN8Qyk5ojE8cdGzrGAao+Hwk=;
 b=QK10wwnjDK+7aJCxWNwT2uNaT8dbI9RIFh1t7RWmRo11ZFohb9tmH8fL
 xo+7Tsb9WMPUsrUJA50MjMNFX9fYKBJCe378CJatIjPgJt1r/OeZq8dia
 UlMzEnN8CdGKxyZvFTFWZgzaT6d1vu2yUxu831XyB7iNDWm4nFHJZJxNN
 0KdKKNtd9aTL3hTo1G+USV4wTuwfNyGdOex3lC+2HEn1oXx6ryAi0yiIk
 jMVDhu/bqnkGvyXwfShgAgoZDNkk5bvDRIGVRdQC0/6rCNKH3bCY5WO7j
 em8ZsrTYobXoU8LdOxBoJEFatq+n9gJ28+P7zU0sgKxvKKhKQrQjpi9+v w==;
IronPort-SDR: Z/cH5aUAjdpIEQNWONTXY9uVO9Ckl6xiWC8kiJChlvL8v8Rp2UQqzTsVN/vqtAoj4fXijwuNJD
 jQ/eZQZ+O/TUfXQey2DFnvy6EVuyj9Pu48GaTs/U9g4EzLZrAeRJXgaxbSMDNeYfaTR3GB6AyY
 hVKXGk2TSXE9IELd0geFa2A6AKEf5haBbR5nqTvleoO879NgYoESO/OuH+kD9jEnAy67mzs/Ip
 eWBOopREhH8vcJdjdMLE0vP8SezDixeS1Fs+SECbj9HhvIU2sAnGDgdq3D4uE8Kmyz+EMM0xo4
 hkk=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486907"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:26 +0800
IronPort-SDR: SpDd8GTqtoJfMFuVUDK6nZizm+FtDduQYKJRgMcEIcwOH8jZ9iaWtvxM9Zx37Be4OT0g/tFARZ
 OkrBtCcaOuRWVkFAwpw9Ls7zWuj3QoAGzKCwQ6Cp2eqa39X5zynSnh+rvVh7lmltbAZlZXxxuz
 L6fn+Gfs19rvgYAMBZaG2KPaikCcV/3H0nnCaba84G3/I9VqxIk4i2NAAz49h0fuA8rpB+kjZ4
 kLvmkgZX3cMuyY4zez34cWEiIEJnkjGPGSbsbTq1X88aJ8bznnK3920NDUuqP18GLvBSRYtZEx
 YCG7HLhm89aowP0P/C4Q94l4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:43 -0700
IronPort-SDR: 7elb/x0ptLLj0i0Sez73m0Di+PGjl5lUQXUgDnEobbiNQmr8x8nU/lVqCNhL4XkXQWyQnmr7Of
 QANgHSW7CZ5knaFXyR7odRpFQ50eGnqHWqJy75mkFQfMtSHRgfLaJx2BoIXi811cRJ9dmUaDnA
 E6MtiiHb3KP+FWn4Dyjy0BjDIBXg0WhB4NrVClorqfTEWCpS2E5Lm6Gixa+Lq2YWuvYl4AAeNo
 pQ4zIZ1d+x9GwUgwdPzxFHy50rPvLPlA7yRNUYSMYOBSuTpsRR7fDXWIATr7rb2xOdDHDA7/BM
 dpY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:44 -0700
Message-Id: <8a628d1542d547b6d639cdba51db67590d0b56de.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 21/28] target/riscv: Respect MPRV and SPRV
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
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
index 19771904f4..ea19ba9c5d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -750,7 +750,21 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
2.22.0



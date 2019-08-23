Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0BCC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF5E2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eunTKJAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF5E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JME-0002XZ-5r
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC5-0000v2-6x
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC3-0000D8-TY
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13685)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JC3-0000CF-KM; Fri, 23 Aug 2019 19:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603728; x=1598139728;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V5Eonze3Bqz/BwDJKsuRkxnZlbmS3mwZ2MRvo1P6p1Q=;
 b=eunTKJAhFmdnnKLE0VoX6QsiBrF0c6SyzGQH0EqLGeCIsjlJbAcmQC6G
 kdozO5gcB1vy28SoifI6CzKLnoSXe5KkwRbavsaNoMEMGzjps5N2UPQTS
 b6C5ZaE0b8aoRqfhh5doMIyvpE5VfB2UIo5p+zCkHae+LbxzwIMNZ6YnN
 cGTFQTaglg5BV5hJ3be5duIKm4wDK94rD693oNrMcnltzXBGJWYTityAM
 LQMesJ7ihJNdLglswO5Qynqf6nd0vKW1M8Iou8VRkd9BNCr/LJLIacjpw
 OcSdIQ6H1FZo8q38b1ij1LmIIYSNi3nczXrNxE9TfD76gz3OLi0Vfbl3w w==;
IronPort-SDR: dLHRLFu616wIb6AyHudpxv0nX8mbvAxlHRA8c1Am/1ai1kGZVnCgtphuWdvjKNLK34Irn/KGb0
 Yb3YBxLaTTkBSL6SS++aYNd7oF+cTOlimwSPxJzeAO4P3BTDz9a+hnZ+YtmwOWTFcQgHTTsnnh
 DSCVduSQ3QLp8kTjCr04Yv33pheISzkOU3dRO0QkWWiMU+P9CAcOcSM1IGn2Gll4ByDoLagwWQ
 S8Eq7aCNKc12tx53TZ+v88hbz3fcppB6We38MzbG+83Id9LFEGl63dQoDvYuuX53lnZSlf1KN3
 nNc=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154432"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:07 +0800
IronPort-SDR: QY5mJ1kbGjHuNxiHoszSCgRVQDgvzRtkaGgOn6Wrz5JVmhNEXiwcRbjh2smUT9PVuI7ODInu7h
 86+z2KMT3bhGF1n/5i7XWf/yHK7NYHcupzQ6Y+Kcv+lLJx1fW1yiRVUBNqcaxniplT1rz0NCwW
 7euPgOcPq2VspHmRNtxyNdFJe1O8wYEt79Fk3lh5RxDz+b83pZKM/0WtuEbxCpbMHIJPGq6Pai
 RwEbhhmPqcqEWsF2dKrpRsPnWcYhh5pJ7jkSWfyUxgNNpQblKVNe1wxgWz8X6+UE74Wj1n3JH9
 g1JkJNJqcvvCVXZ7dpshQ6rz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:24 -0700
IronPort-SDR: /+y5dSw0/a74jzvyQrpjZlJ2Hv8OhoWMlT43w9PPW0tXUC0fsHPFsdQFn/7TCEOrvcvdJcsggO
 sfAKO2Y3cID/X1y2jFj/8IL0oXLbWv8ktek4lN17fKvf3uR43JJGwqKa3fjis2acL+1+RxzHUU
 GKYnFhLYY5D2QN/SlwLXdLvVSGbBoL9lqyJMFl64N/JpXqUO5/fsRrZdH6www6W5rqi7iFhegx
 P1rZDbYxwTFzg65uAXSJ899JcS9Kaa8dPZmOTa8bCkRbhFJ7E7dFaNibXfbLY6JbB2E1sf1AEv
 Llw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:42:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:26 -0700
Message-Id: <f3f7e9fdb539df1aa4c5f2b64db5847ad8d2eaee.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 14/28] target/riscv: Generate illegal
 instruction on WFI when V=1
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index d150551bc9..beb34e705b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -130,9 +130,10 @@ void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    if (env->priv == PRV_S &&
+    if ((env->priv == PRV_S &&
         env->priv_ver >= PRIV_VERSION_1_10_0 &&
-        get_field(*env->mstatus, MSTATUS_TW)) {
+        get_field(*env->mstatus, MSTATUS_TW)) ||
+        riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
         cs->halted = 1;
-- 
2.22.0



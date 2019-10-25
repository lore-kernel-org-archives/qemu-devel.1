Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27221CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3823206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iOBbjpOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3823206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9TL-0007rf-Kn
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91C-0005BN-5X
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91A-0004Xz-Vh
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO917-0004Sy-Pg; Fri, 25 Oct 2019 19:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046154; x=1603582154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X5dyDZAU+qyzeBfQWrLfqPPCa3H8yb2Aup7zkIbTqeU=;
 b=iOBbjpOiFDgRRSWeLJRkBP//7UxYV7XlQ+ZUeJtYEsLSXjViY1Tnxtzh
 6Zuf1BkQsn+DlQnZPZWn0KJ4W7W3v+dJ17JeaED0hFWrHWQW/FEDKI79Q
 jZPQGq7Y2BkIC2JDsOVtnd5Dw+jLpm4Dx+fcnVkG/yHIE+8bcaUZLSqzl
 oIU2i8Tj+YXGjsETmZM93Wk9Gx3fQwbunqp9E20eVY2K34M8WWCyPfWxb
 5ynhuIAosNI9Ik9tD5CwzZ63Cl3Xo8Oedd80F0R7MNoquWLB5ufxG3pqF
 9KBnaSl7oVN8cuFUdtYTLduvUcLhcYG3DSb0l8C6GutoMrREYkwWsHxly A==;
IronPort-SDR: EmUJalDVyOJGEViwOXAN7v6RgpGGoEU+5CaFxU8M6qBg7o3nNEDXZT8jkh2BJHIA1G80PjKfPY
 H0kDKI29ZMmxO+WzZSrrM3oUUVWWaBnLfreyJfAbtF4OimW8nl1WrCvPp9Vh1gs056j42l++tw
 X2fjLU7dcJwJuCL/B+3ZFl6muXe4dyBTR1DutoCPSavb/Hrt2vIjlWe+D7HPlAykIW4wX5U3vx
 7KFacJG5BZXcY6QREY2TaTF3tYvZvG1XmEuViMkPYhllTfNpUF0CNhn5OdKaNGSmxXDB8aqOVZ
 RxI=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956690"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:13 +0800
IronPort-SDR: 07/BLcAjcDiKWZ1ZgwA9rN0JaMN7uqa6aIVGorzgHeTpJjQDtTh+nzvdRWHDLTrfX2MbdJdsea
 Q4uoNCBoS3xLbsRPArmqfb26kDIpYvmgqTDYnLbgyw6x15OqQAcoHppSfiApYpC09nT9xlJAOY
 uqjlz5lwQVGYOruMY75mAo6On9GYJD292iV5aFc0bozcnW7IUhhXdvyVdP10Hs2Sq9xUs7U8M7
 CkU9C2+/Mz3jRN9kgaqT72RfrVoWmqipxJVXH0IjjMz7MS3QmQzG05nVB4u6g+mFjsExchXhQf
 fPG5IH/M5LEYssEuJqnBY1Bz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:39 -0700
IronPort-SDR: P3AxYXNCx3emXoGrsUU6Z3FMnLFGM6bzUqEmwh0Ltu3W8aL9VxPYnymF3x+hruIbkXxyAVeNzu
 qU5ELiEbFcBfdoIsQN+jQ8RX33NHwi+rZpbWZhg9IndU0HgZ6CqF/RNc8o/qbXEj9FOMUlqb05
 7sOSxhZ2GWONZiiKtkvsLRSTyewEBqLGJqR9jZzcIX3EvvzlJ6Z2sEyjzi0xycfWQr7Nrn5FX0
 mymP3uS87QcbMDtoupZL0FbjmOYulJHPJT5DE9U0ub6Nyo8gYTs9dFVwRv7CGc9eDICDyk1Vy+
 U9k=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:13 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 20/27] target/riscv: Disable guest FP support based on
 virtual status
Date: Fri, 25 Oct 2019 16:24:17 -0700
Message-Id: <8014e06e5b0c5fad5b0a33e977bf9bb50a8cab30.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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

When the Hypervisor extension is in use we only enable floating point
support when both status and vsstatus have enabled floating point
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 41cd314f64..79966ac6e6 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -91,6 +91,9 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 {
     if (*env->mstatus & MSTATUS_FS) {
+        if (riscv_cpu_virt_enabled(env) && !(env->vsstatus & MSTATUS_FS)) {
+            return false;
+        }
         return true;
     }
 
-- 
2.23.0



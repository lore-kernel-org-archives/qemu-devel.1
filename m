Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004DBCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EED205ED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MsBFZSVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EED205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOA87-0008BD-U1
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90q-00051x-33
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90n-0004D4-UZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO90n-0004CY-Hb; Fri, 25 Oct 2019 19:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046133; x=1603582133;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FdeZ4NhLfUCPSsQnsVMq9BAn/ZA/owDOlR0AZEjNA30=;
 b=MsBFZSVLvGsdLnJ/eYyEfQZ6SLMVjqrlHlBsRuWK5wA4KmXsD6sVeA4B
 s8hHAVWenLNBdLiLZK/jczpr9I0Tf6mIY2nCFCQ5iPhzd+jujAByO45mL
 G1pyVFwQ9y3XN5hbVsQAMbbz6df2VxJPpeJG/JRncPjkFYmlE+uQCr2DY
 R72IcsBRCLzgh+YHNjrd/TtfSQkEYZd+qXCL2qWzl+od3pjfLuB+nOQGX
 vkJUPrsNI4hH81A0FFBrFM87GefpWBOvVIUWN56OeaVl1n+d/6pyQ0ZTL
 iLySQs/BOqrrf2WUkuROqdwp2pL0PXNq8g89kLt/BJmTN7MOLe0B7BZIE w==;
IronPort-SDR: QIgdlC26c/9NlcD9JFOfk4I9sz+NM75la7FSlmqdBOxgUQwt1VfPgpM85BPoY8j16S5Xvk6Wxf
 JTfjB/nOjuw0tHHjjX5Z/fav0XKuB5lW7LZP8IiEeWrBbHnTsNnUkaSQLQRcUXLvF9bDFV5CSJ
 QtRjS4RmcA7yYMBE0Yniz6GmV3EfdE3/hhA7+7petqhSysDywtgrmUOuQwRCR/o8OUh6OtF9sk
 +szv5Azvxy6YJ9S/EbYscSyJe3Wwal4H2dPfc/SQ8yynZOEtx3G4Aqd9b36/HXNyhg5zzwlzK6
 x8Y=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520394"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:21 +0800
IronPort-SDR: 8sEjert+rRdGwD95cgxpBTl/O0ah1ECxS5lz954x1vnz6U9KYajYYjHxRT5kFbB0IT8zHSu23q
 8/GcNu53B5lGCsW6uHkJrx9ojOJMEHyaSu/GXXAyhE1NfDOI91xuNYtaQrd0SairBu077ohi/U
 6qceM5v6RBdBDug/zArhmmytS3y/5szIgUA63X/N2CPclgm4esn4FVuhRXuEnX43Ew0q2Oi8xD
 l6s/6q1XJn9yEyrXDX8v+rjCtY6lVKZAQq/23sKN9ZhU73MUREpUCK3rQuntptq7U4tpGQs/Nb
 UGM2QursmSlqgIIRDke+wQJp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:46 -0700
IronPort-SDR: EaFI86jyQ2mwZkh2WIGp3Nwx7yinwDy8MSy2wV2tMZd+kOK+gZf7hS/gxpMn0F+6YBlyqcmYtt
 9d8pHbjPDwcq/7sehmd+H8v7v2A9LGKmc8mm0+/mawGaK9P9/shFzMx8mBH2gMJDd5FlDD3j8q
 cRr5h10pc1acftoKcHxLHenyeXQbP2KBmsH57VXr0Kq3WDZFcVe88JL6D/5xoCDguH4R2HyfKW
 Slgkg2kGKB4Lb0enQsIrubpaWrSsdgCvPIk27i/suVJHOkp1k04rWOx+e/oyfRXJI0B5u0x6mG
 ZYk=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 05/27] target/riscv: Fix CSR perm checking for HS mode
Date: Fri, 25 Oct 2019 16:23:25 -0700
Message-Id: <1cb5cdbe67d8d9c489f6c0bedfc6c007e1f7243a.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

Update the CSR permission checking to work correctly when we are in
HS-mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f0b1..08956aa557 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -799,12 +799,22 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
+    int effective_priv = env->priv;
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((!env->debugger) && (env->priv < csr_priv)) {
-        return -1;
+
+    if (riscv_has_ext(env, RVH) &&
+        env->priv == PRV_S &&
+        !riscv_cpu_virt_enabled(env)) {
+        /*
+         * We are in S mode without virtualisation, therefore we are in HS Mode.
+         * Add 1 to the effective privledge level to allow us to access the
+         * Hypervisor CSRs.
+         */
+        effective_priv++;
     }
-    if (write_mask && read_only) {
+
+    if ((write_mask && read_only) ||
+        (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
         return -1;
     }
 #endif
-- 
2.23.0



Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92841C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A96F20850
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qjTUqum+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JfY-00073R-HT
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCd-0001Vb-VI
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCc-0000QH-8J
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCb-0000Pq-US; Fri, 23 Aug 2019 19:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603762; x=1598139762;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BcKwsJ8UdBDM71IJxhMwOmPklql2SLp8yqEnUlStuz8=;
 b=qjTUqum+z0DIwS7e6JTax15WJk7ID+Pt8w6AGJIAAe8gs3pnk/544Wu3
 JHjKwsZmnYb0V2VfGhT+OuVleh5uTQ5LgVzP7ULj0BDpcyoZN8ChxOICk
 cKkJLNfwa9Rf/YMeYOOikeXQm4EEI5BsZBDjLhqc+7iluluN46reaTtYn
 /o/MUiwa60bwzoLeN51eV4EoqZ79Pp0FWJCACxBhHU8kNmrPj8FUggzp3
 y7kkj7Ztj0DX+KkyiKOZRVSRSo9yCjdtMkT5m6YrzA62mulRdiJdjHcCH
 YVNP8QCIeKNuMDZ0JEKVK47k6CGzjiabJGaKJVj1QHdpLzZJ5Te3lyaUB g==;
IronPort-SDR: 79cPE2+w4dMo1EtpKVxyViGae5nJ8x4xw6yDgtyh0kxVDhNV/+aT6VktNK2jwhcSuDkPqaxiKM
 md3n7jHRCmgFavguTMj0ugE02TKmCToE3fiSO7nXN0TH8tdMrTGYGz5BcYN+D6m2Tj96p09oAE
 dPFQvb/bhHDHiQKHSiw9OG1UO1mWWswfClzDmiIK/dr064tBm6OgsE7O9JA3uwaGhU4D3BDgR+
 NwDKmLYYNGhJeRi+4L51nGmK08D97+8oTR9HHqS+b4UqCuTr/ATPX6W8Sy0OKQxu8GjAB5RuTa
 8c8=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="118154444"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:41 +0800
IronPort-SDR: RCJ5//b4DFr2/SV1EtDYhZrO7nt1Pfl7HSdk6H9VKwdVROfRLFlwrvqVMW1DwSBASg1spvHo35
 ulr0164NyF0B3Mk19ArRWQxcQNh7gx814CnMmE/cxsjV9Hn8ZknEAwyl9p4tXaEV6So/AH6OqX
 xI44FttrJp4pbIazxUK3a+y1T/XsFAotiCTBTFSzU7y9DI+/NI5lEA+Rjs3PIoeGWF4S3UAmQH
 g9OfUsi0LUwOqQWuhHwlCwI7mraAm0pFk2YmDa5x3OTVMVmDJ38312l42kZPXEJRcMBvxaMNLn
 WyvPfDCChyHTd+iRr//J1Kh8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:58 -0700
IronPort-SDR: 0ftYSPLyMbwPbYj7y92iyEUYgRsW2f0QhT/1WD658Twe5/gMP0hIkz0Lw/wumqPXQcusNdfRBy
 9O3WRIngg5BaKVhKKGsvu7+BOjv/VN/8K+vaxlYoMx2NVyaSDohrSROxZ0mjmXJBM7yQ+D2xdv
 boN9IvIjWeFE3P7g0H7Lbd8itPnk0s8fno3563fncnita0FwMsJw31TBxlXlC1wFO2oXFQOhID
 tqNKkA+e93279yQzGmzac+d9/E0q+oR7tsvhxp1vpdEOVoL4fXy5uB17kXlo5RWg7NsDRKRZwf
 La0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:42:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:39:00 -0700
Message-Id: <c7961e38284feb8de1180173bf92c78153fd6970.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 27/28] target/riscv: Add the
 MSTATUS_MPV_ISSET helper macro
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

Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   | 11 +++++++++++
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/op_helper.c  |  2 +-
 target/riscv/translate.c  |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 55e20af6d9..7056d9218b 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -365,8 +365,19 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
+#if defined(TARGET_RISCV64)
 #define MSTATUS_MTL         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#elif defined(TARGET_RISCV32)
+#define MSTATUS_MTL         0x00000040
+#define MSTATUS_MPV         0x00000080
+#endif
+
+#ifdef TARGET_RISCV32
+# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatush, MSTATUS_MPV)
+#else
+# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatus, MSTATUS_MPV)
+#endif
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8c80486dd0..2b88f756bb 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -351,7 +351,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             mode = get_field(*env->mstatus, MSTATUS_MPP);
 
             if (riscv_has_ext(env, RVH) &&
-                get_field(*env->mstatus, MSTATUS_MPV)) {
+                MSTATUS_MPV_ISSET(env)) {
                 use_background = true;
             }
         }
@@ -730,7 +730,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         m_mode_two_stage = env->priv == PRV_M &&
                            access_type != MMU_INST_FETCH &&
                            get_field(*env->mstatus, MSTATUS_MPRV) &&
-                           get_field(*env->mstatus, MSTATUS_MPV);
+                           MSTATUS_MPV_ISSET(env);
 
         hs_mode_two_stage = env->priv == PRV_S &&
                             !riscv_cpu_virt_enabled(env) &&
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 8dec1aee99..6149cd9c15 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
+    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ea19ba9c5d..f0d9860429 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -754,7 +754,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
         if (env->priv_ver == PRV_M &&
             get_field(*env->mstatus, MSTATUS_MPRV) &&
-            get_field(*env->mstatus, MSTATUS_MPV)) {
+            MSTATUS_MPV_ISSET(env)) {
             ctx->virt_enabled = true;
         } else if (env->priv == PRV_S &&
                    !riscv_cpu_virt_enabled(env) &&
-- 
2.22.0



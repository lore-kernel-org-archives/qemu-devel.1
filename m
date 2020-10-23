Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E59C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555E122254
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n5hSvp4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555E122254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW00A-0001rv-Bl
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFS-0002TU-TW; Fri, 23 Oct 2020 11:44:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFQ-0003hI-W0; Fri, 23 Oct 2020 11:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603468982; x=1635004982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vTHanwPQHpUU4UIL54mFbOGiG50hWJKmpPnONYHIZGU=;
 b=n5hSvp4qiUlaJ0RrV/FOou+5GjOfvzictOgvETU61LbMoOH9y4YBFtHt
 6gP02aQlZYpuV1L1m1KsiJGQ87UQ61E9YgJ855vPU2LyOhp52Z0brBILo
 OLDvhjDXOdLdnRgvTHYFNmJLvRfgolSrsRMfwbaoxKvqL4YLPh4CWhGUP
 u6KA0iEW9kFSfbB4dPNTWtzg//mpq/eJKPXtZ6I0xlq1f50ylFNVjIK00
 I5EaMH/VUjpgTHqFeVG7pa9Zyrp2vAKGU9nn3rFEKRl+1JtVfCARPiWN0
 fgPNvqLb1VHt1CAfIGhTaX3LU10Bj7hb3UfTw2Xn4RSCcpg94YD0SJX39 Q==;
IronPort-SDR: K6zSXinnUANiXm5d71uhgjE6xcWiXvLskQSv1N7a9wL5EkONnTRkWq0dYEfqZdAGEvUXOwmxxp
 tanbIEkRStEy1MXKdkYghnBVME9XbXTLViKS+Jg4mS90xZvb5MLpzfHe6aWN/bDDex6WB28XSG
 +LEHlnGaa37wS0FSdxvyAiFW1u23CDk6Ant2AvqRfM/DnE9p3p3lwQpMXUnLOM6tWemdPrGvbe
 8n5R4/zKyMupUGB2SbV/x0R01TOcofxiYnAXLHBfSZBlfGwGv9zXcKuWCDrwUHgMgYZtCcikrG
 0sk=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="254245090"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2020 00:03:01 +0800
IronPort-SDR: aCl1VED6W3W2QJ0vuF0AfEBS0kFUDCIwbvsNKIBFWFKWUYxkhEmT0tzs2C/fQCZiL3RHmieJgf
 rptM67s6LZsrAyLiHBTR01rq3DWeHSybBL1shyZSxUFQ7ShEjZNgFQRKnJgfjsKWmY5tgLOGTo
 R9YYY+DcFW3cMNh6hdAT7aOP8rnlz56d8dWCwmkoQG3UfJxq+BzbXPehIH7ezpsXqoWOHlIFwe
 Gclvzahet9HMAtT6mlvolReIagSSGUp0LIoFHCzL/HZ8/5iQj9m9E7oM4RprPeN5nLT7wc/9B0
 MDmkIh7QxSu4iVEo7Y/m4uqd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:18 -0700
IronPort-SDR: 7s8sa0mq/kdQ4M27qo0PuY2NuAP25ua82pE40uxNSqFqHdXrXjuDHxCW/NEG7aGxzzSOAvggTR
 mC4wxGTIus5izNQziIg26aaJ54tbjvTDfAaDPHJyM0qJ944v8b+WKCeBBmzNmmEtQQgCgssr77
 9zo+gJtvgd4WUWT8/MY28/g4VVU24z0dd+O0s9VMfQIPirbdk7fUKUm24OPbBQJ6UR/7cuzmjQ
 6bhg73ZOcdcEPnawToKYPAASQgOHXhCGUKPYOQA8dkFZ/3KFxMkvqmeKjNDqTM8PKgKOOKVwB7
 hq8=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:44:56 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 08/16] target/riscv: fpu_helper: Match function defs in
 HELPER macros
Date: Fri, 23 Oct 2020 08:33:35 -0700
Message-Id: <8786fd77439c26f677eeac2eccedf75ba3b68bb4.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/fpu_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index bb346a8249..507d7fe7fa 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -224,13 +224,13 @@ target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
 }
 
 #if defined(TARGET_RISCV64)
-uint64_t helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
+target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(rs1);
     return float32_to_int64(frs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
+target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(rs1);
     return float32_to_uint64(frs1, &env->fp_status);
@@ -248,12 +248,12 @@ uint64_t helper_fcvt_s_wu(CPURISCVState *env, target_ulong rs1)
 }
 
 #if defined(TARGET_RISCV64)
-uint64_t helper_fcvt_s_l(CPURISCVState *env, uint64_t rs1)
+uint64_t helper_fcvt_s_l(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(int64_to_float32(rs1, &env->fp_status));
 }
 
-uint64_t helper_fcvt_s_lu(CPURISCVState *env, uint64_t rs1)
+uint64_t helper_fcvt_s_lu(CPURISCVState *env, target_ulong rs1)
 {
     return nanbox_s(uint64_to_float32(rs1, &env->fp_status));
 }
@@ -337,12 +337,12 @@ target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
 }
 
 #if defined(TARGET_RISCV64)
-uint64_t helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
+target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
 {
     return float64_to_int64(frs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
+target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
 {
     return float64_to_uint64(frs1, &env->fp_status);
 }
@@ -359,12 +359,12 @@ uint64_t helper_fcvt_d_wu(CPURISCVState *env, target_ulong rs1)
 }
 
 #if defined(TARGET_RISCV64)
-uint64_t helper_fcvt_d_l(CPURISCVState *env, uint64_t rs1)
+uint64_t helper_fcvt_d_l(CPURISCVState *env, target_ulong rs1)
 {
     return int64_to_float64(rs1, &env->fp_status);
 }
 
-uint64_t helper_fcvt_d_lu(CPURISCVState *env, uint64_t rs1)
+uint64_t helper_fcvt_d_lu(CPURISCVState *env, target_ulong rs1)
 {
     return uint64_to_float64(rs1, &env->fp_status);
 }
-- 
2.28.0



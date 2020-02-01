Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138EAC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E8E20663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ewcJm9Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E8E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhV2-0006Kz-Vd
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIJ-0003uT-4j
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhII-0006fS-7l
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhIH-00069K-VQ; Fri, 31 Jan 2020 20:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519393; x=1612055393;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IMNpwSVAgvEgNAhMhGCgLlEg4EDzXqZf8Go08P6JEo8=;
 b=ewcJm9Lr8ZIJrjMJeQLEXbrf0jcJH29jwNCg8KJ7KliSiWj7ToQjbwDR
 n3+sr+7gZxqO6/FNvcYu3P6GIGQ4HE304SXdTeqnCQyIdpSZX7/bUjAPA
 DlIxTNW6ck4aWZ4R+9wDUG3t6uI/sBsq7iIYil35A36adR35QrnwlNXnj
 F69GYddg2tjAyIvkIVT1+cZjyHb2q/IgnSPKjiyiid4kSRnc1HLMGwcn7
 GpCiGQTQ4muMYDEGsWJRuugRxg/AWlDRmCQf2l9hhnufnnjVPRtxvRtPJ
 nlmH+S0CMx8DQ9duRMcvhw30rsyQgyrSpleHeUl9y7yg0dROvgvb+rEQ7 g==;
IronPort-SDR: KsoWscCqzHaM/gw586789UsBy5ThqrZ2VcHICj+g11RJvzrgwCfsw7ot1qjD6IaBl8kgNNM/tJ
 RWjFf9g01wUpN6PWV3UcRYOXHuqg07MrVgBpq4Eg0lnvEmlE5W4wr+vIpUrgX2EFEjN0KCJU/7
 Bp7onCDhTbxL/TfBdvHOHqFu1waJpFDTk0oa2RHUL2ewn0O5S9A1YDv9Q49W0CihJb9b1sIA2t
 cguyI2vqO+kB1Z/MGQ8DgoTHErWAblK+2F0XCw0QhL1InsXjRWOcsk9qqMvNz0uGqozJfPpFtQ
 DiI=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872484"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:18 +0800
IronPort-SDR: XiqFQ+Zr723J7EvbfOFqWmf7LN5TCMfrGPyJgIyod72Rkipez5VDGjKGdLAGidGL1NGpr50fbP
 FDtbunRhBiH/LckTnIxCkdHkJQrzV7TywdoTsfSXdhX7k9FMGzMZIJgkL/lWfb28zRN0z8uY3Z
 KOhhE7FGDF5GLMBxBoIRK1KaCzYCsZIo9r292lQTEbEYUWxUAyjTrjHSKxf6yD6JSh1FTGi5tM
 ymfBHOi7DZGgA6IwvotL2QSGNQ/FTGKrH29DocJwlhlgUi+KliPtTDHy0JmA1xPHXVET4FQp4l
 9F1tmyrjXGkGcrRcaRGbHxq1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:26 -0800
IronPort-SDR: Od8sdJWYdtDHMvi/yGu2phityyLq9zVU2nbfuQas8DMAzL3MPqGAGQQfTzIMXvY07WncmWzvhy
 tP8BcJc1AXUb0ckUFwkaxlau6WTGb1U48m+13BTbm6xNaKewRKuFo3mp3R8nGBCGcYDKrAw+19
 dCm6FkuPvpVDUihjv9VvHjrivTZia2Hjg+a/zCGZnGdce2eabKXvqVViXj8w8Ei+alteeBqw0e
 71tj+fMAAKvjXzXP7wfs/gJUL2FIudG5MRFtZA8tRqZWHnY+1D0lFde2R0WcfEgQ2VP5DWLgQx
 Q8s=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:09:18 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 25/35] target/riscv: Only set TB flags with FP status if
 enabled
Date: Fri, 31 Jan 2020 17:02:41 -0800
Message-Id: <e8605241a8acc3ead0177d723f70a44d08234b24.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5b889a0065..aa04e5cca7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -332,7 +332,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    *flags = cpu_mmu_index(env, 0);
+    if (riscv_cpu_fp_enabled(env)) {
+        *flags |= env->mstatus & MSTATUS_FS;
+    }
 #endif
 }
 
-- 
2.25.0



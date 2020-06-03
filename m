Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50148C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A9E20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eDq0I1oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A9E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWFj-00080Z-9v
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAE-0007fJ-1y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWA9-00060l-07
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201365; x=1622737365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fhc/PEMZMN4A6kCgXybLzUY3iXO9Ks3M99zkjxMv3/M=;
 b=eDq0I1oQcWMP/2zIkB9o0B9Tw0uK5EikxbBZzxy1ieY+r+8t7dPsvpHt
 kVqeBdMoYE8gKLiodV3wjzPvGvTPUpBJbyKV7vFftnMOmE4aoWYcJiqef
 9tiMJPDQQoMwiYmmvgAvIl9iGLysQFFK/s/+f5GWbwc9ogz9OJKND5ieM
 w9g5SS1IBjFZ7tPYRpK7fSQ03xnhDn1a971oZMBFotZG3OzkKTtOfGYbO
 +6cVBf0pmcDLBjNTARwh9VUf3V1dmrb4CbENeOr18O7XDHqfxQi9j8iXb
 CgL/1CDr/vPMbQ69HpkpnSNljHazqzQWhCYLv6rytOp8Cl/mWnbVNl9Dk Q==;
IronPort-SDR: JFsx564uUlStgfzX+yUg4zgv720vJ7IMKmRpElh8iHuWqU+nQPRt5tYB0uRqTIVFdYB+F+p1rA
 4nvapXP41i8kPtc6tRhDiv6ef3r5AmrQ394Ni9ymQirfvaRhP3cHStRok5MVvXoi4hLuxdZjje
 vGTOEpmxW/ld30WbNVXA0AHqklO5VacAuGjSs8p/Rmcvm4daHX1+Piu6TmoSMj9Uar49pzSBmv
 tR7OyAn//5aBX/RrxRxRix4SNKndB3DnhkqAMLSMavCG/4CcrY0FeqOEktZuEqDI0smrN1VMbr
 tb8=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451355"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:41 +0800
IronPort-SDR: iZjjxU+1DsRLjizgX6DmDaVCAS/1VqqTGhXMFpsJW3pjcZ2B0nVbzL6dHfFbkc+uzjuWrxjVQa
 yQGpjQYhH1QdB2oE7uNoH5t2JtRfWepSI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:45 -0700
IronPort-SDR: 74BRW8siS13FjY8SICfBNSASpabUQESUyrnqfNJybEL982TcvQqgh4p/dtHV4wB4WQ83tMQqVB
 /ufSBnjqYTVA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/15] riscv: Suppress the error report for QEMU testing with
 riscv_find_firmware()
Date: Wed,  3 Jun 2020 09:13:44 -0700
Message-Id: <20200603161352.744204-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

We only ship plain binary bios images in the QEMU source. With Spike
machine that uses ELF images as the default bios, running QEMU test
will complain hence let's suppress the error report for QEMU testing.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Message-Id: <1588348254-7241-6-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 726300a171..da5817d438 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -88,9 +88,17 @@ char *riscv_find_firmware(const char *firmware_filename)
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
     if (filename == NULL) {
-        error_report("Unable to load the RISC-V firmware \"%s\"",
-                     firmware_filename);
-        exit(1);
+        if (!qtest_enabled()) {
+            /*
+             * We only ship plain binary bios images in the QEMU source.
+             * With Spike machine that uses ELF images as the default bios,
+             * running QEMU test will complain hence let's suppress the error
+             * report for QEMU testing.
+             */
+            error_report("Unable to load the RISC-V firmware \"%s\"",
+                         firmware_filename);
+            exit(1);
+        }
     }
 
     return filename;
-- 
2.26.2



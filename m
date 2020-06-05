Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB94B2067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pt9wE2pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB94B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1EW-0006qm-6s
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BN-00025A-OT; Thu, 04 Jun 2020 21:30:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BM-00006w-O9; Thu, 04 Jun 2020 21:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320628; x=1622856628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eCEctXu2r/noDa+f6W0xRPXi0SV6hI35JY1T8wGTdzI=;
 b=pt9wE2pTiZ1oOQ/5pk405BfgNPqml0X02uuqdFXuxYy1jme6+Ps/ywLV
 0mPfcYzzgBjSnG6puHohpu7vLofX8xgMJRukidsZVJVPHPFPjYLrhxucr
 +zlZ5y+a3BAW8e3zfcQw2GM9S3QwC+25ZSB2N7emNHporTHsN0hNyES+j
 DCO4KXpen92kAlsj4N81tA9K4QfUtuScnm18AMy6EIdTXXkksZnGVmeGm
 ZHf2lurNfsNbvwe8sAr7yPOC74IQ7JBz90sGyQzTFw/RxyuHGkzBDiPfO
 2FZu31XolzRJ62G0mYdrmWlRNC2ncksj6cuZuZfqyKR4CZfeg3Mh4wnVJ g==;
IronPort-SDR: qpJxUDi1nbfdU///kiy2XScpkSzK+vFHiYCfYSFgWTxnh1+qqAEt0xIu+zmTRzL4K5dXZjTLBU
 K0EK8JxrH+/qUTpIVVnLi9kteT7m5jeX66ODMIi/pQ26zkBpUp8+ytpKl8siKjurCFYlpXi9S6
 TcIBgpnq+7lm+Lo2o2kJUxrn5NPYagkR1O56VtKj6+WX0pyYhUGlFgbNhOlcCM8zYUJ+sYReEP
 i79fdyjOeD+veI4ndlWMcHjm6d3DvYaoxpy4jlWz/q7ElXVNoVy7SuS+JvHt9glMk9w8wCAJMk
 VYw=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127048"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:25 +0800
IronPort-SDR: CsfO7HmRORAeBWvUCVCQ/kZXL+6hWpwBuEkIi4cvT70BJ4ln4uM3I9U1iWv/xEFGkPzzQhhCr7
 KpPYl3Rb+ScmGGaMxzCq07or+N/CqExsg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:39 -0700
IronPort-SDR: +UxRphIdICYeIuGrO8MAPJUD+yUWZIJ9TLIVfwF0xcvWKTr4P5jPP+ttK0dhMJ8Alhk8yeyk8B
 C7z2VTFu4JLg==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:30:02 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 12/17] target/riscv: Update the CSRs to the v0.6 Hyp
 extension
Date: Thu,  4 Jun 2020 18:21:15 -0700
Message-Id: <a86e80ee1db64433a88affa13d0f68363cc15695.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 6b97c27711..8a145e0a32 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -422,15 +422,17 @@
 #endif
 
 /* hstatus CSR bits */
-#define HSTATUS_SPRV         0x00000001
+#define HSTATUS_VSBE         0x00000020
+#define HSTATUS_GVA          0x00000040
 #define HSTATUS_SPV          0x00000080
-#define HSTATUS_SP2P         0x00000100
-#define HSTATUS_SP2V         0x00000200
+#define HSTATUS_SPVP         0x00000100
+#define HSTATUS_HU           0x00000200
+#define HSTATUS_VGEIN        0x0003F000
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
-#define HSTATUS_HU           0x00000200
-#define HSTATUS_GVA          0x00000040
-#define HSTATUS_SPVP         0x00000100
+#if defined(TARGET_RISCV64)
+#define HSTATUS_VSXL        0x300000000
+#endif
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
-- 
2.26.2



Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515E320873
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZJQz93eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515E320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzUK-0002aZ-GV
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOg-0002Kk-ON; Wed, 27 May 2020 12:59:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1jdzOf-0002MX-Qr; Wed, 27 May 2020 12:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590598758; x=1622134758;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zqd6k5FdYqQWvLECnOga6kNJfZU2xefucHfQ/nuNgEk=;
 b=ZJQz93eZsiwcv9BDr9MaJpgn5nOBjBR0vn/2WTfKg7DcUOu+kU2B8zdg
 ZRqVu1+SGZz5dnZ8I0b2fBXE2Eoj7oPJ/ekAkXc+d3Kr9Kn610LTCUpn4
 4876RsfmeD4+LK85NZca2FVfsRY/q+S7k5eXevGuo/al6gxGFCHSd1F8u
 XWRySp0RoOXpqqVXA7tjyGgTMrOHE3OzIsxMRQjqk9gjNRjFphoXMzsSI
 IZecgStZjwrKCLTR+4/nOYT8DB7GTCLZwY4tKXoZuNktEIGcsBU+pTvrd
 mnPUuy3odTAsBvdDUk3b2SpcqoOFViKyuwwrv+VKqhwxxwUHgAgxwDZiF w==;
IronPort-SDR: /l9wtYOR8pfPCY//IeFYtFH5jJLi3SBqxhwzQHr7HkGsEvcoGQWD3fEN7GwNiTyvPy/vMsBShg
 Fe4zCKY73R5wVAodnZnoEE9xp4nFryRBXBEKaouoye1J1wUhQL2ZuFwagNUxoCAoHU8GSrndVO
 xJByyxer8FLQHl3Rw2DOr9ZRTZxi1tNAb8VwBw85kiWHvWlTPPIY6Y8bF+vmO4Tgdg9DYnY+cY
 1S5SBGb8tc/6RZVEyNOWMxfaZrXBtbhyc+1LEd4yPa14qpQ07B/BDmK713hXrkh6XfZZtl27/j
 d9M=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140062151"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 00:59:16 +0800
IronPort-SDR: /qX4Hqfoo9oZhE2nWnK4irHc8WRkFWnIav0KJkiUPT8k1HCTFtpYU5HIsZpgJykDEPnOsxYeMX
 08XL3G4vcR1OsW0ZGSACOLSfP+mTkv+JE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 09:48:33 -0700
IronPort-SDR: phw7JhdKEYukeTLoWNZ4vaKoawGcq7TAhPOX9F1LTaLBNf5hfCk9TWMYWrISpvvlRzqZMXqELM
 2sMGz637VlSA==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 09:59:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 10/10] target/riscv: Use a smaller guess size for no-MMU PMP
Date: Wed, 27 May 2020 09:50:42 -0700
Message-Id: <d65e90ab8ca5ee29ab26973c86a18549853a98cd.1590598125.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590598125.git.alistair.francis@wdc.com>
References: <cover.1590598125.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:55
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 0e6b640fbd..9418660f1b 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -233,12 +233,16 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         return true;
     }
 
-    /*
-     * if size is unknown (0), assume that all bytes
-     * from addr to the end of the page will be accessed.
-     */
     if (size == 0) {
-        pmp_size = -(addr | TARGET_PAGE_MASK);
+        if (riscv_feature(env, RISCV_FEATURE_MMU)) {
+            /*
+             * If size is unknown (0), assume that all bytes
+             * from addr to the end of the page will be accessed.
+             */
+            pmp_size = -(addr | TARGET_PAGE_MASK);
+        } else {
+            pmp_size = sizeof(target_ulong);
+        }
     } else {
         pmp_size = size;
     }
-- 
2.26.2



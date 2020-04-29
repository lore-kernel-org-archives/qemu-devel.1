Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E955EC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53FC2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EN9nbLdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53FC2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrdC-0005Xy-RN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraF-0008SH-24
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraC-0003VX-C1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra6-0003PZ-JX; Wed, 29 Apr 2020 14:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185435; x=1619721435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xAP1D28Ruxk2F1O9NmhqCbS55wsbO5b1VBkOLwbfPLU=;
 b=EN9nbLdJeSEOe39GPcLtxViEyZVWvSSQGFJ0vc6mQH8tUZGTD0ZmuCe9
 cyldnd805BqsrJtAJ3/jFX6ajBjUIUBX54XKdEyzcCieRG2ViuIK4TWev
 BqnL7yIj6bzyWSkldL4bo/9LKAWPHz62chu7Pgt9fCrUST2PaxrCTBtfw
 2uEcatY65yUfbckyuGY8N2exzlwkxBdQwJYvx9tg29IQCxbcrIey8YfYy
 JEan6SeAX1IrZegIXJ6t7lcV2D5futi0eVZD2V7MsjxLy7guRaxmJuEJd
 +HkTpbeIOVzLC13fMtpDoOlcN/PLqPVQtb8CDlth7mlj8cVekWEqkHH49 Q==;
IronPort-SDR: mr8Gi2ver2QV83FVQYSTuph3RzVFhhL/PbXdkTPQ2tMCeOKIQV65sn/AU+s+gfiUvSPGfcR8E2
 tzCMOA1Ioo2TcPbftyeQQeBfNxyyiS+GJU+fpZu7zt2FDQ6e1B7mi99JokHx90TKH/S8dIsf84
 R7el5h7bvZkWygE3IYjlcM5C3a0UyR9TQdcKaQ5ielWSrJIOqkxUIAkLNDzn6fBHyY2udc7c6j
 ghn/nOiDSxztyrlA8Vp+GtIvatjmNaOLXb9RhhLcAx2391fK2QgkF3ruNA9ugo1V3xRyz6SFoH
 vws=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935152"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:07 +0800
IronPort-SDR: MI8C4XM7g4JeIk3ppcnjznctMT2pgzLBJmE7lYw8h9yapS3N0sAI1e5EGCSWVk9ExKQLhCNelg
 ZeJpJ6iQ4+1a3e0JMLAlx1dlZspTN7d9M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:11 -0700
IronPort-SDR: spjpOaVPflTp66IWzQWIONik1mO5SVONUp1DXi70MoZa+humlSkje7dG9TNDYPiCe/XQBMcj+H
 31+deURj8FSg==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:05 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 10/14] linux-user/riscv: fix up struct target_ucontext
 definition
Date: Wed, 29 Apr 2020 11:28:52 -0700
Message-Id: <20200429182856.2588202-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: Alistair Francis <alistair.francis@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

As struct target_ucontext will be transfered to signal handler, it
must keep pace with struct ucontext_t defined in Linux kernel.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200412020830.607-1-zhiwei_liu@c-sky.com
Message-Id: <20200412020830.607-1-zhiwei_liu@c-sky.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 83ecc6f799..67a95dbc7b 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -40,8 +40,9 @@ struct target_ucontext {
     unsigned long uc_flags;
     struct target_ucontext *uc_link;
     target_stack_t uc_stack;
-    struct target_sigcontext uc_mcontext;
     target_sigset_t uc_sigmask;
+    uint8_t   __unused[1024 / 8 - sizeof(target_sigset_t)];
+    struct target_sigcontext uc_mcontext QEMU_ALIGNED(16);
 };
 
 struct target_rt_sigframe {
-- 
2.26.2



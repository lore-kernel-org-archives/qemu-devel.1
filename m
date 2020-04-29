Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2CC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6542076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JjIEpN7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6542076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtZg-0005IK-5K
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOo-00080n-BO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOA-0006uy-H9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtKL-000664-KS; Wed, 29 Apr 2020 16:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192145; x=1619728145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xAP1D28Ruxk2F1O9NmhqCbS55wsbO5b1VBkOLwbfPLU=;
 b=JjIEpN7ZBklAbwCmFpFRLZc6xcUJThs78MvQBpnL7AEEt9LlbkxQu57L
 ehqzAtg/ZE+9eXJpOk4mSGvwW6FaPF66+VQX4hWbZDQqPmUCJRyKbflvW
 cvfsfhVJsRK9acKFyF9qlKUSNUGuK/DdgCXiakqrU4YW6Yw2260pbffc7
 tdBx0kFA5pe1FTnjbE31TUrWrJ0yxkdL4ml98eFWgQMc0wrrssXovpOkw
 z9dtfM1n58i55QrTkmT1xV3SgopskDeRslZ4/LWacLMFWIllS7eV3eXZV
 bom+2lNhsmSW30D5O0MgYdYTwfCNo7H7uGoy4Qm/h75Js7sVs9rQyKES+ A==;
IronPort-SDR: W8JB2oCLHF8ie++1c2zNajwibdbxkmR9eCbsXmrJ2DgsnJJaQwUIskbvcvmkZqbOGy4EJkIFge
 RxUyAMPqzxEs4cEpfCjXkINxaFLlBM0SCDttha6Q4MjtvpKXgH+VD/CLo4FkeGAQnAx/GVS618
 jqpJ3pMCx8I8C2qREayUaUoaUN5w7H1qw8mAAN8E4XmumFRu7DEuH8GGhfxNXXg8mumMnvsGuq
 1zPO29vnYeCgfOMfiVTScK6YXKRTPrHmsk4TxIxP0ReLQiM0BiHqLLkgcUsr5jNLO4N07N73+p
 H+8=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507040"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:40 +0800
IronPort-SDR: N70QnSowggVf2ICZKldPqi7af4tyi0wNsXinJgAoA2uzBcAHIiu32FIegL/CX8a0DE0bgqsEPo
 1BgvBewJBd8c5b9aVI5rJ4ssc0ByaYlFU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:44 -0700
IronPort-SDR: 6TrPTPWZm4S7BSG7QiwNQacwj7H7TT7rt85hHsHk4AX1fnRigjE6PXWWyI7jQKRJlQE18JrkY/
 jtWvcq+7D+kA==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 10/14] linux-user/riscv: fix up struct target_ucontext
 definition
Date: Wed, 29 Apr 2020 13:20:02 -0700
Message-Id: <20200429202006.775322-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429202006.775322-1-alistair.francis@wdc.com>
References: <20200429202006.775322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 16:28:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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



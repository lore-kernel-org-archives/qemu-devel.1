Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14512C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03BD206F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XxeFPRAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03BD206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhRV-0000xj-Tp
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI2-0003Ff-2A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI1-0006Yx-0N
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:09:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhI0-0006JU-MS; Fri, 31 Jan 2020 20:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519376; x=1612055376;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HP2myi0QgHwUIpOeB7O6xthtCDeRYGykPyTEWPEw0LQ=;
 b=XxeFPRAhY2LDbWujIppa2bJk0JreIc2moBh3Mez4I2LDnmtfOhHHTYw1
 SLZZGvu7nxfOvaGPKSZivPr+BwDjzRk1ZMcLJ8vwfkU/qOvDUkD3Qbvj2
 3zxL0YozcvzJHN87Vd7hzJqwA1wc2VQ1kbgJA0AG3HhnpZWt1sQVLxor/
 h9e7WdwIksb2c0b+kgVkP7PqsSK9m5tIHVq75ebTMVptKeqW0ccM00vb9
 NJ9gTM+dU84L8HRRCmYQalak6OBNYV3xSMK+7XoGUBurrJwuebY1TjLlh
 YUMPYIEZCizTWJDWzd4zvQXdr/+rQfn0/m0Uc/DTE1IIm/9htGG8+nr28 A==;
IronPort-SDR: lN30cGyZuVQ7mpcEV7Q1oPTWpDYim++jW3nP1LaITcWAS8ITa2n8sQH43kSZzCbfeCK/b83Tvj
 04mFR7wIpctf3mJNc1XkShM195s5HkLBqDXkXTBw4jG99JeevUFo9K1+053G6dbruaiXq+Zpl+
 FTEurI6c/3PH2K0MhG7wg8NCmUDUWF4djXnk6jh/66fNrjJgLCDN7u9JUJDDlwFs/SknsQcCMH
 8JpWicXKvJTdZuKgKhQQlDNQhgIQZqT0++X2QBN7Ug5sXBCl8vFc9v4HHKzlmgTukfQWCBb0pJ
 85E=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872472"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:02 +0800
IronPort-SDR: SH4U5irUBl8iSr+BCgBATsUlZVxknkH5gdQMhOuFqvU9FlsmkggWiii18Ud2QgT0C7HZ1z/nfB
 eP7wncLgfxX2yCpbTmELtywMimYx4o4rYg+4KMr+cSrEFmeJ7+RSG63Hrgf68G3TLWsma3CYYO
 P/lt0eU0rH/BNiuFFDfCG57s5W/5QHOAwKik1SZHvpNar9dF+nL46au7OduAMNHLbwU5an6lfH
 kMzSny3nbb2Xcx4t/rlWg0tPSrbpLWBEAYNzou9OyZjUjP209qPB5PQK3t7ngIGigpEDQSOA0v
 4hmL1KyyJcR6HzE1hR4SM6TB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:10 -0800
IronPort-SDR: w1e74NtyrW72PcnIheDjkEHGG6wEHZr74YqLP9mKAC4WqllBLGmb9eHQiN8A74asKFd7Sb7DXG
 hDu0MPbIDK7bC6UayXrGuclRiHWtjY5U/dBtKSXaMBZFuYPXOqqcP+RTgLp7NsPtIEk05dKXsW
 IMDu7Qs0HVD520FcvQpoVOqV5OI1qb3O/YZW1OkK8Al6gvVXrfTkJwZIEiySIq95yJFlxLtx1I
 cTqjEpLVaIYXzCML88X3BB/rl6qXwamxkD3hMRaTyXnRFx0d7x23ksGZ6yGC7/c54YT7niL2DC
 ycg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:09:02 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 19/35] target/ricsv: Flush the TLB on virtulisation mode
 changes
Date: Fri, 31 Jan 2020 17:02:25 -0800
Message-Id: <3ed3214f75740bfa9d101c7b67d8f5ae017e5d16.1580518859.git.alistair.francis@wdc.com>
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

To ensure our TLB isn't out-of-date we flush it on all virt mode
changes. Unlike priv mode this isn't saved in the mmu_idx as all
guests share V=1. The easiest option is just to flush on all changes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 3984a1f1ac..98017df33b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -181,6 +181,11 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
         return;
     }
 
+    /* Flush the TLB on all virt mode changes. */
+    if (get_field(env->virt, VIRT_ONOFF) != enable) {
+        tlb_flush(env_cpu(env));
+    }
+
     env->virt = set_field(env->virt, VIRT_ONOFF, enable);
 }
 
-- 
2.25.0



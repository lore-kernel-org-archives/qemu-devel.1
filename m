Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A7C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519F7206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UZY1vkgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519F7206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtTa-0002qd-6k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOk-0007va-RY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtO4-0006FV-UM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtJz-000664-80; Wed, 29 Apr 2020 16:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192123; x=1619728123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XLpDvnqj9bkxM9N2CIUAMQTvObl1PtMILsBu24h494E=;
 b=UZY1vkgsrmNKW8FDMLsvO70uh5AHeb/iUaQNVHqWznvG9X6hreiuVXZS
 rrkbuvNguOkjo3ZqjEAKDLJ3f3hKUORLQCCbmpzMb4b9kE+SwYNegSHY0
 hlrSmhObiMS8VbzSzi+p9WXWoZXjHpkDgRjmUZoBh1FSsqkKjRaNO1TVu
 DuhYQAzECod4Br97CHsa1xOjAzbqhbsH0rfzPOM6/QVFmkHetxtFVNMqX
 itIMH3MEqmVbfo+YeH/kTlCe8W12SNTx6NRv0QyZS5YBTvg0GX9tCKAkD
 MqWe34l+jrYGqPRXSfRQRRrs+dIeH9q5YqjkNTaxv3R2gIRPvTrUL0sMi A==;
IronPort-SDR: UdjDx9iFsruECsy2wfDI2KcGNgrWoV4jmhxcMu9gD/dWpWVcP1XmCY/n3rs0rWeL+PYpunfCqP
 Qci7aw8QKqZVbgbkrtB2FdQgj2ZryfQ+JyS90gE+YSZ+2Yw+Soo5+kq9ny0/RW6/Zl/hlU6WjS
 T40E/zgZmKBMY6TySZ5sSWiPEcY5cXiB5n1N9vm4QHgISlGBmv+RBhhoTlVOMCu4miFMJ1Q5Nj
 mqg6mUpJrUiKRh+6+QGNvvdM2amFk1xGUMJnaO5TWmieTd4FFFg3JBuVaLfT84ysvp5gK8MHsB
 Eac=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507034"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:38 +0800
IronPort-SDR: IPGAcAFd5veTwIa6ZWEq4RF8qkyH3KTnX2pFBr1NELEKh+N3tPz5vA80DgjQMFL80Ypp7XwqVw
 bcHxlpkWu/tkUDXCBWES+0exa61Snmtk8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:43 -0700
IronPort-SDR: VKp1u+Iwkj1aknyShC2BYwcTnom+wbBoaTOAFmRiabV9V+OUXCNRnmW5fJw7E5v3FUom6VhUf6
 76nNQD4UKMPw==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 04/14] riscv: Don't use stage-2 PTE lookup protection flags
Date: Wed, 29 Apr 2020 13:19:56 -0700
Message-Id: <20200429202006.775322-5-alistair.francis@wdc.com>
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
Cc: qemu-riscv@nongnu.org, Anup Patel <anup@brainfault.org>,
 palmerdabbelt@google.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When doing the fist of a two stage lookup (Hypervisor extensions) don't
set the current protection flags from the second stage lookup of the
base address PTE.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Anup Patel <anup@brainfault.org>
Message-id: 931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com
Message-Id: <931db85d6890ed4bc2b527fd1011197cd28299aa.1585262586.git.alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..f36d184b7b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -452,10 +452,11 @@ restart:
         hwaddr pte_addr;
 
         if (two_stage && first_stage) {
+            int vbase_prot;
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, prot, base, access_type,
+            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
                                  mmu_idx, false, true);
 
             pte_addr = vbase + idx * ptesize;
-- 
2.26.2



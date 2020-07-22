Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39968C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00142207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ik2M4cv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00142207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyI5l-0007fi-7C
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4k-0005ze-VI
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=465c3c755=alistair.francis@wdc.com>)
 id 1jyI4i-0002hc-Rn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595437116; x=1626973116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I0pdoDeme+HuR5fVQ6XAsARi8mHiU5f3Dp/ZaZKJpnE=;
 b=ik2M4cv4m8HNpZlduvW2YLc2M1/MWRDi/65e6xWQCFzJnffsOlyUJJM5
 Etc9pJntMzRk32qyNhobmniQsbHWQ3fi6saQjPlNWo4U0+lSiO9V0rYDZ
 XQ4TECcrzsJ+rovPJIxjpEvn1kH8P7iiOTEc0PGN1GOlk4mA3fHx63qlT
 hU0Rfb1/cAMvYbA9bQmfN+0MkLkvV5Ia/wMLqt6desFI9di7Wvtmv9TlA
 WbTMxbeSAtpjHBVqRUOHPlX+Ewv1Ob7YsvHF1Rw8hgDyhnF5pYthV5VHq
 iw60iEtYraPPHzmLr9l0zbLoTH33NLNEQT5fAURP0MhcO5M69V8PruP2t A==;
IronPort-SDR: lkzvQ3cWkP+ZeOgpxGB49noS8iUNz8bJojKatm7LetoPuYdOdjkZE0hK8Slz1xa2SFMCkEdqe8
 WZUB5h95TyCjcmZRTf9U++aGJznKcLr2BQK/R4XJJwLUo9BwjhRJj+1cD139LcF6nggqDfJkqo
 hcJYcWMqEhXGvc0MkAHQJukcZsqVNYCYFxAdfWLlUyvkp6Atb90qCWlDMM+71xD+gJp+LvfIGB
 +ZyISc44wgjXaf8YC9K+UWnEzTyBMm+Hv1X2ujVKc97xF4Bs2OsFH/e5NjyBRkOANn4lrSniwX
 Jm4=
X-IronPort-AV: E=Sophos;i="5.75,383,1589212800"; d="scan'208";a="252418638"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2020 00:58:22 +0800
IronPort-SDR: Ufn2PwBWqxXIaQpjg+7WN8QUCuUKAup0S5wLuGnYhRabQtH6R3S7n0YOJkGzD1Eja/XKayScsg
 r+c87DnRiTczg4kmn6jyHM4/yQbVs822c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2020 09:46:38 -0700
IronPort-SDR: E3uBad/5vTPgNF75YGMPh4naLr9RsLM5MGVgtHKEue1EV7yNHVM2W6UcGoymQypMT9Tk4m4OkX
 s2Ql/PnPmLkQ==
WDCIronportException: Internal
Received: from usa001575.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.115])
 by uls-op-cesaip02.wdc.com with ESMTP; 22 Jul 2020 09:58:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] target/riscv: Fix the range of pmpcfg of CSR funcion table
Date: Wed, 22 Jul 2020 09:48:38 -0700
Message-Id: <20200722164838.1591305-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164838.1591305-1-alistair.francis@wdc.com>
References: <20200722164838.1591305-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=465c3c755=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 12:58:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>, Zong Li <zong.li@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zong Li <zong.li@sifive.com>

The range of Physical Memory Protection should be from CSR_PMPCFG0
to CSR_PMPCFG3, not to CSR_PMPADDR9.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <eae49e9252c9596e4f3bdb471772f79235141a87.1595335112.git.zong.li@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ac01c835e1..6a96a01b1c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1353,7 +1353,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTINST] =              { hmode,   read_mtinst,      write_mtinst     },
 
     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPCFG0  ... CSR_PMPCFG3]   = { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
     /* Performance Counters */
-- 
2.27.0



Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CAC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABBD20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RP6IogFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABBD20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs2e-0004FA-Pw
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmZ-0007vt-F9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:50019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmU-0007kZ-J4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149270;
 bh=37Qg0M6Cgn8RIf6R4DNY3eDMd1YwBtJmIys2nkMm5vA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RP6IogFT4+9HnNsSVOnE4kiN0y1BsOpG239QzLBjV6D1Ayq4eZRAIOym5+zLMS8xw
 PXCxC09dKpY68J+LpffFOeR1M4+MUSV7vLut9/pMNF67xwce1gKvlayQ1pQUJvsZB2
 MzqTcXHf2vxXwIaLyWlqg9Nr5wsTUjMIQSVLoO3E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1k9jAj2Zpz-005H9B; Thu, 03
 Sep 2020 18:07:50 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 02/10] hw/hppa: Make number of TLB and BTLB entries configurable
Date: Thu,  3 Sep 2020 18:07:38 +0200
Message-Id: <20200903160746.27491-3-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iB8h5gi8tl0fVeIS1JY1XRWwQfA1kd7ZOufl1NKc8AgCG67iYzI
 fDPlqMJ3G0qTVr+6Ts0vP1BPQ67bva4aqzqiKp6K2uXusC+IHm/xV5wKcWvfvWWSSdH7qbb
 +ENODaQZ0ednydBfPOXIJFp5v9vLKX57mFkaBeyrWZTQAV26Tn3CX+AOq3I64EfvsWmX/9J
 byNcYAFPForKgWSuRhnWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2E1ejVb5Wc=:Ynb22IXx3pMKbcwAWnLGn2
 lke3/YKV866iCvPyugTrhaavHO8ZzWXI+rEzucKp+8YYz0ji8SCuPIMB7BhBmBSsbV7LQrhTv
 xS2pTf7tio/lZ6JtRWW2gSQ4h3W9Xtwf5ZO4IEeEy/xtJaySb2Ql8KwJ7l6wL+GhttpSyUhL4
 y/YoBTG77v9XHGkVZnqu8x4EVMddX2oqlx2rxSVNW0xfxQt+PjtHwZBUlIE9Lyg84XdGOf+AM
 gxiJrFb/ONy1pGvKyt7W/RpuxyZ9fUmcRv5dnJXhiJWzVxLbXE3DeRnSEjHE+Prpo2qVtbfHT
 cm1OMRjTEgoKWGiXu4kYv6D1KlJpSbGCFpknkn7uQZtYrbGvDfOzNdSjDwz+K1A53+b46EDWx
 NMScTvg3SnW8mlS2pVKC+5yXVjCDaawcwgTzm6Y+wneBX9Pva92rWhr5jsTJPc9iySf2DRH3P
 Bw9I7TThwZlYliK/oLw5CXcqF0wO8vJ8IfIB+/aBCSjjrX6XUK3CjaX8PY7/q8aOBuPNdeg+0
 zpYPCczRIxEhEyw71YPQU+rk0c61RI3ZpOHB2mUVf30VhnV4wjr2cYVRl8nMw6ATHqdKVN7N5
 0VtNlIg+fprBMToK9j4SRWxGDiE0a3xiw5hl0E1tsC/4AoimrCDOdbrk1YX+unmvZVYrplsyn
 /NQClELKkIi1jYWPBJlpGenG2QFqWxPmmz1nVvpMnMKMR9XYpsWzSKBe+5C4wxIQGXdOZ8IO/
 wzcOhE/Wc9h0uYWOXpTwbeQASIl3Hd86AexqobjlqmUjfnIgbC+AubVCj4lQuMPmTYukb+n0R
 loUMZUgEX6w83hnQDyWf5WJzl8lJDnyBWZ0QvAj+FshiLTN5z52XSEIffhzhIzmUA+FndqwJQ
 ec+hXQeqNvF5f3vrze3e1+eFxQrsO3LEeacXSvpHAoMXqKS1G2A6jEPGWfIje+twqDogOY1jo
 Oexo9BrWJYL2vxy6iIKKL0yqAb8oMI+x/W8mGB3Du+a0deR/qeRtqAFIqufIX/7PG/3W/PqGV
 fhES+vnJi+XNdaCzioyit9YeLMKaG5oOVdGSuscuJ2bE5ZXyI38cD3zhOHdT5L8suYlCrUDfb
 wpFuJhNFGjVzszIyv03goDY2b1zmrGNIu/nNlD7e0zHeG+/IaIn0uhRvUAQOHA1mQHBoX3/BQ
 NkRoEr3+uNaVEdFKeT7j9MSbambMJitJZUVqMfkWqLM4b5lCkG67r4b/+s1j32BxwW0PGQrxb
 6U9wBzyT5tdYiyDtp
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Until now the TLB size was fixed at 256 entries. To allow operating
systems to utilize more TLB entries in the future, we need to tell
firmware how many TLB entries we actually support in the emulation.
Firmware then reports this to the operating system via the
PDC_CACHE_INFO call.

This patch simply does the preparation to allow more TLB entries.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 8 ++++++++
 target/hppa/cpu.h | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 90aeefe2a4..e9d84d0f03 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -72,6 +72,14 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
                     g_memdup(&val, sizeof(val)), sizeof(val));

+    val =3D cpu_to_le64(HPPA_TLB_ENTRIES);
+    fw_cfg_add_file(fw_cfg, "/etc/cpu/tlb_entries",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    val =3D cpu_to_le64(HPPA_BTLB_ENTRIES);
+    fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
     return fw_cfg;
 }

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 801a4fb1ba..fb6c59d075 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -196,9 +196,12 @@ struct CPUHPPAState {
     target_ureg shadow[7];   /* shadow registers */

     /* ??? The number of entries isn't specified by the architecture.  */
+#define HPPA_TLB_ENTRIES        256
+#define HPPA_BTLB_ENTRIES       0
+
     /* ??? Implement a unified itlb/dtlb for the moment.  */
     /* ??? We should use a more intelligent data structure.  */
-    hppa_tlb_entry tlb[256];
+    hppa_tlb_entry tlb[HPPA_TLB_ENTRIES];
     uint32_t tlb_last;
 };

=2D-
2.21.3



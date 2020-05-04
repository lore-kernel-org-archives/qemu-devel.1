Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F81C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F22206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F22206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa2P-0003FI-KH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZju-0003DP-Lf; Mon, 04 May 2020 07:58:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjs-0002JU-Ii; Mon, 04 May 2020 07:58:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M894P-1jS0xl1PVr-005JNp; Mon, 04 May 2020 13:58:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] hw/ide/sii3112: Remove dead assignment
Date: Mon,  4 May 2020 13:57:54 +0200
Message-Id: <20200504115758.283914-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bMYhpdRoGq4TloRGXhT0RRzVkdA2HsVH38gxEEbUu2mBiqfL14C
 rte2EhtZ3DK3F+uI/Cvm/n41idenNNxJAQnBY5pTs5lpFeMOmG2Fx9D4F3SJCPDUzyV8HLu
 vcMgs1C9QyjCq/20MaJIBFWuHpnvNeutjXOm1CD4kgLCqIh64wySvIX/h2VmQpA7Yysa2jl
 BvgeAa7MVvTIllHzAUCOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s6R3vZ250Cg=:cZEQ0lRSD/yu4gi2y6GAU4
 O2NPZy/PsS7BUcdfns+ith+XK5cceEgGhsPyqAQ7nV5xQ3KdoXYAOA6t4p9ikl6pJk0g0WJhW
 TU2ft8Z0fTgGwCDveJuSsKtWckF5Own9vSds2m+qSV85dg0tRG0GjiGfWqtxJuQN6Vp+cfj+J
 VKaz3ZzDd2r9Irlrg1PEdghPyEKo/XmlzERnKBrtSl1uo+G7L/a0Y3eabm2zviTs8bKEEWAfd
 5EbbjDtUmtnyiOYQYhI+cxwXX/AN2V7EzJqUITiQrW5s6c77Y7RqPa1ivm7GeGSwEKUiYvgiO
 YD7DDfRxtNQ1zZCVk7+Q+F0RqKkji5PuzDUSdR7aG6+J8tTDuE2hmLusp3iEjgQUF6x9G02ez
 3tuNLP8kmzLIsCVFdP/8JmNIzIF5rtfzoJ7md8jzwqbez3ZsnkysONSbI9Yxam//DjPQ+8gs/
 DlXsLl/INGbGm6OMfUyjL0EJNX53pLL39Mk0YB3OyvgPNbMyesqUCo2UQED15zmMSOIXixaNZ
 UFfqVnquYpsf0b99nKQF0AdH8LLOvy9lVYK0euZpvGUREmETKjCuW+58QN0CNDq+XSpQSoGad
 eFVKOtyEcm1qPxjenWhGY8nOUqlSdGgYJICXL/+xrSUNzD8YQAktCienIKO1oe7kp2Wqqnmvv
 J2RCZvhlZkB9a85iaWceUhJy+Xl0WpH0/0jNo4tMZxBzvY+fbIw6D9b4sMwUJFQwH/UGxEg2i
 jWP4s5JN52pqwBgt+ylOUTz8OTRBneMDNRVZor7Zuc5TQiS/pgkDTQE3al4tI4mGCgLw8zI+X
 rhV+zEdS3poc+zj2Unj8SXTJ/z3O8Rba18aZ57TV/igWJNqVpOSppa06dIYFx5gk+dVoHxA
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:04:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

    CC      hw/ide/sii3112.o
  hw/ide/sii3112.c:204:9: warning: Value stored to 'val' is never read
          val = 0;
          ^     ~

Fixes: a9dd6604
Reported-by: Clang Static Analyzer
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ide/sii3112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index d69079c3d9b7..94d2b57f9535 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -42,7 +42,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
                                 unsigned int size)
 {
     SiI3112PCIState *d = opaque;
-    uint64_t val = 0;
+    uint64_t val;
 
     switch (addr) {
     case 0x00:
@@ -126,6 +126,7 @@ static uint64_t sii3112_reg_read(void *opaque, hwaddr addr,
         break;
     default:
         val = 0;
+        break;
     }
     trace_sii3112_read(size, addr, val);
     return val;
@@ -201,7 +202,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
         d->regs[1].sien = (val >> 16) & 0x3eed;
         break;
     default:
-        val = 0;
+        break;
     }
 }
 
-- 
2.26.2



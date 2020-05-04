Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48526C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9312053B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9312053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdiq-0008Gh-6N
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW2-0001Vc-KU; Mon, 04 May 2020 12:00:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW1-0005ud-D3; Mon, 04 May 2020 12:00:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mum6l-1jF4ZA1Blz-00ro4i; Mon, 04 May 2020 18:00:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/19] hw/ide/sii3112: Remove dead assignment
Date: Mon,  4 May 2020 17:59:52 +0200
Message-Id: <20200504155956.380695-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lgVrMoml8bYCxI2Y+gJetK2X5PYyHDeGI0vM/BCBrUlgBU4vesB
 pRo0wzORuvfwE6X1WN6sO4awT/cBaHaEpkBIzOrb29e5qRkF+DKKulCYWiTbiTZW36AZe2x
 y/ETeVuZ8C2ddWYrFex1exTvGsxSi+yDXW4fSY5Dw8hwzWPiQpYfDZJnA9C5ZSBZKSb9ybR
 IC6zji8W6X/W4oy8SENJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MLrnwyS2kLE=:ZgXkqqoKPTBCTYfeCGH6gQ
 XtapdkH+03aGfU9tO3cD5rcUDIUa7Kmv2JFRyUK4TuL4SJaaDLOZMZy31FopHZskQ1YjLKOuQ
 pwnaQSqvtSuGa8ylCGgPJMItsKfB/HnG0QKaIg5n1opTetZYqofbzQbWlalX0wJa/NUdX6EXx
 vdo4BocXO1gfXZBbuN5GqDxqZG6oJUMdowPRqx9dX/nPIliJZp1WkMLaL2YWXFFLfz1J/3w30
 sbXJ53rm447U60SAwL0zcCU2IFrUCuJhA8SX1MI9MdPZQHmDUucF4UkiqdSJptpK+eXw3emtu
 BvCucf1+d/T4MHD/LVeVMJenqogQduQYiC60LHfQoEO3PcdH/8qz033F4JqVl/YER6g8BbjI3
 /lVJ4gBYYTpcSs6LeWB3Yy6HikW0pTkxU4Rz+EdYPqm4WPnfsbPPHa8gJtRicrta8oHgOb2dR
 rvH2w1UCXSG1wiZLPk1USl7c8Z0CGYrtvStX6PZgijUBQ+C+F5F2zTig3gciXWq5/nzXDNqUs
 lvKXxx9hWlUqxdJGoL4yofnTlFRUymiMCfKzCGTzPBaQqaMfEjwH7Y0QwGXZjwE0ULNE3CH1k
 dDdLaSI0wGID0f+0GToBhZbUGnG1hl0Qx2xHtt3MNTnC7VA3RwiBMkhldBahT++eFhvwRKV4b
 uO3trKmrqgiH9lDby5xB1VXBc6RVbl8qiJ8pRONk4dH45bCKPUb3M816Omb0cXp2Kj8MsjCpH
 ZF7CUzODPyXCB4hm1twQ4LqYq9OX225rWoSMdSiixXSlDPAZu9LASjEI7kHEs7miGBBUVRMAp
 NU7Pp+Fh4SQDOkjVWkaFXeMwsVjFnsZwklqbFVuYUJStHVQGwapKacITYiRmUEIwt0ibX2+
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:07
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



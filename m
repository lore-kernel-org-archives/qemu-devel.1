Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69931C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2444E214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444E214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGot3-0003QZ-7d
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo1-0002ym-Rg; Fri, 11 Sep 2020 15:33:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonx-0000pl-F7; Fri, 11 Sep 2020 15:33:57 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N94FT-1kcuQm0rXb-0164xR; Fri, 11 Sep 2020 21:33:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] hw: hyperv: vmbus: Fix 32bit compilation
Date: Fri, 11 Sep 2020 21:33:24 +0200
Message-Id: <20200911193330.1148942-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K4gAqu5gqDOiQPAt7j4PednT7s9z+df7zh63luO3srHDbESqqmT
 L+y+/SRIztKLnUXqISo/RraJQtbT5tflDaY8iECxMMThzbZjApz2N4MviXBpT6+8LQXi8qr
 +N2/XFRJjwSUGmGusH03HMwGa4Id5GmcyRXEYEGnWJfMqqMtySWVQknAnZKzEYK58XUjC5w
 yZzNh1ZtQkVu4KY3P1euQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uM8ICdled2c=:Hmcc8M85HnqHFY9KCqnI6g
 2NzWChgIn3HsxHpKenpsY3xeohG/MCDgH3Jv/PX0ru10hLoZgzCKeTmqN5Slphj1P47T6Z57/
 HOKV/78J6xq76EXQcvXWUw4AMvFmAWgJ7MjjqsGL3d8KRt2kiqHJL2hrhfVPWyHIlxT4B5N0z
 r//cPCITfvg8PL9NzvSpvIxVbn0rH4Bi9kkdYAbTV2DNznX3RlMNtEkee+r8kgSmX4KYaovRo
 Al9qHs2mCD5nzFI+zAUGjkYJx5wTOSItA1/8fDjDilK0TYWqZr5ihRbpSIEjSLiBPXPc8dhtl
 o9VPg25mK0htLfUXCTde77TScwdcFkpezkBBlPKpJbM5wo5Fd6eCF35wDauXJ3s+IrwSdBlyy
 YBudl6Aifuv/GsyzNK0t5e1X9iS0zYa5IswaIf/M8wzZz4Eg3WEPt0rrTRvysjeKCucv2suie
 xqaYESAgdzhNdalqlJ+emSD7MIj3BqbE7nT6FTf+iXzTvZELmvkAIBjtMUz0YwRSQTa9f61+V
 bbr7dlFZYYNS4U4B0ZPJZBkN/icFWIzxikKnU0pDprf1slQ9xB/5/7NuMxKEDJf1+68KVEzP+
 ebobamn/ZhmeEG+uNOViXFLQUViSmp+w0bR1dMN3yUP/RoFSUQ0wjWnWFJWNpyENm6RLspuRJ
 m52To9fFbuso9JHfEFwStUtJIVh2OGyOh1vohET1lsKkFDSZqPwSdJw0WUw3ijuTRfq7+0Q6W
 y0hNahPRkBLJObgsuR8mv5mfX0+sF/ue8hxg632CS+AOaMzEwi6Z+zNjj2yMmfq9cB/zYrb4Z
 Y7q57PnUrj60L5V5YRoP5zq85AtjmZmDAIzz1lZ2FBgI+vj6M/touSuEN5K27WSHsDc55Rg
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jon Doron <arilou@gmail.com>

Fix 32-bit build error for vmbus:

  hw/hyperv/vmbus.c: In function ‘gpadl_iter_io’:
  hw/hyperv/vmbus.c:383:13: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  383 |         p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
      |             ^
  cc1: all warnings being treated as errors

Fixes: 0d71f7082d7 ("vmbus: vmbus implementation")
Signed-off-by: Jon Doron <arilou@gmail.com>
Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200715084326.678715-3-arilou@gmail.com>
[lv: updated with commit description from <20200906050113.2783642-1-richard.henderson@linaro.org>]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/hyperv/vmbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 75af6b83dde7..6ef895bc352b 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -380,7 +380,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             }
         }
 
-        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
+        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
+                off_in_page);
         if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
         } else {
-- 
2.26.2



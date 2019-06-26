Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451EBC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F66C20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F66C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6tE-0002tg-Ab
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mX-0005cy-FM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mV-0000uS-H3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:09 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mU-0000nN-8M
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRCFu-1huMPQ1xUi-00NCN6; Wed, 26 Jun 2019 14:11:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:36 +0200
Message-Id: <20190626121139.19114-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8LioHe/lMony4uDwZrVGQsbC9Th7eTsFeIHzFVAi45zJBUTzqFn
 pmWkYTXEeaUiG7xgg+4Qu5yTkXBJh3S/MofESJvCl2VhtsI5ciHHZ/XlkUHR2P+cbWZUALK
 XEXAEphkossUkRRKCBTPeb6+U2YcdBdg4voFEDuHBjbewitNULW8KBOHFZ2Xhw2dtbswaiA
 D9AW8FlNAj1ObofY0+Kug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b35BU5mdNIY=:/nxkDKTFZgl5CieTikNQrG
 atnCnsGWjDJ0euJeWIMR+dfQZUgjlj+xtruAnuox39/kBXSDE/AVnSG3g0U8gXx9jz8C6Y6PA
 ujq2IR9S904d4yvaiT0iNq6foKRpVNWeLSAcM5U1BFBHAK0qi15gzcbQbvf7wtAsN40yGN1c9
 B9FpD75rj/D2BNn9qbgEF1IbUQL/1yMF0PtILZoqdjBf7ukeolRrVoEEQygHh0UAW0bkDtb/9
 BHdusuci2Foo3XSwo3uQaxnsKWlyjjXQL5qTSXuG5LHK++x6PzzzlQ28uVrn43lCGD/bVG1XQ
 nw1z16IH3FIArKD9asTd0LwnmKD9faLMt3Ule2Cs9dIrYMpM7IAiTcG2VLpUMv7O2KpfHxUG0
 504t4MNSqyee7ws0vY0olJ7uLcCYSWnhjitZVLM51/NafrKzA4w/8sDIRc/SblxLqM9yzTJmD
 a7SnMp+RVC7OSllveVxr9DW3S+teJ72WeF8rcsvnk3Me4oTxpli1cx0QFv/3uXGYmiQEp1Qc1
 pSaRokXlxYxXP7sr2YEREMx41/nDVc2P+Za1GWhMhLk8fpobZzh5+1GHaNYlxZML+/OJ8pIf5
 phmHACncH09wZtwQ5gk6z/RnTQ2GcjKGqfLUqbSAjG3Hitws5wxZHmsM1TcFQEKh5bnV1k8jd
 xE5iYz2YGnzvA42mXDYJkJIDTwIp/z+Oxe3DWFcz9CENTw5FApxkbn8bCX5xkZpeoUyR9UX2K
 XTJQ46P4/puKetu8dkErl/34X9OgdzM8PFi4aU+kvgDwb6iX5hsYUog6drQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 3/6] linux-user: Add support for setsockopt()
 option SOL_ALG
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Yunqiang Su <ysu@wavecomp.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yunqiang Su <ysu@wavecomp.com>

Add support for options SOL_ALG of the syscall setsockopt(). This
option is used in relation to Linux kernel Crypto API, and allows
a user to set additional information for the cipher operation via
syscall setsockopt(). The field "optname" must be one of the
following:

  - ALG_SET_KEY – seting the key
  - ALG_SET_AEAD_AUTHSIZE – set the authentication tag size

SOL_ALG is relatively newer setsockopt() option. Therefore, the
code that handles SOL_ALG is enclosed in "ifdef" so that the build
does not fail for older kernels that do not contain support for
SOL_ALG. "ifdef" also contains check if ALG_SET_KEY and
ALG_SET_AEAD_AUTHSIZE are defined.

Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1560953834-29584-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e942049cb0da..ed1c9b0033be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -102,6 +102,7 @@
 #include <linux/blkpg.h>
 #include <netpacket/packet.h>
 #include <linux/netlink.h>
+#include <linux/if_alg.h>
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -1941,6 +1942,36 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
             goto unimplemented;
         }
         break;
+#if defined(SOL_ALG) && defined(ALG_SET_KEY) && defined(ALG_SET_AEAD_AUTHSIZE)
+    case SOL_ALG:
+        switch (optname) {
+        case ALG_SET_KEY:
+        {
+            char *alg_key = g_malloc(optlen);
+
+            if (!alg_key) {
+                return -TARGET_ENOMEM;
+            }
+            if (copy_from_user(alg_key, optval_addr, optlen)) {
+                g_free(alg_key);
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       alg_key, optlen));
+            g_free(alg_key);
+            break;
+        }
+        case ALG_SET_AEAD_AUTHSIZE:
+        {
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       NULL, optlen));
+            break;
+        }
+        default:
+            goto unimplemented;
+        }
+        break;
+#endif
     case TARGET_SOL_SOCKET:
         switch (optname) {
         case TARGET_SO_RCVTIMEO:
-- 
2.21.0



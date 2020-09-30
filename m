Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22435C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643FA20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643FA20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ3U-0007qP-AX
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1N-0006Qa-22
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:31:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1K-00089I-FB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:31:00 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS3vJ-1jyN2U059f-00TWCj; Wed, 30 Sep 2020 02:30:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user: update mips/syscall-args-o32.c.inc to Linux
 5.9-rc7
Date: Wed, 30 Sep 2020 02:30:31 +0200
Message-Id: <20200930003033.554124-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930003033.554124-1-laurent@vivier.eu>
References: <20200930003033.554124-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pPg1763ftYxmOZe7qWMyUEGBomdvy4BCWC1NPaYsEysGGv7kbvG
 hMh3ywRUPbhN54VOhQQ4WVJErRu6HuuKpohBCSef7bXpH9cpUNJU9dhIKomLQMcArozofSa
 ZWpYsNWm+VrxguNacGhAUbsJbggBikE/5Vu6Cdp4jeO2AsX1Qg7t0urORohh5uHUwqytnXN
 QJkUE1/fKqg8VC0DA2zzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yMk2ZNNfW7Y=:BKLBEZhp4U16ScN1qXz8Cs
 OrjEqE+NE28RtJIc2gtkGup2Icficc4P7DX2FMRMpe8I0Rlk5G9ZiOb/bMvJI2zPnenf1cagX
 coOeG4w9wnsvEbSb7IdFcvXzDCKFcAF1DWQP16wSgm2D3IAbc2dYJ9x5PfaPEblgUPYn1zQk/
 62GBQp2khHMe2RcTWYTZBv7XltwylK0Rgx/FD4VU8nc/KyKGw6lA5/eHXwTp+AGb4bYq37AIK
 2FzUzC9n6ds3NCIVEkjaRqqxpVMrT3gzU/M2AEEJ71vZ+TcYOu6bWAvtmoxhnnCzAEKPyXqvg
 UBFa4mRNm2SqfvxBFGQ5b+68D8GtWSuW9UTIuySC+bvfLdxto3alDZPZdyG2ELZ8Fr80865iW
 G9Brn+tPQOUfMraN5um/h8PECl0aBT/utOXEDfL6bApcJNV6ODDCB/hbglLmOJoUIb6bEGWUX
 s3Y9rLoIqeLxzeNMOnXI2VvHoALIVUJJP+Ce2sJaZ0EpWdjbmGtQGZcg7GfqdDzaP4fsqOeVl
 oPGjtwCz3aonTiU4JwsyYMp4GWGa8HqCGN1c3aD6a4N0inmPv+kScqisDtSwr3JDZmKgmqxbv
 1TCeDi8H6e0bg7xhmeqeDc1r5BhwUuU5cdzOnxVqAWm67G3xgRDcOyTKg9X0aFtVUb2TYArjp
 z75PXP2mOMUNXm7pMufpUeJa2+3qCbWaQdNXY5r07U3mWlot+oGtmeOrhYoon4P/yFC6JliMK
 sPkJbB2qa5ZUvcbS8wcwa80AaamUCMzsZvaqxlGt39vTRWTp52pbL69Bst0+SRowh67lKp+W9
 TQtjMuVpNcLdVGD9FUcJX8X9Faci9Lk3ONV5Qgg+5MqfL4CmTg599xFM//3h9cFkh7bwC6Z
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:30:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Updated running scripts/update-mips-syscall-args.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/syscall-args-o32.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
index 0ad35857b4e4..92ee4f921ec7 100644
--- a/linux-user/mips/syscall-args-o32.c.inc
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -434,3 +434,7 @@
     [ 433] = 3, /* fspick */
     [ 434] = 2, /* pidfd_open */
     [ 435] = 2, /* clone3 */
+    [ 436] = 3, /* close_range */
+    [ 437] = 4, /* openat2 */
+    [ 438] = 3, /* pidfd_getfd */
+    [ 439] = 4, /* faccessat2 */
-- 
2.26.2



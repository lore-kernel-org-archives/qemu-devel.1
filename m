Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346DC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC942082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC942082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jKS-0001kO-Tu
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j87-0004wy-3K
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j86-0002Ip-0q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j85-0002IK-O8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:33 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N9MYu-1iAqJs0Mq4-015GEj; Tue, 10 Sep 2019 18:36:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:59 +0200
Message-Id: <20190910163600.19971-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j3hxowZgULFsmcQkhqJXfvJU6P0M974wp99dlXXw63V2K4PMAer
 q00eNjanqIeN1N/jIrjk8reaBdis5iEHJrpN5HYuwG+GKgxey2TNuegrfSgVDlT7NZPwQkW
 QZjYHz2uoQAJSUF0xr+tzsyw+aGlH+I9yFz5+qOJL6pfDr5B9t8AIVe80heQtF/VHgplabO
 +o5eJyrNp5Hvhl/Thy+GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NOOetTmBtf0=:DHIfczAsisCLrslwKVyrWQ
 ekUCcbVzbzI+mT36y5o/wswO/FqkTKzTAdlcKcp3tdLcZ0n6Xe7TxGnou2D6LzlWekrB8ejOG
 4BapOzpg95Gt24SdCv0GAJhDHRraTb+AjQHNLlYRfi+NjeSzSQqSGz5G+X7OMd2pFulThGFXU
 enhJeJEmfmtGLJDwPvbAp0lTJhow2PXAe/yt0HkUUV/nPHNNjwRX/XeAB2m1lquQjFhAYPa7F
 bPKX1rCO8xq+zy6Y9+IQZuZ1Os7GtWV2mRSVSy9dua3Thhpm8qgdf+drXmyHVZfNwEUk/Cy0U
 YSwmBPxSuhAAeMbG3m4m11AkqkuTaDEK4hrUtW0LHewnTE57nckbeSxuX8aA30TQEEsyrcVIp
 CEDGpgQ4omqr9ASnRpO07jHMWpo/nF9STjlKIcyPG1Fbl6tDysJh3+C3RI3zOJH0ds2+ip2Wm
 JrWWu315037VUHwS7emysJZe3gRe9V19j+OofGK9M2DgNmRET1yRUE56lOxHHrVDJcYISsiJF
 2ea89cl5Icvx4yfB2cKZY3qcE4s/VuMCyYuXvZHAOsqDjzPYgmcUzK04XHZBB3hF76I/O4Yv8
 zJxEhFU1/vBQcdW+PfNJ9aCQOelfCt34XffCVM9Sbj/0oYlW8WFD+30vtHJum1B3JuKC23Sh/
 tITJI70WpzcoVzscLsjD+80bTbyNHSiRsF+z8mpJ/7OW0u6Sy4Lr80eYdzD4XkPN/ZgeKHtei
 da0k+hnf7jdpLXFX3FCyNZi4lB9gBKX5bv//rZUj6DA4UMjE5IoZ3JJjd/D9ZBT9MPBTS4YVl
 hvMAdPGTn9voe5P4Wxho0/dzQjnQcdLNl5OwIk2Tso9K4GCdFc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 14/15] linux-user: Add support for FDMSGON and
 FDMSGOFF ioctls
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FDMSGON and FDMSGOFF switch informational messages of floppy drives
on and off.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-6-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index bc1944804220..b253469999ee 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -112,6 +112,8 @@
      IOCTL(BLKZEROOUT, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 2)))
 #endif
 
+     IOCTL(FDMSGON, 0, TYPE_NULL)
+     IOCTL(FDMSGOFF, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
 
 #ifdef FIBMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 917202a2035d..4e33ef396be4 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -890,6 +890,8 @@ struct target_pollfd {
 
 /* From <linux/fd.h> */
 
+#define TARGET_FDMSGON        TARGET_IO(2, 0x45)
+#define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
 
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
-- 
2.21.0



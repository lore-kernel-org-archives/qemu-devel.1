Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D9C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80C9217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80C9217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOznL-00072p-RZ
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:18:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlL-0005hW-Uy
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hOzlL-0001gB-4H
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:11 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hOzlK-0001fd-RL
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:16:11 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N1Oft-1gjefj1bUR-012tSC; Fri, 10 May 2019 09:16:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 09:15:57 +0200
Message-Id: <20190510071557.30126-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510071557.30126-1-laurent@vivier.eu>
References: <20190510071557.30126-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XzJq04w+5M3m2BSeE6X/5R7ET+xs+0l4O0ib+jrUACU8+B1n9xN
	J69RSVffYV0Tyt+Y0MewNajtzss6nVbO94XYCGrhhkmFYoMOc5z1GPzuaST4HJ5xTY0oMzt
	Ug1fTCMUIj8fGYYQc8f6I0TLMZ+56kVDVgaQERH1SKIyzgOcj4lUH49KWmnQKOjp86QfQpf
	PXZjUTmiUInV4x5p+1tiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h2wjnWxYZd0=:tlCZ9Szuf0tdY4wTA7ZyIP
	pHg33CnZoW6KFUqhR3J3CrfeKicCt+fGkh7UwYjvDZqwz/rUNO/MMLejzEFM4kBXW3dLGOvTl
	fAN2bwwteJ2WDVqcvhoMPGOssQeFcK+t7jGJrMTlHlRDqXmOgdPCe6IbkbXGsBotYUvMB96+T
	gdIXAEpQsk8xbYJzQ0lkGcTjdpOfJNXJ62zm5rDhlBn4Np3FGn5xAVDr6Otd80plB43oOtmij
	lTZNiufFC7UpQe02M9LKm7iQZvGIMohUWZFDbZ56k8RB1j0HIZ3VHYwnMF8qoEHnRJWoe4rcl
	TASpQHAZIcumem+0iquEeSPMWURO1PAuufbhmMnka6WbUOXCZoKJBAiP9TM+ZR2zTz3HLw5S1
	EqIKx9RQus2YYc49stP1twXRjIPUIb2CyTiv39uoknyhVC9aTSskPzo+JiZaYTk/n63Uh/Lef
	wrq5/j/0M9XdKNBkjBSlKB8rBqBhAimQzduhaBPNdhc2IIKvfE+n6lEoEYzo8jqcni49/6ERh
	b2dW4X7uRdFbhAEwaG68orhqkucEJA5BfySujiXlj+6MC726MNp+E6hUnW8YBLNSvKgUtxKpS
	yDixn/kZ4V4mUv8bCBSsKJGBzcOn3MeWWm3O/PoZdCTPd2kVh5EobAbsNik5wKuWeNnCgHtVm
	iP4rbkN5FFcXB1VXleFQQD0xe7gxj89b36HHHro+zU762HABjr5lhW69vdooBoAZPcAJzm4sk
	KCK8jVopG+nvD+PFFX4qhANaPcguS3rIMI/MFL4Jzxzqzq8pkoLLtjSu3Vc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 7/7] linux-user: fix GPROF build failure
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

When linux-user/exit was introduced we failed to move the gprof
include at the same time. The CI didn't notice because it only builds
system emulation. Fix it for those that still find gprof useful.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-Id: <20190502092728.32727-1-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/exit.c    | 3 +++
 linux-user/syscall.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index 14e94e28faf8..bdda7205532e 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -18,6 +18,9 @@
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
+#ifdef TARGET_GPROF
+#include <sys/gmon.h>
+#endif
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 44b593b81161..f5ff6f5dc8a8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -59,9 +59,6 @@
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
 #endif
-#ifdef TARGET_GPROF
-#include <sys/gmon.h>
-#endif
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #endif
-- 
2.20.1



Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97DDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813FD2087F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="CqYa2F2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813FD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMM7c-0006Yv-QH
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:32:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM6i-0006D6-9P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMM6h-00077x-BV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:31:20 -0400
Received: from smtpbg303.qq.com ([184.105.206.26]:38472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMM6h-00077R-3y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556843476;
	bh=fqx7px8aicw59s5wsPfWml96z0lJHa6tUbYs8uCbaaw=;
	h=From:To:Subject:Date:Message-Id;
	b=CqYa2F2jMwuHryqZpoZMNIe5vyLIP3Mr6wyxD8fLVb7ZHyfSpG/yvYSb8fEX1z31b
	iRkiqlJlkTojNkeSl3zvKuK8aw5OzYEhSNTrDMjnahzLlJA3De8pu44UGBCVeZFsEC
	t2STMLACWnBjxIlkOdLaULFTbQvzeetPWGGV3H6c=
X-QQ-mid: esmtp5t1556843473thzphk4qe
Received: from localhost (unknown [183.63.119.3])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 03 May 2019 08:31:13 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: 4BYgmPH5RlFjA17kQRr7ZyJkFx/kfakujIKzxM05g82e6NguNap469qtv1ut6
	xCAsyr9YL30V+wb6vlPIQRyAaP5XJYu07+d0vgd1TniHMJQuzfiKl5CzqmNzFrEAid3uwx+
	43V5HRJqNYzZC1ozLAcdr9ENkRipEuy3/t4RRTRQ342lf7g/Epn+4L12uxZZNScCKO7IL1e
	YVpALxePTUM99huD4FgLgci7ul1F4HRZW8oR8DjyAvQmkF7rPMO/ipqCrK3hbQNZjdrRgk1
	OO0wxqyadsk/Vr9igMAL5gvXQb9vC1pqO+yci2DheUFCTH
X-QQ-GoodBg: 0
From: Cao Jiaxi <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 08:31:02 +0800
Message-Id: <20190503003102.10042-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503002258.9799-1-driver1998@foxmail.com>
References: <20190503002258.9799-1-driver1998@foxmail.com>
X-QQ-SENDSIZE: 520
X-QQ-FName: DAE9471D2F334AC0B24022B5402A4308
X-QQ-LocalIP: 10.198.131.167
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 184.105.206.26
Subject: [Qemu-devel] [PATCH v3 4/4] osdep: Fix mingw compilation regarding
 stdio formats
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
Cc: Cao Jiaxi <driver1998@foxmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503003102.zep6Y4Ro-Bo4ksBO5oLEysSsGj0TgsHVYtdl3JJeReY@z>

I encountered the following compilation error on mingw:

/mnt/d/qemu/include/qemu/osdep.h:97:9: error: '__USE_MINGW_ANSI_STDIO' macro redefined [-Werror,-Wmacro-redefined]
 #define __USE_MINGW_ANSI_STDIO 1
        ^
/mnt/d/llvm-mingw/aarch64-w64-mingw32/include/_mingw.h:433:9: note: previous definition is here
 #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be 0 */

It turns out that __USE_MINGW_ANSI_STDIO must be set before any
system headers are included, not just before stdio.h.

Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>
---
 include/qemu/osdep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 303d315c5d..af2b91f0b8 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -85,17 +85,17 @@ extern int daemon(int, int);
 #endif
 #endif
 
+/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
+#ifdef __MINGW32__
+#define __USE_MINGW_ANSI_STDIO 1
+#endif
+
 #include <stdarg.h>
 #include <stddef.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <sys/types.h>
 #include <stdlib.h>
-
-/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
-#ifdef __MINGW32__
-#define __USE_MINGW_ANSI_STDIO 1
-#endif
 #include <stdio.h>
 
 #include <string.h>
-- 
2.17.1



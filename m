Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17667C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41452339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41452339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LxN-0001jh-1y
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0LwH-0000PG-DY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0LwG-0007YG-C9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i0LwG-0007X2-2i
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MekGB-1iYJqL1oFZ-00amI7; Wed, 21 Aug 2019 10:25:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:25:46 +0200
Message-Id: <20190821082546.5252-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821082546.5252-1-laurent@vivier.eu>
References: <20190821082546.5252-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FPDr0L5pH7NCfwta3oN+Eh7y2+C+Mfd/ZDKpoKYoUT5fWOM28Fd
 Lvfg43yjJM4mdQQG78fyBY79rVDFzVXFhqUbFnMsx1HVB2OI8o5ZHtVvfxibeOPDjKw3fMW
 7GQiymnbPFx83btEPZ+dU+YQSR/T5tjlTV3FK5rPDi+wWC5tNp92ThbAbIfplav6VDLJl0V
 j3uKQNP7Wy1N/SES3yPtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IJhO7bWI1Hw=:J0tmZr+DzwAnzUCg947MV/
 bzWtxGys7TzpeLTl1zRHqKU4Maz3KtP7XmVKunT5i90UfCNCD2Jxy4tBbZ2Hi3AW2+icWPtub
 aQmAgPgsyrgL217s8UrUWyPwQl1djWtLLVyomenWY7FIBj+heHrsdMVLgEoDVVB/sAPq6AKrb
 9ANZ555VQbIWEQiAl136hby8wtwBJw2qvxJ6NVMNE0tFXY1QzL6ohvmcGYQmp5/51hd0J4ZTG
 IyC3g3dm3SjRvSFjuTGMqLnTNOWg8ZxszLrk7pYrVScYijWYmVrneO3zGgxFl+DOuLOzcZbpz
 rXnXel6IAiXMXn23Nimn0b9TrB+5uJUTJUN6GrgDku8A93EUq4A5bBUSIofWTQiMtf2N3tCBe
 GHg7yhqralhJM5CrW6aXdr0iMKXUQvfUthzZxTriBdPtPJZAEnOQw9Rz0BR4V/ak9aSPHgSsz
 MLmUy+nefP69UwpalvZNqfBxN/UrhrO1VRVYtIL+3qrIn+4+92tkQcQiH7Ws6uiqfzUX844v+
 GUercvjATHw2obTSK8kpiWs7pwhkKpg9mGtCvGFF8GG2MC3V2NSFzUuIMVatWs4xcWi07fXdt
 Ko83yeidSvG9No0jfNwkbtcyBbPF7Zc/XbbJvV8U+VNRrjVXgdiuNYEaTSeK6S+7GySLLugEV
 7QX0b1PTA21hrGKlekun65YQWgiMWxX+L0QHAQD6VDh8FMcdyhF+L6VWJLyKQF2fzamHRg5W0
 Q7SD+2bQOHgRGwb/E2MN3SPAthXe/hiZhfdizQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PATCH 1/1] Fix cacheline detection on FreeBSD/powerpc.
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Justin Hibbits <chmeeedalf@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Justin Hibbits <chmeeedalf@gmail.com>

machdep.cacheline_size is an integer, not a long.  Since PowerPC is
big-endian this causes sysctlbyname() to fill in the upper bits of the
argument, rather than the correct 'lower bits' of the word.  Specify the
correct type to fix this.

Fixes: b255b2c8a548 ("util: add cacheinfo")
Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/cacheinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index eebe1ce9c5d2..ea6f3e99bf4a 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -65,25 +65,28 @@ static void sys_cache_info(int *isize, int *dsize)
     g_free(buf);
 }
 
-#elif defined(__APPLE__) \
-      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+#elif defined(__APPLE__)
 # include <sys/sysctl.h>
-# if defined(__APPLE__)
-#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
-# else
-#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
-# endif
-
 static void sys_cache_info(int *isize, int *dsize)
 {
     /* There's only a single sysctl for both I/D cache line sizes.  */
     long size;
     size_t len = sizeof(size);
-    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &size, &len, NULL, 0)) {
+    if (!sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0)) {
+        *isize = *dsize = size;
+    }
+}
+#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
+# include <sys/sysctl.h>
+static void sys_cache_info(int *isize, int *dsize)
+{
+    /* There's only a single sysctl for both I/D cache line sizes.  */
+    int size;
+    size_t len = sizeof(size);
+    if (!sysctlbyname("machdep.cacheline_size", &size, &len, NULL, 0)) {
         *isize = *dsize = size;
     }
 }
-
 #else
 /* POSIX */
 
-- 
2.21.0



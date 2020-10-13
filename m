Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C8C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3C92080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3C92080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIuX-00056X-Gy
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpr-0007T8-59; Tue, 13 Oct 2020 07:51:19 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpp-0004zZ-5S; Tue, 13 Oct 2020 07:51:18 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4rD7-1kRTcQ2XAd-001zY8; Tue, 13 Oct 2020 13:51:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
Date: Tue, 13 Oct 2020 13:50:51 +0200
Message-Id: <20201013115052.133355-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bMEwQZ/2+w1BP1pBsvNGrwUA7NAW3yel8jGng8WANQkE+G78HDC
 EvmQc3jTNFzCK6/GtJ4KRKK4NJvX0ScTtmIVe2JclR8gn9A8g6l0MsNJrgGqwp+z/tngr0l
 hA0mcUU/8JXii/oKAk2HS/YMzWKLklJi7Zp74L/3iKMIIa5JFBIDaDfcqy+aRj9GQ6Qwvji
 KMAJBAMpV5rpFLI6PGKZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OsPRTZe8LuM=:wHy0fDft2zQSAjs+Nfx3vV
 K9nRES06BDpbLxI8vgGsKF8SZRneNg5fBjXyMZpuYqMghzpjZjUZrK4DzDSZztmKdF3GzRbKg
 GvHTf1YRx820NIVhnXL1ZAP7G7kiLOWC49iwg06lxxNSLYMJFzFwHmFS8zNVX/rXEbey7U3UU
 uEgGUF7UBN67aFrhi0LgdKPm9HmxPVNsVgY/oNFarupRpKYEmF0s5tQDTuNBnP3n7xj6/vAtw
 joNwd3P1qjEGtmf3iG6/1i8itJrvx5ogiB6v8b4TRRr1c0WPowLXq6Ms3AMGDS1WorWa+fYoa
 mI67PLDhy3z1AoyQe+c4q8ivnwTho7xxUN26ylHhCfXtXSmJU2jPIDmmSM498Sy79lMPgk/5h
 PrcmEo4J/8W0ROJGk3u3EPSggj++NalvO40ax6BkGRPaYPuQquBFMECla2Q4y4fljQveLxq83
 b34zTGCxXs+wAmCEmBCgYBpEWsnpksFbgs8935+u4w6FJpxxVUb94pK8FYTjGkmmo1Y2L6Zt/
 5xoEwSBwkmOdR/JR8EbA+YPM8aGLrCIX9+Fa126HFyTw4Jkc/sLgChIVEynvN9/bH9MmaKytH
 hb2+bG9QHfst2C4J7O99x7yVbnJDnTSm9vUbu2DFJZAXtkqJXtwpmm7pumy6IhXZHybIk3rPU
 hVRfShOtxsORhsrqAl77IzipStzM06KxfHRGzOQVxsCzPZNEMwPbwK+V0MkqHLzCTP/IJycLc
 tSXnazASLpEVSVoINq3b9Dwedb0sW4kfgYeH6Nas+pY7xQMzOELT8H5Z9PmqtbadLIy+Q7e4m
 s24JB6w61pD6RZKRKl8RDlmN3a4/8f67VM9O4IISN2hMn0slzTEv9qVHkrYdGLyYzg6T2fq
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:32:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Always put osdep.h first, and remove redundant stdlib.h include.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201008165953.884599-1-marcandre.lureau@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 migration/dirtyrate.c | 3 ++-
 tests/test-bitmap.c   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 68577ef25028..47f761e67acb 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -10,8 +10,9 @@
  * See the COPYING file in the top-level directory.
  */
 
-#include <zlib.h>
 #include "qemu/osdep.h"
+
+#include <zlib.h>
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/config-file.h"
diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
index 2f5b71458a3d..8db4f67883fe 100644
--- a/tests/test-bitmap.c
+++ b/tests/test-bitmap.c
@@ -8,7 +8,6 @@
  * Author: Peter Xu <peterx@redhat.com>
  */
 
-#include <stdlib.h>
 #include "qemu/osdep.h"
 #include "qemu/bitmap.h"
 
-- 
2.26.2



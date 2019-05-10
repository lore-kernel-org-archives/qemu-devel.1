Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F87C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ECE217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ECE217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP34B-0000Py-Tl
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:47:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32D-000788-Kl
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32C-0003Vc-Lk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32C-0003Uz-DW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:48 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MmQUL-1gyY3M2LI1-00iS8Y; Fri, 10 May 2019 12:45:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:36 +0200
Message-Id: <20190510104536.17483-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vnp9sO9bsBtHY23Rv87ruW1IedEDylnTSw/JngGbdN+Sn+v5ue6
	V+vY+jfX4MHALsCDR5+cSVm9jteOu4TnUaidu0wb7TGmOjJpdzoxTKuQmp4aZzEgCTMVRVI
	otWkieotbHPkf/5TUQcyOpglPAZFMJnUCErtN4u0Rk1k8jq6cOb0bDsPlqSJpcE/F1TLRsD
	Q+fhbx0p7qBnpkKUHt5TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehbUMQwMp48=:lTlwX7co5kT9WRvo/BOo0I
	WgSoBguHeSS0rVG3VI91IKeekgoaM6d0sbEWZE5lZ0FXnGnaCbUqVBMmuYeIAvxEzOxrZ3NwG
	3nD2crBA1+qz9v/RNEE3oUsA92t7IuZxf58EgEuKMT4aOA5mmXSHDeEEK9q3fBRSTwySFb5wF
	WEMC7gPFRpPi4nEtkaHsFoV7CYV67jsFqF1Bx7qolzn/6NsszqxzTJGOwRaNBL79RDXPU7zf9
	ZpcA5Ld5EuJx/0uvw7zdVsyU/DaJgabnFlw/ImPLDT1Oy0SkqhHlG1VrrQwsJ0Ir5gY5dnTlF
	W1E0zCqTYoarhOvLXyubdSASFaf6MPQXHhj/LuYRFfxeEHQ2KaOvEWO0irC7ru5fIBAoiKw2u
	9nE87HQNYjvb9JuajqOOFeKlXmjmTKIS2aaqjB4LuesSfExUvTxlxg0sZjEyuOCxm6NsN8UNm
	TVnpe3PhhuKc9xpVGn6N3dxui6uy24KxWSWrn5jMdrNxhR+ESyASN719BrYCVu1SrpwLskeU6
	Je+SnPamx5g4D09O3wKkKLVuXiuVsZlZ8DTmdCX2o0Mh9rWy7I3WKQZDdeZWTKRVj1CbwnmPe
	T/rwVbR6a0nwbCwsEKKc1Z1+4g8x3+tMLf2ZUcOAe/1iu+mhdc4HiK49rW3Q3pJsfB2G2Efds
	3cc3UwkBtaTlsCg5TYgPIKgV9/HULAU+SDbM72pHOkg4DKkbsbz1vvFq2kVG8AkSvjZ3P6C9A
	u1pRWJ9kThY+vbQa1iLor9p3mjsUENQA6CbwqiApyPZiR8ZyywBTnKxXklg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL v2 7/7] linux-user: fix GPROF build failure
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



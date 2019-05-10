Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B559C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C9520881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C9520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41037 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3AY-0005oa-6t
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:54:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32F-0007CF-3c
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32E-0003Xj-51
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32D-0003Wz-T4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:50 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MxYT3-1gVq0t3NyD-00xtYQ; Fri, 10 May 2019 12:45:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:31 +0200
Message-Id: <20190510104536.17483-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B18h2bbB+DvXy/LsGfaQGDwqnqdRjV9ivPqai/M0fqd84uX/P47
	jwYv/rOJRgznf2CrQR/vv5QmaMFSm6U8YhB3u0ms7w6p6WyUvspTWCNUzylrBnOWewi82rw
	tKGIvSwr1+SRAROvHF1kB0Un78QHb1q+/VdO8e8/Zb6aDrqyP9Qczhp0wK71EQ4lAoPecXH
	iBd8J0GYzVbrsyaNNMD6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IfQqvT2QTQk=:dxB6v6qyZjcCCBdsBN6crE
	RsQkbGYXKbITCpSXR6oZhAZ0lHW5twErXvSyV6vPQN9eqpuVM4vBN3XnsjOpTvedYL8cMByOK
	sGpAYLlt6KLtKDbI1YVySJTPm2Ru7vLSiNj8yUZYOVSOsp0WqwptTMPIhURsics4b/Hw5kWQ7
	N92m4nUs5xiPKrvyMqjh8Qusa654rLLEAWBcCLmp25hq3PZMrGFWY4FtZ4Ae+7gbIiA67XNrm
	zh2OQBvtb72DApweYlki5kpLbJxh2/17ySn1beHJjlT0BcP/aPQvVzttxH6x3h+zuGZ1KJDmI
	kJHKR2sSLtnrVjFlwaA8bRaBZcBnkp9GKVlmETndhRjgt6b+i+ZO40v+GiWC916Li1/YhS5eh
	XhBu2uVh9Z/0M7pkcHb1fTwG6yY84PV5U01a+abEjNrR97nC/ZI9QBeqFRCDTwsisszifcASo
	qRT0fRmO61t5kNPr4c/yhIYnLzRZo2KM/g2NXgx2nq7h9r8TZiazZ7Qli2ejKGPXbBvYqea5S
	DVzlAQhU7sQe0wmMcXhmmlOpWvuDR+B4scgQdy40MbFnjTTslGBzHAVo2WfkOvZACWuzxkfvm
	sbU0PGgvdnSN2ONHcA+3/aT/xraMWLVIf7NwdU0G17D4R7s66iXnrdkW/2FIunCgEq/HdbqQu
	4IUFTnV+V1pOhOAspMwGcNVkWHsRGYXk5jGEDbzSPcPbmu9nX5ohqlapDw2r/eS9s3/GV35jQ
	pcybh9ZS9wbnGziBFmw5HEpTMtepQl3RQevUqjbfKOShRF5b2+Lgqt/ThuU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL v2 2/7] linux-user/elfload: Fix GCC 9 build
 warnings
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Riku Voipio <riku.voipio@iki.fi>,
	Alistair Francis <alistair.francis@wdc.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Fix this warning when building with GCC9 on Fedora 30:
In function ‘strncpy’,
    inlined from ‘fill_psinfo’ at /home/alistair/qemu/linux-user/elfload.c:3208:12,
    inlined from ‘fill_note_info’ at /home/alistair/qemu/linux-user/elfload.c:3390:5,
    inlined from ‘elf_core_dump’ at /home/alistair/qemu/linux-user/elfload.c:3539:9:
/usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 16 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8d7..d08fe2346683 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
     target_gid_t pr_gid;
     target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
     /* Lots missing */
-    char    pr_fname[16];           /* filename of executable */
+    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-- 
2.20.1



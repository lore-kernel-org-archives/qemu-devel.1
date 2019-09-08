Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE9C4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0732A206BB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 10:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0732A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6uot-0004m1-3x
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 06:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6ukH-0003bD-VZ
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6ukG-0004dD-V0
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6ukG-0004aW-LL
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 06:48:36 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRnTQ-1hjDyx0i30-00TFdD; Sun, 08 Sep 2019 12:48:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 12:48:15 +0200
Message-Id: <20190908104816.20713-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KoCgvAiafcQ9otrq6itW9xO115jMTh2G5idkN0FZKSZgNixM/j/
 t97GUVtETzL3SqqB4RAfg0VzT2TocwkUjuWDQ3/0atAJNZs6/bv4qGeWjVogqZVWlSPuknB
 KRHVbdOEVIwa6FtzO/w4Rdtzy3vUjMqrxaVkgGEjMWjF684ALbGO35CXoGBtUtE7GKohbvn
 sQt8vuaH6jRhuzZiYz64g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RykH3zLm6Yc=:qUogJkeoFF2k63T2V6fX9e
 OcSWk2BaSAPiHVjXqn4djzY9bz/z4kUwbLWth35gBh4Xgi3yEQoTekaKVgoKTIrV9P7fzQQZK
 gigaTQ8VxQJkaCJmRX7T6Nd3hr3T6KUznvj8gO9AybLSGsY4sNt5Av+49At6brQ9mkr2UrN6b
 AKOHvWt6LVWSD1naiIkoaaDvZq5azmXWUQw4Dus8puFf2qpAOVnPmdblfTP61eUOIKLU1zb4k
 6a6s52oVYFujeVLgxFEQEDVynjzCZLPRd2MN5onI/lSQaeNSc9WyxN0wiy4hrCCg6ROwThPZq
 uWNtxZaCNSogKURA7wM3QvzZ25wQ1UZGVnQRAxsJVBQL5eiduozrjN4Pyz3b/Zb9mDjTbl0sJ
 4xHXooIq0c3roFVCaE83LiySwkB00XnY0XjeRL6t8iTFP+PJbvbdoowwPJM2Mn/VcXbA3Xc5W
 3qr6ha4Ayz8yQVI1SeSqua4dRrjIurI9YIykFwxQMsCXbsG7DAvFuPfqYhKZi+DxhV0LZ/h3q
 RRc+Krq5jp2CLMcDCfAT2l1RRmBsYG920RWL/0LcvMRUiOICeB8I6pmrOFY8spP8ieZBNdBjZ
 hCC3nXONDKCBLgQZ75J6/bGFbYZSu0Lt5i2auh83I1isg/vMq5MgIGop9i0yAix/PbPIfQsQ3
 W1JTvjZIbRXDQo6UcjnmhYMO6OPeAvP72epakaOD10wLubsi/vfQ7DP3oGZ8gnKcLYofHVW0o
 GUi9EEJqse0MYJpSWu930URP1NBtIizENiQB+PArvlrHnRPntP/7i6LHYi1WYOt1cWlCAqSBE
 v6ceuBE4TpZXXbRr9/HQn8NUOTSVdHJL54QO14ijEQoeMA4wbU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: [Qemu-devel] [PATCH v2 1/2] linux-user: remove useless variable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

filename is only used to open the file if AT_EXECFD is not provided.
But exec_path already contains the path of the file to open.
Remove filename as it is only used in main.c whereas exec_path is
also used in syscall.c.

Fixes: d088d664f201 ("linux-user: identify running binary in /proc/self/exe")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20fc..28f0065b6ddf 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -49,7 +49,6 @@
 char *exec_path;
 
 int singlestep;
-static const char *filename;
 static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
@@ -586,7 +585,6 @@ static int parse_args(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-    filename = argv[optind];
     exec_path = argv[optind];
 
     return optind;
@@ -657,9 +655,9 @@ int main(int argc, char **argv, char **envp)
 
     execfd = qemu_getauxval(AT_EXECFD);
     if (execfd == 0) {
-        execfd = open(filename, O_RDONLY);
+        execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
-            printf("Error while loading %s: %s\n", filename, strerror(errno));
+            printf("Error while loading %s: %s\n", exec_path, strerror(errno));
             _exit(EXIT_FAILURE);
         }
     }
@@ -784,10 +782,10 @@ int main(int argc, char **argv, char **envp)
     cpu->opaque = ts;
     task_settid(ts);
 
-    ret = loader_exec(execfd, filename, target_argv, target_environ, regs,
+    ret = loader_exec(execfd, exec_path, target_argv, target_environ, regs,
         info, &bprm);
     if (ret != 0) {
-        printf("Error while loading %s: %s\n", filename, strerror(-ret));
+        printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
         _exit(EXIT_FAILURE);
     }
 
-- 
2.21.0



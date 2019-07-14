Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F60DC742D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEC92064A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 13:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEC92064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmekb-0003ie-Fz
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 09:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hmekH-0002QA-2h
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hmekG-0004V4-4x
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:53 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hmekF-0004Rw-SN
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 09:40:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHFwM-1hiClZ3BXU-00DKAM; Sun, 14 Jul 2019 15:40:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 15:40:27 +0200
Message-Id: <20190714134028.315-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W2oKBr2yYGbFSuf9U/8f5mZmEhzv/n4Vt8nY4mXqU0da53Gpd/M
 XJ7NcanRsitBp2VffZYDi6lEwPw6AIPz2Va+7mkxHO04BK1L5rn2xIHlaiSjowgx6Y+Ohvc
 dyZKmNcpbp1plG2YwoYd+LNSSqVMxWUgEp1WScbe7Upvv5QF3yqJf1GH8GmnP3i8z/bEZLb
 25eEu3q6sFV/mKyFSk/WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RU2I3wTcelE=:YFdhpJsMvO9KvPUDBEDbCa
 7wBttdPRS43Ycsk9GS4d9onilyg0sYlNvBObW4G2wkwPj1i+oYeT7oUNmBJ1t/cqfh4FNc9nX
 JD5N4oS7GqYMfYTeLSxOsprX2qbIK942rvno36CJz5xH8n3ctzAZBnL1R6ESK8z3D3NRT5SYc
 MdhPLlsJRBLANfH1UP0Nk2lz2NIhN2AIWy7O8/T10SZP7qcqSnco0Gv9LgfZX5MTuGHEo2zh6
 srCZdokBCQUY/CoZWPmWEr/4P5Btx7URLGWh2Bory6MQLikPaGP/AikJ8Od3CnjO87uhB2bw0
 W9Tm5R4uUhm4uXJrMvb8i1qYUla2hz2CrrZaDw44he7ONgOc68YfgpYI9iTCZtntU17uy2127
 BlHJKiIIgvXKMNUzxCvYxOY9xYshJIIuwIwlwXnzDvydK/RwWAC2vo0FSTw791W+DtxMrqBZY
 geqZlMyL4sPvYrGtclogyK4dwbJCZSSX37YJ/2kaqgIuVqj6zJpa15HIzfM13ZugI19crcmJF
 cDKs9u2z68mnbSr7M6N39IyXnUQpidEdeAI+da/01daOcK8JW/dWWbPlSi2RqoCvs/nmCVWik
 sSjBMNCbETywQNu3upKCz2Q5706nKakUwIE5/PEMm2F8h5FxDRvRoKom2XzpGwpATDe3eKzdy
 zeX7+EAFdz3eG8z/RWgEBt3BDQonUhvtAr1tHO5zI1QvniOvEeoBNhNbsSD8bv9eR/OkvonJd
 gs1u4TsPL8KPYSu89+snf7H6Qkf4YiNZaPXo0A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 1/2] linux-user: remove useless variable
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
index a59ae9439de1..ef8e8cb10eba 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -48,7 +48,6 @@
 char *exec_path;
 
 int singlestep;
-static const char *filename;
 static const char *argv0;
 static int gdbstub_port;
 static envlist_t *envlist;
@@ -580,7 +579,6 @@ static int parse_args(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-    filename = argv[optind];
     exec_path = argv[optind];
 
     return optind;
@@ -651,9 +649,9 @@ int main(int argc, char **argv, char **envp)
 
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
@@ -778,10 +776,10 @@ int main(int argc, char **argv, char **envp)
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



Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157AEC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A412081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A412081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jD8-000262-Hr
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7x-0004fS-F1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7w-00029R-By
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:25 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7w-00028h-2q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbzhv-1ih4sB2VsF-00dZ1m; Tue, 10 Sep 2019 18:36:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:46 +0200
Message-Id: <20190910163600.19971-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3R9/nrf6F1+CkOxpfuZXTiwuoLi5+ZCthPICIeKxQmd0X1UvGFI
 MQmzmbiT/3J+WnCW6EqF81pvOlc3TzWWY37E+FojlVlnQfUN+O7bVrOQkpJsNDh5wANfigX
 CaHHcknek7lf/z2cNEXB1/bPjYqZSM5pd+K0vwCw4/aW7OKUXjY22SQnNP3yzNIqb0R8UoF
 RJnInhWrsHAPV3z/SLnxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UvcckU/Hz6g=:6lal6D9cpfbS/ftM1T8tvo
 dN3z4J0yjaeCS3Uj76R5rRNSPOFtomsNK0n5Q489+P7P0OrPMSp+qavKVbKaiu7v5CmxY/gW8
 kp2juFqUy6Fpiqs1/x0fbhGxFNUy85owI8QMQITeR76BF+AYcFVGivIbUB6O0QonWH/WkFkKZ
 75VGcTldsBkmb7QpcNexPgasZMS4p8m3FTdR7cSIei6F7veyLiXfq1uQ56Q2TYaV+3laeBpEH
 Kr+MvQQOokx2SR6gX3iBbCUFSTQYbzT65Ni21odrW0TRlpHppCHJnR/Pm2pGrEDVmJv5SQ1tz
 dAIDTvtxBET7PtGCwyjsW6PmxVrlACmDqNL5I2uhSMyjRCcloGgnnKBnwSTLfRW4sid3e4if6
 CUxqeWiZ0W+2ZmeaCaHBpiqt04092H65c95422SbeZRmD8ubE1K8lZ7GXwlg2E0lS9Gv1nmd1
 ekU0V2GubZan6F3ggM/OG5eH//ZvQU7vKjCh8Hjh0z21+gECJgG5be9ClM22tXpjk4STkWRg+
 hQV9XxZq+TlWfxOpt16gqxDmYy3SzPey9gTqX9B0jLqhzyBKunqvKmqLrz6Jz3W2w8V5WMxYp
 XcOUo90PtOGoBKqs3GuVD7Ntiw2QV/c/i3m+5WY+W0p3tqyJWPAYOIlQfC2rUvhN37dDF80Vq
 OtWkqF3htZYjC7KI2PAELMiaf6/OgAK47MAdh5MpGZpPbVKGG0QQIPMb4LbQ3snLN018txDpQ
 8MxHgeQeEN+gP5nRa8X2sRvcaCtcKKXEXOC02eTgl48fnAszyPdhJ/XEn5ZnHEjbbSgD2/EUT
 A5EQbUnNVKIQWx5dBFksaqPGQVzXww0LrBu433CH65dICWrAc8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 01/15] linux-user: remove useless variable
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

filename is only used to open the file if AT_EXECFD is not provided.
But exec_path already contains the path of the file to open.
Remove filename as it is only used in main.c whereas exec_path is
also used in syscall.c.

Fixes: d088d664f201 ("linux-user: identify running binary in /proc/self/exe")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190714134028.315-1-laurent@vivier.eu>
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



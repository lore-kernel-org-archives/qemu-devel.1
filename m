Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6DECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96117222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96117222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wh5-00059v-QF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRk-00068g-Ad
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRj-0004Qj-8g
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58021)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRj-0004Py-0H
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:43 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzhzd-1iLKWS2rw1-00vbu6; Wed, 11 Sep 2019 08:49:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:06 +0200
Message-Id: <20190911064920.1718-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XRNaDVW/Z6FFauGWDmfsEwdbmHLOp9czIYg/b7ZfJNy9qHKSfGE
 H29vtQwz34phoQeBvDFaul7IhkYM7kkgeblbhRyuVReX6iH2xZ0HQbw6cNuQAmyNWe/5v9h
 OM+/n4WMocQe/9ZzRR1wVkMA2ZYxKhwMYPs//Eu+fxr8fnwqbEpH1nunhTqRVJ+HjaqObim
 Kiy5vJZZvdnyG+1Fc2NRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g+4deSDCMqQ=:5LDGnoSHT9zYaHZq4eChyl
 wkBSEG1Lm965AykirnABv66GwVBtdb3be0NMI80huF3vxDRXl+YgcYjL2zYeuyGmP2buUFjyg
 E++sGDaBdgxa0HUW0Bp7Ju+iXXJM3sXM3SYJ+1JthrI32ZJ16q9q4vZvvQbtdpRDF8J8iy10V
 /txQccNthfJWCX0ZkJQAfXCw31es6yCNuVM1BQ3NEQ2KfY3RG9kyWQUG+QD0DwRF8wL6kZqEx
 vIqr1ZLkcYh8Wx41QoyA7l+wLjOVjxrARUUfEUXjYdO+PA3swHavAeIWOzi7uG+nqP7bqFvgX
 o1dQqTysDZzEJ45/CgBaYBhORKNYPQFaRfcwXDsqHRK+U8JSkVpMYWVJhoqMmKATPyHiSs6ov
 IV4+oxiQyJfht6sznBDER3qbhGsZI+g/d8gZekuJNgBB1p5C2aKtQjmjlYlKbwPjH6cmiFfI/
 Q1W2gs9nDRybBGek2RTrID+241hYXC3JFFSZOhAbuBybDxfDVek2ZV+iYSv+BjDBeRDETXDzh
 dqIcJr0x56rz3lgsCg3cCDDIxUiNBcWJu7ZKxIpch00cio61JPjlqk9MnUQ9MdC6GHt4dhGbx
 2PWk8c+UNCeX2/2qoamLvKIWWO0lpzTC2I03bujsu6i6C+5x46XJxqFty2tbxFL0X4gQ4NCSF
 UTkngEnueaR/ipcBBjqpvYcmXlFUgqe0b0eM+EpRF1A0KZhE1Kp9EMsUBHaQXFwRUTrpCq4G/
 VxkuZJmn0FoH1gAn7pLBwMPleEr1gFZzeIk0w+zT2KM9PAGydc7KxzbzA+sKIzXbwxLYsx7ls
 mg9TTswo+e/RjTV3sN2GxCOO9m/JR09NOng4Zpe5Nw7JSW4DHY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 01/15] linux-user: remove useless variable
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



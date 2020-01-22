Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051DFC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 01:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01DA21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 01:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01DA21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qindel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuRJO-000278-Sb
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 20:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salvador@qindel.com>) id 1iuNNm-00041V-Vs
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salvador@qindel.com>) id 1iuNNl-0007FU-SB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:17:50 -0500
Received: from smtp.qindel.com ([89.140.90.34]:45952 helo=thor.qindel.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <salvador@qindel.com>)
 id 1iuNNl-0007Cc-Mb; Wed, 22 Jan 2020 16:17:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id 106FD601FF;
 Wed, 22 Jan 2020 22:08:15 +0100 (CET)
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id D-EQ8sW2gTWe; Wed, 22 Jan 2020 22:08:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id D634260214;
 Wed, 22 Jan 2020 22:08:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at thor.qindel.com
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id XMXxiAbV2CnJ; Wed, 22 Jan 2020 22:08:14 +0100 (CET)
Received: from freeso.my.domain (unknown [82.213.225.96])
 by thor.qindel.com (Postfix) with ESMTPSA id 69593601FF;
 Wed, 22 Jan 2020 22:08:14 +0100 (CET)
From: salvador@qindel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu_set_log_filename: filename argument may be NULL
Date: Wed, 22 Jan 2020 22:08:12 +0100
Message-Id: <20200122210812.17124-1-salvador@qindel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.140.90.34
X-Mailman-Approved-At: Wed, 22 Jan 2020 20:28:29 -0500
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com,
 Salvador Fandino <salvador@qindel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Salvador Fandino <salvador@qindel.com>

NULL is a valid log filename used to indicate we want to use stderr
but qemu_set_log_filename (which is called by bsd-user/main.c) was not
handling it correctly.

Signed-off-by: Salvador Fandino <salvador@qindel.com>
---
 util/log.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/util/log.c b/util/log.c
index 867264da8d..3cd2ebfdf4 100644
--- a/util/log.c
+++ b/util/log.c
@@ -151,22 +151,25 @@ void qemu_log_needs_buffers(void)
  */
 void qemu_set_log_filename(const char *filename, Error **errp)
 {
-    char *pidstr;
     g_free(logfilename);
     logfilename =3D NULL;
=20
-    pidstr =3D strstr(filename, "%");
-    if (pidstr) {
-        /* We only accept one %d, no other format strings */
-        if (pidstr[1] !=3D 'd' || strchr(pidstr + 2, '%')) {
-            error_setg(errp, "Bad logfile format: %s", filename);
-            return;
-        } else {
-            logfilename =3D g_strdup_printf(filename, getpid());
-        }
-    } else {
-        logfilename =3D g_strdup(filename);
+    if (filename) {
+            char *pidstr =3D strstr(filename, "%");
+            if (pidstr) {
+                /* We only accept one %d, no other format strings */
+                if (pidstr[1] !=3D 'd' || strchr(pidstr + 2, '%')) {
+                    error_setg(errp, "Bad logfile format: %s", filename)=
;
+                    return;
+                } else {
+                    logfilename =3D g_strdup_printf(filename, getpid());
+                }
+            } else {
+                logfilename =3D g_strdup(filename);
+            }
     }
+    /* else, let logfilename be NULL indicating we want to use stderr */
+
     qemu_log_close();
     qemu_set_log(qemu_loglevel);
 }
--=20
2.24.1



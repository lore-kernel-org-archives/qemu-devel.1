Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202DFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C0A21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C0A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5IZ-0002EJ-3h
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:10:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Az-0004Nn-Ab
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Ax-0004KE-Vr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:03:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5At-000485-OV; Fri, 10 May 2019 09:02:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1609B753F5;
	Fri, 10 May 2019 13:02:55 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A091001E86;
	Fri, 10 May 2019 13:02:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:38 +0100
Message-Id: <20190510130243.8887-4-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 10 May 2019 13:02:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/8] util/readline: Add braces to fix checkpatch
 errors
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Jules Irenge <jbi.octave@gmail.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jules Irenge <jbi.octave@gmail.com>

Add braces to fix errors issued by checkpatch.pl tool
"ERROR: braces {} are necessary for all arms of this statement"
Within "util/readline.c" file
Message-Id: <20190330112142.14082-1-jbi.octave@gmail.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/readline.c | 50 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index 3eb5a66dfc..a7672b51c1 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -54,8 +54,9 @@ static void readline_update(ReadLineState *rs)
         rs->cmd_buf[rs->cmd_buf_size] =3D '\0';
         if (rs->read_password) {
             len =3D strlen(rs->cmd_buf);
-            for (i =3D 0; i < len; i++)
+            for (i =3D 0; i < len; i++) {
                 rs->printf_func(rs->opaque, "*");
+            }
         } else {
             rs->printf_func(rs->opaque, "%s", rs->cmd_buf);
         }
@@ -178,13 +179,15 @@ static void readline_up_char(ReadLineState *rs)
 {
     int idx;
=20
-    if (rs->hist_entry =3D=3D 0)
+    if (rs->hist_entry =3D=3D 0) {
         return;
+    }
     if (rs->hist_entry =3D=3D -1) {
         /* Find latest entry */
         for (idx =3D 0; idx < READLINE_MAX_CMDS; idx++) {
-            if (rs->history[idx] =3D=3D NULL)
+            if (rs->history[idx] =3D=3D NULL) {
                 break;
+            }
         }
         rs->hist_entry =3D idx;
     }
@@ -198,8 +201,9 @@ static void readline_up_char(ReadLineState *rs)
=20
 static void readline_down_char(ReadLineState *rs)
 {
-    if (rs->hist_entry =3D=3D -1)
+    if (rs->hist_entry =3D=3D -1) {
         return;
+    }
     if (rs->hist_entry < READLINE_MAX_CMDS - 1 &&
         rs->history[++rs->hist_entry] !=3D NULL) {
         pstrcpy(rs->cmd_buf, sizeof(rs->cmd_buf),
@@ -216,8 +220,9 @@ static void readline_hist_add(ReadLineState *rs, cons=
t char *cmdline)
     char *hist_entry, *new_entry;
     int idx;
=20
-    if (cmdline[0] =3D=3D '\0')
+    if (cmdline[0] =3D=3D '\0') {
         return;
+    }
     new_entry =3D NULL;
     if (rs->hist_entry !=3D -1) {
         /* We were editing an existing history entry: replace it */
@@ -230,8 +235,9 @@ static void readline_hist_add(ReadLineState *rs, cons=
t char *cmdline)
     /* Search cmdline in history buffers */
     for (idx =3D 0; idx < READLINE_MAX_CMDS; idx++) {
         hist_entry =3D rs->history[idx];
-        if (hist_entry =3D=3D NULL)
+        if (hist_entry =3D=3D NULL) {
             break;
+        }
         if (strcmp(hist_entry, cmdline) =3D=3D 0) {
         same_entry:
             new_entry =3D hist_entry;
@@ -240,8 +246,9 @@ static void readline_hist_add(ReadLineState *rs, cons=
t char *cmdline)
                     (READLINE_MAX_CMDS - (idx + 1)) * sizeof(char *));
             rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
             for (; idx < READLINE_MAX_CMDS; idx++) {
-                if (rs->history[idx] =3D=3D NULL)
+                if (rs->history[idx] =3D=3D NULL) {
                     break;
+                }
             }
             break;
         }
@@ -254,8 +261,9 @@ static void readline_hist_add(ReadLineState *rs, cons=
t char *cmdline)
         rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
         idx =3D READLINE_MAX_CMDS - 1;
     }
-    if (new_entry =3D=3D NULL)
+    if (new_entry =3D=3D NULL) {
         new_entry =3D g_strdup(cmdline);
+    }
     rs->history[idx] =3D new_entry;
     rs->hist_entry =3D -1;
 }
@@ -297,16 +305,18 @@ static void readline_completion(ReadLineState *rs)
     g_free(cmdline);
=20
     /* no completion found */
-    if (rs->nb_completions <=3D 0)
+    if (rs->nb_completions <=3D 0) {
         return;
+    }
     if (rs->nb_completions =3D=3D 1) {
         len =3D strlen(rs->completions[0]);
         for (i =3D rs->completion_index; i < len; i++) {
             readline_insert_char(rs, rs->completions[0][i]);
         }
         /* extra space for next argument. XXX: make it more generic */
-        if (len > 0 && rs->completions[0][len - 1] !=3D '/')
+        if (len > 0 && rs->completions[0][len - 1] !=3D '/') {
             readline_insert_char(rs, ' ');
+        }
     } else {
         qsort(rs->completions, rs->nb_completions, sizeof(char *),
               completion_comp);
@@ -318,25 +328,29 @@ static void readline_completion(ReadLineState *rs)
             if (i =3D=3D 0) {
                 max_prefix =3D len;
             } else {
-                if (len < max_prefix)
+                if (len < max_prefix) {
                     max_prefix =3D len;
+                }
                 for (j =3D 0; j < max_prefix; j++) {
-                    if (rs->completions[i][j] !=3D rs->completions[0][j]=
)
+                    if (rs->completions[i][j] !=3D rs->completions[0][j]=
) {
                         max_prefix =3D j;
+                    }
                 }
             }
-            if (len > max_width)
+            if (len > max_width) {
                 max_width =3D len;
+            }
         }
         if (max_prefix > 0)
             for (i =3D rs->completion_index; i < max_prefix; i++) {
                 readline_insert_char(rs, rs->completions[0][i]);
             }
         max_width +=3D 2;
-        if (max_width < 10)
+        if (max_width < 10) {
             max_width =3D 10;
-        else if (max_width > 80)
+        } else if (max_width > 80) {
             max_width =3D 80;
+        }
         nb_cols =3D 80 / max_width;
         j =3D 0;
         for (i =3D 0; i < rs->nb_completions; i++) {
@@ -383,8 +397,9 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         case 10:
         case 13:
             rs->cmd_buf[rs->cmd_buf_size] =3D '\0';
-            if (!rs->read_password)
+            if (!rs->read_password) {
                 readline_hist_add(rs, rs->cmd_buf);
+            }
             rs->printf_func(rs->opaque, "\n");
             rs->cmd_buf_index =3D 0;
             rs->cmd_buf_size =3D 0;
@@ -495,8 +510,9 @@ void readline_restart(ReadLineState *rs)
=20
 const char *readline_get_history(ReadLineState *rs, unsigned int index)
 {
-    if (index >=3D READLINE_MAX_CMDS)
+    if (index >=3D READLINE_MAX_CMDS) {
         return NULL;
+    }
     return rs->history[index];
 }
=20
--=20
2.21.0



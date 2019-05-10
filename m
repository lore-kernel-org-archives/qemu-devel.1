Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD609C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732052089E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732052089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5Ey-0007gg-JB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:07:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Au-0004Ko-2n
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5As-00047a-SR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5Aq-00040V-3l; Fri, 10 May 2019 09:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54DC93004151;
	Fri, 10 May 2019 13:02:51 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E2255E7B8;
	Fri, 10 May 2019 13:02:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:36 +0100
Message-Id: <20190510130243.8887-2-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 10 May 2019 13:02:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/8] util/readline: add a space to fix errors by
 checkpatch tool
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
	Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jules Irenge <jbi.octave@gmail.com>

util/readline: add a space to fix errors reported by checkpatch.pl tool
"ERROR: space required before the open parenthesis"
"ERROR: space required after that ..."
within "util/redline.c" file

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190401024406.10819-2-jbi.octave@gmail.com
Message-Id: <20190401024406.10819-2-jbi.octave@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/readline.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index ec91ee0fea..db399d3948 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -48,13 +48,13 @@ static void readline_update(ReadLineState *rs)
=20
     if (rs->cmd_buf_size !=3D rs->last_cmd_buf_size ||
         memcmp(rs->cmd_buf, rs->last_cmd_buf, rs->cmd_buf_size) !=3D 0) =
{
-        for(i =3D 0; i < rs->last_cmd_buf_index; i++) {
+        for (i =3D 0; i < rs->last_cmd_buf_index; i++) {
             rs->printf_func(rs->opaque, "\033[D");
         }
         rs->cmd_buf[rs->cmd_buf_size] =3D '\0';
         if (rs->read_password) {
             len =3D strlen(rs->cmd_buf);
-            for(i =3D 0; i < len; i++)
+            for (i =3D 0; i < len; i++)
                 rs->printf_func(rs->opaque, "*");
         } else {
             rs->printf_func(rs->opaque, "%s", rs->cmd_buf);
@@ -67,12 +67,12 @@ static void readline_update(ReadLineState *rs)
     if (rs->cmd_buf_index !=3D rs->last_cmd_buf_index) {
         delta =3D rs->cmd_buf_index - rs->last_cmd_buf_index;
         if (delta > 0) {
-            for(i =3D 0;i < delta; i++) {
+            for (i =3D 0; i < delta; i++) {
                 rs->printf_func(rs->opaque, "\033[C");
             }
         } else {
             delta =3D -delta;
-            for(i =3D 0;i < delta; i++) {
+            for (i =3D 0; i < delta; i++) {
                 rs->printf_func(rs->opaque, "\033[D");
             }
         }
@@ -301,7 +301,7 @@ static void readline_completion(ReadLineState *rs)
         return;
     if (rs->nb_completions =3D=3D 1) {
         len =3D strlen(rs->completions[0]);
-        for(i =3D rs->completion_index; i < len; i++) {
+        for (i =3D rs->completion_index; i < len; i++) {
             readline_insert_char(rs, rs->completions[0][i]);
         }
         /* extra space for next argument. XXX: make it more generic */
@@ -312,15 +312,15 @@ static void readline_completion(ReadLineState *rs)
               completion_comp);
         rs->printf_func(rs->opaque, "\n");
         max_width =3D 0;
-        max_prefix =3D 0;=09
-        for(i =3D 0; i < rs->nb_completions; i++) {
+        max_prefix =3D 0;
+        for (i =3D 0; i < rs->nb_completions; i++) {
             len =3D strlen(rs->completions[i]);
-            if (i=3D=3D0) {
+            if (i =3D=3D 0) {
                 max_prefix =3D len;
             } else {
                 if (len < max_prefix)
                     max_prefix =3D len;
-                for(j=3D0; j<max_prefix; j++) {
+                for (j =3D 0; j < max_prefix; j++) {
                     if (rs->completions[i][j] !=3D rs->completions[0][j]=
)
                         max_prefix =3D j;
                 }
@@ -328,8 +328,8 @@ static void readline_completion(ReadLineState *rs)
             if (len > max_width)
                 max_width =3D len;
         }
-        if (max_prefix > 0)=20
-            for(i =3D rs->completion_index; i < max_prefix; i++) {
+        if (max_prefix > 0)
+            for (i =3D rs->completion_index; i < max_prefix; i++) {
                 readline_insert_char(rs, rs->completions[0][i]);
             }
         max_width +=3D 2;
@@ -339,7 +339,7 @@ static void readline_completion(ReadLineState *rs)
             max_width =3D 80;
         nb_cols =3D 80 / max_width;
         j =3D 0;
-        for(i =3D 0; i < rs->nb_completions; i++) {
+        for (i =3D 0; i < rs->nb_completions; i++) {
             rs->printf_func(rs->opaque, "%-*s", max_width, rs->completio=
ns[i]);
             if (++j =3D=3D nb_cols || i =3D=3D (rs->nb_completions - 1))=
 {
                 rs->printf_func(rs->opaque, "\n");
@@ -362,9 +362,9 @@ static void readline_clear_screen(ReadLineState *rs)
 /* return true if command handled */
 void readline_handle_byte(ReadLineState *rs, int ch)
 {
-    switch(rs->esc_state) {
+    switch (rs->esc_state) {
     case IS_NORM:
-        switch(ch) {
+        switch (ch) {
         case 1:
             readline_bol(rs);
             break;
@@ -425,7 +425,7 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         }
         break;
     case IS_CSI:
-        switch(ch) {
+        switch (ch) {
 	case 'A':
 	case 'F':
 	    readline_up_char(rs);
@@ -444,7 +444,7 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             rs->esc_param =3D rs->esc_param * 10 + (ch - '0');
             goto the_end;
         case '~':
-            switch(rs->esc_param) {
+            switch (rs->esc_param) {
             case 1:
                 readline_bol(rs);
                 break;
@@ -463,7 +463,7 @@ void readline_handle_byte(ReadLineState *rs, int ch)
     the_end:
         break;
     case IS_SS3:
-        switch(ch) {
+        switch (ch) {
         case 'F':
             readline_eol(rs);
             break;
--=20
2.21.0



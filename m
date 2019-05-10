Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE57C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B2F2177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B2F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5Gy-0001A1-5A
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:09:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Av-0004MD-NW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hP5Au-0004AH-Ht
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hP5Ar-00044l-SB; Fri, 10 May 2019 09:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26C8B821EF;
	Fri, 10 May 2019 13:02:53 +0000 (UTC)
Received: from localhost (ovpn-116-89.ams2.redhat.com [10.36.116.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADFF21001E86;
	Fri, 10 May 2019 13:02:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 14:02:37 +0100
Message-Id: <20190510130243.8887-3-stefanha@redhat.com>
In-Reply-To: <20190510130243.8887-1-stefanha@redhat.com>
References: <20190510130243.8887-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 10 May 2019 13:02:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/8] util: readline: replace tab indent by four
 spaces to fix checkpatch errors
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

Replace tab indent by four spaces to fix errors issued by checkpatch.pl t=
ool
"ERROR: code indent should never use tabs" within "util/readline.c" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190401024406.10819-3-jbi.octave@gmail.com
Message-Id: <20190401024406.10819-3-jbi.octave@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/readline.c | 98 ++++++++++++++++++++++++-------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index db399d3948..3eb5a66dfc 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -179,20 +179,20 @@ static void readline_up_char(ReadLineState *rs)
     int idx;
=20
     if (rs->hist_entry =3D=3D 0)
-	return;
+        return;
     if (rs->hist_entry =3D=3D -1) {
-	/* Find latest entry */
-	for (idx =3D 0; idx < READLINE_MAX_CMDS; idx++) {
-	    if (rs->history[idx] =3D=3D NULL)
-		break;
-	}
-	rs->hist_entry =3D idx;
+        /* Find latest entry */
+        for (idx =3D 0; idx < READLINE_MAX_CMDS; idx++) {
+            if (rs->history[idx] =3D=3D NULL)
+                break;
+        }
+        rs->hist_entry =3D idx;
     }
     rs->hist_entry--;
     if (rs->hist_entry >=3D 0) {
-	pstrcpy(rs->cmd_buf, sizeof(rs->cmd_buf),
+        pstrcpy(rs->cmd_buf, sizeof(rs->cmd_buf),
                 rs->history[rs->hist_entry]);
-	rs->cmd_buf_index =3D rs->cmd_buf_size =3D strlen(rs->cmd_buf);
+        rs->cmd_buf_index =3D rs->cmd_buf_size =3D strlen(rs->cmd_buf);
     }
 }
=20
@@ -202,11 +202,11 @@ static void readline_down_char(ReadLineState *rs)
         return;
     if (rs->hist_entry < READLINE_MAX_CMDS - 1 &&
         rs->history[++rs->hist_entry] !=3D NULL) {
-	pstrcpy(rs->cmd_buf, sizeof(rs->cmd_buf),
+        pstrcpy(rs->cmd_buf, sizeof(rs->cmd_buf),
                 rs->history[rs->hist_entry]);
     } else {
         rs->cmd_buf[0] =3D 0;
-	rs->hist_entry =3D -1;
+        rs->hist_entry =3D -1;
     }
     rs->cmd_buf_index =3D rs->cmd_buf_size =3D strlen(rs->cmd_buf);
 }
@@ -217,42 +217,42 @@ static void readline_hist_add(ReadLineState *rs, co=
nst char *cmdline)
     int idx;
=20
     if (cmdline[0] =3D=3D '\0')
-	return;
+        return;
     new_entry =3D NULL;
     if (rs->hist_entry !=3D -1) {
-	/* We were editing an existing history entry: replace it */
-	hist_entry =3D rs->history[rs->hist_entry];
-	idx =3D rs->hist_entry;
-	if (strcmp(hist_entry, cmdline) =3D=3D 0) {
-	    goto same_entry;
-	}
+        /* We were editing an existing history entry: replace it */
+        hist_entry =3D rs->history[rs->hist_entry];
+        idx =3D rs->hist_entry;
+        if (strcmp(hist_entry, cmdline) =3D=3D 0) {
+            goto same_entry;
+        }
     }
     /* Search cmdline in history buffers */
     for (idx =3D 0; idx < READLINE_MAX_CMDS; idx++) {
-	hist_entry =3D rs->history[idx];
-	if (hist_entry =3D=3D NULL)
-	    break;
-	if (strcmp(hist_entry, cmdline) =3D=3D 0) {
-	same_entry:
-	    new_entry =3D hist_entry;
-	    /* Put this entry at the end of history */
-	    memmove(&rs->history[idx], &rs->history[idx + 1],
-		    (READLINE_MAX_CMDS - (idx + 1)) * sizeof(char *));
-	    rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
-	    for (; idx < READLINE_MAX_CMDS; idx++) {
-		if (rs->history[idx] =3D=3D NULL)
-		    break;
-	    }
-	    break;
-	}
+        hist_entry =3D rs->history[idx];
+        if (hist_entry =3D=3D NULL)
+            break;
+        if (strcmp(hist_entry, cmdline) =3D=3D 0) {
+        same_entry:
+            new_entry =3D hist_entry;
+            /* Put this entry at the end of history */
+            memmove(&rs->history[idx], &rs->history[idx + 1],
+                    (READLINE_MAX_CMDS - (idx + 1)) * sizeof(char *));
+            rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
+            for (; idx < READLINE_MAX_CMDS; idx++) {
+                if (rs->history[idx] =3D=3D NULL)
+                    break;
+            }
+            break;
+        }
     }
     if (idx =3D=3D READLINE_MAX_CMDS) {
-	/* Need to get one free slot */
+        /* Need to get one free slot */
         g_free(rs->history[0]);
-	memmove(rs->history, &rs->history[1],
-	        (READLINE_MAX_CMDS - 1) * sizeof(char *));
-	rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
-	idx =3D READLINE_MAX_CMDS - 1;
+        memmove(rs->history, &rs->history[1],
+                (READLINE_MAX_CMDS - 1) * sizeof(char *));
+        rs->history[READLINE_MAX_CMDS - 1] =3D NULL;
+        idx =3D READLINE_MAX_CMDS - 1;
     }
     if (new_entry =3D=3D NULL)
         new_entry =3D g_strdup(cmdline);
@@ -403,9 +403,9 @@ void readline_handle_byte(ReadLineState *rs, int ch)
         case 8:
             readline_backspace(rs);
             break;
-	case 155:
+        case 155:
             rs->esc_state =3D IS_CSI;
-	    break;
+            break;
         default:
             if (ch >=3D 32) {
                 readline_insert_char(rs, ch);
@@ -426,14 +426,14 @@ void readline_handle_byte(ReadLineState *rs, int ch=
)
         break;
     case IS_CSI:
         switch (ch) {
-	case 'A':
-	case 'F':
-	    readline_up_char(rs);
-	    break;
-	case 'B':
-	case 'E':
-	    readline_down_char(rs);
-	    break;
+        case 'A':
+        case 'F':
+            readline_up_char(rs);
+            break;
+        case 'B':
+        case 'E':
+            readline_down_char(rs);
+            break;
         case 'D':
             readline_backward_char(rs);
             break;
--=20
2.21.0



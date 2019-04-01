Received: from eggs.gnu.org ([209.51.188.92]:60406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hApob-0004za-CK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hApoT-0005f9-Dl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:48:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hApoM-0005bA-GP
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 01:48:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id w1so10207195wrp.2
	for <qemu-devel@nongnu.org>; Sun, 31 Mar 2019 22:48:41 -0700 (PDT)
MIME-Version: 1.0
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Mon, 1 Apr 2019 11:18:28 +0530
Message-ID: <CAH95U0h_H+pkPj5gBXXqiFPCPByVQ32GXa-Kpg7UPp-4MSdzoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC] Header cleanups for functions declared in
 utils/ files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

>From d34c4a45de91eadf2a6e98fd54aa86df11997fa2 Mon Sep 17 00:00:00 2001
From: Archfx <aruna.15@cse.mrt.ac.lk>
Date: Mon, 1 Apr 2019 11:01:22 +0530
Subject: [PATCH 2/2] Header cleanups Declarations were moved out of
 qemu-common.h for functions declared in utils/ files
Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>

---
 include/qemu/id.h       | 4 ++--
 include/qemu/readline.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/id.h b/include/qemu/id.h
index 3a651fb9d2..f3451344e2 100644
--- a/include/qemu/id.h
+++ b/include/qemu/id.h
@@ -1,8 +1,8 @@
 #ifndef QEMU_ID_H
 #define QEMU_ID_H

-#define qemu_isalnum(c) isalnum((unsigned char)(c))
-#define qemu_isalpha(c) isalpha((unsigned char)(c))
+#define qemu_isalnum(c)    isalnum((unsigned char)(c))
+#define qemu_isalpha(c)    isalpha((unsigned char)(c))

 typedef enum IdSubSystems {
     ID_QDEV,
diff --git a/include/qemu/readline.h b/include/qemu/readline.h
index 4cbf7ead5a..67859a3028 100644
--- a/include/qemu/readline.h
+++ b/include/qemu/readline.h
@@ -1,7 +1,7 @@
 #ifndef READLINE_H
 #define READLINE_H

-#define qemu_isspace(c) isspace((unsigned char)(c))
+#define qemu_isspace(c)    isspace((unsigned char)(c))

 #define READLINE_CMD_BUF_SIZE 4095
 #define READLINE_MAX_CMDS 64
--=20
2.17.1

--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSL-0002GO-Ax
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSK-00081C-IQ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:10 -0300
Message-Id: <20171006235023.11952-76-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 75/88] decnumber: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 libdecnumber/decNumber.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libdecnumber/decNumber.c b/libdecnumber/decNumber.c
index 8c197023f4..2d13198730 100644
--- a/libdecnumber/decNumber.c
+++ b/libdecnumber/decNumber.c
@@ -4089,7 +4089,7 @@ static decNumber * decAddOp(decNumber *res, const decNumber *lhs,
       acc=accbuff;			/* assume use local buffer */
       if (need*sizeof(Unit)>sizeof(accbuff)) {
 	/* printf("malloc add %ld %ld\n", need, sizeof(accbuff)); */
-	allocacc=(Unit *)malloc(need*sizeof(Unit));
+	allocacc=g_new(uint16_t, need);
 	if (allocacc==NULL) {		/* hopeless -- abandon */
 	  *status|=DEC_Insufficient_storage;
 	  break;}
@@ -4452,7 +4452,7 @@ static decNumber * decDivideOp(decNumber *res,
     acclength=D2U(reqdigits+DECDPUN);	/* in Units */
     if (acclength*sizeof(Unit)>sizeof(accbuff)) {
       /* printf("malloc dvacc %ld units\n", acclength); */
-      allocacc=(Unit *)malloc(acclength*sizeof(Unit));
+      allocacc=g_new(uint16_t, acclength);
       if (allocacc==NULL) {		/* hopeless -- abandon */
 	*status|=DEC_Insufficient_storage;
 	break;}
@@ -4477,7 +4477,7 @@ static decNumber * decDivideOp(decNumber *res,
     if (!(op&DIVIDE)) var1units++;
     if ((var1units+1)*sizeof(Unit)>sizeof(varbuff)) {
       /* printf("malloc dvvar %ld units\n", var1units+1); */
-      varalloc=(Unit *)malloc((var1units+1)*sizeof(Unit));
+      varalloc=g_new(uint16_t, (var1units+1));
       if (varalloc==NULL) {		/* hopeless -- abandon */
 	*status|=DEC_Insufficient_storage;
 	break;}
@@ -6314,7 +6314,7 @@ static Int decUnitCompare(const Unit *a, Int alength,
   need+=2;
   acc=accbuff;				/* assume use local buffer */
   if (need*sizeof(Unit)>sizeof(accbuff)) {
-    allocacc=(Unit *)malloc(need*sizeof(Unit));
+    allocacc=g_new(uint16_t, need);
     if (allocacc==NULL) return BADINT;	/* hopeless -- abandon */
     acc=allocacc;
     }
-- 
2.14.2

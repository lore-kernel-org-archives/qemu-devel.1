Received: from eggs.gnu.org ([2001:4830:134:3::10]:42182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2n-0004wa-U0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2i-0006dc-Uz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:37 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2i-0006dR-Qt
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:32 -0400
Received: by mail-ua0-x243.google.com with SMTP id 80so15042804uas.4
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 18:40:09 -0300
Message-Id: <20170726214010.420-4-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-1-f4bug@amsat.org>
References: <20170726214010.420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 3/4] fdt: probe for v1.4.2 using
 fdt_setprop_inplace_namelen_partial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

instead of fdt_first_subnode() which is v1.4.0

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 0d5bdb3ae9..2d803d6a77 100755
--- a/configure
+++ b/configure
@@ -3565,7 +3565,10 @@ if test "$fdt" != "no" ; then
   cat > $TMPC << EOF
 #include <libfdt.h>
 #include <libfdt_env.h>
-int main(void) { fdt_first_subnode(0, 0); return 0; }
+int main(void) {
+    fdt_setprop_inplace_namelen_partial(0, 0, 0, 0, 0, 0, 0);
+    return 0;
+}
 EOF
   if compile_prog "" "$fdt_libs" ; then
     # system DTC is good - use it
-- 
2.13.3

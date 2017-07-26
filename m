Received: from eggs.gnu.org ([2001:4830:134:3::10]:42083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2c-0004oo-IA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2b-0006aa-NR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:26 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:35219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2b-0006aS-K5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:25 -0400
Received: by mail-ua0-x244.google.com with SMTP id d29so14016606uai.2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 18:40:07 -0300
Message-Id: <20170726214010.420-2-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-1-f4bug@amsat.org>
References: <20170726214010.420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] configure: remember the user to run 'git
 submodule' command in source dir
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index f8b1d014d7..063de32773 100755
--- a/configure
+++ b/configure
@@ -502,6 +502,7 @@ if test -f "./configure"; then
     pwd_is_source_path="y"
 else
     pwd_is_source_path="n"
+    git_submodule_path_info="(in ${source_path})"
 fi
 
 check_define() {
@@ -3313,7 +3314,7 @@ else
     error_exit "pixman >= 0.21.8 not present. Your options:" \
         "  (1) Preferred: Install the pixman devel package (any recent" \
         "      distro should have packages as Xorg needs pixman too)." \
-        "  (2) Fetch the pixman submodule, using:" \
+        "  (2) Fetch the pixman submodule, using: $git_submodule_path_info" \
         "      git submodule update --init pixman"
   fi
   mkdir -p pixman/pixman
@@ -3593,7 +3594,7 @@ EOF
     # have neither and want - prompt for system/submodule install
     error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:" \
         "  (1) Preferred: Install the DTC (libfdt) devel package" \
-        "  (2) Fetch the DTC submodule, using:" \
+        "  (2) Fetch the DTC submodule, using: $git_submodule_path_info" \
         "      git submodule update --init dtc"
   else
     # don't have and don't want
-- 
2.13.3

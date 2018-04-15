Received: from eggs.gnu.org ([2001:4830:134:3::10]:58287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiT-0007Gr-0d
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiR-00039C-Es
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:49 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7qiR-00038v-9R
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 19:05:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id s78so14742883qkl.8
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 16:05:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 15 Apr 2018 20:05:21 -0300
Message-Id: <20180415230522.24404-4-f4bug@amsat.org>
In-Reply-To: <20180415230522.24404-1-f4bug@amsat.org>
References: <20180415230522.24404-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] shippable: Remove Debian 8 libfdt kludge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, YunQiang Su <syq@debian.org>

This kludge was added in a825ca06137, but a cleaner and more generic
fix is now available (see ##COMMIT_CONFIGURE_LIBFDT_LDFLAGS_SHA##).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
If a maintainer take the whole series, I hope he'll be kind enough to update
##COMMIT_CONFIGURE_LIBFDT_LDFLAGS_SHA## with the sha of the patch #1 :) Thanks!

 .shippable.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 60f2ce9218..f74a3de3ff 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -35,13 +35,5 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
-    # some targets require newer up to date packages, for example TARGET_LIST matching
-    # aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
-    # see the configure script:
-    #    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:"
-    #    "  (1) Preferred: Install the DTC (libfdt) devel package"
-    #    "  (2) Fetch the DTC submodule, using:"
-    #    "      git submodule update --init dtc"
-    - dpkg --compare-versions `dpkg-query --showformat='${Version}' --show libfdt-dev` ge 1.4.2 || git submodule update --init dtc
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.17.0

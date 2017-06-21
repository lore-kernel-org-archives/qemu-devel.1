Received: from eggs.gnu.org ([2001:4830:134:3::10]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzy-0003ro-ID
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzx-0007nu-Oi
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:50 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgzx-0007nR-Jl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:49 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y25so99077421wrd.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:52:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:08 +0100
Message-Id: <20170621144814.15324-16-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/21] shippable: build using all available cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As of this commit:

$ echo "container proc:" `getconf _NPROCESSORS_ONLN` `getconf _NPROCESSORS_CONF`
container proc: 2 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 231c29b620..1e3ae35dd9 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -20,4 +20,4 @@ build:
   ci:
     - unset CC
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
-    - make -j2
+    - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
2.13.0

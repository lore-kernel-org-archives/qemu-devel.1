Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4q-0004X6-KC
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVJ4m-0007Zm-Tt
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:52 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVJ4m-0007ZP-Mm
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:01:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id n5-v6so1401584wmc.5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 09:01:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:08 +0100
Message-Id: <20180619154435.18898-30-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/56] tests/docker/Makefile.include: fix
 mipsel-cross dependancy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This got broken in commit 4319db7 but generally only shows up when you
try and do massive parallel builds on fresh machines.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 8afb383478..4a2b028a3b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -57,6 +57,7 @@ docker-image-debian-armel-cross: docker-image-debian9
 docker-image-debian-armhf-cross: docker-image-debian9
 docker-image-debian-arm64-cross: docker-image-debian9
 docker-image-debian-mips-cross: docker-image-debian9
+docker-image-debian-mipsel-cross: docker-image-debian9
 docker-image-debian-mips64el-cross: docker-image-debian9
 docker-image-debian-powerpc-cross: docker-image-debian8
 docker-image-debian-ppc64el-cross: docker-image-debian9
-- 
2.17.1

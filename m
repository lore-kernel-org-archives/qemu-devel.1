Received: from eggs.gnu.org ([209.51.188.92]:43046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjD-0006yR-IE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrjC-0006Wj-Gq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjrjC-0006Qi-8r
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id l9so8414057wrt.13
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:23:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 20:23:48 +0000
Message-Id: <20190116202349.29272-7-alex.bennee@linaro.org>
In-Reply-To: <20190116202349.29272-1-alex.bennee@linaro.org>
References: <20190116202349.29272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/7] scripts/archive-source: include
 softfloat tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We need these if we want to run unit/softfloat tests in our docker
containers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/archive-source.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 62bd22578b..6eed2a29bd 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ vroot_dir="${tar_file}.vroot"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc ui/keycodemapdb"
+submodules="dtc ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 
 trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
 
-- 
2.17.1

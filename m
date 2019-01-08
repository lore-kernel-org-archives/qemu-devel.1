Received: from eggs.gnu.org ([209.51.188.92]:48042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8s-0004Mi-BN
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8o-00017c-J3
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggu8j-0000dg-FF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d15so4712601wmb.3
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:22:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  8 Jan 2019 16:21:53 +0000
Message-Id: <20190108162154.22259-6-alex.bennee@linaro.org>
In-Reply-To: <20190108162154.22259-1-alex.bennee@linaro.org>
References: <20190108162154.22259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/6] scripts/archive-source: include
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
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We need these if we want to run unit/softfloat tests in our docker
containers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywX-0008Ne-K4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fNywU-0001ue-Dt
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:07:01 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fNywU-0001uQ-7M
	for qemu-devel@nongnu.org; Wed, 30 May 2018 07:06:58 -0400
Received: by mail-wr0-x242.google.com with SMTP id i12-v6so29116622wrc.4
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 04:06:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 30 May 2018 12:06:48 +0100
Message-Id: <20180530110655.22022-2-alex.bennee@linaro.org>
In-Reply-To: <20180530110655.22022-1-alex.bennee@linaro.org>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/8] .travis.yml: disable linux-user build
 for gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Currently the default testing doesn't exercise the linux-user builds
so there is no point spending time building them. We may want to
enable a separate gcov build once linux-user testing is re-enabled
although it's likely to report very low coverage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c1e99237b2..aa83e9aed7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,7 +74,7 @@ matrix:
     - env: CONFIG=""
       compiler: clang
     # gprof/gcov are GCC features
-    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
+    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-- 
2.17.0

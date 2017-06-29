Received: from eggs.gnu.org ([2001:4830:134:3::10]:42769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrw-0004ly-1F
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrv-00075d-AQ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:40 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrv-00075T-5y
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id 16so9866215qkg.2
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:03:00 -0300
Message-Id: <20170629010300.2848-9-f4bug@amsat.org>
In-Reply-To: <20170629010300.2848-1-f4bug@amsat.org>
References: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 8/8] travis: remove tcg/tci job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9cfb3..d10ee5ed79 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -74,9 +74,6 @@ matrix:
     - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
       compiler: gcc
     # We manually include builds which we disable "make check" for
-    - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-           TEST_CMD=""
-      compiler: gcc
     - env: CONFIG="--enable-trace-backends=simple"
            TEST_CMD=""
       compiler: gcc
-- 
2.13.1

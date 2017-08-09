Received: from eggs.gnu.org ([2001:4830:134:3::10]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZt-000663-7N
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZr-0002Hx-Vw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:41 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZr-0002Ha-Rs
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id x77so6717176qka.4
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:27:05 -0300
Message-Id: <20170809202712.6951-10-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 09/16] travis: reduce git clone
 depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

see https://docs.travis-ci.com/user/customizing-the-build#Git-Clone-Depth

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index 57462b0471..72aad5ca35 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -70,6 +70,7 @@ env:
     - CONFIG="--with-coroutine=sigaltstack"
     - CONFIG="--enable-debug --enable-debug-tcg --enable-trace-backends=log"
 git:
+  depth: 3
   # we want to do this ourselves
   submodules: false
 before_install:
-- 
2.13.3

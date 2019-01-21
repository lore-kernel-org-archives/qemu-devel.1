Received: from eggs.gnu.org ([209.51.188.92]:40385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAq-0005S4-MV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAo-0002rw-Uu
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gldAo-0002rD-Nr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:46 -0500
Received: by mail-wm1-x32a.google.com with SMTP id m1so11572859wml.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:15:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 21 Jan 2019 17:15:41 +0000
Message-Id: <20190121171543.32422-2-alex.bennee@linaro.org>
In-Reply-To: <20190121171543.32422-1-alex.bennee@linaro.org>
References: <20190121171543.32422-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/3] tests/vm: call make check directly for
 netbsd/freebsd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kamil@netbsd.org, brad@comstyle.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The "make check" target calls check-qtest which has the appropriate
system binaries as dependencies so we shouldn't need to do two steps
of make invocation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/freebsd | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 19a3729172..a85c866c30 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -25,7 +25,6 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
         gmake --output-sync -j{jobs} check {verbose};
     """
 
-- 
2.17.1

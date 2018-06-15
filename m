Received: from eggs.gnu.org ([2001:4830:134:3::10]:53923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoX-0000Ww-6n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoU-0006Ul-Nf
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:17 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuoU-0006TC-Go
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:14 -0400
Received: by mail-wm0-x243.google.com with SMTP id v16-v6so5202085wmh.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:55:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:42 +0100
Message-Id: <20180615194705.28019-32-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 31/54] tests/tcg: enable building for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

This doesn't add any additional tests but enables building the
multiarch tests for s390x.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 tests/tcg/s390x/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tests/tcg/s390x/Makefile.include

diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefile.include
new file mode 100644
index 0000000000..1f58115d96
--- /dev/null
+++ b/tests/tcg/s390x/Makefile.include
@@ -0,0 +1,2 @@
+DOCKER_IMAGE=debian-s390x-cross
+DOCKER_CROSS_COMPILER=s390x-linux-gnu-gcc
-- 
2.17.1

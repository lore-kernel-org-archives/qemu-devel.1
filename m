Received: from eggs.gnu.org ([2001:4830:134:3::10]:40254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxSp-0006OV-5C
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxSl-00038x-5i
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:36:23 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxSl-00038R-23
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:36:19 -0500
Received: by mail-qk0-x241.google.com with SMTP id 8so18775680qkj.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:36:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 12:35:52 -0300
Message-Id: <20171218153552.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] travis: add no-TPM build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Use CI to avoid TPM bitrot:
  hw/core/qdev-properties-system.o: In function `release_tpm':
  hw/core/qdev-properties-system.c:291: undefined reference to `tpm_backend_reset'

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 20171218140002.23677-1-cohuck@redhat.com

 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index f583839755..b4232ff2f9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -90,6 +90,9 @@ matrix:
     - env: CONFIG="--disable-tcg"
            TEST_CMD=""
       compiler: gcc
+    - env: CONFIG="--disable-tpm"
+           TEST_CMD=""
+      compiler: gcc
     - env: CONFIG=""
       os: osx
       compiler: clang
-- 
2.15.1

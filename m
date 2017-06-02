Received: from eggs.gnu.org ([2001:4830:134:3::10]:40182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlI-0002S3-7v
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlH-0006Yw-JN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:28 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrlH-0006YY-F0
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:27 -0400
Received: by mail-oi0-x242.google.com with SMTP id f206so3400702oig.2
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:28 -0300
Message-Id: <20170602185630.5059-23-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 22/24] shippable: add mipsel target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index aad66ec5ec..75c2895a21 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -13,6 +13,9 @@ env:
       TARGET_LIST=s390x-softmmu,s390x-linux-user
     - IMAGE=debian-powerpc-cross
       TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
+    # mips64el-softmmu disabled due to libfdt problem
+    - IMAGE=debian-mipsel-cross
+      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.11.0

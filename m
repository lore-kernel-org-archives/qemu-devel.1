Received: from eggs.gnu.org ([2001:4830:134:3::10]:53854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZY-0001EO-PR
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZW-0004NN-NO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:48 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZW-0004NJ-J9
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:46 -0400
Received: by mail-qk0-x242.google.com with SMTP id p21so15383847qke.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:55 -0300
Message-Id: <20170711031000.24844-14-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 13/18] shippable: add ppc64el targets
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
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index abcaf6f4d4..189d193da5 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -16,6 +16,8 @@ env:
     # mips64el-softmmu disabled due to libfdt problem
     - IMAGE=debian-mipsel-cross
       TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
+    - IMAGE=debian-ppc64el-cross
+      TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.13.2

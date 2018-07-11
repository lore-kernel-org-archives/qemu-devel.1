Received: from eggs.gnu.org ([2001:4830:134:3::10]:48126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pk-00059e-VA
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pk-0005pO-7A
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:32 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fd6pk-0005pI-26
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 00:34:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id m13-v6so20329918qth.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 21:34:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 11 Jul 2018 01:34:17 -0300
Message-Id: <20180711043417.24097-3-f4bug@amsat.org>
In-Reply-To: <20180711043417.24097-1-f4bug@amsat.org>
References: <20180711043417.24097-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for-3.1 2/2] shippable: Build the TriCore
 docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, David Brenken <david.brenken@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..9670b13f8e 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,8 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    - IMAGE=debian-tricore-cross
+      TARGET_LIST=
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.18.0

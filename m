Received: from eggs.gnu.org ([2001:4830:134:3::10]:54349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlan-0002HO-UZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaj-0004nZ-9q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:12:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlaj-0004nV-4z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:12:01 -0400
Received: by mail-qk0-f194.google.com with SMTP id 16so15383857qkg.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:12:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:10:00 -0300
Message-Id: <20170711031000.24844-19-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 18/18] shippable: restrict builds to
 master/staging and shippable* branches
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
 .shippable.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index 4c8a85941f..1f05d934e4 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -1,6 +1,11 @@
 language: c
 git:
    submodules: false
+branches:
+  only:
+    - master
+    - staging
+    - shippable*
 env:
   global:
     - LC_ALL=C
-- 
2.13.2

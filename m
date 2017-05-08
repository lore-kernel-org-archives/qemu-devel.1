Received: from eggs.gnu.org ([2001:4830:134:3::10]:37052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7al5-00047i-91
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7al4-0007yy-Lf
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:55 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7al4-0007yp-HZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:58:54 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so8682661qkh.0
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:58:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:57:08 -0300
Message-Id: <20170508045715.21770-17-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/23] shippable: do not initialize submodules
 automatically
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

do it in the 'ci' target when needed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index fa2d6a4e9b..b3cbca458c 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -1,4 +1,6 @@
 language: c
+git:
+   submodules: false
 env:
   global:
     - LC_ALL=C
-- 
2.11.0

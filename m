Received: from eggs.gnu.org ([2001:4830:134:3::10]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiF-0003LL-Pn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiF-0007TH-1K
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:11 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiE-0007Sy-Tl
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:10 -0400
Received: by mail-qk0-x242.google.com with SMTP id c136so5941415qkb.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:47:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:39 -0300
Message-Id: <20180419164642.9536-5-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/7] qemu.py: Avoid deprecated
 tempfile.mktemp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

We already have secure temporary directory created with tempfile.mkdtemp().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 379767b62f..26c4b1fd3b 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -201,7 +201,8 @@ class QEMUMachine(object):
 
         chardev = 'socket,id=console,{address},server,nowait'
         if console_address is None:
-            console_address = tempfile.mktemp()
+            console_address = os.path.join(self._temp_dir,
+                                           self._name + "-console.sock")
             chardev = chardev.format(address='path=%s' %
                                      console_address)
         elif isinstance(console_address, tuple):
-- 
2.17.0

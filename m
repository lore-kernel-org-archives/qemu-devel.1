Received: from eggs.gnu.org ([2001:4830:134:3::10]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2j-0000Dr-K2
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2i-00005d-Ai
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:49 -0400
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2i-00005N-5E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:48 -0400
Received: by mail-ua0-x229.google.com with SMTP id y8-v6so26189951uan.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:48:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:48:27 -0300
Message-Id: <20180717024827.27897-6-f4bug@amsat.org>
In-Reply-To: <20180717024827.27897-1-f4bug@amsat.org>
References: <20180717024827.27897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 5/5] tests/vm: When using TCG,
 wait longer for a VM to start
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
4 is random (but more than 1).
---
 tests/vm/basevm.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 7575c36f0b..50785a64df 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -182,6 +182,8 @@ class BaseVM(object):
                             usernet_info)
 
     def wait_ssh(self, seconds=120):
+        if not kvm_available():
+            seconds *= 4
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-- 
2.18.0

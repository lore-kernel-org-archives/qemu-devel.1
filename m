Received: from eggs.gnu.org ([2001:4830:134:3::10]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zB-00020f-VQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zB-0000YD-B7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zB-0000Xg-4E
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id n1-v6so15112172wrt.10
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:32 +0200
Message-Id: <20181013004034.6968-8-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 7/8] tests/vm: Do not use -enable-kvm if
 HOST != TARGET architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index b2e0de2022..9f4794898a 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -74,7 +74,7 @@ class BaseVM(object):
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus and vcpus > 1:
             self._args += ["-smp", str(vcpus)]
-        if kvm_available():
+        if kvm_available(self.arch):
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
-- 
2.19.1

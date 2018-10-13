Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zA-0001zY-Qo
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zA-0000Xc-6E
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z9-0000XH-VU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id 61-v6so15120151wrb.6
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:31 +0200
Message-Id: <20181013004034.6968-7-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 6/8] tests/vm: Let kvm_available() work in
 cross environments
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
 scripts/qemu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9fc0be4828..bcd24aad82 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -27,6 +27,8 @@ LOG = logging.getLogger(__name__)
 
 
 def kvm_available(target_arch=None):
+    if target_arch and target_arch != os.uname()[4]:
+        return False
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
 
 
-- 
2.19.1

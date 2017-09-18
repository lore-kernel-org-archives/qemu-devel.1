Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsUz-0003rR-4L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dtsUw-0002pP-0Z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:37:53 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:54133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dtsUv-0002ol-Pn
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:37:49 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l22so5773495wrc.10
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 02:37:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 18 Sep 2017 10:37:40 +0100
Message-Id: <20170918093740.25198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scripts/qemu.py: fix continuation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Commit dab91d9aa00e41ee680524e4f6e99a1e7fe12eb2 broke the invocation by
dropping the surrounding braces. I'm not sure how this could have
worked, maybe some pythons are more forgiving?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Amador Pahim <apahim@redhat.com>
CC: Fam Zheng <famz@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 774e201e8b..2b5c2accb5 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -193,8 +193,8 @@ class QEMUMachine(object):
         qemulog = open(self._qemu_log_path, 'wb')
         try:
             self._pre_launch()
-            self._qemu_full_args = self._wrapper + [self._binary] +
-                                    self._base_args() + self._args
+            self._qemu_full_args = (self._wrapper + [self._binary] +
+                                    self._base_args() + self._args)
             self._popen = subprocess.Popen(self._qemu_full_args,
                                            stdin=devnull,
                                            stdout=qemulog,
-- 
2.14.1

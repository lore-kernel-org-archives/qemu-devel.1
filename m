Received: from eggs.gnu.org ([2001:4830:134:3::10]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtoYv-0005V2-BD
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 01:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtoYu-0002aS-Hp
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 01:25:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Sep 2017 07:25:24 +0200
Message-Id: <20170918052524.4045-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu.py: Fix syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, apahim@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, crosa@redhat.com, qemu-devel@nongnu.org

Python requires parentheses around multiline expression. This fixes the
breakage of all Python-based qemu-iotests cases that was introduced in
commit dab91d9aa0.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---

Eduardo, I think I'm going to include this patch in a block layer pull
request today, just to stop the CI spam I'm getting, so the CC is just
FYI.

 scripts/qemu.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 8c67595ec8..5e02dd8e78 100644
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
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptW-00026u-L8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eiptV-0007Zn-MS
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eiptV-0007ZT-Fo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:57 -0200
Message-Id: <20180205230900.11344-19-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 18/21] input: add missing JIS keys to virtio
 input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Miika S <miika9764@gmail.com>

From: Miika S <miika9764@gmail.com>

keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana

Signed-off-by: Miika S <miika9764@gmail.com>
Message-Id: <20180116134217.8725-12-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/ui.json    | 5 ++++-
 ui/keycodemapdb | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 07b468f625..d6679aa8f5 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -748,6 +748,9 @@
 # @ac_bookmarks: since 2.10
 # altgr, altgr_r: dropped in 2.10
 #
+# @muhenkan: since 2.12
+# @katakanahiragana: since 2.12
+#
 # 'sysrq' was mistakenly added to hack around the fact that
 # the ps2 driver was not generating correct scancodes sequences
 # when 'alt+print' was pressed. This flaw is now fixed and the
@@ -775,7 +778,7 @@
             'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
             'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
             'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
-            'ro', 'hiragana', 'henkan', 'yen',
+            'ro', 'hiragana', 'henkan', 'yen', 'muhenkan', 'katakanahiragana',
             'kp_comma', 'kp_equals', 'power', 'sleep', 'wake',
             'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
             'volumeup', 'volumedown', 'mediaselect',
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 10739aa260..05dad417e9 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
+Subproject commit 05dad417e9d0b37ee1fba33056d91a6b734b3357
-- 
2.14.3

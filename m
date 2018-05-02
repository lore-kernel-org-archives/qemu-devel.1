Received: from eggs.gnu.org ([2001:4830:134:3::10]:47382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMZ-0007TX-EX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzMY-0000Ll-BC
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:32:35 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 23:32:14 +0200
Message-Id: <20180502213219.7842-3-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC 2/7] block: Let change-medium add detect-zeroes
 as bool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

There is no reason to use the wrong type here.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index c31bf3d98d..76f811c415 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2654,7 +2654,7 @@ void qmp_blockdev_change_medium(bool has_device, const char *device,
 
     options = qdict_new();
     detect_zeroes = blk_get_detect_zeroes_from_root_state(blk);
-    qdict_put_str(options, "detect-zeroes", detect_zeroes ? "on" : "off");
+    qdict_put_bool(options, "detect-zeroes", detect_zeroes);
 
     if (has_format) {
         qdict_put_str(options, "driver", format);
-- 
2.14.3

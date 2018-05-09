Received: from eggs.gnu.org ([2001:4830:134:3::10]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNo-0003qO-1X
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGSNl-0007Cf-JP
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:56:04 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  9 May 2018 18:55:30 +0200
Message-Id: <20180509165530.29561-14-mreitz@redhat.com>
In-Reply-To: <20180509165530.29561-1-mreitz@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 13/13] iotests: qcow2's encrypt.format is now
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Remove the encrypt.format option from the two blockdev-add test cases
for encrypted qcow2 images in 087 to explicitly test that this parameter
is now optional.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/087 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 2561a14456..1eba457985 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -150,7 +150,6 @@ run_qemu <<EOF
           "filename": "$TEST_IMG"
       },
       "encrypt": {
-          "format": "aes",
           "key-secret": "sec0"
       }
     }
@@ -183,7 +182,6 @@ run_qemu <<EOF
           "filename": "$TEST_IMG"
       },
       "encrypt": {
-        "format": "luks",
         "key-secret": "sec0"
       }
     }
-- 
2.14.3

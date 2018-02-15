Received: from eggs.gnu.org ([2001:4830:134:3::10]:51185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxX-0001rz-5P
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1emJxS-00010s-PZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:52:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 15 Feb 2018 16:51:45 +0300
Message-Id: <1518702707-7077-8-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 7/9] iotests.py: tiny refactor: move system
 imports up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1bcc9ca57d..c1302a2f9b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -23,13 +23,14 @@ import subprocess
 import string
 import unittest
 import sys
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
-import qtest
 import struct
 import json
 import signal
 import logging
 
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
+import qtest
+
 
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
-- 
2.11.1

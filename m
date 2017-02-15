Received: from eggs.gnu.org ([2001:4830:134:3::10]:55871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdwXs-0002rx-M2
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdwXm-0003cl-70
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:10:44 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:1211 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cdwXl-0003Z1-Pf
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:10:38 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 15 Feb 2017 13:10:06 +0300
Message-Id: <1487153430-17260-2-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v15 01/25] specs/qcow2: fix bitmap granularity
 qemu-specific note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 docs/specs/qcow2.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
index 80cdfd0..dda53dd 100644
--- a/docs/specs/qcow2.txt
+++ b/docs/specs/qcow2.txt
@@ -472,8 +472,7 @@ Structure of a bitmap directory entry:
              17:    granularity_bits
                     Granularity bits. Valid values: 0 - 63.
 
-                    Note: Qemu currently doesn't support granularity_bits
-                    greater than 31.
+                    Note: Qemu currently supports only values 9 - 31.
 
                     Granularity is calculated as
                         granularity = 1 << granularity_bits
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSO-0004qj-Dv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002Lf-S5
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:40 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:15 +0300
Message-Id: <20181001102928.20533-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 05/18] util/id: add block-bitmap subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add block-bitmap subsystem to generate bitmap names in the following
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/id.h | 1 +
 util/id.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/qemu/id.h b/include/qemu/id.h
index 40c70103e4..013a560e01 100644
--- a/include/qemu/id.h
+++ b/include/qemu/id.h
@@ -4,6 +4,7 @@
 typedef enum IdSubSystems {
     ID_QDEV,
     ID_BLOCK,
+    ID_BLOCK_BITMAP,
     ID_MAX      /* last element, used as array size */
 } IdSubSystems;
 
diff --git a/util/id.c b/util/id.c
index 6141352955..beb4ee7f0b 100644
--- a/util/id.c
+++ b/util/id.c
@@ -34,6 +34,7 @@ bool id_wellformed(const char *id)
 static const char *const id_subsys_str[ID_MAX] = {
     [ID_QDEV]  = "qdev",
     [ID_BLOCK] = "block",
+    [ID_BLOCK_BITMAP] = "block-bitmap",
 };
 
 /*
-- 
2.18.0

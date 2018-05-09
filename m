Received: from eggs.gnu.org ([2001:4830:134:3::10]:49650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7a-0005vH-0K
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fGI7Z-0001Bv-5k
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:58:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  9 May 2018 13:58:01 +0800
Message-Id: <20180509055802.28423-5-famz@redhat.com>
In-Reply-To: <20180509055802.28423-1-famz@redhat.com>
References: <20180509055802.28423-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] iotests: Filter cid numbers in VMDK extent
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/common.filter | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index c5f4bcf578..0debefed18 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -164,6 +164,7 @@ _filter_img_info()
         -e "/table_size: [0-9]\\+/d" \
         -e "/compat: '[^']*'/d" \
         -e "/compat6: \\(on\\|off\\)/d" \
+        -e "s/cid: [0-9]\+/cid: XXXXXXXXXX/" \
         -e "/static: \\(on\\|off\\)/d" \
         -e "/zeroed_grain: \\(on\\|off\\)/d" \
         -e "/subformat: '[^']*'/d" \
-- 
2.14.3

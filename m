Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8O-0005QI-Ju
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eUp8N-0007RT-CH
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eUp8N-0007Qi-6D
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 02:31:15 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 612F1C0587F3
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 07:31:14 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Dec 2017 15:31:00 +0800
Message-Id: <20171229073104.3810-2-peterx@redhat.com>
In-Reply-To: <20171229073104.3810-1-peterx@redhat.com>
References: <20171229073104.3810-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] doc: another fix to "info pic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

Something that commit 254316fa1f ("intc: make HMP 'info irq' and 'info
pic' commands available on all targets", 2016-10-04) forgot to touch up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp-commands-info.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 54c3e5eac6..4ae2df2f86 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -198,7 +198,7 @@ ETEXI
 STEXI
 @item info pic
 @findex info pic
-Show i8259 (PIC) state.
+Show PIC state.
 ETEXI
 
     {
-- 
2.14.3

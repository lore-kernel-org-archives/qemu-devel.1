Received: from eggs.gnu.org ([2001:4830:134:3::10]:45283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXy-0005hA-LD
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiXu-00043u-Oj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eJiXu-00043X-I8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:15:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Nov 2017 16:15:29 +0000
Message-Id: <20171128161529.3025-3-stefanha@redhat.com>
In-Reply-To: <20171128161529.3025-1-stefanha@redhat.com>
References: <20171128161529.3025-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-options: document memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Hu Tao <hutao@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@redhat.com>

The documentation should mention -object memory-backend-ram.

Suggested-by: Yumei Huang <yuhuang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-options.hx | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index f2cf0be193..65123ae177 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4242,6 +4242,13 @@ restrict memory allocation to the given host node list
 interleave memory allocations across the given host node list
 @end table
 
+@item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
+
+Creates a memory backend object, which can be used to back the guest RAM.
+Memory backend objects offer more control than the @option{-m} option that is
+traditionally used to define guest RAM. Please refer to
+@option{memory-backend-file} for a description of the options.
+
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
 Creates a random number generator backend which obtains entropy from
-- 
2.14.3

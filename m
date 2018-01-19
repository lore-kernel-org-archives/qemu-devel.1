Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZcg-0005hk-ON
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZcf-0006c4-Rm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZcf-0006bu-Lo
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:34:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:30 -0200
Message-Id: <20180119163345.10649-5-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 04/19] qemu-options: document
 memory-backend-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The documentation should mention -object memory-backend-ram.

Suggested-by: Yumei Huang <yuhuang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20171128161529.3025-3-stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qemu-options.hx | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index fe8c04f644..5b0ee43b18 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4025,6 +4025,13 @@ restrict memory allocation to the given host node list
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

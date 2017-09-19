Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duEQP-0004gs-9i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duEQJ-0002sK-Ra
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:02:37 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Sep 2017 11:02:26 +0200
Message-Id: <1505811746-29439-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Add missing "-m" parameter in
 docs/memory-hotplug.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org

The example obviously lacks the "-m" parameter.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/memory-hotplug.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/memory-hotplug.txt b/docs/memory-hotplug.txt
index 56bdd0a..d96397c 100644
--- a/docs/memory-hotplug.txt
+++ b/docs/memory-hotplug.txt
@@ -24,7 +24,7 @@ Where,
 
 For example, the following command-line:
 
- qemu [...] 1G,slots=3,maxmem=4G
+ qemu [...] -m 1G,slots=3,maxmem=4G
 
 Creates a guest with 1GB of memory and three hotpluggable memory slots.
 The hotpluggable memory slots are empty when the guest is booted, so all
-- 
1.8.3.1

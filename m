Received: from eggs.gnu.org ([2001:4830:134:3::10]:51804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEyW-00005q-UZ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEyS-0006U5-VN
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:02:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:41 +0300
Message-Id: <67124752942a3ba5ab23a78847fb9f20e69f8c58.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 23/31] trivial: Add missing "-m" parameter in
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

The example obviously lacks the "-m" parameter.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/memory-hotplug.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/memory-hotplug.txt b/docs/memory-hotplug.txt
index 56bdd0a47b..d96397c1af 100644
--- a/docs/memory-hotplug.txt
+++ b/docs/memory-hotplug.txt
@@ -24,7 +24,7 @@ Where,
 
 For example, the following command-line:
 
- qemu [...] 1G,slots=3,maxmem=4G
+ qemu [...] -m 1G,slots=3,maxmem=4G
 
 Creates a guest with 1GB of memory and three hotpluggable memory slots.
 The hotpluggable memory slots are empty when the guest is booted, so all
-- 
2.11.0

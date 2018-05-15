Received: from eggs.gnu.org ([2001:4830:134:3::10]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXyN-0005Aa-Hs
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIXyK-0004s1-E6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:18:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIXyK-0004rt-9j
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:18:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 15 May 2018 13:17:38 +0200
Message-Id: <1526383058-49501-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] linux-user: update comments to point to
 cpu_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu

cpu_init() was replaced by cpu_create() since 2.12 but comments
weren't updated. So update stale comments now.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 bsd-user/main.c   | 2 +-
 linux-user/main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 283dc6f..a6ef4a7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -917,7 +917,7 @@ int main(int argc, char **argv)
     envlist_free(envlist);
 
     /*
-     * Now that page sizes are configured in cpu_init() we can do
+     * Now that page sizes are configured in cpu_create() we can do
      * proper page alignment for guest_base.
      */
     guest_base = HOST_PAGE_ALIGN(guest_base);
diff --git a/linux-user/main.c b/linux-user/main.c
index 3234754..27d0b37 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -693,7 +693,7 @@ int main(int argc, char **argv, char **envp)
     envlist_free(envlist);
 
     /*
-     * Now that page sizes are configured in cpu_init() we can do
+     * Now that page sizes are configured in cpu_create() we can do
      * proper page alignment for guest_base.
      */
     guest_base = HOST_PAGE_ALIGN(guest_base);
-- 
2.7.4

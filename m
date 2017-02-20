Received: from eggs.gnu.org ([2001:4830:134:3::10]:33233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb7-0001Ye-Mf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb3-00044t-Gc
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:45851 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cfsb3-00043K-5V
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:01 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 20 Feb 2017 21:21:55 +0300
Message-Id: <1487614915-18710-4-git-send-email-den@openvz.org>
In-Reply-To: <1487614915-18710-1-git-send-email-den@openvz.org>
References: <1487614915-18710-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 3/3] qmp-events: fix GUEST_PANICKED description
 formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---
 qapi/event.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/event.json b/qapi/event.json
index 970ff02..e02852c 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -488,9 +488,9 @@
 #
 # @action: action that has been taken, currently always "pause"
 #
-# @info: optional information about a panic
+# @info: #optional information about a panic (since 2.9)
 #
-# Since: 1.5 (@info since 2.9)
+# Since: 1.5
 #
 # Example:
 #
-- 
2.7.4

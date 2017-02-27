Received: from eggs.gnu.org ([2001:4830:134:3::10]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgw-0004p9-Cg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgv-0000hd-Lr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgv-0000gW-Fr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:13 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:51 +0100
Message-Id: <20170227124551.8673-18-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] qmp-events: fix GUEST_PANICKED
 description formatting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eric Blake <eblake@redhat.com>
Message-Id: <1487614915-18710-4-git-send-email-den@openvz.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.9.3

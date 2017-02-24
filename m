Received: from eggs.gnu.org ([2001:4830:134:3::10]:36469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrS-00085W-3p
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chJrR-0002Kc-1X
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chJrQ-0002KK-Qu
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:40:52 -0500
Received: by mail-wm0-x241.google.com with SMTP id r18so4054785wmd.3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:40:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Feb 2017 18:40:30 +0100
Message-Id: <1487958030-51417-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
References: <1487958030-51417-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/17] qmp-events: fix GUEST_PANICKED
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>

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
1.8.3.1

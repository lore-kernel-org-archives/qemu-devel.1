Received: from eggs.gnu.org ([2001:4830:134:3::10]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceQNS-0005AH-DK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ceQNN-0003am-Hs
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:01:58 -0500
Received: from mail-db5eur01on0096.outbound.protection.outlook.com
	([104.47.2.96]:18624
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1ceQNN-0003Zk-2j
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 13:01:53 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 16 Feb 2017 19:30:01 +0300
Message-ID: <1487262601-78993-1-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <aefcd4e5-8d7e-b50e-e080-981e18013967@openvz.org>
References: <aefcd4e5-8d7e-b50e-e080-981e18013967@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qmp-events: fix GUEST_PANICKED description
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
Cc: eblake@redhat.com, pbonzini@redhat.com, den@openvz.org, anton.nefedov@virtuozzo.com

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
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

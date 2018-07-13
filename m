Received: from eggs.gnu.org ([2001:4830:134:3::10]:57558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdx1j-0005DR-IB
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stweil@ub-blade-01.bib.uni-mannheim.de>)
	id 1fdx1g-0004B0-Ca
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:18:23 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Fri, 13 Jul 2018 14:17:27 +0200
Message-Id: <20180713121727.6095-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH v2] docs: Fix some typos (most found by
 codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

v2: Rebased, so the recently applied fixes are no longer included.

 docs/COLO-FT.txt            | 2 +-
 docs/interop/vhost-user.txt | 4 ++--
 docs/replay.txt             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index d7c7dcda8f..70cfb9ce7d 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -104,7 +104,7 @@ Primary side.
 COLO Proxy:
 Delivers packets to Primary and Seconday, and then compare the responses from
 both side. Then decide whether to start a checkpoint according to some rules.
-Please refer to docs/colo-proxy.txt for more informations.
+Please refer to docs/colo-proxy.txt for more information.
 
 Note:
 HeartBeat has not been implemented yet, so you need to trigger failover process
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index f59667f498..c2194711d9 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -666,12 +666,12 @@ Master message types
       Equivalent ioctl: VHOST_SET_VRING_ENDIAN
       Master payload: vring state description
 
-      Set the endianess of a VQ for legacy devices. Little-endian is indicated
+      Set the endianness of a VQ for legacy devices. Little-endian is indicated
       with state.num set to 0 and big-endian is indicated with state.num set
       to 1. Other values are invalid.
       This request should be sent only when VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
       has been negotiated.
-      Backends that negotiated this feature should handle both endianesses
+      Backends that negotiated this feature should handle both endiannesses
       and expect this message once (per VQ) during device configuration
       (ie. before the master starts the VQ).
 
diff --git a/docs/replay.txt b/docs/replay.txt
index 2e21e9ccb0..3497585f5a 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -320,7 +320,7 @@ Here is the list of events that are written into the log:
    async event id from the following list:
      - REPLAY_ASYNC_EVENT_BH. Bottom-half callback. This event synchronizes
        callbacks that affect virtual machine state, but normally called
-       asyncronously.
+       asynchronously.
        Argument: 8-byte operation id.
      - REPLAY_ASYNC_EVENT_INPUT. Input device event. Contains
        parameters of keyboard and mouse input operations
-- 
2.11.0

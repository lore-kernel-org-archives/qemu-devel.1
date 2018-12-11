Received: from eggs.gnu.org ([2001:4830:134:3::10]:50272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gWgfk-00031I-H2
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gWgfg-0006qX-Go
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 06:57:56 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 11 Dec 2018 14:57:39 +0300
Message-Id: <20181211115739.7725-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH trivial]
 contrib/systemd/qemu-guest-agent.service: BindTo=>BindsTo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

As per https://github.com/systemd/systemd/commit/7f2cddae09fd2579ae24434df577bb5e5a157d86

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 contrib/systemd/qemu-guest-agent.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/systemd/qemu-guest-agent.service b/contrib/systemd/qemu-guest-agent.service
index 51cd7b37ff..59f7ecb1b8 100644
--- a/contrib/systemd/qemu-guest-agent.service
+++ b/contrib/systemd/qemu-guest-agent.service
@@ -1,6 +1,6 @@
 [Unit]
 Description=QEMU Guest Agent
-BindTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
+BindsTo=dev-virtio\x2dports-org.qemu.guest_agent.0.device
 After=dev-virtio\x2dports-org.qemu.guest_agent.0.device
 
 [Service]
-- 
2.11.0

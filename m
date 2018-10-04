Received: from eggs.gnu.org ([2001:4830:134:3::10]:46654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86Ll-0005wp-FK
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86Li-0002jg-V3
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:40 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:52 -0400
Message-Id: <20181004161852.11673-11-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 10/10] scripts/qemu.py: remove trailing quotes
 on docstring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qemu.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 7abe26de69..676eb9709a 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -88,7 +88,7 @@ class QEMUMachine(object):
         @param name: prefix for socket and log file names (default: qemu-PID)
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
-        @param socket_scm_helper: helper program, required for send_fd_scm()"
+        @param socket_scm_helper: helper program, required for send_fd_scm()
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
-- 
2.17.1

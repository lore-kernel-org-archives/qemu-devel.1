Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBsi-0006JP-MT
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cPBsd-0008FM-PX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cPBsd-0008E1-KN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 12:31:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  5 Jan 2017 17:31:05 +0000
Message-Id: <20170105173107.5426-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qga: systemd socket activation for AF_UNIX
 and AF_VSOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

These patches add optional systemd socket activation support to the QEMU guest
agent.  The listen socket is created by systemd.  qemu-ga is only launched when
the first client connects and the listen fd is passed in.  The guest agent
detects socket activation automatically on startup.  There are no new
command-line options.

I wrote this code to test systemd AF_VSOCK socket activation but it also works
with AF_UNIX.

Stefan Hajnoczi (2):
  configure: add libsystemd check
  qga: add systemd socket activation support

 configure           | 34 +++++++++++++++++++++++++++
 qga/Makefile.objs   |  3 +++
 qga/channel.h       |  3 ++-
 qga/channel-posix.c | 66 ++++++++++++++++++++++++++++++-----------------------
 qga/channel-win32.c |  2 +-
 qga/main.c          | 45 ++++++++++++++++++++++++++++++++----
 6 files changed, 118 insertions(+), 35 deletions(-)

-- 
2.9.3

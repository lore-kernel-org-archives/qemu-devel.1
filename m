Received: from eggs.gnu.org ([209.51.188.92]:49412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjew-0001ES-3I
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grjev-0004D0-I7
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:06 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:59531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grjev-000407-8O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:24:05 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  7 Feb 2019 15:23:20 +0200
Message-Id: <cover.1549545591.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

this series fixes the crash I reported yesterday in char-socket and
adds a new qemu_idle_add() function, fixing a couple of memory leaks
along the way.

Regards,

Berto

Alberto Garcia (3):
  main-loop: Don't leak GSources attached to a GMainContext
  main-loop: Add qemu_idle_add()
  char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeout()

 chardev/char-pty.c       |  8 ++------
 chardev/char-socket.c    | 19 +++++++++++++++++--
 include/qemu/main-loop.h |  8 ++++++++
 io/task.c                |  6 ++----
 util/main-loop.c         |  9 +++++++++
 5 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.11.0

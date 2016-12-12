Received: from eggs.gnu.org ([2001:4830:134:3::10]:44129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZNC-0006CK-8B
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZN9-0004vK-3Q
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:47:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZN8-0004uy-Td
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:47:03 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F422C04B320
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:47:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:43:25 +0300
Message-Id: <20161212224325.20790-55-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 54/54] char: headers clean-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Those could probably be squashed with earlier patches, however I
couldn't easily identify them, test them or check if there are still
necessary on various platforms.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index a727c56390..e03525aec3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -26,54 +26,15 @@
 #include "qemu/cutils.h"
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
-#include "qemu/timer.h"
 #include "sysemu/char.h"
-#include "hw/usb.h"
 #include "qmp-commands.h"
-#include "qapi/clone-visitor.h"
 #include "qapi-visit.h"
-#include "qemu/base64.h"
-#include "io/channel-socket.h"
-#include "io/channel-tls.h"
 #include "sysemu/replay.h"
 #include "qemu/help_option.h"
=20
-#include <zlib.h>
-
-#ifndef _WIN32
-#include <sys/times.h>
-#include <sys/wait.h>
-#include <sys/ioctl.h>
-#include <sys/resource.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <net/if.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <sys/select.h>
-#ifdef __sun__
-#include <sys/ethernet.h>
-#include <sys/sockio.h>
-#include <netinet/arp.h>
-#include <netinet/in.h>
-#include <netinet/in_systm.h>
-#include <netinet/ip.h>
-#include <netinet/ip_icmp.h> // must come after ip.h
-#include <netinet/udp.h>
-#include <netinet/tcp.h>
-#endif
-#endif
-
-#include "qemu/sockets.h"
-#include "ui/qemu-spice.h"
-
 #include "char-mux.h"
 #include "char-io.h"
-#ifdef _WIN32
-#include "char-win.h"
-#endif
 #include "char-parallel.h"
 #include "char-serial.h"
=20
--=20
2.11.0

Received: from eggs.gnu.org ([209.51.188.92]:45802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaS-00066J-Ow
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTn-0005ny-Mb
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:17 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTl-0005mG-LC
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:44:09 -0500
Received: by mail-qt1-f174.google.com with SMTP id v11so124441qtc.2
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:44:08 -0800 (PST)
Date: Mon, 4 Feb 2019 09:44:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-25-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 24/25] r2d: fix build on mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Comment near strncpy explains kernel_cmdline does
not need to be 0-terminated.

Accordingly mark it as QEMU_NONSTRING.

Without this, gcc warns:
    'strncpy' specified bound 256 equals destination size

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/sh4/r2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 5b399e7161..dcdb3728cb 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -220,7 +220,7 @@ static struct QEMU_PACKED
 
     char pad[232];
 
-    char kernel_cmdline[256];
+    char kernel_cmdline[256] QEMU_NONSTRING;
 } boot_params;
 
 static void r2d_init(MachineState *machine)
-- 
MST

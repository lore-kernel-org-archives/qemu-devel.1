Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Gh-0005Gf-GP
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006yL-EK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo8Ge-0006xH-8B
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 08:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62DBC4028150
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 13:47:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 20 Feb 2018 14:47:20 +0100
Message-Id: <20180220134723.11776-10-kraxel@redhat.com>
In-Reply-To: <20180220134723.11776-1-kraxel@redhat.com>
References: <20180220134723.11776-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/12] vl: drop full_screen variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Not used any more, delete it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180202111022.19269-11-kraxel@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vl.c b/vl.c
index 2dd00e00d9..6271ad0634 100644
--- a/vl.c
+++ b/vl.c
@@ -150,7 +150,6 @@ static int rtc_utc = 1;
 static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
-static int full_screen = 0;
 static DisplayOptions dpy;
 int no_frame;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
@@ -3652,7 +3651,6 @@ int main(int argc, char **argv, char **envp)
                 loadvm = optarg;
                 break;
             case QEMU_OPTION_full_screen:
-                full_screen = 1;
                 dpy.has_full_screen = true;
                 dpy.full_screen = true;
                 break;
-- 
2.9.3

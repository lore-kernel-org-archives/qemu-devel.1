Received: from eggs.gnu.org ([2001:4830:134:3::10]:45808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0007xx-V7
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCED-0002TB-73
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCED-0002S0-0l
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54FFB39B26
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:16 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:24:06 +0100
Message-Id: <20180129162408.415-11-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/12] vl: drop full_screen variable
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
---
 vl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/vl.c b/vl.c
index eb8aca9479..899fcad75e 100644
--- a/vl.c
+++ b/vl.c
@@ -149,7 +149,6 @@ static int rtc_utc = 1;
 static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
-static int full_screen = 0;
 static DisplayOptions dpy;
 int no_frame;
 Chardev *serial_hds[MAX_SERIAL_PORTS];
@@ -3659,7 +3658,6 @@ int main(int argc, char **argv, char **envp)
                 loadvm = optarg;
                 break;
             case QEMU_OPTION_full_screen:
-                full_screen = 1;
                 dpy.has_full_screen = true;
                 dpy.full_screen = true;
                 break;
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEF-0007zM-Em
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCE9-0002Oa-KJ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCE9-0002Nk-EE
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2BCB1752A8
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:12 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:23:58 +0100
Message-Id: <20180129162408.415-3-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/12] vl: deprecate -alt-grab and -ctrl-grab
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 vl.c          | 8 ++++++++
 qemu-doc.texi | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/vl.c b/vl.c
index ac0efca708..fa19a61500 100644
--- a/vl.c
+++ b/vl.c
@@ -2115,6 +2115,8 @@ static DisplayType select_display(const char *p)
                     goto invalid_sdl_args;
                 }
             } else if (strstart(opts, ",alt_grab=", &nextopt)) {
+                g_printerr("The alt_grab= sdl option is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
                     alt_grab = 1;
@@ -2124,6 +2126,8 @@ static DisplayType select_display(const char *p)
                     goto invalid_sdl_args;
                 }
             } else if (strstart(opts, ",ctrl_grab=", &nextopt)) {
+                g_printerr("The ctrl_grab= sdl option is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
                     ctrl_grab = 1;
@@ -3649,9 +3653,13 @@ int main(int argc, char **argv, char **envp)
                 no_frame = 1;
                 break;
             case QEMU_OPTION_alt_grab:
+                g_printerr("The -alt-grab switch is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 alt_grab = 1;
                 break;
             case QEMU_OPTION_ctrl_grab:
+                g_printerr("The -ctrl-grab switch is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 ctrl_grab = 1;
                 break;
             case QEMU_OPTION_no_quit:
diff --git a/qemu-doc.texi b/qemu-doc.texi
index cd8d96f0d3..6d167a6949 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2756,6 +2756,12 @@ support for frameless windows, and the other user interfaces never
 implemented this in the first place.  So this will be removed together
 with SDL 1.2 support.
 
+@subsection -alt-grab and -ctrl-grab (since 2.12.0)
+
+The ``-alt-grab'' and ``-ctrl-grab'' arguments are deprecated.  They
+work with SDL only.  They will eventually replaced with a new way to
+configure hotkeys which works consistently across all user interfaces.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
-- 
2.9.3

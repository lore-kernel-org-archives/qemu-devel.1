Received: from eggs.gnu.org ([2001:4830:134:3::10]:45752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCEA-0007xI-Jc
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egCE7-0002Mi-VG
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egCE7-0002Lf-Os
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:24:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA6AE1752C0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 16:24:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 17:23:57 +0100
Message-Id: <20180129162408.415-2-kraxel@redhat.com>
In-Reply-To: <20180129162408.415-1-kraxel@redhat.com>
References: <20180129162408.415-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/12] vl: deprecate -no-frame
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
 vl.c          | 4 ++++
 qemu-doc.texi | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/vl.c b/vl.c
index e517a8d995..ac0efca708 100644
--- a/vl.c
+++ b/vl.c
@@ -2104,6 +2104,8 @@ static DisplayType select_display(const char *p)
             const char *nextopt;
 
             if (strstart(opts, ",frame=", &nextopt)) {
+                g_printerr("The frame= sdl option is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 opts = nextopt;
                 if (strstart(opts, "on", &nextopt)) {
                     no_frame = 0;
@@ -3642,6 +3644,8 @@ int main(int argc, char **argv, char **envp)
                 full_screen = 1;
                 break;
             case QEMU_OPTION_no_frame:
+                g_printerr("The -no-frame switch is deprecated, and will be\n"
+                           "removed in a future release.\n");
                 no_frame = 1;
                 break;
             case QEMU_OPTION_alt_grab:
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 79d08b3f04..cd8d96f0d3 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2749,6 +2749,13 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
 which is not the recommended way to run QEMU. This backend should not be
 used and it will be removed with no replacement.
 
+@subsection -no-frame (since 2.12.0)
+
+The ``-no-frame'' argument works with SDL 1.2 only.  SDL 2.0 lacks
+support for frameless windows, and the other user interfaces never
+implemented this in the first place.  So this will be removed together
+with SDL 1.2 support.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
-- 
2.9.3

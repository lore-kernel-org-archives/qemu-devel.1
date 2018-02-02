Received: from eggs.gnu.org ([2001:4830:134:3::10]:42442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcca-0003iP-5p
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehccV-0004n6-9j
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehccV-0004lA-31
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:47:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2AB9C05E764
	for <qemu-devel@nongnu.org>; Fri,  2 Feb 2018 11:10:25 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 12:10:11 +0100
Message-Id: <20180202111022.19269-2-kraxel@redhat.com>
In-Reply-To: <20180202111022.19269-1-kraxel@redhat.com>
References: <20180202111022.19269-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/12] vl: deprecate -no-frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
index 19a82bfea3..aa7180a3d9 100644
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

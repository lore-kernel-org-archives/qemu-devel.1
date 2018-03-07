Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etSzz-0008At-2Q
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 01:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etSzu-0006Eo-7K
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 01:56:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  7 Mar 2018 07:56:09 +0100
Message-Id: <1520405769-22179-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Add the paragraph about the
 -no-frame deprecation again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

The section has accidentially been removed while resolving a
contextual conflict during a rebase, so add this again.

Fixes: f29d4450428fe07e9d6b0655cef2e59bfa0b2ea5
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 NB: I also slightly changed the wording and removed the "SDL 2.0 lacks
 support for frameless windows" part - AFAIK it can do frameless windows
 with the SDL_WINDOW_BORDERLESS flag for SDL_CreateWindow().

 qemu-doc.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39e38c8..031f443 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2728,6 +2728,12 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
 which is not the recommended way to run QEMU. This backend should not be
 used and it will be removed with no replacement.
 
+@subsection -no-frame (since 2.12.0)
+
+The @code{--no-frame} argument works with SDL 1.2 only. The other user
+interfaces never implemented this in the first place. So this will be
+removed together with SDL 1.2 support.
+
 @subsection -rtc-td-hack (since 2.12.0)
 
 The @code{-rtc-td-hack} option has been replaced by
-- 
1.8.3.1

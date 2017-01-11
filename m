Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgw-0003ee-UO
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgw-0003jv-5m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:14 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgw-0003jJ-0a
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:36:14 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so337243wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:36:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:27 +0100
Message-Id: <1484163327-111841-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/33] Revert "win32: don't run subprocess tests
 on Mingw32 platform"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.

The error "Failed to execute helper program (No such file or directory)"
is due to broken glib installation, missing windows gspawn helpers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170104205722.26492-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 091ae05..1f2ee71 100755
--- a/configure
+++ b/configure
@@ -3079,7 +3079,7 @@ fi
 
 # g_test_trap_subprocess added in 2.38. Used by some tests.
 glib_subprocess=yes
-if test "$mingw32" = "yes" || ! $pkg_config --atleast-version=2.38 glib-2.0; then
+if ! $pkg_config --atleast-version=2.38 glib-2.0; then
     glib_subprocess=no
 fi
 
-- 
1.8.3.1

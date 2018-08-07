Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYN-00087H-VY
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1fmzYJ-00034n-3E
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:28 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1fmzYI-00034W-TL
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:49:23 -0400
Received: by mail-wm0-f42.google.com with SMTP id r24-v6so14004997wmh.0
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 03:49:22 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  7 Aug 2018 12:49:15 +0200
Message-Id: <65e1a15b5c2bb532a26a4fe908c67f4c9ea5f138.1533638952.git.tgolembi@redhat.com>
In-Reply-To: <cover.1533638952.git.tgolembi@redhat.com>
References: <cover.1533638952.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/4] build: rename CONFIG_QGA_NTDDDISK to
 CONFIG_QGA_NTDDSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

There was inconsistency between commits:

  50cbebb9a3 configure: add configure check for ntdddisk.h
  a3ef3b2272 qga: added bus type and disk location path

The first commit added #define CONFIG_QGA_NTDDDISK but the second commit
expected the name to be CONFIG_QGA_NTDDSCSI. As a result the code in
second patch was never used.

Renaming the option to CONFIG_QGA_NTDDSCSI to match the name of header
file that is being checked for.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 2a7796ea80..b31f37ed50 100755
--- a/configure
+++ b/configure
@@ -6111,7 +6111,7 @@ if test "$mingw32" = "yes" ; then
     echo "WIN_SDK=\"$win_sdk\"" >> $config_host_mak
   fi
   if test "$guest_agent_ntddscsi" = "yes" ; then
-    echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
+    echo "CONFIG_QGA_NTDDSCSI=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
     echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
-- 
2.18.0

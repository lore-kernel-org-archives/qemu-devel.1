Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tH-000415-0g
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iP-0003Ua-Ar
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iP-0003TH-3x
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so9483158wru.8
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:45 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:30 +0200
Message-Id: <73a25549dfd4206b53f5fd8e98f789b20ac861a4.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/11] build: rename CONFIG_QGA_NTDDDISK to
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
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

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
index 58862d2ae8..0f168607e8 100755
--- a/configure
+++ b/configure
@@ -6201,7 +6201,7 @@ if test "$mingw32" = "yes" ; then
     echo "WIN_SDK=\"$win_sdk\"" >> $config_host_mak
   fi
   if test "$guest_agent_ntddscsi" = "yes" ; then
-    echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
+    echo "CONFIG_QGA_NTDDSCSI=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
     echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
-- 
2.19.0

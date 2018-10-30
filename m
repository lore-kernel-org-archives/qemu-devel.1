Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG8-0007Vb-Qq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVG3-0008UX-Hk
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:44 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVFz-0008FF-Oa
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:44:38 -0400
Received: by mail-qt1-x844.google.com with SMTP id l9-v6so13690255qtj.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:44:24 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:43 -0500
Message-Id: <20181030144358.23144-10-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/24] build: rename CONFIG_QGA_NTDDDISK to
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

There was inconsistency between commits:

  50cbebb9a3 configure: add configure check for ntdddisk.h
  a3ef3b2272 qga: added bus type and disk location path

The first commit added #define CONFIG_QGA_NTDDDISK but the second commit
expected the name to be CONFIG_QGA_NTDDSCSI. As a result the code in
second patch was never used.

Renaming the option to CONFIG_QGA_NTDDSCSI to match the name of header
file that is being checked for.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index eea3b0c7a4..e63ec5e60d 100755
--- a/configure
+++ b/configure
@@ -6136,7 +6136,7 @@ if test "$mingw32" = "yes" ; then
     echo "WIN_SDK=\"$win_sdk\"" >> $config_host_mak
   fi
   if test "$guest_agent_ntddscsi" = "yes" ; then
-    echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
+    echo "CONFIG_QGA_NTDDSCSI=y" >> $config_host_mak
   fi
   if test "$guest_agent_msi" = "yes"; then
     echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
-- 
2.17.1

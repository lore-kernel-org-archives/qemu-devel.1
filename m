Received: from eggs.gnu.org ([2001:4830:134:3::10]:33452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMf-0000vB-7N
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHrMa-0007DW-Hl
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHrMa-0006v6-6j
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:20:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id j3so8869805otl.9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:20:25 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2018 09:19:10 -0500
Message-Id: <20181031141925.30026-10-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 09/24] build: rename CONFIG_QGA_NTDDDISK to
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
index 61276982c6..95f3d44ecd 100755
--- a/configure
+++ b/configure
@@ -6142,7 +6142,7 @@ if test "$mingw32" = "yes" ; then
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

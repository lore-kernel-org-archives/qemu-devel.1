Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtM-00084c-7f
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCtL-0001AV-4B
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCtK-00019x-Tz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:16:55 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:37 +0800
Message-Id: <1513908937-16034-19-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 18/18] qemu-doc: Update the deprecation
 information of -tftp, -bootp, -redir and -smb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The information how to update the deprecated parameters was too scarce,
so that some people did not update to the new syntax yet. Provide some
more information to make sure that it is clear how to update from the
old syntax to the new one.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-doc.texi | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 140659a..ae90f71 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2648,27 +2648,36 @@ combined with ``-vnc tls-creds=tls0'
 
 @subsection -tftp (since 2.6.0)
 
-The ``-tftp /some/dir'' argument is now a synonym for setting
-the ``-netdev user,tftp=/some/dir' argument. The new syntax
-allows different settings to be provided per NIC.
+The ``-tftp /some/dir'' argument is replaced by
+``-netdev user,id=x,tftp=/some/dir'', either accompanied with
+``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
 
 @subsection -bootp (since 2.6.0)
 
-The ``-bootp /some/file'' argument is now a synonym for setting
-the ``-netdev user,bootp=/some/file' argument. The new syntax
-allows different settings to be provided per NIC.
+The ``-bootp /some/file'' argument is replaced by
+``-netdev user,id=x,bootp=/some/file'', either accompanied with
+``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
 
 @subsection -redir (since 2.6.0)
 
-The ``-redir ARGS'' argument is now a synonym for setting
-the ``-netdev user,hostfwd=ARGS'' argument instead. The new
-syntax allows different settings to be provided per NIC.
+The ``-redir [tcp|udp]:hostport:[guestaddr]:guestport'' argument is
+replaced by ``-netdev
+user,id=x,hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport'',
+either accompanied with ``-device ...,netdev=x'' (for pluggable NICs) or
+``-net nic,netdev=x'' (for embedded NICs). The new syntax allows different
+settings to be provided per NIC.
 
 @subsection -smb (since 2.6.0)
 
-The ``-smb /some/dir'' argument is now a synonym for setting
-the ``-netdev user,smb=/some/dir'' argument instead. The new
-syntax allows different settings to be provided per NIC.
+The ``-smb /some/dir'' argument is replaced by
+``-netdev user,id=x,smb=/some/dir'', either accompanied with
+``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
 
 @subsection -net vlan (since 2.9.0)
 
-- 
2.7.4

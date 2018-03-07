Received: from eggs.gnu.org ([2001:4830:134:3::10]:49240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eta46-0005U4-0L
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eta42-0007Vf-PD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:29:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eta42-0007VI-Gw
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:29:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAF7040252F0
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 14:29:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  7 Mar 2018 15:28:57 +0100
Message-Id: <20180307142857.28438-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: update deprecation section to use
 -nic and -netdev hubport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

The deprecated SLIRP options -tftp, -bootp, -redir, -smb provide
sample replacements that use "-net nic".  Suggest "-nic" instead,
since we finally have a path towards getting rid of "-net".

For "-net vlan" the replacement involves hubport network devices,
so mention that too.

Cc: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39e38c87ec..918d97c18b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2643,42 +2643,46 @@ combined with ``-vnc tls-creds=tls0'
 
 @subsection -tftp (since 2.6.0)
 
-The ``-tftp /some/dir'' argument is replaced by
-``-netdev user,id=x,tftp=/some/dir'', either accompanied with
-``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+The ``-tftp /some/dir'' argument is replaced by either
+``-netdev user,id=x,tftp=/some/dir '' (for pluggable NICs, accompanied
+with ``-device ...,netdev=x''), or ``-nic user,tftp=/some/dir''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
 @subsection -bootp (since 2.6.0)
 
-The ``-bootp /some/file'' argument is replaced by
-``-netdev user,id=x,bootp=/some/file'', either accompanied with
-``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+The ``-bootp /some/file'' argument is replaced by either
+``-netdev user,id=x,bootp=/some/file '' (for pluggable NICs, accompanied
+with ``-device ...,netdev=x''), or ``-nic user,bootp=/some/file''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
 @subsection -redir (since 2.6.0)
 
 The ``-redir [tcp|udp]:hostport:[guestaddr]:guestport'' argument is
-replaced by ``-netdev
-user,id=x,hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport'',
-either accompanied with ``-device ...,netdev=x'' (for pluggable NICs) or
-``-net nic,netdev=x'' (for embedded NICs). The new syntax allows different
-settings to be provided per NIC.
+replaced by either
+``-netdev user,id=x,hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport''
+(for pluggable NICs, accompanied with ``-device ...,netdev=x'') or
+``-nic user,hostfwd=[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestport''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
 
 @subsection -smb (since 2.6.0)
 
-The ``-smb /some/dir'' argument is replaced by
-``-netdev user,id=x,smb=/some/dir'', either accompanied with
-``-device ...,netdev=x'' (for pluggable NICs) or ``-net nic,netdev=x''
+The ``-smb /some/dir'' argument is replaced by either
+``-netdev user,id=x,smb=/some/dir '' (for pluggable NICs, accompanied
+with ``-device ...,netdev=x''), or ``-nic user,smb=/some/dir''
 (for embedded NICs). The new syntax allows different settings to be
 provided per NIC.
 
 @subsection -net vlan (since 2.9.0)
 
-The ``-net vlan=NN'' argument is partially replaced with the
-new ``-netdev'' argument. The remaining use cases will no
-longer be directly supported in QEMU.
+The ``-net vlan=NN'' argument was mostly used to attach separate
+network backends to different virtual NICs.  This is the default
+behavior for ``-netdev'' and ``-nic''.  You can connect multiple
+``-netdev'' and ``-nic'' devices to the same network using the
+"hubport" network backend, created with ``-netdev hubport,hubid=NN,...''
+and ``-nic hubport,hubid=NN''.
 
 @subsection -drive cyls=...,heads=...,secs=...,trans=... (since 2.10.0)
 
-- 
2.14.3

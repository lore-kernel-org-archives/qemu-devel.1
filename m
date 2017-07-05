Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0004Mi-Kq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWT-0007Oy-0Z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:57 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWS-0007OO-Qv
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:52 -0400
Received: by mail-wm0-x241.google.com with SMTP id u23so30501897wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:52 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:05 +0200
Message-Id: <1499238885-26161-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/42] qemu-doc: Add missing "@c man end"
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since commit 3f2ce724f1f1 ("Move the qemu-ga description into a
separate chapter"), the qemu.1 man page looks pretty much screwed
up, e.g. the title was "qemu-ga - QEMU Guest Agent" instead of
"qemu-doc - QEMU Emulator User Documentation". However, that movement
of the gemu-ga chapter is not the real problem, it just triggered
another bug in the qemu-doc.texi: There are some parts in the file
which introduce a "@c man begin OPTIONS" section, but never close
it again with "@c man end". After adding the proper end tags here,
the title of the man page is right again and the previously wrongly
tagged sections now also show up correctly in the man page, too.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1497863771-24929-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 21079fd..45f67f6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2566,6 +2566,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node ColdFire System emulator
 @section ColdFire System emulator
 @cindex system emulation (ColdFire)
@@ -2610,6 +2612,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node Cris System emulator
 @section Cris System emulator
 @cindex system emulation (Cris)
@@ -2682,6 +2686,8 @@ so should only be used with trusted guest OS.
 
 @end table
 
+@c man end
+
 @node QEMU Guest Agent
 @chapter QEMU Guest Agent invocation
 
-- 
1.8.3.1

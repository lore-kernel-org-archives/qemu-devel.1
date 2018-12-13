Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQK6-0004d2-BI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQK5-0002YX-KN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gXQK5-0002TE-Au
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 939DC30023C5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:42:36 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Thu, 13 Dec 2018 13:42:22 +0100
Message-Id: <20181213124224.31585-2-kchamart@redhat.com>
In-Reply-To: <20181213124224.31585-1-kchamart@redhat.com>
References: <20181213124224.31585-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-deprecated.texi: Rename the HMP
 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

So that it is consistent with the naming of QMP's

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 qemu-deprecated.texi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 72b8191d60..46bec688db 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -114,7 +114,7 @@ The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
 
-@section System emulator human monitor commands
+@section Human Monitor Protocol (HMP) commands
 
 @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
 
-- 
2.17.2

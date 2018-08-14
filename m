Received: from eggs.gnu.org ([2001:4830:134:3::10]:48485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdkp-0002rH-K5
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpdka-0005gI-AG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49899 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpdka-0005ep-0K
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F4818197005
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 15:41:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Aug 2018 17:41:39 +0200
Message-Id: <20180814154139.28604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add maintainers for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, thuth@redhat.com

Thomas has been doing a lot of work on qom-test and device-introspection-test,
and Laurent has ported libqos to sPAPR and co-mentored Emanuele on the
upcoming qtest device framework.  They deserve recognition. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936812..657595e6be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1685,7 +1685,6 @@ F: qom/
 X: qom/cpu.c
 F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
-F: tests/qom-test.c
 
 QMP
 M: Markus Armbruster <armbru@redhat.com>
@@ -1697,6 +1696,16 @@ F: scripts/qmp/
 F: tests/qmp-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
+qtest
+M: Paolo Bonzini <pbonzini@redhat.com>
+M: Thomas Huth <thuth@redhat.com>
+M: Laurent Vivier <lvivier@redhat.com>
+S: Maintained
+F: qtest.c
+F: tests/libqtest.*
+F: tests/libqos/
+F: tests/*-test.c
+
 Register API
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
-- 
2.17.1

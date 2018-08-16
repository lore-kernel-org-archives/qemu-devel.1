Received: from eggs.gnu.org ([2001:4830:134:3::10]:59311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZo-0001LP-10
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqGZl-0003Ty-Oz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34548 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqGZh-0003RI-Mz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:36:23 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 16 Aug 2018 13:35:58 +0200
Message-Id: <1534419358-10932-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1534419358-10932-1-git-send-email-thuth@redhat.com>
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/8] MAINTAINERS: add maintainers for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Thomas has been doing a lot of work on qom-test and device-introspection-test,
and Laurent has ported libqos to sPAPR and co-mentored Emanuele on the
upcoming qtest device framework.  They deserve recognition. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
[thuth: removed the hunk that deleted the tests/qom-test.c entry]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936..072824c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1697,6 +1697,16 @@ F: scripts/qmp/
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
1.8.3.1

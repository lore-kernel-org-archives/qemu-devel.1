Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3x-0001At-Ax
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3o-0005fl-6D
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:20 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:40657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3n-0005Yp-0H
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:15 -0400
Received: by mail-wm0-x234.google.com with SMTP id y9-v6so3496460wma.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:14 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-184-244.clienti.tiscali.it.
	[78.12.184.244]) by smtp.gmail.com with ESMTPSA id
	v6-v6sm2608955wmc.43.2018.08.21.10.03.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Aug 2018 10:03:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:41 +0200
Message-Id: <1534870966-9287-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/74] MAINTAINERS: add maintainers for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thomas has been doing a lot of work on qom-test and device-introspection-test,
and Laurent has ported libqos to sPAPR and co-mentored Emanuele on the
upcoming qtest device framework.  They deserve recognition. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6902a56..68bc92e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1696,7 +1696,6 @@ F: qom/
 X: qom/cpu.c
 F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
-F: tests/qom-test.c
 
 QMP
 M: Markus Armbruster <armbru@redhat.com>
@@ -1708,6 +1707,16 @@ F: scripts/qmp/
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

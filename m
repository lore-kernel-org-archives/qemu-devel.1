Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo61R-0002dC-4N
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo61O-0003YZ-37
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:56:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fo61N-0003XP-U5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 07:55:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEB6C402243B
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 11:55:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-62.ams2.redhat.com
	[10.36.117.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5AAB2026D65
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 11:55:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 10 Aug 2018 13:55:53 +0200
Message-Id: <20180810115553.32604-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Fix F: patterns that don't match
 anything
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit ba51ef25571 moved hw/dma/sun4m_iommu.c to
hw/sparc/sun4m_iommu.c without updating MAINTAINERS.

Commit f5980f757c0 deleted include/hw/sparc/sun4m.h without updating
MAINTAINERS.

Commit 0bcc8e5bd8d fat-fingered tests/check-block-qdict.c.

Commit 33e9e9bd62d fat-fingered include/qemu/job.h.

Commit eb815e248f5 moved qapi-schema.json to qapi/ without updating
MAINTAINERS.

Commit 2e3c8f8dbdd converted docs/devel/migration.txt to
docs/devel/migration.rst without updating MAINTAINERS.

Offenders tracked down with the following shell loop:

    shopt -s nullglob
    for i in `sed -n 's/^F: //p' <MAINTAINERS `
    do
        glob="`echo $i`"
	if [ "$glob" = "$i" ]
	then [ ! -e $i ]
	else [ -z "$glob" ]
	fi && echo "$i"
    done

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936812..01a2f20718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -873,12 +873,11 @@ Sun4m
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc/sun4m.c
+F: hw/sparc/sun4m_iommu.c
 F: hw/dma/sparc32_dma.c
-F: hw/dma/sun4m_iommu.c
 F: hw/misc/eccmemctl.c
 F: hw/misc/slavio_misc.c
 F: include/hw/sparc/sparc32_dma.h
-F: include/hw/sparc/sun4m.h
 F: pc-bios/openbios-sparc32
 
 Sun4u
@@ -1399,7 +1398,7 @@ F: qemu-io*
 F: tests/qemu-iotests/
 F: util/qemu-progress.c
 F: qobject/block-qdict.c
-F: test/check-block-qdict.c
+F: tests/check-block-qdict.c
 T: git git://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
@@ -1432,7 +1431,7 @@ F: blockjob.c
 F: include/block/blockjob.h
 F: job.c
 F: job-qmp.c
-F: include/block/job.h
+F: include/qemu/job.h
 F: block/backup.c
 F: block/commit.c
 F: block/stream.c
@@ -1647,7 +1646,6 @@ QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
-F: qapi-schema.json
 F: qapi/*.json
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
@@ -1756,7 +1754,7 @@ F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
 F: tests/migration-test.c
-F: docs/devel/migration.txt
+F: docs/devel/migration.rst
 F: qapi/migration.json
 
 Seccomp
-- 
2.17.1

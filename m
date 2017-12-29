Received: from eggs.gnu.org ([2001:4830:134:3::10]:41917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPE-0004Gj-BR
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwPB-0005xx-1g
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwPA-0005xZ-RF
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:17:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09FD67EA91
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 15:17:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 29 Dec 2017 16:16:37 +0100
Message-Id: <1514560602-280058-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] tests: acpi: fix FADT not being tested and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin " <mst@redhat.com>, Thomas Huth <thuth@redhat.com>

Even though we have tests/acpi-test-data/[q35|pc]/FACP reference table
in source tree, it hasn't been actually tested. As result it went stale
and we did not notice any changes that were happening to it.

Fix it buy making sure it's not ignored and before fixing it,
do some cleanups in testcase that hopefully will make more clear what
functions actually do. 

NOTE to maintaner:
   after fix in 5/5 update following reference tables, to match reality
   tests/acpi-test-data/pc/FACP
   tests/acpi-test-data/q35/FACP


CC: Michael S. Tsirkin" <mst@redhat.com>
CC: Thomas Huth <thuth@redhat.com>

Igor Mammedov (5):
  tests: acpi: move tested tables array allocation outside of
    test_acpi_dsdt_table()
  tests: acpi: init table descriptor in test_dst_table()
  tests: acpi: rename test_acpi_tables()/test_dst_table() to reflect its
    usage
  tests: acpi: add comments to fetch_rsdt_referenced_tables/data->tables
    usage
  tests: acpi: fix FADT not being compared to reference table

 tests/bios-tables-test.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.7.4

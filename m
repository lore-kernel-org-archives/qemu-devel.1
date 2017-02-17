Received: from eggs.gnu.org ([2001:4830:134:3::10]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002Yc-QX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIS-0004Og-5P
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIR-0004OA-Vh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0447361BA6
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4554B6826
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:11 +0100
Message-Id: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/14] qobject: Cleanups, mostly in tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Markus Armbruster (14):
  qdict: Make qdict_get_qlist() safe like qdict_get_qdict()
  check-qdict: Simplify qdict_crumple_test_recursive()
  check-qdict: Tighten qdict_crumple_test_recursive() some
  check-qjson: Simplify around compare_litqobj_to_qobj()
  libqtest: Clean up qmp_response() a bit
  test-qmp-event: Simplify and tighten event_test_emit()
  Don't check qobject_type() before qobject_to_qdict()
  tests: Don't check qobject_type() before qobject_to_qlist()
  tests: Don't check qobject_type() before qobject_to_qstring()
  tests: Don't check qobject_type() before qobject_to_qint()
  tests: Don't check qobject_type() before qobject_to_qfloat()
  tests: Don't check qobject_type() before qobject_to_qbool()
  monitor: Clean up handle_hmp_command() a bit
  block: Don't bother asserting type of output visitor's output

 block.c                             |   4 +-
 block/nbd.c                         |   2 -
 block/nfs.c                         |   2 -
 block/qapi.c                        |   1 -
 hw/pci/pcie_aer.c                   |   2 +-
 monitor.c                           |  19 +++---
 qapi/qmp-dispatch.c                 |   5 +-
 qobject/qdict.c                     |  30 +-------
 tests/check-qdict.c                 |  37 ++++------
 tests/check-qjson.c                 | 113 ++++++------------------------
 tests/libqtest.c                    |   4 +-
 tests/test-qmp-event.c              |  14 ++--
 tests/test-qobject-output-visitor.c | 133 ++++++++++++++----------------------
 13 files changed, 113 insertions(+), 253 deletions(-)

-- 
2.7.4

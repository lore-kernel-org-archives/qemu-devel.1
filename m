Received: from eggs.gnu.org ([2001:4830:134:3::10]:40578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNU-0004d5-EK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNR-0000dP-7q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgcNR-0000cv-2C
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:01 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F26B61D14
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1MJExj4023280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 14:15:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Feb 2017 20:14:42 +0100
Message-Id: <1487790898-24921-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 00/16] QAPI patches for 2017-02-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-22

for you to fetch changes up to 7c81e4e9db5f63635fbf11d66bf08e73d325ae97:

  block: Don't bother asserting type of output visitor's output (2017-02-22 19:52:20 +0100)

----------------------------------------------------------------
QAPI patches for 2017-02-22

----------------------------------------------------------------
Markus Armbruster (16):
      numa: Flatten simple union NumaOptions
      net: Flatten simple union NetLegacyOptions
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
 net/net.c                           |  44 ++++++------
 numa.c                              |   4 +-
 qapi-schema.json                    |  21 ++++++
 qapi/qmp-dispatch.c                 |   5 +-
 qobject/qdict.c                     |  30 +-------
 tests/check-qdict.c                 |  37 ++++------
 tests/check-qjson.c                 | 113 ++++++------------------------
 tests/libqtest.c                    |   4 +-
 tests/test-qmp-event.c              |  14 ++--
 tests/test-qobject-output-visitor.c | 133 ++++++++++++++----------------------
 16 files changed, 158 insertions(+), 277 deletions(-)

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5gU-0000wR-Cu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5gT-0007td-Lf
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:52:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db5gT-0007sc-D5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A74685363
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:45:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-254.ams2.redhat.com
	[10.36.116.254])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 470F57E2E6
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:45:54 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 28 Jul 2017 15:45:49 +0200
Message-Id: <1501249552-788-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Don't QAPI without need
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These are pretty trivial, probably simplest if I take them through my
tree.

Markus Armbruster (3):
  replay: Define ReplayMode without QAPI
  COLO: Define COLOMode without QAPI
  block: Remove unused BlockDeviceMapEntry

 include/migration/colo.h |  6 ++++++
 include/sysemu/replay.h  |  6 ++++++
 qapi-schema.json         | 34 ----------------------------------
 qapi/block-core.json     | 29 -----------------------------
 4 files changed, 12 insertions(+), 63 deletions(-)

-- 
2.7.5

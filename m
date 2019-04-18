Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8V2-0002PV-JZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002Bx-2M
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002Ao-Rf
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 929EA30254A2
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 641D55D9C5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 16:53:49 +0200
Message-Id: <20190418145355.21100-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Fix misuse of ctype.h functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Markus Armbruster (6):
  qemu-bridge-helper: Fix misuse of isspace()
  tests/vhost-user-bridge: Fix misuse of isdigit()
  gdbstub: Reject invalid RLE repeat counts
  gdbstub: Fix misuse of isxdigit()
  pc-bios/s390-ccw: Clean up harmless misuse of isdigit()
  cutils: Simplify how parse_uint() checks for whitespace

 gdbstub.c                 | 16 ++++++++--------
 pc-bios/s390-ccw/libc.c   |  2 +-
 pc-bios/s390-ccw/menu.c   |  2 +-
 qemu-bridge-helper.c      |  7 ++++---
 tests/vhost-user-bridge.c |  2 +-
 util/cutils.c             |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.17.2

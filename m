Received: from eggs.gnu.org ([209.51.188.92]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sQ-0004Hl-K8
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sP-0007eA-NK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJ2sN-0007ZB-Mt
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 23 Apr 2019 18:22:43 -0300
Message-Id: <20190423212246.3542-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mprivozn@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This series adds machine type deprecation information to the
output of the `query-machines` QMP command.  With this, libvirt
and management software will be able to show this information to
users and/or suggest changes to VM configuration to avoid
deprecated machine types.

Eduardo Habkost (3):
  qapi: SupportStatusInfo struct
  machine: Use SupportStatusInfo for deprecation info
  qmp: Add deprecation information to query-machines

 qapi/common.json                   | 24 ++++++++++++++++++++++++
 qapi/misc.json                     |  5 ++++-
 include/hw/boards.h                |  7 ++++---
 hw/i386/pc_piix.c                  |  4 +++-
 hw/ppc/prep.c                      |  4 +++-
 vl.c                               | 19 +++++++++++++++----
 tests/acceptance/query_machines.py | 27 +++++++++++++++++++++++++++
 7 files changed, 80 insertions(+), 10 deletions(-)
 create mode 100644 tests/acceptance/query_machines.py

-- 
2.18.0.rc1.1.g3f1ff2140

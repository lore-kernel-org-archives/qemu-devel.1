Received: from eggs.gnu.org ([2001:4830:134:3::10]:32919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNyX-0002WO-Dc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNyS-0002gZ-CK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:10:21 -0500
Received: from ozlabs.ru ([107.173.13.209]:41798)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1erNyS-0002g6-5J
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:10:16 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  2 Mar 2018 00:09:37 +1100
Message-Id: <20180301130939.15875-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 0/2] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

This adds a new QMP command to list any class/object properties,
not just devices.

Now comes in 2 patches.

Please comment. Thanks.



Alexey Kardashevskiy (2):
  qmp: Merge ObjectPropertyInfo and DevicePropertyInfo
  qmp: Add qom-list-properties to list QOM object properties

 qapi-schema.json     | 38 +++++++++++++++--------------
 include/qom/object.h | 16 ++++++++++++
 qdev-monitor.c       |  6 ++---
 qmp.c                | 69 ++++++++++++++++++++++++++++++++++++++++++++--------
 qom/object.c         |  7 ++++++
 5 files changed, 105 insertions(+), 31 deletions(-)

-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzE-0008Bb-Pt
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzB-0005D9-1V
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:16 -0500
Received: from ozlabs.ru ([107.173.13.209]:43544)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eruzA-0005BI-Pc
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 19:25:12 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sat,  3 Mar 2018 11:25:02 +1100
Message-Id: <20180303002504.25142-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 0/2] qmp: Add qom-list-properties to
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>


This adds a new QMP command to list any class/object properties,
not just devices.

I do not know how/if we need to address the concern about
abstract/nonabstract classes though.

Changes:
v4:
* cleanup in 1/2



Please comment. Thanks.



Alexey Kardashevskiy (2):
  qmp: Merge ObjectPropertyInfo and DevicePropertyInfo
  qmp: Add qom-list-properties to list QOM object properties

 qapi-schema.json     | 38 ++++++++++++++++---------------
 include/qom/object.h | 16 +++++++++++++
 qdev-monitor.c       |  6 ++---
 qmp.c                | 63 ++++++++++++++++++++++++++++++++++++++++++++++------
 qom/object.c         |  7 ++++++
 5 files changed, 102 insertions(+), 28 deletions(-)

-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GU-0001fZ-OS
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GQ-00018L-BT
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:22 -0400
Received: from [107.173.13.209] (port=49943 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fD2GQ-000182-4B
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 02:26:18 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 30 Apr 2018 16:25:34 +1000
Message-Id: <20180430062536.49077-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v2 0/2] memory/hmp: Print owners/parents
 in "info mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>


This is a debug extension to "into mtree" to print a memory region owner/parent.

This is based on sha1
4743c23 Peter Maydell "Update version for v2.12.0 release".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  memory/hmp: Print owners/parents in "info mtree"
  object: Handle objects with no parents

 include/exec/memory.h |  2 +-
 memory.c              | 69 +++++++++++++++++++++++++++++++++++++++++++--------
 monitor.c             |  4 ++-
 qom/object.c          |  2 +-
 hmp-commands-info.hx  |  7 +++---
 5 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.11.0

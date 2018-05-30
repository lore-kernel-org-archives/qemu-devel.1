Received: from eggs.gnu.org ([2001:4830:134:3::10]:41491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvNT-0006Sg-1t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvNP-0005Vz-VZ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:35 -0400
Received: from [107.173.13.209] (port=51950 helo=ozlabs.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fNvNP-0005Vu-OA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:18:31 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 30 May 2018 17:17:55 +1000
Message-Id: <20180530071757.9112-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v3 0/2] memory/hmp: Print owners/parents
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is a debug extension to "into mtree" to print a memory region owner/parent.

This is based on sha1
e609fa7 Peter Maydell "Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-05-29-v1.for-upstream' into staging".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  object: Handle objects with no parents
  memory/hmp: Print owners/parents in "info mtree"

 include/exec/memory.h |  2 +-
 memory.c              | 68 +++++++++++++++++++++++++++++++++++++++++++--------
 monitor.c             |  4 ++-
 qom/object.c          | 10 ++++++--
 hmp-commands-info.hx  |  7 +++---
 5 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.11.0

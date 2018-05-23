Received: from eggs.gnu.org ([2001:4830:134:3::10]:44411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIW-0005Xl-0a
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLWIS-0005f5-Jg
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:07:32 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 May 2018 18:07:19 +0200
Message-Id: <20180523160721.14018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] sheepdog: remove huge BSS object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, qemu-block@nongnu.org

block/sheepdog.o has a 4M static variable that is 90% of QEMU's whole .bss
section.  Since it doesn't really have to be static, we can just use a
heap allocated block.  We can actually make it smaller too. :)

Patch 1 is a related cleanup since we're touching that area of the code.

Paolo

v1->v2: free the data...

Paolo Bonzini (2):
  sheepdog: cleanup repeated expression
  sheepdog: remove huge BSS object

 block/sheepdog.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.17.0

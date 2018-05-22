Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLDcg-0001fK-B3
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fLDcd-0002vc-5t
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:11:06 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 May 2018 22:10:54 +0200
Message-Id: <20180522201056.1442-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] sheepdog: remove huge BSS object
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

Paolo Bonzini (2):
  sheepdog: cleanup repeated expression
  sheepdog: remove huge BSS object

 block/sheepdog.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
2.17.0

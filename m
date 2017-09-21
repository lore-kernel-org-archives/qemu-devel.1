Received: from eggs.gnu.org ([2001:4830:134:3::10]:39292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Gu-0002Hf-Ad
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dv0Go-00021M-FM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dv0Go-0001z1-8M
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:07:54 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 21 Sep 2017 14:07:48 +0200
Message-Id: <20170921120751.3027-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] FlatView memory savings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru

This gets memory API consumption down to 4 FlatViews when non-virtio
devices are in use.  virtio still wastes memory due to the "modern_as".

Alexey Kardashevskiy (1):
  memory: Share special empty FlatView

Paolo Bonzini (2):
  memory: trace FlatView creation and destruction
  memory: seek FlatView sharing candidates among children subregions

 include/exec/memory.h   |  1 -
 include/qemu/typedefs.h |  1 +
 memory.c                | 60 +++++++++++++++++++++++++++++++++++++++++++------
 trace-events            |  3 +++
 4 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.13.5

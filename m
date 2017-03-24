Received: from eggs.gnu.org ([2001:4830:134:3::10]:54381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1crQ9F-0003Ys-9P
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1crQ9C-00059j-2z
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1crQ9B-00059P-TO
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:24:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 114CD80F9D
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 14:24:57 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 24 Mar 2017 15:24:48 +0100
Message-Id: <1490365490-4854-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-input: eventq batching fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Two bugs found when reviewing the code against the candidate spec:

* memory leak: the event queue is never freed
* incorrect virtqueue check: virtqueue_get_avail_bytes does not
  guarantee number of available buffers

Ladi Prosek (2):
  virtio-input: free event queue when finalizing
  virtio-input: fix eventq batching

 hw/input/virtio-input.c          | 33 +++++++++++++++++----------------
 include/hw/virtio/virtio-input.h |  5 ++++-
 2 files changed, 21 insertions(+), 17 deletions(-)

Thanks!
Ladi

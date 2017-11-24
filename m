Received: from eggs.gnu.org ([2001:4830:134:3::10]:52424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eIIoV-0004Xd-1B
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eIIoR-0005qd-RC
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:34:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eIIoR-0005qI-Lt
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:34:55 -0500
From: P J P <ppandit@redhat.com>
Date: Sat, 25 Nov 2017 00:04:44 +0530
Message-Id: <20171124183446.7308-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] check VirtiQueue Vring objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

An user could attempt to use an uninitialised VirtQueue object
or set Vring object with undue values, raising an unexpected
exception in Qemu. This patch set fixes this issue and also adds
a unit test to the suite.

Thank you.
--
Prasad J Pandit (2):
  virtio: check VirtQueue Vring object is set
  tests: add test to check VirtQueue object

Update: Fixed style error, add space before parenthesis '('
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04652.html

 hw/virtio/virtio.c      | 14 +++++++++++---
 tests/virtio-blk-test.c | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.13.6

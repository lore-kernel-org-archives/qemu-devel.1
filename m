Received: from eggs.gnu.org ([2001:4830:134:3::10]:58399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTwsL-0007Dl-6O
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTwsI-0001WG-IP
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:30:33 -0500
Received: from mail.kernel.org ([198.145.29.136]:49546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTwsI-0001VH-CT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:30:30 -0500
Date: Wed, 18 Jan 2017 22:30:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484771412-28024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 0/4] virtio: ARRAY_SIZE fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Turns out virtio kept using ARRAY_SIZE on fields which stopped
being arrays, this was noticed by a coverity scan.
Fix this up, and fix up the ARRAY_SIZE macro so that this
bug does not reappear in any other place.

Michael S. Tsirkin (4):
  virtio: fix up max size checks
  compiler: drop ; after BUILD_BUG_ON
  compiler: expression version of QEMU_BUILD_BUG_ON
  ARRAY_SIZE: check that argument is an array

 include/qemu/compiler.h |  4 +++-
 include/qemu/osdep.h    |  8 +++++++-
 hw/virtio/virtio.c      | 27 +++++++++++----------------
 3 files changed, 21 insertions(+), 18 deletions(-)

-- 
MST

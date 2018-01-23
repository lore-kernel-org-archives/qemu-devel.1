Received: from eggs.gnu.org ([2001:4830:134:3::10]:36557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee7Ii-0002bq-U3
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee7Ie-0000nw-OQ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ee7Ie-0000m1-IH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:16 -0500
Date: Wed, 24 Jan 2018 00:44:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516747387-31760-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PULL 0/1] virtio: quick fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is just a quick bugfix so people can make progress.
Will send a pull req with more patches queues later this week.

The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:

  Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 3e59a4745a1668eeec94d142b0f5a7847b866a87:

  kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call (2018-01-24 00:41:50 +0200)

----------------------------------------------------------------
virtio: quick fix

Fixes a regression in virtio that's causing issues
for many people.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Jose Ricardo Ziviani (1):
      kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call

 accel/kvm/kvm-all.c | 4 ----
 1 file changed, 4 deletions(-)

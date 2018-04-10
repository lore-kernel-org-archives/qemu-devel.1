Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5k8q-0003ZF-2i
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5k8m-0005sL-Ht
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44786 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5k8m-0005rq-9C
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:16 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Apr 2018 11:39:56 +0800
Message-Id: <1523331602-18781-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b32:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-04-09 17:29:10 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 5f523530915e57a14ffb8c00e22252bfa557441c:

  e1000: Old machine types, turn new subsection off (2018-04-10 11:30:04 +0800)

----------------------------------------------------------------

A series from David that switches to use subsection instead of version
bumping for e1000 to keep migration compatibility for old
versions. This will ease the downstream maintaining.

Please merge.

Thanks

----------------------------------------------------------------
Dr. David Alan Gilbert (6):
      e1000: Convert v3 fields to subsection
      e1000: Dupe offload data on reading old stream
      e1000: wire new subsection to property
      e1000: Migrate props via a temporary structure
      e1000: Choose which set of props to migrate
      e1000: Old machine types, turn new subsection off

 hw/net/e1000.c      | 103 ++++++++++++++++++++++++++++++++++++++++------------
 include/hw/compat.h |   4 ++
 2 files changed, 84 insertions(+), 23 deletions(-)

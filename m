Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewv6T-0004ru-UW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewv6R-0000dg-BJ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewv6R-0000dO-5c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:33:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 16 Mar 2018 16:33:14 -0300
Message-Id: <20180316193315.6956-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] PC compat bug fix for v2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Dropped all the other commits from machine-next and kept only the
bug fix below.

The following changes since commit 2bb39a657abeac3f33ab3298177fb27c35f5b50a:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180316' into staging (2018-03-16 17:25:33 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 0ab126f165b04cce4a6e641d6bfce2ffd8a7cf62:

  pc: correct misspelled CPU model-id for pc 2.2 (2018-03-16 16:29:07 -0300)

----------------------------------------------------------------
PC compat bug fix for 2.12

----------------------------------------------------------------

Queue for Machine Core patches


Wang Xin (1):
  pc: correct misspelled CPU model-id for pc 2.2

 include/hw/i386/pc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.14.3

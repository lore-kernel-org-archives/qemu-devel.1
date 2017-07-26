Received: from eggs.gnu.org ([2001:4830:134:3::10]:40892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSl-0001Qa-Se
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSi-0007HX-Tv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:35 -0400
Received: from [59.151.112.132] (port=30802 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSi-0007El-Hg
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:32 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:13:31 +0800
Message-ID: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 0/4] Remove dead error handling and convert
 to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

This series mainly implements the conversion of rocker to realize,
also remove the dead error handling and rename the unusual macro 
name.

v6:

I posted another patch(commit 4cee3cf3) after patch1 of this series but 
before patch1 be merged, they changed the same function caused this 
series not to be applied cleanly on HEAD. so resend v6 to fix it.

Because there is no change on the patch content, so still add the R-B.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org

Mao Zhongyi (4):
  net/rocker: Remove the dead error handling
  net/rocker: Plug memory leak in pci_rocker_init()
  net/rocker: Convert to realize()
  net/rocker: Fix the unusual macro name

 hw/net/rocker/rocker.c        | 94 +++++++++++--------------------------------
 hw/net/rocker/rocker_desc.c   | 10 -----
 hw/net/rocker/rocker_fp.c     |  4 --
 hw/net/rocker/rocker_of_dpa.c | 20 ---------
 hw/net/rocker/rocker_world.c  | 12 +++---
 5 files changed, 28 insertions(+), 112 deletions(-)

-- 
2.9.4

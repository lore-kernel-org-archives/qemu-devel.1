Received: from eggs.gnu.org ([2001:4830:134:3::10]:36264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtF-0001bB-DQ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtC-0001lx-6m
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:13 -0400
Received: from [59.151.112.132] (port=20783 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtB-0001kb-Qg
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:10 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 17 May 2017 19:12:22 +0800
Message-ID: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/3] Convert to realize and fix error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org, armbru@redhat.com

v4:
* Patch 1 is following Markus's suggestion that remove the dead error
  handling.
* Patch 2 is separate from patch 1 to plug the memory leak in the v3.
* Patch 3 is based on the patch 1 in the v3. Meanwhile, dorp the superfluous
  prefix "rocker:" and adjust the commit message.

v3:
* Following Jason's suggstion that add suitable error message to 
  each error site.
* Modified the commit message to make it easier to read.

v2:
* Following Philippe's suggestion that shorten the patch subject 
  "hw/net/rocker/rocker" to "net/rocker". 
* Use a consistent log format to report error message.
* Add a specific goto label "err_name_too_long" to make a correct
  cleanup.

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: f4bug@amsat.org
Cc: armbru@redhat.com
Mao Zhongyi (3):
  net/rocker: Remove the dead error handling
  net/rocker: Plug memory leak in pci_rocker_init()
  net/rocker: Convert to realize()

 hw/net/rocker/rocker.c      | 61 ++++++++++-----------------------------------
 hw/net/rocker/rocker_desc.c |  3 ---
 hw/net/rocker/rocker_fp.c   |  4 ---
 3 files changed, 13 insertions(+), 55 deletions(-)

-- 
2.9.3

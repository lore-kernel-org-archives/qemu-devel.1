Received: from eggs.gnu.org ([2001:4830:134:3::10]:59903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NG-0001bg-56
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NA-0000K0-GH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:01:54 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 13:01:39 -0400
Message-Id: <cover.1504112256.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Live block optional disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, mrezanin@redhat.com, ehabkost@redhat.com, peterx@redhat.com, jsnow@redhat.com

This series adds a configurable option to disable live block operations.

The default is that live block operations are 'enabled'.

Jeffrey Cody (3):
  configure: Add option in configure to disable live block ops
  block-jobs: Optionally unregister live block operations
  hmp: Optionally disable live block operations in HMP monitor

 configure            | 11 +++++++++++
 hmp-commands-info.hx |  4 ++++
 hmp-commands.hx      | 12 ++++++++++++
 hmp.c                | 12 ++++++++++++
 monitor.c            | 16 ++++++++++++++++
 5 files changed, 55 insertions(+)

-- 
2.9.5

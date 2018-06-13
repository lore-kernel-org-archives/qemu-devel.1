Received: from eggs.gnu.org ([2001:4830:134:3::10]:41473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7zd-0002aD-5C
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fT7zc-00005O-D7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:47:29 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 13 Jun 2018 18:47:09 +0300
Message-Id: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 0/2] enable/disable copy-on-read via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, eblake@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

In some cases there is a need to perform a special access pattern to a disk
backend. This may be done by providing disk reading access to external readers.
In this case there should be the ability to enable/disable the copy-on-read mode
for the disk during VM runtime. 
By the moment, there is no such ability. The patch set adds qmp command to 
enable/disable the copy-on-read mode.

Denis Plotnikov (2):
  block: check for read-only on copy-on-read setting
  qmp: add block-set-copy-on-read command

 block.c               |  4 +---
 block/io.c            | 10 ++++++++--
 block/stream.c        |  5 +++--
 blockdev.c            | 38 ++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  2 +-
 qapi/block-core.json  | 20 ++++++++++++++++++++
 6 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.17.0

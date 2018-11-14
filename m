Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrYI-0006qY-A9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMrY8-0003Wx-HX
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3102 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMrY6-0003VM-Gx
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 04:33:28 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Wed, 14 Nov 2018 17:27:36 +0800
Message-ID: <cover.1542187291.git.xiezhide@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/4] fsdev-throttle-qmp: qmp interface for
 fsdev io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, eblake@redhat.com, armbru@redhat.com, berto@igalia.com, zengcanfu@huawei.com, jinxuefeng@huawei.com, chenhui.rtos@huawei.com

This patches provide qmp interface to query/set io throttle parameters of a fsdev. 
Some of patches also refactor the code and structure that was present in block and fsdev files.

xiezhide (4):
  fsdev-throttle-qmp: factor out throttle code to reuse code
  fsdev-throttle-qmp: move struct ThrottleLimits to new file
  fsdev-throttle-qmp: qmp interface for fsdev io throttling
  fsdev-throttle-qmp: hmp interface for fsdev io throttling

 Makefile                        |  18 ++++
 Makefile.objs                   |   8 ++
 block/throttle.c                |   6 +-
 blockdev.c                      |  94 +----------------
 fsdev/qemu-fsdev-dummy.c        |  11 ++
 fsdev/qemu-fsdev-throttle.c     | 142 ++++++++++++++++---------
 fsdev/qemu-fsdev-throttle.h     |   6 +-
 fsdev/qemu-fsdev.c              |  29 +++++
 hmp-commands-info.hx            |  15 +++
 hmp-commands.hx                 |  15 +++
 hmp.c                           |  83 +++++++++++++--
 hmp.h                           |   4 +
 include/qemu/throttle-options.h |   2 +
 include/qemu/throttle.h         |   4 +-
 include/qemu/typedefs.h         |   1 +
 monitor.c                       |  41 ++++---
 qapi/block-core.json            | 122 +--------------------
 qapi/fsdev.json                 |  96 +++++++++++++++++
 qapi/qapi-schema.json           |   2 +
 qapi/tlimits.json               |  89 ++++++++++++++++
 util/throttle.c                 | 229 ++++++++++++++++++++++++++--------------
 21 files changed, 640 insertions(+), 377 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/tlimits.json

 v0 -> v1:
  Addressed comments from Eric Blake and Greg Kurz.
  Fix patch corrupt issue due to email client change the patch format with copy-to-paster
  Break patch to patches

 v1 -> v2:
  Addressed comments from Greg Kurz.
  send patch with outlook,patch corrupted, resend with git send-email

 v2 -> v3:
  Addressed comments from Eric Blake.
  split patch1 into two patches 

-- 
2.7.4

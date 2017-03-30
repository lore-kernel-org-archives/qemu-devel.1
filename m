Received: from eggs.gnu.org ([2001:4830:134:3::10]:42044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYuf-00064n-5i
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1ctYuc-0007AU-1F
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:49 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1ctYub-000785-Ri
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:10:45 -0400
Received: by mail-wr0-x243.google.com with SMTP id w43so11536203wrb.1
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 05:10:45 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 30 Mar 2017 08:10:09 -0400
Message-Id: <1490875813-35588-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v2 0/4] fsdev: qmp interface for io throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

These patches provide the qmp interface, to query the io throttle 
status of the all fsdev devices that are present in a vm.
also, it provides an interface to set the io throttle parameters of a
fsdev to a required value. some of the patches also remove the duplicate
code that was present in block and fsdev files. 

pradeep jagadeesh (4):
  throttle: create iothrottle structure
  fsdev: qmp interface for throttling
  qmp: refactor duplicate code
  throttle: factor out duplicate code

 makefile                        |   3 ++
 blockdev.c                      |  97 ++-----------------------------------
 fsdev/qemu-fsdev-throttle.c     |  90 ++++++++++++++++++----------------
 fsdev/qemu-fsdev-throttle.h     |  13 +++++
 fsdev/qemu-fsdev.c              |  36 ++++++++++++++
 hmp-commands-info.hx            |  19 ++++++++
 hmp-commands.hx                 |  19 ++++++++
 hmp.c                           |  87 ++++++++++++++++++++++++++++++---
 hmp.h                           |   5 ++
 include/qemu/throttle-options.h |   7 +++
 qapi-schema.json                |   3 ++
 qapi/block-core.json            |  76 ++---------------------------
 qapi/fsdev.json                 |  84 ++++++++++++++++++++++++++++++++
 qapi/iothrottle.json            |  87 +++++++++++++++++++++++++++++++++
 qmp.c                           |  14 ++++++
 util/makefile.objs              |   1 +
 util/throttle-options.c         | 105 ++++++++++++++++++++++++++++++++++++++++
 17 files changed, 532 insertions(+), 214 deletions(-)
 create mode 100644 qapi/fsdev.json
 create mode 100644 qapi/iothrottle.json
 create mode 100644 util/throttle-options.c

-- 
1.8.3.1

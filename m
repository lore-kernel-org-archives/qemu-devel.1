Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfB7-0007Dd-By
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdfB6-0007m4-EN
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:38:05 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 16:37:54 +0100
Message-Id: <1487086676-24339-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 0/2] block: Crude initial implementation
 of -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com

This is based on "[PATCH 00/24] QemuOpts util/cutils: Fix and clean up
number conversions".

v2: Support KEY=VALUE,... syntax as well.

Markus Armbruster (2):
  util/qemu-option: New opt_parse_qdict()
  block: Crude initial implementation of -blockdev

 include/qemu/option.h  |   3 ++
 qemu-options.hx        |   3 ++
 tests/test-qemu-opts.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-option.c     | 131 ++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c                   |  51 +++++++++++++++++++
 5 files changed, 320 insertions(+)

-- 
2.7.4

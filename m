Received: from eggs.gnu.org ([2001:4830:134:3::10]:55311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB3Mh-0006EX-Ey
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB3Md-0002D6-Ff
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB3Md-0002Cx-8r
	for qemu-devel@nongnu.org; Wed, 17 May 2017 14:07:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C51C61B80
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 18:07:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 17 May 2017 19:07:51 +0100
Message-Id: <20170517180754.20456-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fea9:

  block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170517

for you to fetch changes up to be9b23c4a539090da30b482015ee660850e8bb5f:

  ramblock: add new hmp command "info ramblock" (2017-05-17 17:31:16 +0100)

----------------------------------------------------------------
HMP pull

----------------------------------------------------------------
Peter Xu (3):
      ramblock: add RAMBLOCK_FOREACH()
      utils: provide size_to_str()
      ramblock: add new hmp command "info ramblock"

 exec.c                       | 44 +++++++++++++++++++++++++++++++++-----------
 hmp-commands-info.hx         | 14 ++++++++++++++
 hmp.c                        |  6 ++++++
 hmp.h                        |  1 +
 include/exec/ramlist.h       |  6 ++++++
 include/qemu-common.h        |  1 +
 migration/ram.c              | 13 +++++++------
 qapi/string-output-visitor.c | 22 ++++++----------------
 util/cutils.c                | 25 +++++++++++++++++++++++++
 9 files changed, 99 insertions(+), 33 deletions(-)

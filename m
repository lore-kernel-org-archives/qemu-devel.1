Received: from eggs.gnu.org ([2001:4830:134:3::10]:35952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3Kt0-00052n-Pn
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3Ksw-0002x0-Qx
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3Ksw-0002w4-Lq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 744BBC05AD62
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 11:13:25 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 26 Apr 2017 19:13:10 +0800
Message-Id: <1493205192-26743-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] ramblock: add hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

v2:
- replace "lx" with "PRIx64" in three places

Sometimes I would like to know ramblock info for a VM. This command
would help. It provides a way to dump ramblock info. Currently the
list is by default sorted by size, though I think it's good enough.

Please review, thanks.

Peter Xu (2):
  ramblock: add RAMBLOCK_FOREACH()
  ramblock: add new hmp command "info ramblock"

 exec.c                 | 57 ++++++++++++++++++++++++++++++++++++++++----------
 hmp-commands-info.hx   | 14 +++++++++++++
 hmp.c                  |  6 ++++++
 hmp.h                  |  1 +
 include/exec/ramlist.h |  6 ++++++
 migration/ram.c        | 15 ++++++-------
 6 files changed, 81 insertions(+), 18 deletions(-)

-- 
2.7.4

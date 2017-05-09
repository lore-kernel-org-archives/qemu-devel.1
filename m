Received: from eggs.gnu.org ([2001:4830:134:3::10]:57875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83Gd-0007pk-FH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83GZ-0007s0-E4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:25:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d83GZ-0007rV-7m
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BEB1C04B935
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:25:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 May 2017 19:25:02 +0800
Message-Id: <1494329105-4411-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/3] ramblock: add hmp command "info
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

v5
- add r-b for Dave on first patch (which I forgot in v4, so I got it
  again)
- add one more patch to introduce size_to_str() as patch 2 [Dave]
- let the last patch use the new interface

v4:
- move page_size_to_str() into util/cutil.c [Dave]

v3:
- cast the three PRIx64 addresses using (uint64_t) [Fam]
- add more comment in patch 2 to emphasize that this command is only
  suitable for HMP, not QMP [Markus]

v2:
- replace "lx" with "PRIx64" in three places

Sometimes I would like to know ramblock info for a VM. This command
would help. It provides a way to dump ramblock info. Currently the
list is by default sorted by size, though I think it's good enough.

Please review, thanks.

Peter Xu (3):
  ramblock: add RAMBLOCK_FOREACH()
  utils: provide size_to_str()
  ramblock: add new hmp command "info ramblock"

 exec.c                 | 44 +++++++++++++++++++++++++++++++++-----------
 hmp-commands-info.hx   | 14 ++++++++++++++
 hmp.c                  |  6 ++++++
 hmp.h                  |  1 +
 include/exec/ramlist.h |  6 ++++++
 include/qemu-common.h  |  1 +
 migration/ram.c        | 15 ++++++++-------
 util/cutils.c          | 26 ++++++++++++++++++++++++++
 8 files changed, 95 insertions(+), 18 deletions(-)

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Ioq-0007P8-Q1
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8Iol-0006Wz-Vp
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8Iol-0006Wh-PF
	for qemu-devel@nongnu.org; Wed, 10 May 2017 00:01:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B963C059724
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 04:01:38 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 10 May 2017 12:01:26 +0800
Message-Id: <1494388889-3558-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/3] ramblock: add hmp command "info
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

v6
- patch 2: instead of create a new size_to_str(), abstract the logic
  out from print_type_size(), refactor it, to make sure
  print_type_size() dumps exactly the same thing as before. (a simple
  test with info qtree is done)
- let suffixes be an array of strings [Markus]

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

 exec.c                       | 44 +++++++++++++++++++++++++++++++++-----------
 hmp-commands-info.hx         | 14 ++++++++++++++
 hmp.c                        |  6 ++++++
 hmp.h                        |  1 +
 include/exec/ramlist.h       |  6 ++++++
 include/qemu-common.h        |  1 +
 migration/ram.c              | 15 ++++++++-------
 qapi/string-output-visitor.c | 22 ++++++----------------
 util/cutils.c                | 23 +++++++++++++++++++++++
 9 files changed, 98 insertions(+), 34 deletions(-)

-- 
2.7.4

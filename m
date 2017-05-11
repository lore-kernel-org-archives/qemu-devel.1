Received: from eggs.gnu.org ([2001:4830:134:3::10]:52284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7M-0005lM-0e
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8n7I-0007Q8-C1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:22:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8n7I-0007Pn-6E
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:22:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F24654E4C6
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:22:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 May 2017 20:22:34 +0800
Message-Id: <1494505358-15287-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 0/4] ramblock: add hmp command "info
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

v7:
- patch 1: removed Dave's r-b since the patch conflicted during rebase
- patch 2: add r-b for Markus, with the nice function comment that
  provided [Markus]
- patch 3: add r-b for Dave
- patch 4 (new): added new patch to remove assert in size_to_str(),
  assuming that would be better.

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

Peter Xu (4):
  ramblock: add RAMBLOCK_FOREACH()
  utils: provide size_to_str()
  ramblock: add new hmp command "info ramblock"
  utils: remove assert in size_to_str()

 exec.c                       | 44 +++++++++++++++++++++++++++++++++-----------
 hmp-commands-info.hx         | 14 ++++++++++++++
 hmp.c                        |  6 ++++++
 hmp.h                        |  1 +
 include/exec/ramlist.h       |  6 ++++++
 include/qemu-common.h        |  1 +
 migration/ram.c              | 13 +++++++------
 qapi/string-output-visitor.c | 22 ++++++----------------
 util/cutils.c                | 31 +++++++++++++++++++++++++++++++
 9 files changed, 105 insertions(+), 33 deletions(-)

-- 
2.7.4

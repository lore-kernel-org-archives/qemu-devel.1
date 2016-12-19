Received: from eggs.gnu.org ([2001:4830:134:3::10]:48138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIyeA-0000nn-N8
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIye6-0003Nd-OW
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIye6-0003NM-JG
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:10:30 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC8E43D955
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:10:29 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Dec 2016 22:10:21 +0800
Message-Id: <1482156623-9111-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] memory: extend "info mtree" with flat view
 dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com

Each address space has its own flatview. It's another way to observe
memory info besides the default memory region hierachy, for example,
if we want to know which memory region will handle the write to
specific address, a flatview will suite more here than the default
hierachical dump.

I used it to debug a vt-d memory region overlap issue. Do we need
this? I think we can at least consider patch 1, which is a cleanup of
existing codes. :)

Please review. Thanks,

Peter Xu (2):
  memory: provide common macros for mtree_print_mr()
  memory: hmp: dump flat view for 'info mtree'

 memory.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 19 deletions(-)

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0rWI-0001Cq-46
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g0rWE-0007Es-Se
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g0rWE-0007EN-Lk
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:04:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C646380F9A
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 17:04:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 14 Sep 2018 18:04:28 +0100
Message-Id: <20180914170430.54271-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migration cleanup fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is a pair of related migration fixes for cases where the loadvm
state doesn't get cleaned up.

In the first case this is because the code hasn't cleared the postcopy
flag, and so a following loadvm gets very confused (leading to it
not cleaning up the loadvm state or syncing the CPUs leading to no
interrupts and a very confused guest).

In the second case I just noticed a few return cases where it didn't get
cleaned up in error paths.

Dave


Dr. David Alan Gilbert (2):
  migration/postcopy: Clear have_listen_thread
  migration: cleanup in error paths in loadvm

 migration/savevm.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.17.1

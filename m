Received: from eggs.gnu.org ([2001:4830:134:3::10]:55490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfFb-00046Y-OK
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddfFX-0002Y1-5L
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddfFW-0002Xh-Vz
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BF00267DB
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 16:14:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  4 Aug 2017 18:14:50 +0200
Message-Id: <20170804161452.17413-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] RCU: forking fix and cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

The first patch fixes a migration deadlock.  The second reverts
a now-unnecessary hack (introduced to support the pre-MTTCG "kick
the CPU thread" special behavior of qemu_mutex_lock_iothread).

Paolo

Paolo Bonzini (2):
  rcu: completely disable pthread_atfork callbacks as soon as possible
  Revert "rcu: do not create thread in pthread_atfork callback"

 include/qemu/rcu.h   |  7 ++++++-
 linux-user/syscall.c |  1 -
 os-posix.c           |  2 --
 util/rcu.c           | 30 +++++++++++++++++++++++++++---
 vl.c                 |  1 +
 5 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.13.3

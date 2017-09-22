Received: from eggs.gnu.org ([2001:4830:134:3::10]:55658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJl5-000435-Nf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvJl2-0004vW-VV
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvJl2-0004v4-PY
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:56:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95B592C976D
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:56:23 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Fri, 22 Sep 2017 16:56:09 +0800
Message-Id: <1506070572-7549-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] iothread: allow to create internal
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

When trying to support monitor OOB (out-of-band) commands, I found
that the monitor IO thread I did looks just like iothread.  It would
be best if I can use iothread directly.  However it seems that it was
mostly used by "-object iothread" before but not friendly to internal
usages.  This series tries to export essential functions to do it.

Also, I think patch 2 also fixes a bug in iothread_stop().

Please review. Thanks.

Peter Xu (3):
  iothread: provide helpers for internal use
  iothread: export iothread_stop()
  iothread: delay the context release to finalize

 include/sysemu/iothread.h |  9 +++++++++
 iothread.c                | 51 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.7.4

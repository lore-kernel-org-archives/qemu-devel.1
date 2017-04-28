Received: from eggs.gnu.org ([2001:4830:134:3::10]:40677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44xI-0003Vh-SS
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d44xD-0004nP-Ub
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:25:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d44xD-0004mx-OO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16FE0C05AD7F
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 12:24:54 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 28 Apr 2017 13:24:43 +0100
Message-Id: <20170428122444.23361-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

At the 2016 summit it was suggested that we delete the GThread
coroutine impl since it is not fully functional, and you can
debug the ucontext impl with our GDB helper script.

I don't recall the subject being raised again since the summit
so here's a proposal to delete the GThread impl, as a way to
trigger input from anyone who thinks we need to keep it......

Daniel P. Berrange (1):
  coroutine: remove GThread implementation

 .travis.yml              |   5 +-
 configure                |  19 ++---
 util/coroutine-gthread.c | 198 -----------------------------------------------
 3 files changed, 6 insertions(+), 216 deletions(-)
 delete mode 100644 util/coroutine-gthread.c

-- 
2.9.3

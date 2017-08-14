Received: from eggs.gnu.org ([2001:4830:134:3::10]:60493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhIDd-0002bH-BN
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhIDa-0005yA-5M
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhIDZ-0005x4-VP
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:27:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A14BA9621
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:21:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 14 Aug 2017 17:21:40 +0100
Message-Id: <20170814162142.29666-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/2] trace: fix simpletrace.stp flight
 recorder mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The SystemTap flight recorder mode no longer works with simpletrace.stp because
the event ID mapping records are emitted the first time an event fires.
Chances are, the event ID mapping record will not be in ring buffer when the
users wants to print the trace.

This series solves the issue by using the trace-events-all global event
ordering for event IDs for simpletrace.stp.

Stefan Hajnoczi (2):
  trace: use static event ID mapping in simpletrace.stp
  simpletrace: fix flight recorder --no-header option

 scripts/simpletrace.py                       | 24 ++++++++++++++-----
 scripts/tracetool/format/simpletrace_stap.py | 36 ++++++++++++----------------
 2 files changed, 33 insertions(+), 27 deletions(-)

-- 
2.13.4

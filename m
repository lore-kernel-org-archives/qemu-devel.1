Received: from eggs.gnu.org ([2001:4830:134:3::10]:44671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dHpT0-0001YT-Mc
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dHpSx-0000cp-MR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dHpSx-0000bb-H9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:42:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E167C0587D2
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 10:42:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  5 Jun 2017 11:42:14 +0100
Message-Id: <20170605104216.22429-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] monitor: add trace events for HMP and QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

It's nice to have HMP and QMP commands as part of a trace log.  This makes it
possible to correlate QEMU-internal events with the monitor commands that
caused them.

Stefan Hajnoczi (2):
  monitor: add handle_hmp_command trace event
  monitor: resurrect handle_qmp_command trace event

 monitor.c    | 7 +++++++
 trace-events | 2 ++
 2 files changed, 9 insertions(+)

-- 
2.9.4

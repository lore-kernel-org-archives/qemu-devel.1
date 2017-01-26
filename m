Received: from eggs.gnu.org ([2001:4830:134:3::10]:41393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnen-0000wO-4d
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWnej-0005xp-WB
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWnej-0005xb-RA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:16:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C14D64E024
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 17:16:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 26 Jan 2017 17:16:11 +0000
Message-Id: <20170126171613.1399-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] trace: clean up trace-events files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

I noticed that some trace-events files are out of date.  This series fixes them.

Stefan Hajnoczi (2):
  qapi: add missing trace_visit_type_enum() call
  trace: clean up trace-events files

 qapi/qapi-visit-core.c  | 1 +
 block/trace-events      | 2 --
 hw/block/trace-events   | 1 -
 hw/display/trace-events | 1 -
 hw/i386/trace-events    | 1 -
 hw/input/trace-events   | 2 --
 hw/intc/trace-events    | 1 -
 hw/net/trace-events     | 8 --------
 hw/usb/trace-events     | 1 -
 hw/vfio/trace-events    | 2 +-
 migration/trace-events  | 3 ---
 qapi/trace-events       | 2 +-
 trace-events            | 1 -
 13 files changed, 3 insertions(+), 23 deletions(-)

-- 
2.9.3

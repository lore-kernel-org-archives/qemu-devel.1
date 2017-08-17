Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFq-0003WC-Hh
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1diIFn-0005Co-EG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1diIFn-0005CM-7s
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D22CE7ACD5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 10:42:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 17 Aug 2017 11:42:14 +0100
Message-Id: <20170817104216.29150-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2 for 2.11] Minor HMP fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

A couple of minor HMP fixes

Dr. David Alan Gilbert (2):
  hmp: Missing handle_errors
  hmp: Fix unknown command for subtable

 hmp.c     | 2 ++
 monitor.c | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cq1Gb-0003Am-Gj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cq1GY-00019W-Ci
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cq1GY-00018y-7f
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 13:38:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 159DE61BA3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 17:38:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 20 Mar 2017 17:38:38 +0000
Message-Id: <20170320173840.3626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2 for 2.10] Remove some monitor_printf's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: kraxel@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I found myself trying to understand cur_mon and found a bunch
of uses that could easily be replaced by error_report or Error **.

Dave

Dr. David Alan Gilbert (2):
  save_vmstate: Convert to Error** from Monitor *
  wavcapture: Convert to error_report

 audio/wavcapture.c       | 39 +++++++++++++++++----------------------
 include/sysemu/sysemu.h  |  2 +-
 migration/savevm.c       | 31 ++++++++++++++++++-------------
 replay/replay-snapshot.c |  6 ++++--
 4 files changed, 40 insertions(+), 38 deletions(-)

-- 
2.9.3

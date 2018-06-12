Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSz-00080J-FH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfSw-00011i-7b
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfSw-00011K-2D
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7F694000C57
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:41 +0100
Message-Id: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/7] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Reenable HMP in preconfig mode; it's pretty
easy and anyway I want to do a similar thing for OOB eventually.
We'll want to enable more commands in preconfig mode to make it
useful at some point.
 
Dave

v4
  Fixes from Markus' review.
    Including enabling some more qom-* commands in qmp

Dr. David Alan Gilbert (6):
  hmp: Add flag for preconfig commands
  hmp: Allow help on preconfig commands
  hmp: Restrict auto-complete in preconfig
  hmp: Add commands for preconfig
  hmp: add exit_preconfig
  hmp: Allow HMP in preconfig state again

Igor Mammedov (1):
  qmp: Enable a few commands in preconfig state

 hmp-commands-info.hx | 12 ++++++++++++
 hmp-commands.hx      | 23 +++++++++++++++++++++++
 hmp.c                |  8 ++++++++
 hmp.h                |  1 +
 monitor.c            | 43 ++++++++++++++++++++++++++++++++++---------
 qapi/char.json       |  3 ++-
 qapi/misc.json       | 27 +++++++++++++++++----------
 7 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVfD9-0006xz-EM
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVfD5-0003j4-Hl
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVfD5-0003is-Cr
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:39:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E6F17721D
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 15:39:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 20 Jun 2018 16:39:40 +0100
Message-Id: <20180620153947.30834-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/7] Reenable hmp for preconfig mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Reenable HMP in preconfig mode; it's pretty
easy and anyway I want to do a similar thing for OOB eventually.
We'll want to enable more commands in preconfig mode to make it
useful at some point.

Dave
 
v5
  Drop info usbhost as per Gerd's comments

Dr. David Alan Gilbert (6):
  hmp: Add flag for preconfig commands
  hmp: Allow help on preconfig commands
  hmp: Restrict auto-complete in preconfig
  hmp: Add commands for preconfig
  hmp: add exit_preconfig
  hmp: Allow HMP in preconfig state again

Igor Mammedov (1):
  qmp: Enable a few commands in preconfig state

 hmp-commands-info.hx | 11 +++++++++++
 hmp-commands.hx      | 23 +++++++++++++++++++++++
 hmp.c                |  8 ++++++++
 hmp.h                |  1 +
 monitor.c            | 43 ++++++++++++++++++++++++++++++++++---------
 qapi/char.json       |  3 ++-
 qapi/misc.json       | 27 +++++++++++++++++----------
 7 files changed, 96 insertions(+), 20 deletions(-)

-- 
2.17.1

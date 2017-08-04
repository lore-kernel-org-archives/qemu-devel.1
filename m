Received: from eggs.gnu.org ([2001:4830:134:3::10]:38659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkLt-0002AV-Pd
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkLq-0005b1-LX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddkLq-0005aq-Fc
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:41:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A75814A703
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 21:36:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  4 Aug 2017 18:36:20 -0300
Message-Id: <20170804213625.3756-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 0/5] qmp-shell non-interactive mode,
 delete scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

This series adds the ability to run QMP commands
non-interactively to qmp-shell, and deletes scripts/qmp/qmp.

Eduardo Habkost (5):
  qmp-shell: Use argparse module
  qmp-shell: Pass split cmdargs to __build_cmd()
  qmp-shell: execute_cmdargs() method
  qmp-shell: Accept QMP command as argument
  Remove scripts/qmp/qmp

 scripts/qmp/qmp       | 126 --------------------------------------------------
 scripts/qmp/qmp-shell |  90 ++++++++++++++++--------------------
 2 files changed, 40 insertions(+), 176 deletions(-)
 delete mode 100755 scripts/qmp/qmp

-- 
2.9.4

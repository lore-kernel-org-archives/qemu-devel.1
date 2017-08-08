Received: from eggs.gnu.org ([2001:4830:134:3::10]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBI2-0008GV-5O
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBHz-0000II-19
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBHy-0000HT-RX
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB1857DD0B
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:30 -0300
Message-Id: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 0/5] qmp-shell non-interactive mode,
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
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>

This series adds the ability to run QMP commands
non-interactively to qmp-shell, and deletes scripts/qmp/qmp.

Changes v1 -> v2:
* Use optparse module instead of argparse. optparse is deprecated
  since Python 2.7, but argparse is not available on Python 2.6,
  the minimum Python version required to build QEMU.
  * Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
  * Suggested-by: "Daniel P. Berrange" <berrange@redhat.com>

Eduardo Habkost (5):
  qmp-shell: Use optparse module
  qmp-shell: Pass split cmdargs to __build_cmd()
  qmp-shell: execute_cmdargs() method
  qmp-shell: Accept QMP command as argument
  Remove scripts/qmp/qmp

 scripts/qmp/qmp       | 126 --------------------------------------------------
 scripts/qmp/qmp-shell |  87 ++++++++++++++++------------------
 2 files changed, 39 insertions(+), 174 deletions(-)
 delete mode 100755 scripts/qmp/qmp

-- 
2.9.4

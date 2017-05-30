Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRK-0006VD-6J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRH-0001NT-2e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dFcRG-0001LY-Th
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 490A881226
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:37 +0000 (UTC)
Received: from moe.brq.redhat.com (dhcp129-131.brq.redhat.com [10.34.129.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCDD917151
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:36 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue, 30 May 2017 10:23:32 +0200
Message-Id: <cover.1496132443.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Fix qemu-bridge-helper with SUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For more description see patch 3. Long story short, if the bridge helper runs
with SUID, the mechanism we rely on (DAC denying access to ACL files) does not
work.

Michal Privoznik (3):
  qemu-bridge-helper: Reverse return value setting logic
  qemu-bridge-helper: Reverse return value setting logic in
    parse_acl_file
  qemu-bridge-helper: Take ACL file gid into account

 qemu-bridge-helper.c | 79 ++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

-- 
2.13.0

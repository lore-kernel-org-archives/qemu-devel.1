Received: from eggs.gnu.org ([2001:4830:134:3::10]:52259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcK-0003lQ-Kr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcG-00089O-W3
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:52 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXpcG-000892-Oc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id g18-v6so17635400wro.7
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:10:48 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 26 Jun 2018 18:10:36 +0300
Message-Id: <20180626151038.24771-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 0/2] prevent qga from crashing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Sameeh Jubran <sjubran@redhat.com>

The following patch series fixes an issue with fsinfo command of qemu-ga
on Windows which leads to crash of qga when the disk paramter is
enabled.

Sameeh Jubran (2):
  qga-win: prevent crash when executing fsinfo command
  qga-win: fsinfo: pci-info: allow partial info

 qga/commands-win32.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.13.6

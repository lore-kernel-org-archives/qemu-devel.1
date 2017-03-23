Received: from eggs.gnu.org ([2001:4830:134:3::10]:33218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cr5Zn-0001pj-2Y
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cr5Zj-0000jX-Uq
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:27:03 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cr5Zj-0000hi-NC
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:26:59 -0400
Received: by mail-wr0-x231.google.com with SMTP id y90so33426410wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 09:26:59 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 23 Mar 2017 18:26:49 +0200
Message-Id: <20170323162650.16973-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH qemu-ga v2] Make QGA VSS provider service run
 only when needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Difference from v1:
Added missing install.h file

Sameeh Jubran (1):
  qemu-ga: Make QGA VSS provider service run only when needed

 qga/vss-win32/install.cpp   | 28 ++++++++++++++++++++++++++--
 qga/vss-win32/install.h     | 20 ++++++++++++++++++++
 qga/vss-win32/requester.cpp |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 qga/vss-win32/install.h

-- 
2.9.3

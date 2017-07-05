Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8j-0004XF-Vt
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dSf8f-0006uI-3C
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:26 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dSf8e-0006tr-Pz
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:54:21 -0400
Received: by mail-wm0-x242.google.com with SMTP id p204so30729125wmg.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:54:19 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Jul 2017 10:54:06 +0300
Message-Id: <20170705075411.6556-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 0/5] Fix qemu-ga's behaviour on Windows
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

From: Sameeh Jubran <sjubran@redhat.com>

This patch series fixes qemu-ga's main service behaviour on Windows
by listening to the virtio-serial device's events.

For more info on why this series is needed checkout the commit message
of the third patch and the following bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=990629.

Sameeh Jubran (5):
  Makefile: clean: Clean exe files
  qga-win: service-win32: Add start_service and stop_service functions
  qga-win: Add serial listener service
  qga-win: Add qga-serial-listener to msi installer
  qga-win: service-win32: Use get_service function

 Makefile                            |  12 ++-
 Makefile.objs                       |   1 +
 qga/Makefile.objs                   |   2 +
 qga/channel.h                       |   9 ++
 qga/installer/qemu-ga.wxs           |  24 +++++
 qga/main.c                          |  23 +++--
 qga/serial-listener-service-win32.c | 181 ++++++++++++++++++++++++++++++++++++
 qga/serial-listener-service-win32.h |  29 ++++++
 qga/service-win32.c                 | 142 +++++++++++++++++++++++-----
 qga/service-win32.h                 |   5 +
 10 files changed, 395 insertions(+), 33 deletions(-)
 create mode 100644 qga/serial-listener-service-win32.c
 create mode 100644 qga/serial-listener-service-win32.h

-- 
2.9.4

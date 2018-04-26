Received: from eggs.gnu.org ([2001:4830:134:3::10]:57181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBlil-0005R7-6j
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBlii-0007Tg-2r
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:34:19 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 26 Apr 2018 20:34:00 +0200
Message-Id: <20180426183404.3756-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] qapi: introduce the SysEmuTarget
 enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-stable@nongnu.org

This is version 2 of the set posted earlier at

  http://mid.mail-archive.com/20180424214550.32549-1-lersek@redhat.com

This version seeks to address the v1 feedback. Changes are noted per
patch.

The following firmware schema / interop docs patch remains dependent on
this series, without any changes to the former:

  [Qemu-devel] [qemu RFC v3 3/3] qapi: add "firmware.json"
  http://mid.mail-archive.com/20180420231246.23130-4-lersek@redhat.com

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org

Thanks
Laszlo

Laszlo Ersek (4):
  qapi: fill in CpuInfoFast.arch in query-cpus-fast
  qapi: add SysEmuTarget to "common.json"
  qapi: change the type of TargetInfo.arch from string to enum
    SysEmuTarget
  qapi: discriminate CpuInfoFast on SysEmuTarget, not CpuInfoArch

 qapi/common.json       | 27 +++++++++++++++++++
 qapi/misc.json         | 69 +++++++++++++++++++++++++++++++++++------------
 arch_init.c            |  4 ++-
 cpus.c                 | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 scripts/qapi/common.py |  2 +-
 5 files changed, 146 insertions(+), 29 deletions(-)

-- 
2.14.1.3.gb7cf6e02401b

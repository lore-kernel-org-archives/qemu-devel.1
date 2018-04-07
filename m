Received: from eggs.gnu.org ([2001:4830:134:3::10]:47418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBU-0004uM-Ul
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f4jBR-00025J-Rb
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:52 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f4jBR-000251-Lb
	for qemu-devel@nongnu.org; Sat, 07 Apr 2018 04:26:49 -0400
Received: by mail-pl0-x242.google.com with SMTP id b6-v6so2032930pla.11
	for <qemu-devel@nongnu.org>; Sat, 07 Apr 2018 01:26:49 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  7 Apr 2018 16:26:29 +0800
Message-Id: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

Current Qemu RDMA communication does not support send and receive
data at the same time, so when RDMA live migration with postcopy
enabled, the source qemu return path thread get qemu file error.

Those patch add the postcopy support for RDMA live migration.

Lidong Chen (5):
  migration: create a dedicated connection for rdma return path
  migration: add the interface to set get_return_path
  migration: implement the get_return_path for RDMA iochannel
  migration: fix qemu carsh when RDMA live migration
  migration: disable RDMA WRITR after postcopy started.

 migration/qemu-file-channel.c |  12 ++--
 migration/qemu-file.c         |  13 +++-
 migration/qemu-file.h         |   2 +-
 migration/rdma.c              | 148 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 163 insertions(+), 12 deletions(-)

-- 
1.8.3.1

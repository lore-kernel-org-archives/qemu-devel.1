Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgY-00062l-FZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgX-000226-If
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNgX-000213-8w
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:37 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Tue, 16 Apr 2019 15:59:09 +0300
Message-Id: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, stefanha@gmail.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com

Hi,

This patch series aims to add supprot to migrate a VM with a vhost-scsi device.

The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend when a
VM is stopped (As happens on migratino pre-copy completion).

The 2nd patch adds ability to save/load vhost-scsi device state in VMState.

The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to specify
it's setup supports vhost-scsi migratino. For more detailed information on why
this is valid, see commit message of specific patch.

Regards,
-Liran

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXd-0000fz-LZ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eHZXb-0007b2-0k
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:33 -0500
Received: from mail-eopbgr20115.outbound.protection.outlook.com
	([40.107.2.115]:44320
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eHZXa-0007aQ-AQ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:14:30 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 22 Nov 2017 21:14:15 +0300
Message-Id: <20171122181418.14180-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] hyperv: hv msr initialization fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

These patches fix problems with hyperv msr initialization.

Evgeny Yakovlev (1):
  hyperv: set partition-wide MSRs only on first vcpu

Roman Kagan (2):
  hyperv: ensure SINTx msrs are reset properly
  hyperv: make SynIC version msr constant

 target/i386/cpu.h |  6 ++++--
 target/i386/kvm.c | 44 ++++++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.14.3

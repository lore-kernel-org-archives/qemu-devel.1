Received: from eggs.gnu.org ([2001:4830:134:3::10]:53915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1dCjzP-0000ao-8P
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eyakovlev@virtuozzo.com>) id 1dCjzK-0003R8-G4
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:50:59 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com
	([104.47.2.92]:59063
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eyakovlev@virtuozzo.com>)
	id 1dCjzK-0003DC-9t
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:50:54 -0400
From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
Date: Mon, 22 May 2017 12:50:29 +0300
Message-ID: <1495446630-365062-1-git-send-email-eyakovlev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] change CPU container node _HID to compatible
 PNP0A05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com
Cc: rkagan@virtuozzo.com

This change is a workaround for win2016 problem with qemu CPU container ACPI
nodes: https://bugzilla.redhat.com/show_bug.cgi?id=1377155#c31

It seems to work properly on all tested windows versions (2008 and later)
however we're not sure what side effects this change may have. So any comments
are welcome.

Evgeny Yakovlev (1):
  acpi: change CPU container node _HID to compatible PNP0A05

 hw/acpi/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1

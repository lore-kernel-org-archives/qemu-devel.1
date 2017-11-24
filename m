Received: from eggs.gnu.org ([2001:4830:134:3::10]:49423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIG2T-0004Df-H0
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eIG2O-0004bS-UD
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:13 -0500
Received: from mail-eopbgr40105.outbound.protection.outlook.com
	([40.107.4.105]:57962
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eIG2O-0004a7-Cx
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:37:08 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 24 Nov 2017 18:36:54 +0300
Message-Id: <20171124153656.30199-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>

UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
property type becomes helpful.

In the existing code, vmgenid can immediately profit from it.

Roman Kagan (2):
  qdev-properties: add UUID property type
  vmgenid: use UUID property type

 include/hw/qdev-properties.h |  3 +++
 hw/acpi/vmgenid.c            | 30 +++++++------------------
 hw/core/qdev-properties.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 22 deletions(-)

-- 
2.14.3

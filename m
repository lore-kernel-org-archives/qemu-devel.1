Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJJ6P-0004Xe-Oi
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJJ6K-00018Y-7A
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:37 -0500
Received: from mail-eopbgr20114.outbound.protection.outlook.com
	([40.107.2.114]:24928
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJJ6J-00017r-Me
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:05:32 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 27 Nov 2017 16:05:16 +0300
Message-Id: <20171127130518.26703-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/2] add UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>, minyard@acm.org, "Daniel P. Berrange" <berrange@redhat.com>

UUIDs (GUIDs) are widely used in VMBus-related stuff, so a dedicated
property type becomes helpful.

In the existing code, vmgenid can immediately profit from it.

Roman Kagan (2):
  qdev-properties: add UUID property type
  vmgenid: use UUID property type

v1 -> v2:
 - make the property default to autogeneration if not specified
   explicitly
 - use the corresponding define for "guid" field name

 include/hw/qdev-properties.h |  9 +++++++
 hw/acpi/vmgenid.c            | 30 ++++++----------------
 hw/core/qdev-properties.c    | 61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 22 deletions(-)

-- 
2.14.3

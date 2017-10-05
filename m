Received: from eggs.gnu.org ([2001:4830:134:3::10]:58667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e05KK-0007hN-BZ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e05KC-0006Xy-Ou
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:32:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e05KC-0006WV-A4
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:32:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57F3F81E14
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 12:32:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  5 Oct 2017 14:32:16 +0200
Message-Id: <1507206738-816-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Check for the availability of a hotplug
 controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

First patch is a small clean up to the error handling code in
qdev_device_add(), and the second patch adds a proper check for
the availability of a hotplug controller to prevent the possibility
of a crash with device_del.

Thomas Huth (2):
  qdev_monitor: Simplify error handling in qdev_device_add()
  qdev: Check for the availability of a hotplug controller before adding
    a device

 hw/core/qdev.c         | 28 ++++++++++++++++++++--------
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         | 26 +++++++++++++++-----------
 3 files changed, 36 insertions(+), 19 deletions(-)

-- 
1.8.3.1

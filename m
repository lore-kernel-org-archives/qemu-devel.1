Received: from eggs.gnu.org ([2001:4830:134:3::10]:47759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhWx-00088T-R4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhWu-0001HT-IO
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdhWu-0001EP-Bb
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jul 2018 16:45:19 -0300
Message-Id: <20180712194522.31063-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 0/3] qom/qdev: Try to clarify ownership rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

The ownership rules of some QOM and qdev functions are not very
clear.  Some of the rules are not trivial because they depend
on other arguments or flags specified when a property was
created.

This is an attempt to clarify the existing ownership rules of
those functions to avoid confusion in the future.

Eduardo Habkost (3):
  qom: Document reference count ownership rules
  qdev: Document ownership rules of qbus_create*()
  pci: Document ownership rules of pci_root_bus_new*()

 include/hw/pci/pci.h   | 15 +++++++++
 include/hw/qdev-core.h | 24 ++++++++++++++
 include/qom/object.h   | 73 ++++++++++++++++++++++++------------------
 hw/core/bus.c          |  5 +++
 4 files changed, 86 insertions(+), 31 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140

Received: from eggs.gnu.org ([209.51.188.92]:44519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIgED-0002UV-VA
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIg7P-0000F5-Ao
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIg7P-0000Ej-5d
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 17:04:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75D3030917AF
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 21:04:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 22 Apr 2019 18:04:45 -0300
Message-Id: <20190422210448.2488-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Remove AccelClass::available field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

The only user of AccelClass::available was the qtest accelerator,
to make it unavailable on non-POSIX systems.  We can drop the
field if we simply not compile the accelerator code on those
systems.

Eduardo Habkost (3):
  qtest: Move accel code to accel/qtest.c
  qtest: Don't compile qtest accel on non-POSIX systems
  accel: Remove unused AccelClass::available field

 include/sysemu/accel.h |  1 -
 include/sysemu/qtest.h |  9 -------
 accel/accel.c          |  5 ----
 accel/qtest.c          | 54 ++++++++++++++++++++++++++++++++++++++++++
 qtest.c                | 34 --------------------------
 accel/Makefile.objs    |  1 +
 6 files changed, 55 insertions(+), 49 deletions(-)
 create mode 100644 accel/qtest.c

-- 
2.18.0.rc1.1.g3f1ff2140

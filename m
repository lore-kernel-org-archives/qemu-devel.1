Received: from eggs.gnu.org ([209.51.188.92]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Pr-000381-Il
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gu7Pp-0006RT-Re
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gu7Po-0006Qs-Lc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:10:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AC9910F86
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:10:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Feb 2019 11:10:02 +0800
Message-Id: <20190214031004.32522-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/2] hostmem-file: reject invalid pmem file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v3:
 * Added Patch 1 by Igor [Wei]
 * Moved pmem size check after mem_path check [Wei]

Guests started with NVDIMMs larger than the underlying host file produce
confusing errors inside the guest.  This happens because the guest
accesses pages beyond the end of the file.

Check the pmem file size on startup and print a clear error message if
the size is invalid.

Igor Mammedov (1):
  hostmem: simplify ifdef-s in file_backend_memory_alloc()

Stefan Hajnoczi (1):
  hostmem-file: reject invalid pmem file sizes

 include/qemu/osdep.h    | 13 ++++++++++
 backends/hostmem-file.c | 32 +++++++++++++++++++++----
 util/oslib-posix.c      | 53 +++++++++++++++++++++++++++++++++++++++++
 util/oslib-win32.c      |  5 ++++
 4 files changed, 98 insertions(+), 5 deletions(-)

--=20
2.20.1

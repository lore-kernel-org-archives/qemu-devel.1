Received: from eggs.gnu.org ([2001:4830:134:3::10]:55500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUjGl-0004hH-Ov
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUjGi-0007nF-IF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUjGi-0007n1-CY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 10 Jul 2017 21:43:00 -0300
Message-Id: <20170711004303.3902-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>

Before 2.8 was released, we found a bug in the way global
properties are applied by device code.  Greg Kurz sent a fix[1],
but we decide to include a more conservative workaround[2]
because the 2.8 release was very close.

The plan was to include Greg's patch in 2.9, but we forgot to do
that.  I'm now resending: Greg's original patch; a test case to
detect the original bug; and a revert of the workaround we
included in 2.8.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg416944.html
[2] commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2
    "machine: Convert abstract typename on compat_props to subclass names"

Eduardo Habkost (2):
  test-qdev-global-props: Test global property ordering
  Revert "machine: Convert abstract typename on compat_props to subclass
    names"

Greg Kurz (1):
  qdev: fix the order compat and global properties are applied

 hw/core/machine.c              | 26 +++-----------------------
 hw/core/qdev-properties.c      | 15 ++-------------
 tests/test-qdev-global-props.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 36 deletions(-)

-- 
2.9.4

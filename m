Received: from eggs.gnu.org ([2001:4830:134:3::10]:54886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiP-0005Vq-TV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiJ-000701-Qb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiJ-0006zX-MR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19FDC81A4EAF
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:00 +0200
Message-Id: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [RFC 00/14] More patches to disable stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

Notice that this is an RFC because they don't work.  As said on my
previous submmision, we need <foo>-softmmu/config-devices.h to make
this work.  This series just allow us to disable the devices, but not
to enable it back O:-)

Notice:

- scsi stuff: we are testing they in cdrom-test.c, so we need to be
  able to config them out.  Notice also that #ifdefs only go in tests/<...>

- virtio stuff: see how we need to also change hw/virtio/virtio-pci.c
  to disable it.  The problem appears in the device-instropect-test.c.
  As they are defined in the binary, but not complied in.  We can
  change for a registration appreach, but that is more work that what
  I intended for this series.

What do you think?

Later, Juan.

Based-on: 20180717113402.5510-1-quintela@redhat.com

Juan Quintela (14):
  check: Only test ipmi when it is compiled in
  check: Only test megasas when it is compiled in
  check: Only test lsi when it is compiled in
  check: Only test esp when it is compiled in
  check: Only test sga when it is compiled in
  check: Only test usb smartcard when it is compiled in
  check: Only test usb storage when it is compiled in
  check: Only test nvdim_acpi when it is compiled in
  check: Only test virtio-balloon when it is compiled in
  check: Only test virtio-serial when it is compiled in
  check: Only test virtio-rng when it is compiled in
  check: Only test virtio-gpu when it is compiled in
  check: Only test virtio-input when it is compiled in
  check: Only test virtio-scsi when it is compiled in

 hw/virtio/virtio-pci.c    | 15 ++++++++++++---
 tests/Makefile.include    | 36 ++++++++++++++++++------------------
 tests/bios-tables-test.c  |  8 ++++++++
 tests/boot-serial-test.c  |  2 ++
 tests/cdrom-test.c        | 10 ++++++++++
 tests/display-vga-test.c  |  4 ++++
 tests/drive_del-test.c    |  6 ++++++
 tests/usb-hcd-uhci-test.c |  5 ++++-
 tests/usb-hcd-xhci-test.c |  9 ++++++++-
 9 files changed, 72 insertions(+), 23 deletions(-)

-- 
2.17.1

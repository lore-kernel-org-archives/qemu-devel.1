Received: from eggs.gnu.org ([2001:4830:134:3::10]:35742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBb-00032E-0g
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsOBO-0007Zc-7h
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsOBN-0007YF-TC
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FAEC40201C0
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 08:08:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 10:07:32 +0200
Message-Id: <20180822080751.11307-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/19] Be able to disable several devices
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

The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/check/20180822

for you to fetch changes up to 889d52a243fb6f1d19c92dec2c8055a7f4efbe22:

  check: Only test tpm devices when they are compiled in (2018-08-21 19:52:16 +0200)

----------------------------------------------------------------
check/next for 20180822

This patch series enable the disable of several devices, and if they
are disabled, the checks for those devices are also disable.

This are only the parts that have been reviewed.  The rest of them
will be posted when all comments from reviews have been addressed.

As you can see, this only touches tests/Makefile.include

The changes for pvpanic are to make it the same that other devices.

Please apply, Juan.

----------------------------------------------------------------
Juan Quintela (19):
      check: Only test vmxnet3 when it is compiled in
      check: Only test ne2000 when it is compiled in
      check: Only test eepro100 when it is compiled in
      check: Only test pcnet when it is compiled in
      check: Only test rtl8139 when it is compiled in
      check: Only test es1370 when it is compiled in
      check: Only test ac97 when it is compiled in
      check: Only test hda when it is compiled in
      check: Only test ipack when it is compiled in
      check: Only test ioh3420 when it is compiled in
      check: Only test i82801b11 when it is compiled in
      check: Only test sdhci when it is compiled in
      check: Only test wdt_ib700 when it is compiled in
      check: Only test pvpanic when it is compiled in
      check: Only test nvme when it is compiled in
      check: Only test usb-ohci when it is compiled in
      check: Only test usb-uhci devices when they are compiled in
      check: Only test usb-ehci when it is compiled in
      check: Only test tpm devices when they are compiled in

 hw/misc/pvpanic.c         |  11 -----
 include/hw/misc/pvpanic.h |  11 ++++-
 tests/Makefile.include    | 100 +++++++++++++++++++++++-----------------------
 3 files changed, 61 insertions(+), 61 deletions(-)

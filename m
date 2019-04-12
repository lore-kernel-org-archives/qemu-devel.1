Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D62C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FC02082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FC02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvNu-0002He-Oc
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFM-0001ZC-CO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFL-0002Fd-6C
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFK-0002FB-SI; Fri, 12 Apr 2019 08:25:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1465C05D3F5;
	Fri, 12 Apr 2019 12:25:29 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CEFDB5D9CC;
	Fri, 12 Apr 2019 12:25:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:06 +0200
Message-Id: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 12 Apr 2019 12:25:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 00/17] vfio-ccw dasd ipl
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122506.whGy7t6X9407WIO_YGgkZQ62uO5Qunyui53S0NOps2E@z>

This pull request is not for master.

 Hi Cornelia,

the following changes since commit 532cc6da74ec25b5ba6893b5757c977d545829=
49:

  Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-04-12

for you to fetch changes up to 4a33fac54665558b7f7a68135c4a4c602eceb72f:

  pc-bios/s390: Update firmware images (2019-04-12 12:40:35 +0200)

----------------------------------------------------------------
Support for booting from a vfio-ccw passthrough dasd device
----------------------------------------------------------------

Jason J. Herne (16):
      s390 vfio-ccw: Add bootindex property and IPLB data
      s390-bios: decouple cio setup from virtio
      s390-bios: decouple common boot logic from virtio
      s390-bios: Clean up cio.h
      s390-bios: Decouple channel i/o logic from virtio
      s390-bios: Map low core memory
      s390-bios: ptr2u32 and u32toptr
      s390-bios: Support for running format-0/1 channel programs
      s390-bios: cio error handling
      s390-bios: Extend find_dev() for non-virtio devices
      s390-bios: Factor finding boot device out of virtio code path
      s390-bios: Refactor virtio to run channel programs via cio
      s390-bios: Use control unit type to determine boot method
      s390-bios: Add channel command codes/structs needed for dasd-ipl
      s390-bios: Support booting from real dasd device
      s390-bios: Use control unit type to find bootable devices

Thomas Huth (1):
      pc-bios/s390: Update firmware images

 MAINTAINERS                  |   2 +
 docs/devel/s390-dasd-ipl.txt | 133 ++++++++++++++
 hw/s390x/ipl.c               |  61 +++++--
 hw/s390x/s390-ccw.c          |   9 +
 hw/vfio/ccw.c                |   6 +-
 include/hw/s390x/s390-ccw.h  |   1 +
 include/hw/s390x/vfio-ccw.h  |  28 +++
 pc-bios/s390-ccw.img         | Bin 34568 -> 42608 bytes
 pc-bios/s390-ccw/Makefile    |   2 +-
 pc-bios/s390-ccw/cio.c       | 423 +++++++++++++++++++++++++++++++++++++=
++++++
 pc-bios/s390-ccw/cio.h       | 270 +++++++++++++++++++++------
 pc-bios/s390-ccw/dasd-ipl.c  | 235 ++++++++++++++++++++++++
 pc-bios/s390-ccw/dasd-ipl.h  |  16 ++
 pc-bios/s390-ccw/helper.h    |  31 ++++
 pc-bios/s390-ccw/libc.h      |  11 ++
 pc-bios/s390-ccw/main.c      | 190 +++++++++++++------
 pc-bios/s390-ccw/netboot.mak |   2 +-
 pc-bios/s390-ccw/netmain.c   |   2 +
 pc-bios/s390-ccw/s390-arch.h | 103 +++++++++++
 pc-bios/s390-ccw/s390-ccw.h  |  10 +-
 pc-bios/s390-ccw/start.S     |  29 +++
 pc-bios/s390-ccw/virtio.c    |  81 +++------
 pc-bios/s390-netboot.img     | Bin 54944 -> 67232 bytes
 tests/boot-serial-test.c     |   2 +-
 24 files changed, 1446 insertions(+), 201 deletions(-)
 create mode 100644 docs/devel/s390-dasd-ipl.txt
 create mode 100644 include/hw/s390x/vfio-ccw.h
 create mode 100644 pc-bios/s390-ccw/cio.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
 create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
 create mode 100644 pc-bios/s390-ccw/helper.h
 create mode 100644 pc-bios/s390-ccw/s390-arch.h


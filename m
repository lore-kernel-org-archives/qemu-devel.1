Received: from eggs.gnu.org ([2001:4830:134:3::10]:40584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9V-0004MZ-0p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9K-0005ZF-33
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9J-0005Yo-PU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:45:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hasx108317
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:57 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3brr6mn4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:45:56 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:45:55 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] Patch Round-up for stable 2.10.1,
 freeze on 2017-09-27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi everyone,

The following new patches are queued for QEMU stable v2.10.1:

  https://github.com/mdroth/qemu/commits/stable-2.10-staging

The release is planned for 2017-10-02:

  https://wiki.qemu.org/Planning/2.10

Please respond here or CC qemu-stable@nongnu.org on any patches you
think should be included in the release.

Testing/feedback is greatly appreciated.

Thanks!

----------------------------------------------------------------
Alex Williamson (1):
      vhost: Release memory references on cleanup

Farhan Ali (1):
      s390-ccw: Fix alignment for CCW1

Greg Kurz (1):
      virtfs: error out gracefully when mandatory suboptions are missing

Hannes Reinecke (1):
      scsi-bus: correct responses for INQUIRY and REQUEST SENSE

Marc-Andr=C3=A9 Lureau (2):
      libvhost-user: support resuming vq->last_avail_idx based on used_id=
x
      vhost-user-bridge: fix resume regression (since 2.9)

Pavel Butsykin (1):
      qcow2: move qcow2_store_persistent_dirty_bitmaps() before cache flu=
shing

Peter Maydell (1):
      mps2-an511: Fix wiring of UART overflow interrupt lines

Pranith Kumar (1):
      arm_gicv3_kvm: Fix compile warning

Richard Henderson (1):
      target/arm: Fix aa64 ldp register writeback

Samuel Thibault (1):
      slirp: fix clearing ifq_so from pending packets

Thomas Huth (1):
      hw/arm/allwinner-a10: Mark the allwinner-a10 device with user_creat=
able =3D false

 block/qcow2.c                         | 16 +++++++-------
 contrib/libvhost-user/libvhost-user.c | 13 ++++++++++++
 contrib/libvhost-user/libvhost-user.h |  7 +++++++
 hw/arm/allwinner-a10.c                |  2 ++
 hw/arm/mps2.c                         |  4 ++--
 hw/intc/arm_gicv3_kvm.c               |  2 +-
 hw/scsi/scsi-bus.c                    | 29 ++++++++++++++++++++++----
 hw/virtio/vhost.c                     |  4 ++++
 pc-bios/s390-ccw/cio.h                |  2 +-
 scripts/device-crash-test             |  1 -
 slirp/socket.c                        | 39 +++++++++++++++++++++--------=
------
 target/arm/translate-a64.c            | 29 +++++++++++++++-----------
 tests/vhost-user-bridge.c             |  7 +++++++
 vl.c                                  | 16 ++++++++------
 14 files changed, 120 insertions(+), 51 deletions(-)

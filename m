Received: from eggs.gnu.org ([2001:4830:134:3::10]:54618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egCfL-0001fN-QZ
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egCfH-0006MS-A1
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:52:19 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 29 Jan 2018 17:52:08 +0100
Message-Id: <20180129165210.21086-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/2] s390x: support zpci in tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

This patch set (available at git://github.com/cohuck/qemu pci-tcg)
wires up zpci under tcg. A guest started with

qemu-system-s390x -M s390-ccw-virtio,accel=tcg -cpu qemu,zpci=on -device virtio-net-pci (...)

and a 4.15 kernel in the guest (needed because the requirement for ais
was dropped with

commit 48070c73058be6de9c0d754d441ed7092dfc8f12
Author: Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Mon Oct 30 14:38:58 2017 +0100

    s390/pci: do not require AIS facility

and we don't have a working ais with tcg yet), I get sensible output
out of lspci.

RFC because I'm not sure that I put up the tcg wires in the best way.

Cornelia Huck (2):
  s390x/tcg: wire up pci instructions
  s390x/cpumodel: allow zpci features in qemu model

 target/s390x/gen-features.c |   3 ++
 target/s390x/helper.h       |   9 ++++
 target/s390x/insn-data.def  |  13 +++++
 target/s390x/misc_helper.c  | 123 ++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/translate.c    | 123 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 271 insertions(+)

-- 
2.13.6

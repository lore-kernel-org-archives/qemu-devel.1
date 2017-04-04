Received: from eggs.gnu.org ([2001:4830:134:3::10]:33993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cvFSj-0005jm-Du
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 23:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1cvFSg-0005n8-A8
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 23:48:57 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1cvFSg-0005le-4K
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 23:48:54 -0400
Received: by mail-pg0-x242.google.com with SMTP id 79so34208220pgf.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 20:48:53 -0700 (PDT)
From: Ashish Mittal <ashmit602@gmail.com>
Date: Mon,  3 Apr 2017 20:48:07 -0700
Message-Id: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
Subject: [Qemu-devel] [PATCH v11 0/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, Ketan.Nilangekar@veritas.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, venkatesha.mg@veritas.com, Rakesh.Ranjan@veritas.com, eblake@redhat.com
Cc: Abhijit.Dey@veritas.com, Ashish Mittal <Ashish.Mittal@veritas.com>

- Veritas HyperScale block driver in QEMU is designed to provide an accelerated
  IO path from KVM virtual machines to Veritas HyperScale storage service.

- A network IO transfer library that translates block IO from HyperScale block
  driver to a network IO format to send it to Veritas HyperScale storage
  service. This library (libvxhs) has been open sourced and is available on
  github here:  https://github.com/VeritasHyperScale/libqnio.git

Ashish Mittal (2):
  block/vxhs.c: Add support for a new block device type called "vxhs"
  block/vxhs.c: Add qemu-iotests for new block device type "vxhs"

 block/Makefile.objs              |   2 +
 block/trace-events               |  17 ++
 block/vxhs.c                     | 575 +++++++++++++++++++++++++++++++++++++++
 configure                        |  39 +++
 qapi/block-core.json             |  23 +-
 tests/qemu-iotests/common        |   6 +
 tests/qemu-iotests/common.config |  13 +
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/common.rc     |  19 ++
 9 files changed, 693 insertions(+), 2 deletions(-)
 create mode 100644 block/vxhs.c

-- 
2.5.5

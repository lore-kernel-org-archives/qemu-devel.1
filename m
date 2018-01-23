Received: from eggs.gnu.org ([2001:4830:134:3::10]:52004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1d9-00042a-8m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ee1d4-0005u5-DY
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:41:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ee1d4-0005tV-7i
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:40:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jan 2018 17:40:37 +0100
Message-Id: <20180123164041.30339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 0/4] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu, xiaolong.ye@intel.com, peterx@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

This series adds DMA operations support to the qemu fw_cfg kernel
module and populates "etc/vmcoreinfo" with vmcoreinfo location
details (since qemu 2.11).

v10:
- merged Peter Xu fix "[PATCH] fw_cfg: don't use DMA mapping for fw_cfg d=
evice"
  (fixing fw-cfg+viommu configuration)
- switch back to kalloc'd struct vmci, to fix DMA garbage operations
- do not attempt to write vmcoreinfo if the entry exists but DMA isn't su=
pported
- removed a copy-pasta memset() on write operation error

Marc-Andr=C3=A9 Lureau (4):
  fw_cfg: add DMA register
  fw_cfg: do DMA read operation
  crash: export paddr_vmcoreinfo_note()
  fw_cfg: write vmcoreinfo details

 drivers/firmware/qemu_fw_cfg.c | 267 +++++++++++++++++++++++++++++++++++=
+-----
 kernel/crash_core.c            |   1 +
 2 files changed, 236 insertions(+), 32 deletions(-)

--=20
2.16.0.rc1.1.gef27df75a1

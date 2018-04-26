Received: from eggs.gnu.org ([2001:4830:134:3::10]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006j7-7w
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA7-0001Ry-Gy
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA7-0001Re-5W
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:27 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:25 +0100
Message-ID: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 0/7] Introduce error_[v]report_errno[val]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

From: Ian Jackson <Ian.Jackson@eu.citrix.com>

This is apropos if a suggestion from Philippe.  I've compile-tested
this but not executed it yet.  Let me know what you think.

Thanks,
Ian.

Ian Jackson (7):
  error reporting: Introduce errnoval parameter to vreport
  error reporting: Provide error_report_errno (and error_vreport_errno)
  error reporting: Use error_report_errno in obvious places
  error reporting: Fix some error messages to use ":" rather than ","
  error reporting: Provide error_report_errnoval (and
    error_vreport_errnoval)
  error reporting: Use error_report_errnoval in obvious places
  error reporting: HACKING: Say to use error_report_errno

 HACKING                      |  1 +
 audio/wavcapture.c           |  2 +-
 block/nvme.c                 |  2 +-
 block/rbd.c                  |  2 +-
 block/sheepdog.c             | 16 ++++-----
 cpus.c                       |  2 +-
 hw/i386/xen/xen-hvm.c        |  2 +-
 hw/ppc/spapr_hcall.c         |  2 +-
 hw/s390x/s390-stattrib-kvm.c |  6 ++--
 hw/s390x/s390-virtio-ccw.c   |  2 +-
 hw/scsi/vhost-scsi.c         |  2 +-
 hw/scsi/vhost-user-scsi.c    |  2 +-
 hw/tpm/tpm_emulator.c        |  2 +-
 hw/xen/xen_pt_load_rom.c     |  4 +--
 include/qemu/error-report.h  |  7 ++++
 migration/migration.c        |  2 +-
 migration/postcopy-ram.c     | 12 +++----
 net/tap-linux.c              |  2 +-
 os-posix.c                   |  8 ++---
 qemu-img.c                   | 10 +++---
 qemu-io-cmds.c               |  4 +--
 qemu-nbd.c                   | 10 +++---
 scsi/qemu-pr-helper.c        |  8 ++---
 slirp/misc.c                 |  4 +--
 target/arm/kvm64.c           |  4 +--
 util/osdep.c                 |  2 +-
 util/qemu-error.c            | 77 ++++++++++++++++++++++++++++++++++++++++----
 vl.c                         |  6 ++--
 28 files changed, 137 insertions(+), 66 deletions(-)

-- 
2.1.4

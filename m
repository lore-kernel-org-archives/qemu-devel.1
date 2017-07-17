Received: from eggs.gnu.org ([2001:4830:134:3::10]:34361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6g-0003Bi-VS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6c-0003Qq-Pn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6c-0003QD-JR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:36 -0300
Message-Id: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 00/15] x86 and machine queue for 2.10 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to f86285c571c49e781d3fa46f3bef3835b8e6f393:

  qmp: Include parent type on 'qom-list-types' output (2017-07-17 15:41:30 -0300)

----------------------------------------------------------------
x86 and machine queue, 2017-07-17

----------------------------------------------------------------

Boqun Feng (Intel) (1):
  i386: add Skylake-Server cpu model

Daniel P. Berrange (1):
  i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf

Eduardo Habkost (9):
  device-crash-test: Fix regexp on whitelist
  tests: Test case for object_resolve_path*()
  test-qdev-global-props: Test global property ordering
  Revert "machine: Convert abstract typename on compat_props to subclass
    names"
  qom: Fix ambiguous path detection when ambiguous=NULL
  i386: Update comment about XSAVES on Skylake-Client
  tests: Simplify abstract-interfaces check with a helper
  qmp: Include 'abstract' field on 'qom-list-types' output
  qmp: Include parent type on 'qom-list-types' output

Greg Kurz (1):
  qdev: fix the order compat and global properties are applied

Mark Cave-Ayland (3):
  fw_cfg: switch fw_cfg_find() to locate the fw_cfg device by type
    rather than path
  fw_cfg: move qdev_init_nofail() from fw_cfg_init1() to callers
  fw_cfg: move QOM type defines and fw_cfg types into fw_cfg.h

 qapi-schema.json               |   7 +-
 include/hw/i386/pc.h           |   5 ++
 include/hw/nvram/fw_cfg.h      |  50 +++++++++++++
 include/qemu/typedefs.h        |   1 +
 target/i386/cpu.h              |   1 +
 hw/core/machine.c              |  26 +------
 hw/core/qdev-properties.c      |  15 +---
 hw/nvram/fw_cfg.c              |  79 +++++----------------
 qmp.c                          |   6 ++
 qom/object.c                   |  17 +++--
 target/i386/cpu.c              |  78 ++++++++++++++++++++-
 tests/check-qom-proplist.c     |  42 +++++++++++
 tests/device-introspect-test.c | 156 +++++++++++++++++++++++++++++++++--------
 tests/test-qdev-global-props.c |  33 +++++++++
 scripts/device-crash-test      |   2 +-
 15 files changed, 381 insertions(+), 137 deletions(-)

-- 
2.9.4

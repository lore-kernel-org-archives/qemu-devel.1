Received: from eggs.gnu.org ([2001:4830:134:3::10]:38204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKGC-0000a9-Rl
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKG8-0003UO-Su
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKG8-0003U9-JU
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:47:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F12761B8A
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DFA18D768
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 13:47:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  9 Jun 2017 15:46:44 +0200
Message-Id: <1497016045-6009-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/41] QAPI patches for 2017-06-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 64175afc695c0672876fbbfc31b299c86d562c=
b4:

  arm_gicv3: Fix ICC_BPR1 reset value when EL3 not implemented (2017-06-0=
7 17:21:44 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-06-09

for you to fetch changes up to 9f70c3652654d59a1cc0e2ef4cc5b0e541d93579:

  tests/qdict: check more get_try_int() cases (2017-06-09 13:48:45 +0200)

----------------------------------------------------------------
QAPI patches for 2017-06-09

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (41):
      qdev: remove PropertyInfo.qtype field
      object: fix potential leak in getters
      tests: Remove test cases for alternates of 'number' and 'int'
      tests: add more int/number ranges checks
      qapi: Clean up qobject_input_type_number() control flow
      qapi: merge QInt and QFloat in QNum
      qapi: Remove visit_start_alternate() parameter promote_int
      tests: remove /{qnum, qlist, dict}/destroy test
      qnum: add uint type
      json: learn to parse uint64 numbers
      qapi: update the qobject visitor to use QNUM_U64
      object: add uint property setter/getter
      q35: fix get_mmcfg_size to use uint64 visitor
      object: use more specific property type names
      qdev: Rename DEFINE_PROP_DEFAULT() to DEFINE_PROP_SIGNED()
      qdev: wrap default property value in an union
      qdev: avoid type casts between signed and unsigned
      apic-common: make "id" property a uint32
      qdev: Use appropriate getter/setters type
      isa: use get_uint() for "io-base"
      pc-dimm: use get_uint() for dimm properties
      pc-dimm: make "size" property uint64
      pcihp: use get_uint() for "bsel" property
      aspeed: use {set, get}_uint() for "ram-size" property
      bcm2835_fb: use {get, set}_uint() for "vcram-size" and "vcram-base"
      platform-bus: use get_uint() for "addr" property
      acpi: use get_uint() for "acpi-pcihp-io*" properties
      acpi: use get_uint() for various acpi properties
      acpi: use get_uint() for "pci-hole*" properties
      pc: use get_uint() for "iobase" property
      pc: use get_uint() for "apic-id" property
      pc: use get_uint() for "hpet-intcap" property
      xen: use get_uint() for "max-ram-below-4g" property
      arm: use get_uint() for "mp-affinity" property
      auxbus: use get_uint() for "addr" property
      pvpanic: use get_uint() for "ioport" property
      pnv-core: use get_uint() for "core-pir" property
      numa: use get_uint() for "size" property
      i386/cpu: use get_uint() for "min-level"/"min-xlevel" properties
      console: use get_uint() for "head" property
      tests/qdict: check more get_try_int() cases

 MAINTAINERS                              |   3 +-
 backends/cryptodev.c                     |   2 +-
 block/blkdebug.c                         |   1 -
 block/nbd.c                              |   1 -
 block/nfs.c                              |   1 -
 block/qapi.c                             |  13 +-
 block/quorum.c                           |   1 -
 block/sheepdog.c                         |   1 -
 block/ssh.c                              |   1 -
 block/vvfat.c                            |   1 -
 blockdev.c                               |   5 +-
 hw/acpi/memory_hotplug.c                 |  12 +-
 hw/acpi/nvdimm.c                         |  18 +--
 hw/acpi/pcihp.c                          |   7 +-
 hw/arm/aspeed.c                          |   8 +-
 hw/arm/bcm2835_peripherals.c             |   9 +-
 hw/arm/raspi.c                           |   4 +-
 hw/block/fdc.c                           |  18 +--
 hw/core/platform-bus.c                   |   2 +-
 hw/core/qdev-properties.c                |  40 +++++-
 hw/core/qdev.c                           |  13 +-
 hw/i386/acpi-build.c                     |  69 +++++-----
 hw/i386/pc.c                             |   6 +-
 hw/i386/xen/xen-hvm.c                    |   6 +-
 hw/intc/apic_common.c                    |  10 +-
 hw/intc/arm_gicv3_common.c               |   2 +-
 hw/mem/pc-dimm.c                         |  23 ++--
 hw/misc/auxbus.c                         |   2 +-
 hw/misc/pvpanic.c                        |   2 +-
 hw/net/e1000e.c                          |   6 +-
 hw/pci-host/gpex.c                       |   2 +-
 hw/pci-host/piix.c                       |   8 +-
 hw/pci-host/q35.c                        |  15 +--
 hw/pci-host/xilinx-pcie.c                |   2 +-
 hw/ppc/pnv.c                             |   2 +-
 hw/ppc/pnv_core.c                        |   2 +-
 hw/ppc/spapr.c                           |   7 +-
 hw/usb/xen-usb.c                         |   1 -
 include/hw/isa/isa.h                     |   2 +-
 include/hw/qdev-core.h                   |   7 +-
 include/hw/qdev-properties.h             |  50 ++++---
 include/qapi/qmp/qdict.h                 |   3 +-
 include/qapi/qmp/qfloat.h                |  29 ----
 include/qapi/qmp/qint.h                  |  28 ----
 include/qapi/qmp/qlist.h                 |   3 +-
 include/qapi/qmp/qnum.h                  |  53 ++++++++
 include/qapi/qmp/types.h                 |   3 +-
 include/qapi/qobject-input-visitor.h     |   6 +-
 include/qapi/qobject-output-visitor.h    |   8 +-
 include/qapi/visitor-impl.h              |   2 +-
 include/qapi/visitor.h                   |   4 +-
 include/qom/object.h                     |  23 ++++
 monitor.c                                |   2 +-
 net/dump.c                               |   2 +-
 net/filter-buffer.c                      |   2 +-
 numa.c                                   |   6 +-
 qapi/qapi-clone-visitor.c                |   2 +-
 qapi/qapi-dealloc-visitor.c              |   2 +-
 qapi/qapi-visit-core.c                   |   6 +-
 qapi/qobject-input-visitor.c             |  58 ++++----
 qapi/qobject-output-visitor.c            |   7 +-
 qapi/trace-events                        |   2 +-
 qga/commands.c                           |   2 +-
 qga/main.c                               |   1 -
 qobject/Makefile.objs                    |   2 +-
 qobject/json-lexer.c                     |   4 +
 qobject/json-parser.c                    |  56 +++++---
 qobject/qdict.c                          |  37 +++---
 qobject/qfloat.c                         |  62 ---------
 qobject/qint.c                           |  61 ---------
 qobject/qjson.c                          |  37 +-----
 qobject/qnum.c                           | 221 +++++++++++++++++++++++++=
++++++
 qobject/qobject.c                        |   3 +-
 qom/object.c                             |  51 +++++--
 scripts/coccinelle/qobject.cocci         |   4 +-
 scripts/qapi-visit.py                    |  12 +-
 scripts/qapi.py                          |  36 +++--
 target/i386/cpu.c                        |  10 +-
 tests/.gitignore                         |   3 +-
 tests/Makefile.include                   |  13 +-
 tests/check-qdict.c                      |  39 +++---
 tests/check-qfloat.c                     |  53 --------
 tests/check-qint.c                       |  87 ------------
 tests/check-qjson.c                      | 135 +++++++++++++------
 tests/check-qlist.c                      |  40 ++----
 tests/check-qnum.c                       | 170 ++++++++++++++++++++++++
 tests/check-qstring.c                    |   9 --
 tests/qapi-schema/comments.out           |   2 +-
 tests/qapi-schema/doc-good.out           |   2 +-
 tests/qapi-schema/empty.out              |   2 +-
 tests/qapi-schema/event-case.out         |   2 +-
 tests/qapi-schema/ident-with-escape.out  |   2 +-
 tests/qapi-schema/include-relpath.out    |   2 +-
 tests/qapi-schema/include-repetition.out |   2 +-
 tests/qapi-schema/include-simple.out     |   2 +-
 tests/qapi-schema/indented-expr.out      |   2 +-
 tests/qapi-schema/qapi-schema-test.json  |   2 -
 tests/qapi-schema/qapi-schema-test.out   |  10 +-
 tests/test-keyval.c                      |   4 +-
 tests/test-qmp-commands.c                |   8 +-
 tests/test-qmp-event.c                   |   9 +-
 tests/test-qobject-input-visitor.c       | 112 +++++++++-------
 tests/test-qobject-output-visitor.c      |  93 ++++++++-----
 tests/test-x86-cpuid-compat.c            |  18 ++-
 ui/console.c                             |   4 +-
 ui/spice-core.c                          |   1 -
 ui/vnc-enc-tight.c                       |   1 -
 util/qemu-option.c                       |  24 ++--
 108 files changed, 1153 insertions(+), 935 deletions(-)
 delete mode 100644 include/qapi/qmp/qfloat.h
 delete mode 100644 include/qapi/qmp/qint.h
 create mode 100644 include/qapi/qmp/qnum.h
 delete mode 100644 qobject/qfloat.c
 delete mode 100644 qobject/qint.c
 create mode 100644 qobject/qnum.c
 delete mode 100644 tests/check-qfloat.c
 delete mode 100644 tests/check-qint.c
 create mode 100644 tests/check-qnum.c

--=20
2.7.5

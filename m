Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fH7I0-00035z-07
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fH7Hw-00025I-TN
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:36:48 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fH7Hw-00024m-Hw
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:36:44 -0400
Received: by mail-wm0-x230.google.com with SMTP id t11-v6so2504620wmt.0
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:36:44 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-189-60.clienti.tiscali.it.
	[78.12.189.60]) by smtp.gmail.com with ESMTPSA id
	z42-v6sm1750279edz.36.2018.05.11.05.36.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 11 May 2018 05:36:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 May 2018 14:36:39 +0200
Message-Id: <1526042199-45745-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 00/29] Misc patches for 2018-05-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit cc8f8ba754bba17eea9791d67b572eb26e30b4ce:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-05-08 15:25:17 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5b27a92dcc5afb11d38c7fe0a637d5d64d31108a:

  rename included C files to foo.inc.c, remove osdep.h (2018-05-11 14:33:40 +0200)

----------------------------------------------------------------
* Don't silently truncate extremely long words in the command line
* dtc configure fixes
* MemoryRegionCache second try
* Deprecated option removal
* add support for Hyper-V reenlightenment MSRs

----------------------------------------------------------------
Cédric Le Goater (1):
      cpus: tcg: fix never exiting loop on unplug

Daniel P. Berrangé (4):
      accel: use g_strsplit for parsing accelerator names
      opts: don't silently truncate long parameter keys
      opts: don't silently truncate long option values
      qemu-doc: provide details of supported build platforms

David Hildenbrand (1):
      pc-dimm: fix error messages if no slots were defined

Jan Kiszka (1):
      build: Silence dtc directory creation

Markus Armbruster (1):
      cpus: Fix event order on resume of stopped guest

Olaf Hering (1):
      configure: recognize more rpmbuild macros

Paolo Bonzini (8):
      qom: allow object_get_canonical_path_component without parent
      memdev: remove "id" property
      exec: move memory access declarations to a common header, inline *_phys functions
      exec: small changes to flatview_do_translate
      exec: extract address_space_translate_iommu, fix page_mask corner case
      exec: reintroduce MemoryRegion caching
      target/i386: sev: fix memory leaks
      rename included C files to foo.inc.c, remove osdep.h

Peter Xu (2):
      checkpatch.pl: add common glib defines to typelist
      qemu-thread: always keep the posix wrapper layer

Philippe Mathieu-Daudé (3):
      configure: Really use local libfdt if the system one is too old
      configure: Display if libfdt is from system or git
      shippable: Remove Debian 8 libfdt kludge

Roman Kagan (1):
      update-linux-headers: drop hyperv.h

Thomas Huth (5):
      qemu-options: Mark -virtioconsole as deprecated
      qemu-options: Remove remainders of the -tdf option
      qemu-options: Bail out on unsupported options instead of silently ignoring them
      qemu-options: Remove deprecated -no-kvm-pit-reinjection
      qemu-options: Remove deprecated -no-kvm-irqchip

Vitaly Kuznetsov (1):
      i386/kvm: add support for Hyper-V reenlightenment MSRs

 .shippable.yml                                     |   8 -
 Makefile                                           |   2 +-
 accel/accel.c                                      |  16 +-
 backends/hostmem.c                                 |  26 ---
 configure                                          |  17 +-
 cpus.c                                             |  18 +-
 exec.c                                             | 242 ++++++++++++++++-----
 hw/i386/multiboot.c                                |  33 ++-
 hw/mem/pc-dimm.c                                   |   9 +-
 include/exec/cpu-all.h                             |  79 +++----
 include/exec/memory-internal.h                     |   3 +
 include/exec/memory.h                              | 209 ++++++++----------
 include/exec/memory_ldst.inc.h                     |  71 ++++++
 include/exec/memory_ldst_cached.inc.h              | 108 +++++++++
 include/exec/memory_ldst_phys.inc.h                | 147 +++++++++++++
 include/qemu-common.h                              |   2 +-
 include/qemu/option.h                              |   3 +-
 include/qom/object.h                               |   1 +
 include/sysemu/hostmem.h                           |   1 -
 memory.c                                           |   4 +-
 memory_ldst.inc.c                                  | 126 -----------
 numa.c                                             |   2 +-
 os-posix.c                                         |   6 +-
 os-win32.c                                         |   4 +-
 qemu-doc.texi                                      |  83 ++++++-
 qemu-options.hx                                    |  15 +-
 qom/object.c                                       |   5 +-
 qom/object_interfaces.c                            |   6 -
 rules.mak                                          |   2 +-
 scripts/checkpatch.pl                              |  28 +++
 scripts/update-linux-headers.sh                    |   6 -
 target/cris/translate.c                            |   2 +-
 .../cris/{translate_v10.c => translate_v10.inc.c}  |   0
 target/i386/cpu.c                                  |   4 +-
 target/i386/cpu.h                                  |   4 +
 target/i386/hyperv-proto.h                         |   9 +-
 target/i386/kvm.c                                  |  39 +++-
 target/i386/machine.c                              |  24 ++
 target/i386/sev.c                                  |  32 +--
 target/mips/translate.c                            |   2 +-
 .../{translate_init.c => translate_init.inc.c}     |   0
 target/ppc/int_helper.c                            |   2 +-
 target/ppc/{mfrom_table.c => mfrom_table.inc.c}    |   0
 target/ppc/translate.c                             |   2 +-
 .../ppc/{translate_init.c => translate_init.inc.c} |   1 -
 tests/test-qemu-opts.c                             |  18 --
 ui/vnc-enc-zrle.c                                  |  22 +-
 ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} |   0
 util/qemu-option.c                                 | 150 +++++++------
 util/qemu-thread-posix.c                           |  33 ++-
 vl.c                                               |  24 +-
 51 files changed, 1029 insertions(+), 621 deletions(-)
 create mode 100644 include/exec/memory_ldst.inc.h
 create mode 100644 include/exec/memory_ldst_cached.inc.h
 create mode 100644 include/exec/memory_ldst_phys.inc.h
 rename target/cris/{translate_v10.c => translate_v10.inc.c} (100%)
 rename target/mips/{translate_init.c => translate_init.inc.c} (100%)
 rename target/ppc/{mfrom_table.c => mfrom_table.inc.c} (100%)
 rename target/ppc/{translate_init.c => translate_init.inc.c} (99%)
 rename ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} (100%)
-- 
1.8.3.1

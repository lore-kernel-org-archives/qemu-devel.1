Received: from eggs.gnu.org ([2001:4830:134:3::10]:47002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eBMLi-0002iu-6E
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eBMLe-0007Ec-A1
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:34 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eBMLe-0007DA-3k
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:30 -0500
Received: by mail-wm0-x243.google.com with SMTP id y83so9520325wmc.4
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 06:56:29 -0800 (PST)
Received: from donizetti.lan (94-39-170-107.adsl-ull.clienti.tiscali.it.
	[94.39.170.107]) by smtp.gmail.com with ESMTPSA id
	b15sm13030903wrh.35.2017.11.05.06.56.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 05 Nov 2017 06:56:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun,  5 Nov 2017 15:56:23 +0100
Message-Id: <20171105145625.7817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/2] Changes for 2017-11-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit b33afc415622e5eb26e0f14fd27eb86e32a5472e:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-ci-updates-for-softfreeze-021117-2' into staging (2017-11-03 10:08:34 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 20bc94a2b8449b7700b6bfa25a87ce2320a1c649:

  build: disable -Wmissing-braces on older compilers (2017-11-05 14:52:10 +0100)

(I see some brokenness in check-qtest-sparc, but not caused by
my two patches of course).

----------------------------------------------------------------
* Remove legacy KVM PCI device assignment
* Fix qemu-pr-helper.c compilation on older compilers

----------------------------------------------------------------
Paolo Bonzini (2):
      pci-assign: Remove
      build: disable -Wmissing-braces on older compilers

 configure                                          |   13 +
 docs/qdev-device-use.txt                           |   12 +-
 hw/i386/Makefile.objs                              |    1 -
 hw/i386/kvm/Makefile.objs                          |    2 +-
 hw/i386/kvm/pci-assign.c                           | 1887 --------------------
 hw/xen/Makefile.objs                               |    1 +
 .../xen_pt_load_rom.c}                             |    4 +-
 include/hw/pci/pci-assign.h                        |   27 -
 qdev-monitor.c                                     |    1 -
 scripts/device-crash-test                          |    2 -
 10 files changed, 19 insertions(+), 1931 deletions(-)
 delete mode 100644 hw/i386/kvm/pci-assign.c
 rename hw/{i386/pci-assign-load-rom.c => xen/xen_pt_load_rom.c} (96%)
 delete mode 100644 include/hw/pci/pci-assign.h
-- 
2.14.3

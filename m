Received: from eggs.gnu.org ([2001:4830:134:3::10]:41474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cc8QX-0002qM-AG
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cc8QT-00083d-8H
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:27:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cc8QS-00083B-Vp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:27:37 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0103A3B71F
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 10:27:36 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 10 Feb 2017 11:27:17 +0100
Message-Id: <1486722439-12033-1-git-send-email-abologna@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/2] docs: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, lersek@redhat.com, kraxel@redhat.com

Changes since [v5]

  * Address review comments:
    - use the native serial console rather than the VirtIO
      based one, and enable monitor multiplexing so that
      the user can switch between the two;
    - add GIC version configuration;
    - improve wording all over the place.

  * Improvements:
    - add information about Debian/Ubuntu firmware
      packages.

Changes since [v4]

  * Improvements:
    - move storage configuration from the command line
      to the configuration files so that the command
      line is shorter and we can provide better
      documentation for the various parts;
    - configure the amount of memory for the guest in
      the file too;
    - document the fact that you might want/need to use
      '-serial stdio' and '-display vnc=...' in some
      situations;
    - fix the value of 'port' for one of the
      pcie-root-port devices;
    - fix some inaccurate comments.

  * Arguably the opposite:
    - remove the sample command line for running a live
      OS from the file header. I could be convinced to
      add it back as a (commented) section about it, if
      people think it's useful enough.

Changes since [v3]

  * Address review comments:
    - place VGA at 00:01.0;
    - use pcie-root-port instead of ioh3420 in
      q35-virtio-*.cfg;
    - add a comment to let users know that PCI Express
      devices should not be placed on the legacy PCI
      bridge.

Changes since [v2]

  * Address review comments:
    - use -nodefaults in q35-emulated.cfg too;
    - add explicit VGA and Ethernet.

  * Improvements:
    - use virtconsole and virtio-serial instead of
      isa-serial in q35-virtio-serial.cfg.

  * Possibily controversial:
    - get rid of q35-virtio-common.cfg and add the PCIe
      Root Ports back into q35-virtio-*.cfg: while this
      leads to having some duplicated content, I feel like
      the sample configurations are much more useful when
      they can stand entirely on their own, especially now
      that they start with a detailed hardware listing.

  * Cosmetic stuff:
    - hardware listing looks like the output of lspci;
    - section names match what's used in the hardware
      listing so it's faster to jump to the section;
    - PCI addresses also match the output of lspci;
    - PCI Express is used instead of PCIe.

Changes since [v1]

  * Address review comments:
    - improve the existing configuration file instead
      of removing it;
    - split off the common part for VirtIO guests;
    - plug all ioh3420 devices in a single slot;
    - use slot 1c for ioh3420 devices;
    - remove useless USB keyboard.

  * Improve usage description:
    - make sure the OS disk actually uses the VirtIO
      SCSI controller, as intended, rather than the
      built-in SATA one;
    - provide a command line for running live CDs.

  * Document more devices:
    - the video card is added by default;
    - so is the Ethernet adapter, apparently.

[v1] http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg06342.html
[v2] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00184.html
[v3] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00461.html
[v4] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00672.html
[v5] http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01714.html

Andrea Bolognani (2):
  q35: Improve sample configuration files
  mach-virt: Provide sample configuration files

 docs/mach-virt-graphical.cfg  | 262 ++++++++++++++++++++++++++++++++++++++++
 docs/mach-virt-serial.cfg     | 224 +++++++++++++++++++++++++++++++++++
 docs/q35-chipset.cfg          | 152 ------------------------
 docs/q35-emulated.cfg         | 269 ++++++++++++++++++++++++++++++++++++++++++
 docs/q35-virtio-graphical.cfg | 229 +++++++++++++++++++++++++++++++++++
 docs/q35-virtio-serial.cfg    | 174 +++++++++++++++++++++++++++
 6 files changed, 1158 insertions(+), 152 deletions(-)
 create mode 100644 docs/mach-virt-graphical.cfg
 create mode 100644 docs/mach-virt-serial.cfg
 delete mode 100644 docs/q35-chipset.cfg
 create mode 100644 docs/q35-emulated.cfg
 create mode 100644 docs/q35-virtio-graphical.cfg
 create mode 100644 docs/q35-virtio-serial.cfg

-- 
2.7.4

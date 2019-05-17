Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32C7C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F4D2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F4D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRU4V-0003FM-BI
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:02:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRU3f-0002y6-5U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hRU3e-0001hW-0l
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hRU3d-0001hA-PM
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D171811DC
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 04:01:20 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 061F560A9A
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 04:01:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 06:01:18 +0200
Message-Id: <1558065678-21543-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 04:01:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/21] Misc patches for 2019-05-15
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb3=
73:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into =
staging (2019-05-14 10:08:47 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ff4a1ff34ba90203845d9668d4ef7d7b5973c64b:

  hw/net/ne2000: Extract the PCI device from the chipset common code (201=
9-05-15 11:56:54 +0200)

----------------------------------------------------------------
Mostly bugfixes and cleanups, the most important being
"megasas: fix mapped frame size" from Peter Lieven.
In addition, -realtime is marked as deprecated.

----------------------------------------------------------------
Chen Zhang (1):
      hvf: Add missing break statement

Igor Mammedov (1):
      roms: assert if max rom size is less than the used size

Laurent Vivier (5):
      trace: only include trace-event-subdirs when they are needed
      build: replace GENERATED_FILES by generated-files-y
      configure: qemu-ga is only needed with softmmu targets
      build: chardev is only needed for softmmu targets
      build: don't build hardware objects with linux-user

Marc-Andr=C3=A9 Lureau (1):
      vl: fix -sandbox parsing crash when seccomp support is disabled

Paolo Bonzini (2):
      mips-fulong2e: obey -vga none
      sun4m: obey -vga none

Peter Lieven (1):
      megasas: fix mapped frame size

Philippe Mathieu-Daud=C3=A9 (5):
      vl: Add missing descriptions to the VGA adapters list
      hw/acpi/piix4: Move TYPE_PIIX4_PM to a public header
      hw/i386/acpi: Add object_resolve_type_unambiguous to improve modula=
rity
      hw/i386/acpi: Assert a pointer is not null BEFORE using it
      hw/net/ne2000: Extract the PCI device from the chipset common code

Thomas Huth (3):
      hw/input: Add a CONFIG_PS2 switch for the ps2.c file
      Declare -realtime as deprecated
      hw/char: Move multi-serial devices into separate file

Vitaly Kuznetsov (1):
      ioapic: allow buggy guests mishandling level-triggered interrupts t=
o make progress

Wei Yang (1):
      memory: correct the comment to DIRTY_MEMORY_MIGRATION

 Makefile                          |  43 ++++----
 Makefile.objs                     |  22 ++--
 Makefile.target                   |   6 +-
 configure                         |   4 +-
 hw/acpi/piix4.c                   |  13 ---
 hw/char/Kconfig                   |   6 ++
 hw/char/Makefile.objs             |   1 +
 hw/char/serial-pci-multi.c        | 208 ++++++++++++++++++++++++++++++++=
++++++
 hw/char/serial-pci.c              | 170 -------------------------------
 hw/core/loader.c                  |   1 +
 hw/i386/acpi-build.c              |  22 +++-
 hw/input/Kconfig                  |   5 +
 hw/input/Makefile.objs            |   2 +-
 hw/intc/ioapic.c                  |  57 ++++++++++-
 hw/intc/trace-events              |   1 +
 hw/isa/lpc_ich9.c                 |  11 --
 hw/mips/mips_fulong2e.c           |  10 +-
 hw/net/Kconfig                    |   7 +-
 hw/net/Makefile.objs              |   3 +-
 hw/net/ne2000-pci.c               | 132 ++++++++++++++++++++++++
 hw/net/ne2000.c                   | 105 -------------------
 hw/scsi/megasas.c                 |   2 +-
 hw/sparc/sun4m.c                  |   6 +-
 include/hw/acpi/piix4.h           |   2 +-
 include/hw/i386/ich9.h            |   2 -
 include/hw/i386/ioapic_internal.h |   3 +
 memory.c                          |   4 +-
 qemu-deprecated.texi              |   5 +
 target/i386/hvf/hvf.c             |   1 +
 target/s390x/Makefile.objs        |   2 +-
 tests/Makefile.include            | 116 ++++++++++-----------
 vl.c                              |  22 ++--
 32 files changed, 568 insertions(+), 426 deletions(-)
 create mode 100644 hw/char/serial-pci-multi.c
 create mode 100644 hw/net/ne2000-pci.c
--=20
1.8.3.1


Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FFEC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 08:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59FE206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 08:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59FE206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD1O3-0007lH-UD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 04:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kD1NW-0007KZ-8E
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 04:10:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:60346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kD1NT-0006Bz-NM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 04:10:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kD1NR-0007hH-NQ
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:10:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AC0A62E8071
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 08:10:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2020 07:58:30 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1893744@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <159894711032.21231.11251207262387060665.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1893744] [NEW] meson: incomplete 'make help'
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="195cbfa84cb75815472f69dd83d46f006869050b"; Instance="production"
X-Launchpad-Hash: 4cc726b41c956d7408261d006ef1196601517b1a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 03:58:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1893744 <1893744@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Since the meson switch, 'make help' doesn't list various targets.

Diff before/after:

---
 Generic targets:
   all                            - Build all
   dir/file.o                     - Build specified target only
   install                        - Install QEMU
   ctags/TAGS                     - Generate tags file for editors
   cscope                         - Generate cscope index
-
-Architecture specific targets:
-  aarch64-softmmu/all            - Build for aarch64-softmmu
-  alpha-softmmu/all              - Build for alpha-softmmu
-  arm-softmmu/all                - Build for arm-softmmu
-  avr-softmmu/all                - Build for avr-softmmu
-  cris-softmmu/all               - Build for cris-softmmu
-  hppa-softmmu/all               - Build for hppa-softmmu
-  i386-softmmu/all               - Build for i386-softmmu
-  lm32-softmmu/all               - Build for lm32-softmmu
-  m68k-softmmu/all               - Build for m68k-softmmu
-  microblazeel-softmmu/all       - Build for microblazeel-softmmu
-  microblaze-softmmu/all         - Build for microblaze-softmmu
-  mips64el-softmmu/all           - Build for mips64el-softmmu
-  mips64-softmmu/all             - Build for mips64-softmmu
-  mipsel-softmmu/all             - Build for mipsel-softmmu
-  mips-softmmu/all               - Build for mips-softmmu
-  moxie-softmmu/all              - Build for moxie-softmmu
-  nios2-softmmu/all              - Build for nios2-softmmu
-  or1k-softmmu/all               - Build for or1k-softmmu
-  ppc64-softmmu/all              - Build for ppc64-softmmu
-  ppc-softmmu/all                - Build for ppc-softmmu
-  riscv32-softmmu/all            - Build for riscv32-softmmu
-  riscv64-softmmu/all            - Build for riscv64-softmmu
-  rx-softmmu/all                 - Build for rx-softmmu
-  s390x-softmmu/all              - Build for s390x-softmmu
-  sh4eb-softmmu/all              - Build for sh4eb-softmmu
-  sh4-softmmu/all                - Build for sh4-softmmu
-  sparc64-softmmu/all            - Build for sparc64-softmmu
-  sparc-softmmu/all              - Build for sparc-softmmu
-  tricore-softmmu/all            - Build for tricore-softmmu
-  unicore32-softmmu/all          - Build for unicore32-softmmu
-  x86_64-softmmu/all             - Build for x86_64-softmmu
-  xtensaeb-softmmu/all           - Build for xtensaeb-softmmu
-  xtensa-softmmu/all             - Build for xtensa-softmmu
-  aarch64_be-linux-user/all      - Build for aarch64_be-linux-user
-  aarch64-linux-user/all         - Build for aarch64-linux-user
-  alpha-linux-user/all           - Build for alpha-linux-user
-  armeb-linux-user/all           - Build for armeb-linux-user
-  arm-linux-user/all             - Build for arm-linux-user
-  cris-linux-user/all            - Build for cris-linux-user
-  hppa-linux-user/all            - Build for hppa-linux-user
-  i386-linux-user/all            - Build for i386-linux-user
-  m68k-linux-user/all            - Build for m68k-linux-user
-  microblazeel-linux-user/all    - Build for microblazeel-linux-user
-  microblaze-linux-user/all      - Build for microblaze-linux-user
-  mips64el-linux-user/all        - Build for mips64el-linux-user
-  mips64-linux-user/all          - Build for mips64-linux-user
-  mipsel-linux-user/all          - Build for mipsel-linux-user
-  mips-linux-user/all            - Build for mips-linux-user
-  mipsn32el-linux-user/all       - Build for mipsn32el-linux-user
-  mipsn32-linux-user/all         - Build for mipsn32-linux-user
-  nios2-linux-user/all           - Build for nios2-linux-user
-  or1k-linux-user/all            - Build for or1k-linux-user
-  ppc64abi32-linux-user/all      - Build for ppc64abi32-linux-user
-  ppc64le-linux-user/all         - Build for ppc64le-linux-user
-  ppc64-linux-user/all           - Build for ppc64-linux-user
-  ppc-linux-user/all             - Build for ppc-linux-user
-  riscv32-linux-user/all         - Build for riscv32-linux-user
-  riscv64-linux-user/all         - Build for riscv64-linux-user
-  s390x-linux-user/all           - Build for s390x-linux-user
-  sh4eb-linux-user/all           - Build for sh4eb-linux-user
-  sh4-linux-user/all             - Build for sh4-linux-user
-  sparc32plus-linux-user/all     - Build for sparc32plus-linux-user
-  sparc64-linux-user/all         - Build for sparc64-linux-user
-  sparc-linux-user/all           - Build for sparc-linux-user
-  tilegx-linux-user/all          - Build for tilegx-linux-user
-  x86_64-linux-user/all          - Build for x86_64-linux-user
-  xtensaeb-linux-user/all        - Build for xtensaeb-linux-user
-  xtensa-linux-user/all          - Build for xtensa-linux-user
-
-Helper targets:
-  fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
-  scsi/qemu-pr-helper            - Build qemu-pr-helper
-  qemu-bridge-helper             - Build qemu-bridge-helper
-  vhost-user-gpu                 - Build vhost-user-gpu
-  virtiofsd                      - Build virtiofsd
-
-Tools targets:
-  qemu-ga                        - Build qemu-ga tool
-  qemu-keymap                    - Build qemu-keymap tool
-  elf2dmp                        - Build elf2dmp tool
-  ivshmem-client                 - Build ivshmem-client tool
-  ivshmem-server                 - Build ivshmem-server tool
-  qemu-nbd                       - Build qemu-nbd tool
-  qemu-storage-daemon            - Build qemu-storage-daemon tool
-  qemu-img                       - Build qemu-img tool
-  qemu-io                        - Build qemu-io tool
-  qemu-edid                      - Build qemu-edid tool
+  sparse                         - Run sparse on the QEMU source

 Cleaning targets:
   clean                          - Remove most generated files but keep
the config
@@ -105,7 +20,7 @@
   vm-help                        - Help about targets running tests
inside VM

 Documentation targets:
-  html info pdf txt              - Build documentation in specified format
+  html info pdf txt man          - Build documentation in specified format

   make [targets]                 - (quiet build, default)
   make V=3D1 [targets]             - (verbose build)
---

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893744

Title:
  meson: incomplete 'make help'

Status in QEMU:
  New

Bug description:
  Since the meson switch, 'make help' doesn't list various targets.

  Diff before/after:

  ---
   Generic targets:
     all                            - Build all
     dir/file.o                     - Build specified target only
     install                        - Install QEMU
     ctags/TAGS                     - Generate tags file for editors
     cscope                         - Generate cscope index
  -
  -Architecture specific targets:
  -  aarch64-softmmu/all            - Build for aarch64-softmmu
  -  alpha-softmmu/all              - Build for alpha-softmmu
  -  arm-softmmu/all                - Build for arm-softmmu
  -  avr-softmmu/all                - Build for avr-softmmu
  -  cris-softmmu/all               - Build for cris-softmmu
  -  hppa-softmmu/all               - Build for hppa-softmmu
  -  i386-softmmu/all               - Build for i386-softmmu
  -  lm32-softmmu/all               - Build for lm32-softmmu
  -  m68k-softmmu/all               - Build for m68k-softmmu
  -  microblazeel-softmmu/all       - Build for microblazeel-softmmu
  -  microblaze-softmmu/all         - Build for microblaze-softmmu
  -  mips64el-softmmu/all           - Build for mips64el-softmmu
  -  mips64-softmmu/all             - Build for mips64-softmmu
  -  mipsel-softmmu/all             - Build for mipsel-softmmu
  -  mips-softmmu/all               - Build for mips-softmmu
  -  moxie-softmmu/all              - Build for moxie-softmmu
  -  nios2-softmmu/all              - Build for nios2-softmmu
  -  or1k-softmmu/all               - Build for or1k-softmmu
  -  ppc64-softmmu/all              - Build for ppc64-softmmu
  -  ppc-softmmu/all                - Build for ppc-softmmu
  -  riscv32-softmmu/all            - Build for riscv32-softmmu
  -  riscv64-softmmu/all            - Build for riscv64-softmmu
  -  rx-softmmu/all                 - Build for rx-softmmu
  -  s390x-softmmu/all              - Build for s390x-softmmu
  -  sh4eb-softmmu/all              - Build for sh4eb-softmmu
  -  sh4-softmmu/all                - Build for sh4-softmmu
  -  sparc64-softmmu/all            - Build for sparc64-softmmu
  -  sparc-softmmu/all              - Build for sparc-softmmu
  -  tricore-softmmu/all            - Build for tricore-softmmu
  -  unicore32-softmmu/all          - Build for unicore32-softmmu
  -  x86_64-softmmu/all             - Build for x86_64-softmmu
  -  xtensaeb-softmmu/all           - Build for xtensaeb-softmmu
  -  xtensa-softmmu/all             - Build for xtensa-softmmu
  -  aarch64_be-linux-user/all      - Build for aarch64_be-linux-user
  -  aarch64-linux-user/all         - Build for aarch64-linux-user
  -  alpha-linux-user/all           - Build for alpha-linux-user
  -  armeb-linux-user/all           - Build for armeb-linux-user
  -  arm-linux-user/all             - Build for arm-linux-user
  -  cris-linux-user/all            - Build for cris-linux-user
  -  hppa-linux-user/all            - Build for hppa-linux-user
  -  i386-linux-user/all            - Build for i386-linux-user
  -  m68k-linux-user/all            - Build for m68k-linux-user
  -  microblazeel-linux-user/all    - Build for microblazeel-linux-user
  -  microblaze-linux-user/all      - Build for microblaze-linux-user
  -  mips64el-linux-user/all        - Build for mips64el-linux-user
  -  mips64-linux-user/all          - Build for mips64-linux-user
  -  mipsel-linux-user/all          - Build for mipsel-linux-user
  -  mips-linux-user/all            - Build for mips-linux-user
  -  mipsn32el-linux-user/all       - Build for mipsn32el-linux-user
  -  mipsn32-linux-user/all         - Build for mipsn32-linux-user
  -  nios2-linux-user/all           - Build for nios2-linux-user
  -  or1k-linux-user/all            - Build for or1k-linux-user
  -  ppc64abi32-linux-user/all      - Build for ppc64abi32-linux-user
  -  ppc64le-linux-user/all         - Build for ppc64le-linux-user
  -  ppc64-linux-user/all           - Build for ppc64-linux-user
  -  ppc-linux-user/all             - Build for ppc-linux-user
  -  riscv32-linux-user/all         - Build for riscv32-linux-user
  -  riscv64-linux-user/all         - Build for riscv64-linux-user
  -  s390x-linux-user/all           - Build for s390x-linux-user
  -  sh4eb-linux-user/all           - Build for sh4eb-linux-user
  -  sh4-linux-user/all             - Build for sh4-linux-user
  -  sparc32plus-linux-user/all     - Build for sparc32plus-linux-user
  -  sparc64-linux-user/all         - Build for sparc64-linux-user
  -  sparc-linux-user/all           - Build for sparc-linux-user
  -  tilegx-linux-user/all          - Build for tilegx-linux-user
  -  x86_64-linux-user/all          - Build for x86_64-linux-user
  -  xtensaeb-linux-user/all        - Build for xtensaeb-linux-user
  -  xtensa-linux-user/all          - Build for xtensa-linux-user
  -
  -Helper targets:
  -  fsdev/virtfs-proxy-helper      - Build virtfs-proxy-helper
  -  scsi/qemu-pr-helper            - Build qemu-pr-helper
  -  qemu-bridge-helper             - Build qemu-bridge-helper
  -  vhost-user-gpu                 - Build vhost-user-gpu
  -  virtiofsd                      - Build virtiofsd
  -
  -Tools targets:
  -  qemu-ga                        - Build qemu-ga tool
  -  qemu-keymap                    - Build qemu-keymap tool
  -  elf2dmp                        - Build elf2dmp tool
  -  ivshmem-client                 - Build ivshmem-client tool
  -  ivshmem-server                 - Build ivshmem-server tool
  -  qemu-nbd                       - Build qemu-nbd tool
  -  qemu-storage-daemon            - Build qemu-storage-daemon tool
  -  qemu-img                       - Build qemu-img tool
  -  qemu-io                        - Build qemu-io tool
  -  qemu-edid                      - Build qemu-edid tool
  +  sparse                         - Run sparse on the QEMU source

   Cleaning targets:
     clean                          - Remove most generated files but keep
  the config
  @@ -105,7 +20,7 @@
     vm-help                        - Help about targets running tests
  inside VM

   Documentation targets:
  -  html info pdf txt              - Build documentation in specified form=
at
  +  html info pdf txt man          - Build documentation in specified form=
at

     make [targets]                 - (quiet build, default)
     make V=3D1 [targets]             - (verbose build)
  ---

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893744/+subscriptions


Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC069C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798DB20663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhHjjAh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798DB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENMi-0005RZ-EC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENLJ-0003sF-C3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENLI-0000Mt-6D
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENLI-0000Kc-22
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584494275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n3vXWA71thEPHzEm/7ME7X4i4ktgY7bp3bBJMm9AakA=;
 b=KhHjjAh3rn74ECtJa13PAR74MPI+iLDNF8WBCh6O3JJ1EzzrlktFdj8Lc0pr/+amxsvB7j
 UKwF9JhHuYSQb1DOFdNLGernmjkw7sIreCisDoGDPUwRzsuafdC6cT1hlmdj0RBsE550t/
 tjl/345e/UAv++DgwVzZX5+3ZXp0rnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-nlGzVTuAPmiKO899HvhA2A-1; Tue, 17 Mar 2020 21:17:51 -0400
X-MC-Unique: nlGzVTuAPmiKO899HvhA2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAD0107ACC9;
 Wed, 18 Mar 2020 01:17:50 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E68D8AC30;
 Wed, 18 Mar 2020 01:17:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/13] x86 and machine queue for 5.0 soft freeze
Date: Tue, 17 Mar 2020 21:17:35 -0400
Message-Id: <20200318011748.2104336-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17=
:=0D
=0D
  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into sta=
ging (2020-03-17 18:33:05 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request=0D
=0D
for you to fetch changes up to 3c6712eca07255803b61ca3d632f61a65c078c36:=0D
=0D
  hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids (2020-03=
-17 19:48:10 -0400)=0D
=0D
----------------------------------------------------------------=0D
x86 and machine queue for 5.0 soft freeze=0D
=0D
Bug fixes:=0D
* memory encryption: Disable mem merge=0D
  (Dr. David Alan Gilbert)=0D
=0D
Features:=0D
* New EPYC CPU definitions (Babu Moger)=0D
* Denventon-v2 CPU model (Tao Xu)=0D
* New 'note' field on versioned CPU models (Tao Xu)=0D
=0D
Cleanups:=0D
* x86 CPU topology cleanups (Babu Moger)=0D
* cpu: Use DeviceClass reset instead of a special CPUClass reset=0D
  (Peter Maydell)=0D
=0D
----------------------------------------------------------------=0D
=0D
Babu Moger (7):=0D
  hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs=0D
  hw/i386: Introduce X86CPUTopoInfo to contain topology info=0D
  hw/i386: Consolidate topology functions=0D
  machine: Add SMP Sockets in CpuTopology=0D
  hw/i386: Remove unnecessary initialization in x86_cpu_new=0D
  hw/i386: Update structures to save the number of nodes per package=0D
  hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids=0D
=0D
Dr. David Alan Gilbert (1):=0D
  machine/memory encryption: Disable mem merge=0D
=0D
Moger, Babu (2):=0D
  i386: Add missing cpu feature bits in EPYC model=0D
  i386: Add 2nd Generation AMD EPYC processors=0D
=0D
Peter Maydell (1):=0D
  cpu: Use DeviceClass reset instead of a special CPUClass reset=0D
=0D
Tao Xu (2):=0D
  target/i386: Add Denverton-v2 (no MPX) CPU model=0D
  target/i386: Add new property note to versioned CPU models=0D
=0D
 hw/core/cpu.c                      |  19 +---=0D
 hw/core/machine.c                  |   9 ++=0D
 hw/i386/pc.c                       |  53 +++++----=0D
 hw/i386/x86.c                      |  51 +++++----=0D
 include/hw/boards.h                |   2 +=0D
 include/hw/core/cpu.h              |   6 -=0D
 include/hw/i386/topology.h         | 113 +++++++++----------=0D
 include/hw/i386/x86.h              |   3 +=0D
 scripts/coccinelle/cpu-reset.cocci |  47 ++++++++=0D
 softmmu/vl.c                       |   1 +=0D
 target/alpha/cpu-qom.h             |   2 +-=0D
 target/arm/cpu-qom.h               |   2 +-=0D
 target/arm/cpu.c                   |   8 +-=0D
 target/cris/cpu-qom.h              |   2 +-=0D
 target/cris/cpu.c                  |   8 +-=0D
 target/hppa/cpu-qom.h              |   2 +-=0D
 target/i386/cpu-qom.h              |   2 +-=0D
 target/i386/cpu.c                  | 174 +++++++++++++++++++++++++----=0D
 target/i386/cpu.h                  |   3 +=0D
 target/lm32/cpu-qom.h              |   2 +-=0D
 target/lm32/cpu.c                  |   8 +-=0D
 target/m68k/cpu-qom.h              |   2 +-=0D
 target/m68k/cpu.c                  |   8 +-=0D
 target/microblaze/cpu-qom.h        |   2 +-=0D
 target/microblaze/cpu.c            |   8 +-=0D
 target/mips/cpu-qom.h              |   2 +-=0D
 target/mips/cpu.c                  |   8 +-=0D
 target/moxie/cpu.c                 |   7 +-=0D
 target/moxie/cpu.h                 |   2 +-=0D
 target/nios2/cpu.c                 |   8 +-=0D
 target/nios2/cpu.h                 |   2 +-=0D
 target/openrisc/cpu.c              |   8 +-=0D
 target/openrisc/cpu.h              |   2 +-=0D
 target/ppc/cpu-qom.h               |   2 +-=0D
 target/ppc/translate_init.inc.c    |   8 +-=0D
 target/riscv/cpu.c                 |   7 +-=0D
 target/riscv/cpu.h                 |   2 +-=0D
 target/s390x/cpu-qom.h             |   2 +-=0D
 target/s390x/cpu.c                 |   8 +-=0D
 target/sh4/cpu-qom.h               |   2 +-=0D
 target/sh4/cpu.c                   |   8 +-=0D
 target/sparc/cpu-qom.h             |   2 +-=0D
 target/sparc/cpu.c                 |   8 +-=0D
 target/tilegx/cpu.c                |   7 +-=0D
 target/tilegx/cpu.h                |   2 +-=0D
 target/tricore/cpu-qom.h           |   2 +-=0D
 target/tricore/cpu.c               |   7 +-=0D
 target/xtensa/cpu-qom.h            |   2 +-=0D
 target/xtensa/cpu.c                |   8 +-=0D
 tests/test-x86-cpuid.c             | 116 +++++++++++--------=0D
 50 files changed, 490 insertions(+), 279 deletions(-)=0D
 create mode 100644 scripts/coccinelle/cpu-reset.cocci=0D
=0D
--=20=0D
2.24.1=0D
=0D



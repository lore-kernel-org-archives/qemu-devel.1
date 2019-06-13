Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EAEC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AC320449
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AC320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRPq-0005vI-5S
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQpR-0001MO-5R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQpP-0001H5-5G
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQpO-0000im-Qm
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D915730BC58B;
 Thu, 13 Jun 2019 14:35:00 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 393DD1001B2B;
 Thu, 13 Jun 2019 14:34:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 16:34:26 +0200
Message-Id: <20190613143446.23937-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:35:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/20] hw/i386/pc: Do not restrict the
 fw_cfg functions to the PC machine
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Rob Bradford <robert.bradford@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is my take at salvaging some NEMU good work.
Samuel worked in adding the fw_cfg device to the x86-virt NEMU machine.
This series is inspired by NEMU's commit 3cb92d080835 [*] and adapted
to upstream style. The result makes the upstream codebase more
modularizable.
There are very little logical changes, this is mostly a cleanup
refactor.

Since v1:
- Addressed Li and MST comments

$ git backport-diff -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/20:[----] [-C] 'hw/i386/pc: Use unsigned type to index arrays'
002/20:[----] [-C] 'hw/i386/pc: Use size_t type to hold/return a size of =
array'
003/20:[----] [--] 'hw/i386/pc: Let e820_add_entry() return a ssize_t typ=
e'
004/20:[0008] [FC] 'hw/i386/pc: Add the E820Type enum type'
005/20:[----] [-C] 'hw/i386/pc: Add documentation to the e820_*() functio=
ns'
006/20:[----] [--] 'hw/i386/pc: Use e820_get_num_entries() to access e820=
_entries'
007/20:[0016] [FC] 'hw/i386/pc: Extract e820 memory layout code'
008/20:[----] [--] 'hw/i386/pc: Use address_space_memory in place'
009/20:[down] 'hw/i386/pc: Rename bochs_bios_init as more generic fw_cfg_=
arch_create'
010/20:[0009] [FC] 'hw/i386/pc: Pass the boot_cpus value by argument'
011/20:[0010] [FC] 'hw/i386/pc: Pass the apic_id_limit value by argument'
012/20:[0009] [FC] 'hw/i386/pc: Pass the CPUArchIdList array by argument'
013/20:[0008] [FC] 'hw/i386/pc: Let fw_cfg_init() use the generic Machine=
State'
014/20:[----] [--] 'hw/i386/pc: Let pc_build_smbios() take a FWCfgState a=
rgument'
015/20:[----] [--] 'hw/i386/pc: Let pc_build_smbios() take a generic Mach=
ineState argument'
016/20:[----] [--] 'hw/i386/pc: Rename pc_build_smbios() as generic fw_cf=
g_build_smbios()'
017/20:[----] [--] 'hw/i386/pc: Let pc_build_feature_control() take a FWC=
fgState argument'
018/20:[----] [--] 'hw/i386/pc: Let pc_build_feature_control() take a Mac=
hineState argument'
019/20:[----] [--] 'hw/i386/pc: Rename pc_build_feature_control() as gene=
ric fw_cfg_build_*'
020/20:[0132] [FC] 'hw/i386/pc: Extract the x86 generic fw_cfg code'
Do you want to view the diffs using meld? y/[n]:

Regards,

Phil.

[*] https://github.com/intel/nemu/commit/3cb92d080835ac8d47c8b713156338af=
a33cff5c

Philippe Mathieu-Daud=C3=A9 (20):
  hw/i386/pc: Use unsigned type to index arrays
  hw/i386/pc: Use size_t type to hold/return a size of array
  hw/i386/pc: Let e820_add_entry() return a ssize_t type
  hw/i386/pc: Add the E820Type enum type
  hw/i386/pc: Add documentation to the e820_*() functions
  hw/i386/pc: Use e820_get_num_entries() to access e820_entries
  hw/i386/pc: Extract e820 memory layout code
  hw/i386/pc: Use address_space_memory in place
  hw/i386/pc: Rename bochs_bios_init as more generic fw_cfg_arch_create
  hw/i386/pc: Pass the boot_cpus value by argument
  hw/i386/pc: Pass the apic_id_limit value by argument
  hw/i386/pc: Pass the CPUArchIdList array by argument
  hw/i386/pc: Let fw_cfg_init() use the generic MachineState
  hw/i386/pc: Let pc_build_smbios() take a FWCfgState argument
  hw/i386/pc: Let pc_build_smbios() take a generic MachineState argument
  hw/i386/pc: Rename pc_build_smbios() as generic fw_cfg_build_smbios()
  hw/i386/pc: Let pc_build_feature_control() take a FWCfgState argument
  hw/i386/pc: Let pc_build_feature_control() take a MachineState
    argument
  hw/i386/pc: Rename pc_build_feature_control() as generic
    fw_cfg_build_*
  hw/i386/pc: Extract the x86 generic fw_cfg code

 hw/i386/Makefile.objs        |   2 +-
 hw/i386/e820_memory_layout.c |  60 +++++++++++
 hw/i386/e820_memory_layout.h |  76 +++++++++++++
 hw/i386/fw_cfg.c             | 137 ++++++++++++++++++++++++
 hw/i386/fw_cfg.h             |   8 ++
 hw/i386/pc.c                 | 201 ++---------------------------------
 include/hw/i386/pc.h         |  11 --
 target/i386/kvm.c            |   1 +
 8 files changed, 291 insertions(+), 205 deletions(-)
 create mode 100644 hw/i386/e820_memory_layout.c
 create mode 100644 hw/i386/e820_memory_layout.h

--=20
2.20.1



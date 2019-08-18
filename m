Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADCC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 22:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66C92186A
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 22:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66C92186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzU6R-0002R8-LO
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 18:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzU4f-0000ZM-AP
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzU4e-0007xu-8l
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:54:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzU4e-0007xf-3w
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 18:54:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F411881343;
 Sun, 18 Aug 2019 22:54:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-33.brq.redhat.com [10.40.204.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 796D31C1;
 Sun, 18 Aug 2019 22:54:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 00:54:03 +0200
Message-Id: <20190818225414.22590-5-philmd@redhat.com>
In-Reply-To: <20190818225414.22590-1-philmd@redhat.com>
References: <20190818225414.22590-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Sun, 18 Aug 2019 22:54:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 04/15] hw/i386/pc: Rename bochs_bios_init as
 more generic fw_cfg_arch_create
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
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, kvm@vger.kernel.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bochs_bios_init() function is not restricted to the Bochs
BIOS and is useful to other BIOS.
Since it is not specific to the PC machine, and can be reused
by other machines of the X86 architecture, rename it as
fw_cfg_arch_create().

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Rename x86_create_fw_cfg() -> fw_cfg_arch_create() (MST)
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 68086cc0fc..6cb39883e8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -933,7 +933,7 @@ static void pc_build_smbios(PCMachineState *pcms)
     }
 }
=20
-static FWCfgState *bochs_bios_init(PCMachineState *pcms)
+static FWCfgState *fw_cfg_arch_create(PCMachineState *pcms)
 {
     FWCfgState *fw_cfg;
     uint64_t *numa_fw_cfg;
@@ -1600,7 +1600,7 @@ void pc_cpus_init(PCMachineState *pcms)
      * Limit for the APIC ID value, so that all
      * CPU APIC IDs are < pcms->apic_id_limit.
      *
-     * This is used for FW_CFG_MAX_CPUS. See comments on bochs_bios_init=
().
+     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_cre=
ate().
      */
     pcms->apic_id_limit =3D x86_cpu_apic_id_from_index(pcms,
                                                      ms->smp.max_cpus - =
1) + 1;
@@ -1854,7 +1854,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         option_rom_mr,
                                         1);
=20
-    fw_cfg =3D bochs_bios_init(pcms);
+    fw_cfg =3D fw_cfg_arch_create(pcms);
=20
     rom_set_fw(fw_cfg);
=20
--=20
2.20.1



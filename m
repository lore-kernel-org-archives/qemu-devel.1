Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A24EC31E49
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034A9206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034A9206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRgC-0005Su-84
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43279)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbQqf-0001yV-RU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbQqe-0002JK-N0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbQqe-0002H5-Ge
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5954FC074EE5;
 Thu, 13 Jun 2019 14:37:02 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DBA331001B2A;
 Thu, 13 Jun 2019 14:36:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 16:34:45 +0200
Message-Id: <20190613143446.23937-20-philmd@redhat.com>
In-Reply-To: <20190613143446.23937-1-philmd@redhat.com>
References: <20190613143446.23937-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 13 Jun 2019 14:37:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 19/20] hw/i386/pc: Rename
 pc_build_feature_control() as generic fw_cfg_build_*
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

Now that the pc_build_feature_control_file() function has been
refactored to not depend of PC specific types, rename it to a
more generic name.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0969efa87d..d96328d8db 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1521,8 +1521,8 @@ void pc_cpus_init(PCMachineState *pcms)
     }
 }
=20
-static void pc_build_feature_control_file(MachineState *ms,
-                                          FWCfgState *fw_cfg)
+static void fw_cfg_build_feature_control(MachineState *ms,
+                                         FWCfgState *fw_cfg)
 {
     X86CPU *cpu =3D X86_CPU(ms->possible_cpus->cpus[0].cpu);
     CPUX86State *env =3D &cpu->env;
@@ -1593,7 +1593,7 @@ void pc_machine_done(Notifier *notifier, void *data=
)
     acpi_setup();
     if (pcms->fw_cfg) {
         fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
-        pc_build_feature_control_file(MACHINE(pcms), pcms->fw_cfg);
+        fw_cfg_build_feature_control(MACHINE(pcms), pcms->fw_cfg);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
     }
--=20
2.20.1



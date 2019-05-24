Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F26C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C8B2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 06:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C8B2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49925 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU44Q-0007Px-5u
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 02:52:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3q5-0003iv-O0
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU3q4-0003fB-S8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU3q4-0003ei-N1
	for qemu-devel@nongnu.org; Fri, 24 May 2019 02:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06244309264D;
	Fri, 24 May 2019 06:38:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-235.brq.redhat.com [10.40.204.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D300C5B689;
	Fri, 24 May 2019 06:37:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 08:35:49 +0200
Message-Id: <20190524063553.5339-17-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-1-philmd@redhat.com>
References: <20190524063553.5339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 24 May 2019 06:38:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 16/20] hw/i386/pc: Rename pc_build_smbios() as
 generic fw_cfg_build_smbios()
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the pc_build_smbios() function has been refactored to not
depend of PC specific types, rename it to a more generic name.

Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a79b344eb5..2804c4dc1b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -886,7 +886,7 @@ static uint32_t x86_cpu_apic_id_from_index(unsigned i=
nt cpu_index)
     }
 }
=20
-static void pc_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
+static void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg)
 {
     uint8_t *smbios_tables, *smbios_anchor;
     size_t smbios_tables_len, smbios_anchor_len;
@@ -1586,7 +1586,7 @@ void pc_machine_done(Notifier *notifier, void *data=
)
=20
     acpi_setup();
     if (pcms->fw_cfg) {
-        pc_build_smbios(MACHINE(pcms), pcms->fw_cfg);
+        fw_cfg_build_smbios(MACHINE(pcms), pcms->fw_cfg);
         pc_build_feature_control_file(pcms);
         /* update FW_CFG_NB_CPUS to account for -device added CPUs */
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus)=
;
--=20
2.20.1



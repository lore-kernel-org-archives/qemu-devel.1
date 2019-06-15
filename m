Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D7C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543C02184C
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 16:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543C02184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcBIW-0005bt-C9
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 12:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAr9-00045t-8e
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAr7-00019l-Te
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAr2-0000oz-Ax; Sat, 15 Jun 2019 11:44:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B465F2F8BF4;
 Sat, 15 Jun 2019 15:44:30 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 753FE1001B05;
 Sat, 15 Jun 2019 15:44:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:45 +0200
Message-Id: <20190615154352.26824-17-philmd@redhat.com>
In-Reply-To: <20190615154352.26824-1-philmd@redhat.com>
References: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Sat, 15 Jun 2019 15:44:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 16/23] target/arm: Make arm_deliver_fault()
 static
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function is now only called within op_helper.c.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/internals.h | 3 ---
 target/arm/op_helper.c | 5 +++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 37ca493635..06e676bf62 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -767,9 +767,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
                       bool probe, uintptr_t retaddr);
 #endif
=20
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
-                       int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
-
 /* Return true if the stage 1 translation regime is using LPAE format pa=
ge
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx=
);
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index e43c99ebf0..63bce32810 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -127,8 +127,9 @@ static inline uint32_t merge_syn_data_abort(uint32_t =
template_syn,
     return syn;
 }
=20
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
-                       int mmu_idx, ARMMMUFaultInfo *fi)
+static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
+                                            MMUAccessType access_type,
+                                            int mmu_idx, ARMMMUFaultInfo=
 *fi)
 {
     CPUARMState *env =3D &cpu->env;
     int target_el;
--=20
2.20.1



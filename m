Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE55C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646A820989
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646A820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLwB-0005ux-M7
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpo-0008F8-UU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKpn-0006Oz-P5
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKpn-0006Jx-Jd
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E2E73086201;
 Tue,  2 Jul 2019 15:36:39 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D08481001E84;
 Tue,  2 Jul 2019 15:36:37 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:19 -0300
Message-Id: <20190702153535.9851-27-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 15:36:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 26/42] i386: Remove unused host_cpudef
 variable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable is completely unused, probably a leftover from
previous code clean up.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190625050008.12789-3-ehabkost@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8d5d34849c..35ecb4113c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3134,14 +3134,8 @@ static void max_x86_cpu_initfn(Object *obj)
         char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
         char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
         int family, model, stepping;
-        X86CPUDefinition host_cpudef = { };
-        uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
-
-        host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
-        x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
 
         host_vendor_fms(vendor, &family, &model, &stepping);
-
         cpu_x86_fill_model_id(model_id);
 
         object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
-- 
2.18.0.rc1.1.g3f1ff2140



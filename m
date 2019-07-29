Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9BEC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D57206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D57206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8Ed-0002iz-JH
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hs8Dw-0001lK-Nb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hs8Dv-0006qA-QE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hs8Dv-0006pS-LE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:10:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF619C09AD17;
 Mon, 29 Jul 2019 16:10:06 +0000 (UTC)
Received: from localhost (ovpn-116-93.gru2.redhat.com [10.97.116.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFC0E60856;
 Mon, 29 Jul 2019 16:10:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 13:09:59 -0300
Message-Id: <20190729160959.24364-2-ehabkost@redhat.com>
In-Reply-To: <20190729160959.24364-1-ehabkost@redhat.com>
References: <20190729160959.24364-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 29 Jul 2019 16:10:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/1] i386: Fix Snowridge CPU model name and
 features
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Paul Lai <paul.c.lai@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Lai <paul.c.lai@intel.com>

Changing the name to Snowridge from SnowRidge-Server.
There is no client model of Snowridge, so "-Server" is unnecessary.

Removing CPUID_EXT_VMX from Snowridge cpu feature list.

Signed-off-by: Paul Lai <paul.c.lai@intel.com>
Tested-by: Tao3 Xu <tao3.xu@intel.com>
Message-Id: <20190716155808.25010-1-paul.c.lai@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e3320f5e92..19751e37a7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2472,7 +2472,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (Icelake)",
     },
     {
-        .name = "SnowRidge-Server",
+        .name = "Snowridge",
         .level = 27,
         .vendor = CPUID_VENDOR_INTEL,
         .family = 6,
@@ -2490,7 +2490,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
         .features[FEAT_1_ECX] =
             CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
-            CPUID_EXT_VMX |
             CPUID_EXT_SSSE3 |
             CPUID_EXT_CX16 |
             CPUID_EXT_SSE41 |
-- 
2.18.0.rc1.1.g3f1ff2140



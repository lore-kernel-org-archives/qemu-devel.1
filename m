Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB40AC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75FCD208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcpV+/YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75FCD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWOk-0006Pv-KO
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNE-0004yS-MC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNC-0006hI-DC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWNB-0006eQ-Va
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587627252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftMZL3c3dNFKHuqGP/JAiTlnjJ0MT+zITksoR9a3Hzw=;
 b=bcpV+/YZv2TPcCi6hhEk/o0rda6vHiUGXbOgalrYP1OWatpdqzEwxZUiOo4ftIC6eqZyFv
 dT9TtEhWV5ARQ0exb+q1EDSmNGCZKW3LSKpKOjj5vZisoK/6pjRgSyOy2DsouJwguqT+qR
 4WnMh8fdX/oPN9nLifAxxZvVQBBEm2U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-5VZp4DJMME6eIxQAfvXomw-1; Thu, 23 Apr 2020 03:34:10 -0400
X-MC-Unique: 5VZp4DJMME6eIxQAfvXomw-1
Received: by mail-wr1-f70.google.com with SMTP id m5so2413973wru.15
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HPb6SwnFh8ABexhp3OhZw3mu416B1z3vNp3cw7rGJvA=;
 b=QijQRh1tNrL4qe6y2Ch91fKD2+ocDpT57LID436onQ/NDgnwRltJVmpAejOevfqK3m
 RBCo6CmH9JXw3ALGJYB3DzidAl4+ovGtTc2VFWbkga/PhbUnNzetS7b1662EiZaLFO/E
 4iDK6sGMVnHHZD205I7DCCNo6FxqXTypRDoPV+g4hv+6XtNhNxzu+5/OvVMZZIRMsocm
 rxTRx9JBxDOWQ43O1vFuu873P89Wv5mbYpjLwepiTrypjZjalCIg+2L+KKNiLbDru8d/
 tdgQ9fz3C0m9PL8ptx91nRniGkziklBmdhLmbzjYOaxw2uzka8m3mAfNRmYGs+W9QTAF
 S59w==
X-Gm-Message-State: AGi0PuaataEzXuKEjy5e/Y6rkVkr6PCclZOxS9dX3F+5ueEDHz3uvfDK
 NpfhdZFnZq23AvHibXs9Z6g7QUqLRQQFVwkvYjvNVaAgy23JRI1MrK5y+y0BAX2yh+zoxXRcP6W
 on/z4zrWIZgw0+GQ=
X-Received: by 2002:a05:6000:14c:: with SMTP id
 r12mr3271056wrx.62.1587627248997; 
 Thu, 23 Apr 2020 00:34:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9sE/vPhSTvKGJJcc+fsuJ6JGOnTd0L/OCtnUWSD+5t5x+xKjrmm4I05Yun8zM4kionu8RHg==
X-Received: by 2002:a05:6000:14c:: with SMTP id
 r12mr3271034wrx.62.1587627248737; 
 Thu, 23 Apr 2020 00:34:08 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p190sm2398798wmp.38.2020.04.23.00.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 00:34:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] target/arm: Restric the Address Translate write
 operation to TCG accel
Date: Thu, 23 Apr 2020 09:33:54 +0200
Message-Id: <20200423073358.27155-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423073358.27155-1-philmd@redhat.com>
References: <20200423073358.27155-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Under KVM these registers are written by the hardware.
Restrict the writefn handlers to TCG to avoid when building
without TCG:

      LINK    aarch64-softmmu/qemu-system-aarch64
    target/arm/helper.o: In function `do_ats_write':
    target/arm/helper.c:3524: undefined reference to `raise_exception'

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e9ea5d20f..dfefb9b3d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3442,6 +3442,7 @@ static CPAccessResult ats_access(CPUARMState *env, co=
nst ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
=20
+#ifdef CONFIG_TCG
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx)
 {
@@ -3602,9 +3603,11 @@ static uint64_t do_ats_write(CPUARMState *env, uint6=
4_t value,
     }
     return par64;
 }
+#endif /* CONFIG_TCG */
=20
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t v=
alue)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type =3D ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA=
_LOAD;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
@@ -3664,17 +3667,26 @@ static void ats_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
     par64 =3D do_ats_write(env, value, access_type, mmu_idx);
=20
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
=20
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type =3D ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA=
_LOAD;
     uint64_t par64;
=20
     par64 =3D do_ats_write(env, value, access_type, ARMMMUIdx_E2);
=20
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
=20
 static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo =
*ri,
@@ -3689,6 +3701,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env=
, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
+#ifdef CONFIG_TCG
     MMUAccessType access_type =3D ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA=
_LOAD;
     ARMMMUIdx mmu_idx;
     int secure =3D arm_is_secure_below_el3(env);
@@ -3728,6 +3741,10 @@ static void ats_write64(CPUARMState *env, const ARMC=
PRegInfo *ri,
     }
=20
     env->cp15.par_el[1] =3D do_ats_write(env, value, access_type, mmu_idx)=
;
+#else
+    /* Handled by hardware accelerator. */
+    g_assert_not_reached();
+#endif /* CONFIG_TCG */
 }
 #endif
=20
--=20
2.21.1



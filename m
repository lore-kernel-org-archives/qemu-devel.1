Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C6C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37D22075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ob69b3JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37D22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsrO-0005ND-OK
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoO-0000wD-3T
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoN-0007NK-GP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsoN-0007LR-3X
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMFN46GGJRGQBe/rYYHHm3lwuDss4tLS+w7l4aZddpQ=;
 b=Ob69b3JNJIcAnudEgSWXy2wp9EPlceo+q9763wIYBcks0f9Q/EMhXTzGomztgVbS+DynLv
 T+ADxmsEf9v/EVP6/Z264aCEqQA6R2Q6H1EIGmbnJBJje5iYYX2wP1fKsntmx0qinaUPBf
 Opl0dAqCd3QjFPKJDYU3rhzdCvRaUnk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-QbP3bM4lOXm6WTdX5T33ow-1; Tue, 21 Apr 2020 09:19:35 -0400
X-MC-Unique: QbP3bM4lOXm6WTdX5T33ow-1
Received: by mail-wr1-f71.google.com with SMTP id p16so7470949wro.16
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ae/4+1sN6db4JUzTalWSGb//t3m1oKTsE7xQyTnypSQ=;
 b=MzEIGQbfxbT2SfQ22eMLX+F92EsUmStTfq42Icx4kRg6TDSHrPRsL4tBWQWCnhz9aF
 UYCDy6hGtv0KG2EyNaD4S7T4HpvrWIJEXOoOsiEhF+yKVmovZUXZom4vZX5MW1Tq5+BG
 nzmgwDaeoAgYxxcIPLbRakg4VNSevch/1/KXwWlux7oKj/G1k61Awlz1561r8RVwesa0
 ZKAsjWkxq4IfDp9rTUgwzMQalVo5CvFK+pYeSGBGlPEkh2kOkC6v/u41rOiKeYZdAgiz
 U61saXgz9GVyvdVaJqCuWDookqoZWmhPkydGWylfSpx5Sy4zoPoJEH2GGtlt7lnHUKEs
 HBLw==
X-Gm-Message-State: AGi0PubiSyG9wq22C/pDQRBYXW8pbHFiqxq+Zh8oRoBFH/MRkyvTmuvx
 F/CF93sqzu/pI4RTgcMckCjvvkM0JA6uFJWqweqisrnguStB8ePAQaGm6lKDHetGSP1HbRiYkS5
 pcVBOZgOvv8sYroI=
X-Received: by 2002:a1c:154:: with SMTP id 81mr4819469wmb.48.1587475173853;
 Tue, 21 Apr 2020 06:19:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHPuElbADy4mspBGKtfKCwZM91kYTJTe3uodBw9u/qXg53Z5lnxWy+W/ZDj504BwBLoLYMkQ==
X-Received: by 2002:a1c:154:: with SMTP id 81mr4819454wmb.48.1587475173622;
 Tue, 21 Apr 2020 06:19:33 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t16sm4307074wrb.8.2020.04.21.06.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/arm: Restric the Address Translate write operation
 to TCG accel
Date: Tue, 21 Apr 2020 15:19:21 +0200
Message-Id: <20200421131926.12116-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421131926.12116-1-philmd@redhat.com>
References: <20200421131926.12116-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Better explanation:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg689388.html
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



Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A91C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B27D20753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I828Jxlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B27D20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsrh-0005tj-K2
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsob-0001Gt-Mx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsob-0007k3-2G
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsoa-0007ei-LJ
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfG1iMoMuVJK3ytJuPp4jkcsIuLSkap1NwXNvJU0GUg=;
 b=I828JxlhqWpiHP91/W7hiQrC6LAMtFc3NtNsNPvP35vH4iaD4u3AvfbjOwbknzOz985Qgc
 nhCcNblcZXup2Xr51VM0Dt9lzvY1C3MDzpQWHBN06+e8NSnYCKek1cvgblauU5tpV+YcxP
 Q9+Rt3ghqh57DiQBBOfMOc0cZHw8f9I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-W7h8QfvDPuSKiMbXVDAFFQ-1; Tue, 21 Apr 2020 09:19:49 -0400
X-MC-Unique: W7h8QfvDPuSKiMbXVDAFFQ-1
Received: by mail-wr1-f70.google.com with SMTP id m5so7459070wru.15
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A6xQD+3rOPF5ujK6YzLWEuyxUGl4uZx+Lu/2zv1O3wM=;
 b=kkJ1WflIoATLcfFHKzcPih8jQpk3HgVwsvKYJkiO3adOYC96oRhsQCXR37qen8qDJZ
 OGsjI9gNVm7ywGc1B/nUu8evBxLnPHJVXtn/qKs2tJ7XZZNcqMp7xgqSw4NumpMf67Pc
 Nr/NBG5DRNc77S7USORx6jSMIP2TeCBrtmL4alTIx+LAAR90pK4YNKj0NuLKIlpCjezC
 d0yRKHWgKeJYzcoEKBf3efVaCTKrymAQCa+U76FC64y5tVh7Xs8pd/7wZjsjNGyBQwO5
 9y7zhCZaoiaKiPV6alxkzPpwyvVMKkQDb451PnIsFw8/zhV99g+WXgsRcV3hzdvdIbWs
 JGrA==
X-Gm-Message-State: AGi0PuaOfjsj8UAuNBdLyQ+En/LHJp6kOJfyEJvCGrrRfKSfxyaDmFHA
 H9At4EAFA4CnKLbaAckvxIKktiu2YR0T6hf3w9kTHBE8FyUTc0roBaKIf11TNSj3wMGJU21qP8g
 9ts5W0lpq8m+EN74=
X-Received: by 2002:adf:aad4:: with SMTP id i20mr20368771wrc.47.1587475188189; 
 Tue, 21 Apr 2020 06:19:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQ45wjdIi2JB7mTGs5QgEoycKoGnml4/LCG6bAVS7Yhekx7ffdfLPkoBCKsiqu3f0PLxQrAQ==
X-Received: by 2002:adf:aad4:: with SMTP id i20mr20368754wrc.47.1587475187984; 
 Tue, 21 Apr 2020 06:19:47 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q184sm3549887wma.25.2020.04.21.06.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
Date: Tue, 21 Apr 2020 15:19:24 +0200
Message-Id: <20200421131926.12116-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421131926.12116-1-philmd@redhat.com>
References: <20200421131926.12116-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.c   | 8 +++-----
 target/arm/cpu64.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6c84e99a38..9023d9e2cf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2735,7 +2735,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "any",         .initfn =3D arm_max_initfn },
 #endif
 #endif
-    { .name =3D NULL }
 };
=20
 static Property arm_cpu_properties[] =3D {
@@ -2883,14 +2882,13 @@ static const TypeInfo idau_interface_type_info =3D =
{
=20
 static void arm_cpu_register_types(void)
 {
-    const ARMCPUInfo *info =3D arm_cpus;
+    size_t i;
=20
     type_register_static(&arm_cpu_type_info);
     type_register_static(&idau_interface_type_info);
=20
-    while (info->name) {
-        arm_cpu_register(info);
-        info++;
+    for (i =3D 0; i < ARRAY_SIZE(arm_cpus); ++i) {
+        arm_cpu_register(&arm_cpus[i]);
     }
=20
 #ifdef CONFIG_KVM
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e89388378b..5daafba937 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -733,7 +733,6 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
     { .name =3D "cortex-a72",         .initfn =3D aarch64_a72_initfn },
     { .name =3D "max",                .initfn =3D aarch64_max_initfn },
-    { .name =3D NULL }
 };
=20
 static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
@@ -839,13 +838,12 @@ static const TypeInfo aarch64_cpu_type_info =3D {
=20
 static void aarch64_cpu_register_types(void)
 {
-    const ARMCPUInfo *info =3D aarch64_cpus;
+    size_t i;
=20
     type_register_static(&aarch64_cpu_type_info);
=20
-    while (info->name) {
-        aarch64_cpu_register(info);
-        info++;
+    for (i =3D 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
+        aarch64_cpu_register(&aarch64_cpus[i]);
     }
 }
=20
--=20
2.21.1



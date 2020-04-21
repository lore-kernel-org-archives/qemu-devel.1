Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A9C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B620920753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F795fu0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B620920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQspy-0003Gx-UI
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoY-0001A7-6p
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoW-0007bx-E3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsoW-0007aO-09
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6lGB+gV2hrPr/0M/fUQbumiT1BIsGf5idBsThrgFcY=;
 b=F795fu0mDuImZx9/Utrf13J3gJjUgdNxAyMvtMZ1Gux2j9RMzzl9TyTQl5z7Sxrh9yTKw3
 7Hq262qjPtAmwQrEAa1Yh1gGHBuzpZbb0fW98aIdJsPxB5aSohlsfUl+3iPzM5tJopezF0
 KbIUoOrPDObPsH/tRAVh3+Qzun3OZ88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-SuwlQToxPCKUfQPuVICSlw-1; Tue, 21 Apr 2020 09:19:45 -0400
X-MC-Unique: SuwlQToxPCKUfQPuVICSlw-1
Received: by mail-wm1-f69.google.com with SMTP id b203so1353483wmd.6
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dS/vtbkAfNhRHkFDGLX+PdB0iniDOVA5vUlcTpqcra4=;
 b=daEyOaz9qakjmUgxRlJ/d0DP5o2SK77iwwIwfmiNhD74RYGczL9efNe4qmfbCz9MOg
 NUaMDsPtZMTrW0NJUSa43xktlyj16ioR+btiZC4RYvLyTGq7Y2JqDKU+Dy4ZrmTQZ7/e
 PxbJ3nPa5vjW4Xjv69kPPzbfriVfh7YKSvvcZ2HrfgOrmdS1/2AxLXe5TTsnY6BjpNOb
 2DlY0yxBZTauMvjXnG5sfEUWQw4T5h+A6jVFTwm4lJnE2/NcX/BLKaEqH2/+A0npwXNy
 Gv5lXlYgWfnhI8M5vEeqo7ZRQEa/GVUOeVRnrlUp//EgPo8EB1h41P4oxQ0Gq6BGZuRO
 P1uQ==
X-Gm-Message-State: AGi0Puanfygpv+qLqAl4usNo8Qc62+o/KR5fZtolUeBfGMyAgt/RFf7v
 blcuDpUEsWZ33ckLKYfSCIR6WoU0BtLJJpuQu8IzFmWe7i5+kRjXgzs5XGQxFclVhcGezTtx49u
 dqE2ZZpW/LFcZj7w=
X-Received: by 2002:a5d:640a:: with SMTP id z10mr18445528wru.280.1587475183474; 
 Tue, 21 Apr 2020 06:19:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypK4guldDk+QQqsJDxrv++UW6HSamXV9/89Lude0W71xIS6NLVELt9/oOzIjYYyfZYhVfagNog==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr18445510wru.280.1587475183303; 
 Tue, 21 Apr 2020 06:19:43 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m1sm3689226wro.64.2020.04.21.06.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/arm: Make cpu_register() available for other files
Date: Tue, 21 Apr 2020 15:19:23 +0200
Message-Id: <20200421131926.12116-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421131926.12116-1-philmd@redhat.com>
References: <20200421131926.12116-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:54:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Make cpu_register() (renamed to arm_cpu_register()) available
from internals.h so we can register CPUs also from other files
in the future.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Split Thomas's patch in two: set_feature (earlier), cpu_register]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu-qom.h |  9 ++++++++-
 target/arm/cpu.c     | 10 ++--------
 target/arm/cpu64.c   |  8 +-------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index d95568bf05..56395b87f6 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -35,7 +35,14 @@ struct arm_boot_info;
=20
 #define TYPE_ARM_MAX_CPU "max-" TYPE_ARM_CPU
=20
-typedef struct ARMCPUInfo ARMCPUInfo;
+typedef struct ARMCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+    void (*class_init)(ObjectClass *oc, void *data);
+} ARMCPUInfo;
+
+void arm_cpu_register(const ARMCPUInfo *info);
+void aarch64_cpu_register(const ARMCPUInfo *info);
=20
 /**
  * ARMCPUClass:
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37f18d1648..6c84e99a38 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2683,12 +2683,6 @@ static void arm_max_initfn(Object *obj)
=20
 #endif /* !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64) */
=20
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo arm_cpus[] =3D {
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
     { .name =3D "arm926",      .initfn =3D arm926_initfn },
@@ -2854,7 +2848,7 @@ static void cpu_register_class_init(ObjectClass *oc, =
void *data)
     acc->info =3D data;
 }
=20
-static void cpu_register(const ARMCPUInfo *info)
+void arm_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_ARM_CPU,
@@ -2895,7 +2889,7 @@ static void arm_cpu_register_types(void)
     type_register_static(&idau_interface_type_info);
=20
     while (info->name) {
-        cpu_register(info);
+        arm_cpu_register(info);
         info++;
     }
=20
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 622082eae2..e89388378b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -728,12 +728,6 @@ static void aarch64_max_initfn(Object *obj)
                         cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
 }
=20
-struct ARMCPUInfo {
-    const char *name;
-    void (*initfn)(Object *obj);
-    void (*class_init)(ObjectClass *oc, void *data);
-};
-
 static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a57",         .initfn =3D aarch64_a57_initfn },
     { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
@@ -816,7 +810,7 @@ static void cpu_register_class_init(ObjectClass *oc, vo=
id *data)
     acc->info =3D data;
 }
=20
-static void aarch64_cpu_register(const ARMCPUInfo *info)
+void aarch64_cpu_register(const ARMCPUInfo *info)
 {
     TypeInfo type_info =3D {
         .parent =3D TYPE_AARCH64_CPU,
--=20
2.21.1



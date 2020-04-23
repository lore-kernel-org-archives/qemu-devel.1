Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFFC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E39208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gbpju5Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E39208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWP5-0006rZ-7G
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNO-00053l-WB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWNM-0006zH-My
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWNL-0006xf-Rn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587627262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7pM8Y9foGxY0KgmfhDIgQ7kPDhEiL45SUO11cYWEao=;
 b=Gbpju5VbFP6THXJlzGejRxeNZ/+fYEE8njY00kqCInjCbsdwqLQQCgXPhtjoxQ7i36p29n
 qCbkxAbjKzVADWA0eluaSo4/wnVk6kRzD0mIoWlZn1h6OcU/jK2+kaXfSmcB95OZtCCgbu
 zWycfeG78axJrg0GtUOCvJ72R9lto7w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-au5TuID8McqgR7bSpnMWjQ-1; Thu, 23 Apr 2020 03:34:21 -0400
X-MC-Unique: au5TuID8McqgR7bSpnMWjQ-1
Received: by mail-wm1-f71.google.com with SMTP id h22so1728782wml.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1CCEkWp7UjJNTmMA2CUtzCRavWKlDQWa9H1QWoyOCGE=;
 b=g61fqFH1/bsqGSN7Q+pzXaA9/Aufzjc0d/HC+CVzwvB3DTdilO1faqcMQRl5+19Tu6
 j2vbAMwwbR02WpJw5v3irTnthDqjpLNzAwWwz7/g6LLB0HWoSri3butkR6wMtVBIzH3i
 JEnAUG97J4Sm1XdYkG+8NrneyZoF3M8vAm/AwkfRkpvjcIUeEXby0eM9Ae6Fw1Db94wJ
 dRrzZxsydbZcM6DRlM96XD66n9QJWJc82aMrNeDvF+sGjXsUvCAwRZ0ieAVFuDCFygRK
 HPibyvTJew1ctr8eYbKtqdCoxY4E1b8N28zSunjRGae7hDw7pEqezBI0XeEZUJ4FKNbJ
 8Zvw==
X-Gm-Message-State: AGi0PuaARuXg2oJKUKBSnQsOLNM9ppbK4VCuT2kbr6EZYqH73RP6NSAm
 EImQi9VP28STs0pOdG13TfPayYYt9WJUebWGpDyv6ODEQXo5SjUuSgc5xlsQ9A0a7KekRaf7uNW
 DePmbM8q0Fid0gDI=
X-Received: by 2002:a5d:5085:: with SMTP id a5mr3546538wrt.394.1587627259697; 
 Thu, 23 Apr 2020 00:34:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKBFLalOrqBSCNmC+FxTMDeR8g5nNvEC+qS61TWAPpg8Jk0cE6Svp6xSWYIwVhMkeOVcIw43Q==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr3546518wrt.394.1587627259485; 
 Thu, 23 Apr 2020 00:34:19 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 185sm2674363wmc.32.2020.04.23.00.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 00:34:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
Date: Thu, 23 Apr 2020 09:33:56 +0200
Message-Id: <20200423073358.27155-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200423073358.27155-1-philmd@redhat.com>
References: <20200423073358.27155-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.c   | 8 +++-----
 target/arm/cpu64.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 47e35400da..30e961f775 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2745,7 +2745,6 @@ static const ARMCPUInfo arm_cpus[] =3D {
     { .name =3D "any",         .initfn =3D arm_max_initfn },
 #endif
 #endif
-    { .name =3D NULL }
 };
=20
 static Property arm_cpu_properties[] =3D {
@@ -2893,14 +2892,13 @@ static const TypeInfo idau_interface_type_info =3D =
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
index 951588c56e..ef9231d55b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -742,7 +742,6 @@ static const ARMCPUInfo aarch64_cpus[] =3D {
     { .name =3D "cortex-a53",         .initfn =3D aarch64_a53_initfn },
     { .name =3D "cortex-a72",         .initfn =3D aarch64_a72_initfn },
     { .name =3D "max",                .initfn =3D aarch64_max_initfn },
-    { .name =3D NULL }
 };
=20
 static bool aarch64_cpu_get_aarch64(Object *obj, Error **errp)
@@ -848,13 +847,12 @@ static const TypeInfo aarch64_cpu_type_info =3D {
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



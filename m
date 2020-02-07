Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8132C35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A212721741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YiwoQfh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A212721741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04lH-0007Ky-My
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hZ-00082D-Ku
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hY-0002An-Fr
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:49 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hY-00028r-64
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:33:48 -0500
Received: by mail-wm1-x342.google.com with SMTP id f129so3030280wmf.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wD5kKpZxds6KotN02B/ZZrgfLYdFxoUcA/v2ch/p7A4=;
 b=YiwoQfh6f3uKr3M/wxRQs2iJzdAo+peC48VJ7ITFU5Wa8+uuzuWzmiNt+X1z4k2wIh
 lDkWaYMfa2q1mDGzne5P9biJSRFvzPelchqrYZNHFGiw++eVcOYw55jZEc1teFG8qfj/
 77MeFXlwKnbawGLx3uMerS9j0TW+whhgK7optxoFp7zsSa6Ogj93Vqbymof2H69SiKRK
 yL3Fo6DFxLopsTaA7Z+cGV3RK2wemRoo7FMVa2TCiolFhsXssmc58xixFGk2NvmLiAOm
 JB+5uzgeScKsLuObpwhrPLyiTqYfHHfVM9D8Ru0s6mERrJ2EZzAmr4V1zhz6273CT3tw
 7b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wD5kKpZxds6KotN02B/ZZrgfLYdFxoUcA/v2ch/p7A4=;
 b=VSBNeCpTrwHmsYdcrRDd+ziDFgoXxdZrdWlVyyxOjHX45wDef3x4cHT7kgmc31+3eo
 plJBepi9cTnSnKdUhFMMbMbMGESoMcwtvZ1TI0Bou9HzHh8/t26Zps3Deku6n0M/YfnX
 SlPs3TKGYwqcmQvAW9PhZomxqlOiy+ttWJ12BTNouEzss3DJbCKrS/J4zLA8zXArVg1w
 iKTfCV77zKD+pNuSsf7F4MEsiTszqXPJ3ODAfayf4yeVRsX4DL26OyDUI+p17TVlbXeK
 R5uF8SQ+mYt+UV51YRU+Hi8Ih9ShnIPbIt7BybYlwZrg78ovPN7wUD1pYBrGnIzKmYzb
 prXQ==
X-Gm-Message-State: APjAAAXqak7U/j5MsGHTwR776Kdfu+U5u1SP78p4/rHXJE0BFtO24E8o
 PXjOcMZ/zMnvbi4ykTjx0RLKuF5o0r8=
X-Google-Smtp-Source: APXvYqzXycdDAV7dnl3rzwMVpUkZErqrmXhI9xfWq2BKQQ1gr70HoZtA5VR6lGyQ62M0uBHN/iWrIw==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr4524173wmm.97.1581086026761; 
 Fri, 07 Feb 2020 06:33:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:33:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/48] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
Date: Fri,  7 Feb 2020 14:32:56 +0000
Message-Id: <20200207143343.30322-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Liang Yan <lyan@suse.com>

Commit e19afd566781 mentioned that target-arm only supports queryable
cpu models 'max', 'host', and the current type when KVM is in use.
The logic works well until using machine type none.

For machine type none, cpu_type will be null if cpu option is not
set by command line, strlen(cpu_type) will terminate process.
So We add a check above it.

This won't affect i386 and s390x since they do not use current_cpu.

Signed-off-by: Liang Yan <lyan@suse.com>
Message-id: 20200203134251.12986-1-lyan@suse.com
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/monitor.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 9725dfff16d..c2dc7908de7 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -137,17 +137,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     }
 
     if (kvm_enabled()) {
-        const char *cpu_type = current_machine->cpu_type;
-        int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
         bool supported = false;
 
         if (!strcmp(model->name, "host") || !strcmp(model->name, "max")) {
             /* These are kvmarm's recommended cpu types */
             supported = true;
-        } else if (strlen(model->name) == len &&
-                   !strncmp(model->name, cpu_type, len)) {
-            /* KVM is enabled and we're using this type, so it works. */
-            supported = true;
+        } else if (current_machine->cpu_type) {
+            const char *cpu_type = current_machine->cpu_type;
+            int len = strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
+
+            if (strlen(model->name) == len &&
+                !strncmp(model->name, cpu_type, len)) {
+                /* KVM is enabled and we're using this type, so it works. */
+                supported = true;
+            }
         }
         if (!supported) {
             error_setg(errp, "We cannot guarantee the CPU type '%s' works "
-- 
2.20.1



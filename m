Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C31C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2A320757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oucdw6sK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7kU-0004Mm-BB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jM-0002ai-VL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jL-0000Jo-Sr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jL-0000Iw-El
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id u16so1541429wmc.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sMT/+tHHwir88ccyz19t7Y3T6ca9xpFk0IXaCH1jghA=;
 b=Oucdw6sKR7H6AI6GH+A7eUeRIpjxhVp2P8Lo0dN0OHdvGdhv49J/MfrYDAqb5Mssr5
 tYjb9kNcGmkj4VE189UstiJAjy8PNbauX8IwwdXmAmkf7gDTkxwrOnNdO221qVLVqiLz
 nR2RAIdAFmxpD1mqUDcSZDZjZGv2/B/HBZlZ9oYbIfk9fTFqiIKXEFznvTL1SYpxrhjZ
 UmFHuR6Jg5TpfzqmFhCNbjj3r8kDYXU6J8Za20Tb03JhbcTqab2JtRkoANT0ZV89UJG7
 geIwTiAc0uTgb9s/aR6iLsz9+RvJxsbVcPi3bcR2O59+KzVOdPpHfeJ4LOEjPemIxqrO
 V4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sMT/+tHHwir88ccyz19t7Y3T6ca9xpFk0IXaCH1jghA=;
 b=PxrXsn6d+Vfh+EC82x7rRRi+DVTJ3iFrou1JYK0tHZ1PXCTriMSFLyvclkHISDi5fN
 Byp9EXv3hNPslgpottXE6oMCT2BJLFpGqrfVOk7ioa8vlgWCrbK6t027Y42RSF0ldg1e
 X8MBSOg/wtPXaXUoFghFY0NMChtxmGu1cEm0btMYe///r1V1lgmugaki1dZWWGraOiYI
 8Pna3YXFOwgRKlZT0vWSh5Z06K0sm8rc+bfHM1vG96e5zgd1cWlKVS/yfy/IHaHDl7ms
 oiGCSGzWNbLZ0G+0obPyDJoXJWD9VR5zJ1mMH1ZXG5uFvXW6TevYVGN9S3sdEakMH/WT
 f1dA==
X-Gm-Message-State: AGi0PuZGd1BLdthUgluFHpsxwqmCZBK3Bg7XTB5YtAd60t/mU5/xuwZ0
 A40BywCovevZ96/bEkv1mMlIK5u0YTTMZA==
X-Google-Smtp-Source: APiQypICVtulZLxmFfTNYLJlfdYQGr1bBtL9mkMq2OYT6cSvYVWe4jtXFQLUcaQmidgjIdpsMFfucw==
X-Received: by 2002:a7b:c104:: with SMTP id w4mr2605509wmi.8.1588247509744;
 Thu, 30 Apr 2020 04:51:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/31] Typo: Correct the name of CPU hotplug memory region
Date: Thu, 30 Apr 2020 12:51:16 +0100
Message-Id: <20200430115142.13430-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::334
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

From: Keqian Zhu <zhukeqian1@huawei.com>

Replace "acpi-mem-hotplug" with "acpi-cpu-hotplug"

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-id: 20200413091552.62748-4-zhukeqian1@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/acpi/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index e2c957ce008..3d6a500fb7e 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -222,7 +222,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
         state->devs[i].arch_id = id_list->cpus[i].arch_id;
     }
     memory_region_init_io(&state->ctrl_reg, owner, &cpu_hotplug_ops, state,
-                          "acpi-mem-hotplug", ACPI_CPU_HOTPLUG_REG_LEN);
+                          "acpi-cpu-hotplug", ACPI_CPU_HOTPLUG_REG_LEN);
     memory_region_add_subregion(as, base_addr, &state->ctrl_reg);
 }
 
-- 
2.20.1



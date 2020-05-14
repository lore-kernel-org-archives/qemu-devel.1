Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AC920748
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qg/XkE4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AC920748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF0N-0001XK-UL
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkV-0003Up-F9
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkT-0005lI-Oe
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id v12so4315595wrp.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SakX2inMtJLZ1FmAb3OkCKDIGikkYphNK+yETDcbpHM=;
 b=Qg/XkE4WGLewrDWtFkQebk9jTmBxTDNVP4+a3ES8lVcUPFMxg8j151NdiLhmfnvK2q
 +DdQ40l1MUaoGQbIB9qPZIjVy0vGajCGPQAYJW5Rs4Z/uCorc8RaV+csgrWEUaEpMCUl
 reH+oC4CNVhJuvaWBwWKCBteyxUro/y0DBJi/GKwnolj1JyO+l+nZT4Wei/wfezY9Ydp
 B7zTNHrWfeIKJYIW00ysNuAzga8XvwBRX4c8qp+FoG/+gZOGASLkVwfJMYHjUdaPd8VG
 ZyEd28DZWXutH7ij/14RzqHOwSaG9e8vSD2rdSFO4XzUykQq4s9DV8JSNOHP07zoZDar
 bqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SakX2inMtJLZ1FmAb3OkCKDIGikkYphNK+yETDcbpHM=;
 b=TrZ/W5LEGdg7SJ7WSVcN6/LFUjOAGFPQfFamdryLUL1zdYvILtjAsQ+7fg4mSjAZVd
 Iyrt6lDDSon+69EmYGS4EsgKQWwly2SWewAywxqz6L6tRNrbgQezz1Vr0WHOKGCLi/fx
 3O/LIMHfTxH8xjjjJhQEpSEdvrlbEPSH/R6B1bQqnTLSR44YHUNT5EKc/VlRYgNyAMPh
 GUbZWAplJ5FlP8gr8xa0xAUVUKA/OsFScPZBq0bKt0WK+vghbmVnMeo3AlMNBUYbYQWX
 TMCxhUuPxzHmsd2rjR4xW7Fre0mOrtE8uvZcOz7jqFsJ/dfTO2axbDSUWXSxFSya/tez
 OI7A==
X-Gm-Message-State: AOAM533M0jnpTJR328xrhFSdhP3K5181yKx5bUENdYRksPW/W2TpZ49/
 AzDcjeAZJLbppKJGMG4PM69KFyqG3e9bMg==
X-Google-Smtp-Source: ABdhPJwl7pj4TAezAoDFxZn4KqdTWnjLAW+UDddobIcX7YJ0kARwlRKPpS/1Eu/pSLVAbjno/OG2CQ==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr6114251wrt.53.1589466127241; 
 Thu, 14 May 2020 07:22:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/45] hw/arm/virt: Introduce a RAS machine option
Date: Thu, 14 May 2020 15:21:13 +0100
Message-Id: <20200514142138.20875-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Dongjiu Geng <gengdongjiu@huawei.com>

RAS Virtualization feature is not supported now, so
add a RAS machine option and disable it by default.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200512030609.19593-3-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 6d67ace76e1..31878ddc722 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -132,6 +132,7 @@ typedef struct {
     bool highmem_ecam;
     bool its;
     bool virt;
+    bool ras;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 634db0cfe97..9e76fa7b01b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1995,6 +1995,20 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &vms->acpi, errp);
 }
 
+static bool virt_get_ras(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->ras;
+}
+
+static void virt_set_ras(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->ras = value;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2327,6 +2341,15 @@ static void virt_instance_init(Object *obj)
                                     "Valid values are none and smmuv3",
                                     NULL);
 
+    /* Default disallows RAS instantiation */
+    vms->ras = false;
+    object_property_add_bool(obj, "ras", virt_get_ras,
+                             virt_set_ras, NULL);
+    object_property_set_description(obj, "ras",
+                                    "Set on/off to enable/disable reporting host memory errors "
+                                    "to a KVM guest using ACPI and guest external abort exceptions",
+                                    NULL);
+
     vms->irqmap = a15irqmap;
 
     virt_flash_create(vms);
-- 
2.20.1



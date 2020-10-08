Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C71C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5DE221F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aK6AECMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5DE221F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYbJ-0007ki-CA
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQYYl-0006bt-Rc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kQYYj-0006Y4-Mh
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 12:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602173661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yGs8E2GCBOV45IEYSLzyQArDj7+rRBQC35wdokiL5VA=;
 b=aK6AECMswXguhi47/38bVji5dR5UKiCC1mM2fMMvyo35g/NdfABSju9SFZtYZv0aRiGcGN
 L4IjD+ost6nd9DndIu0f3RHnnPq222pFrc4wDY5jycosdHEKUgseXRn5uIPawL1W2ASssF
 FRIecVHFjSh6RMVZ1zikliMWD6kG7B0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-zBLmEqkuPWOB0DApxSUMPA-1; Thu, 08 Oct 2020 12:14:17 -0400
X-MC-Unique: zBLmEqkuPWOB0DApxSUMPA-1
Received: by mail-wm1-f70.google.com with SMTP id w23so3303157wmi.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 09:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yGs8E2GCBOV45IEYSLzyQArDj7+rRBQC35wdokiL5VA=;
 b=DSzAelgG6WmhU8uYfM9a67KpGodLBml1JbIryijRwWh9D1chOxAla2XLV5VSYAAU+U
 LrUCrIRTAa48psJ1/E7tAuLBFY229bHEOnx6FeOQFwJwhtXIwPbN2c48ZWAdaZwV6vXN
 /8FE0Guh6Vnobezqc3D5Udeu/6Gr9mwpics8mUvv1AvwQeDrscftp+etFuRUPxh+iHgo
 9qFVKEFYj73E+JxO3iFZiRNSyUlHYdxVycrsnB44Zw0Qrghz/R2U0dqdY+lyZMyfJJO1
 4znASzomHLH/n4uA71udrqmenBXfVBK8zFPYQbOdu/BSY+ybFWxeMMeNdAiFkr/IWnEy
 RdOQ==
X-Gm-Message-State: AOAM530HX0O9rfldk/gvJd2GaKR7RMWLGc8+RrC3CyDMl9VklSyzr/18
 4nbXmOwfwzxzRwop7Cwvuk+/JEmak2v3k4M0BDn2O0TmuU4dT2sDdg9rJqQvacYcUaBS1yYwfgf
 fmZSnRReVjD+NTzM=
X-Received: by 2002:a5d:4987:: with SMTP id r7mr9665170wrq.327.1602173656260; 
 Thu, 08 Oct 2020 09:14:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW5UjqRoc4/JlDJgb93TK8rx7+Of7BsQQsD2sCMFegYy7vSWbgwr9aVDgvGK5qIltZpxQXTQ==
X-Received: by 2002:a5d:4987:: with SMTP id r7mr9665152wrq.327.1602173656104; 
 Thu, 08 Oct 2020 09:14:16 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e18sm7929473wrx.50.2020.10.08.09.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 09:14:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
Date: Thu,  8 Oct 2020 18:14:14 +0200
Message-Id: <20201008161414.2672569-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While APEI is a generic ACPI feature (usable by X86 and ARM64), only
the 'virt' machine uses it, by enabling the RAS Virtualization. See
commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").

Restrict the APEI tables generation code to the single user: the virt
machine. If another machine wants to use it, it simply has to 'select
ACPI_APEI' in its Kconfig.

Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Rebased
v2: Reworded

Cc: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 default-configs/devices/arm-softmmu.mak | 1 -
 hw/arm/Kconfig                          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/devices/arm-softmmu.mak b/default-configs/devices/arm-softmmu.mak
index 9a94ebd0be..08a32123b4 100644
--- a/default-configs/devices/arm-softmmu.mak
+++ b/default-configs/devices/arm-softmmu.mak
@@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ALLWINNER_H3=y
-CONFIG_ACPI_APEI=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f303c6bead..7d040827af 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -26,6 +26,7 @@ config ARM_VIRT
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HW_REDUCED
     select ACPI_NVDIMM
+    select ACPI_APEI
 
 config CHEETAH
     bool
-- 
2.26.2



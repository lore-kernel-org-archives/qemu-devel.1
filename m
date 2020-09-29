Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F6C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF24E207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHNuZy/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFGR-0004oi-IT
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNFB4-0007Nf-1O
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNFB2-0003Fn-3F
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:56:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iguQs2kfsCnerdjWScTWC7qFlJXZ9V7uhuoxVsh48D8=;
 b=KHNuZy/oqkqaxQw4qxAhnUR2IjEc63Roe8a/RhXWHkunfbZ8IBsqUIf7sB2W+REPjk1eRv
 q+ikIOl8QnGXelm/fKiBDl78wxunUTLLWC4BNym1/fyZRYfV/6eNtMx9qr2IPm/kTpTQM1
 Hl2h7AO7u4JL+i12ELXbNMA5/VCfP2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-xgzwXCjaMXeKCigUrkE-Ng-1; Tue, 29 Sep 2020 08:56:13 -0400
X-MC-Unique: xgzwXCjaMXeKCigUrkE-Ng-1
Received: by mail-wm1-f72.google.com with SMTP id a11so1050326wmh.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iguQs2kfsCnerdjWScTWC7qFlJXZ9V7uhuoxVsh48D8=;
 b=f8TLBlvsLcZDuDALY3cvak8r5ctES+90Ars2LvIwzvWc3GcLa0ZRGVWopEB01jdSQy
 gQ9EzOa/SnsQ413kYEgLSIYBRe9O+TKfY4PKAG1ONI3ibu6BhXouDIK6Zi5V+zpH262S
 xfaCO+VM012X9fQgKe+C3Z7DsXm4Wa64QONoE5ZC8wSb8wzzgc8NIrJKneWKgkGiv/ti
 jS7FvL6tHFvXiVIVWwTiiSGgBIX6FwDuvVqM76lzhr/sndr+P3btC5vRjit0mOIcSINl
 9LBb4UO3ZNefvrRdyKQjIMgI5SpvvvMCxqNLXFE7Lkcdx/ZpeU2jUSHDn9KSeebOVowK
 /QqA==
X-Gm-Message-State: AOAM533aiajlqhKW1jJxt1Al7KiF3Fp9vHksV6TvPj2iZsshjIxtEKys
 rtPiY00TPJgd7R3HuzqxgpEpOz4JPAup4PlELrqlKdcaKmiZYbsuaPR2IoCLt5BPjH7cz0M3TM2
 8/OAKSJukVOCjeKY=
X-Received: by 2002:a7b:c453:: with SMTP id l19mr4207284wmi.163.1601384171908; 
 Tue, 29 Sep 2020 05:56:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY/ljyP/8XkyOUh4y71tr6Dg8Rj3L0vAoEHdBT7mtUKxjn+n3W8h0yq7tjPB/MZPTXoF5uhw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr4207263wmi.163.1601384171691; 
 Tue, 29 Sep 2020 05:56:11 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id n21sm5387913wmi.21.2020.09.29.05.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 05:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm: Restrict APEI tables generation to the 'virt' machine
Date: Tue, 29 Sep 2020 14:56:09 +0200
Message-Id: <20200929125609.1088330-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As only the Virt machine uses the RAS Virtualization feature (see
commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option"),
restrict the APEI tables generation code to the virt machine.

Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Xiang Zheng <zhengxiang9@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 default-configs/arm-softmmu.mak | 1 -
 hw/arm/Kconfig                  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 9a94ebd0be..08a32123b4 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
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



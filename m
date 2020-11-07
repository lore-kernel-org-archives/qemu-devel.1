Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B575C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A0D20888
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVVAF9Ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A0D20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMjG-0007zY-PQ
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMiN-0007Op-R2
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbMiM-00077p-6Q
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 06:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604749740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/C0KE97XuxcDYw99rga1UMIhoioSLQvSMLDL2QmOHmg=;
 b=gVVAF9TaKvMzj/zrttgZZT5wDHAg9KPUUlUFOzq4j9vCqJk+513hikboPpCWYApYBorknS
 wijwcFia8kIMDPXZUTtGcwjf9mk2Yr8N4C6nFRrJ8adX/Z4dxhsiv31uXKashxMb/+8wJk
 hLn0aDuD3HqK/fpujtzunmOeL22LPXQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-nnY6AwpwPqCcaX1T6UFTyA-1; Sat, 07 Nov 2020 06:48:56 -0500
X-MC-Unique: nnY6AwpwPqCcaX1T6UFTyA-1
Received: by mail-wr1-f69.google.com with SMTP id m20so1625884wrb.21
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 03:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/C0KE97XuxcDYw99rga1UMIhoioSLQvSMLDL2QmOHmg=;
 b=IObAr2UABGJvp6ekTYznF4+8vxoShwQwFwsFbeoE5IlZb2kLKrQymayzsX57p3BF9k
 s5R1DgVYFv1+EkDz8lyENmqbpU2ErN4Gq8oxNF7+DGYS8gbcZ+LeTH2A+dnl9KIHwG/S
 4qzmwhcuMYxNOijf0bvUhTX4Y6y6jfhWMDevPW/JQgeuJcUeDsJAer2udj0fPiV8se1V
 Qcad1TcPkX6JC3tKQFjOgVM4WumrPU3vPS6ymhBWNw8qh5bM925BtBmvJ4ZmarJhNQt5
 dBGg3aZwbtnTopOdsKfU62Lt7ZVanyIlEXYMtvGYXAg89ALYdvK9uButEpFe2xO/yFVB
 HEOw==
X-Gm-Message-State: AOAM532ZA/LglkgaU5Kg0C5J7oOW0LtOim9oumPRmRBATTCcDfejcX+R
 4WCB99K0ZssAtcEwedpFKVpL9WmYS2Z7lhk2zerQDyoUp5VgXHO30ZAqx04fIxBfa/sTTsthy2f
 inxR1p421q76sxKw=
X-Received: by 2002:a1c:9695:: with SMTP id y143mr4526566wmd.70.1604749735165; 
 Sat, 07 Nov 2020 03:48:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXVe23X3ju4HK2jDVWH45XgFlMbig6gtbyYyd+G9lJ8ohrGbm6LaLbG09W4udD/FzC8cffUg==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr4526549wmd.70.1604749735001; 
 Sat, 07 Nov 2020 03:48:55 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y20sm5982693wma.15.2020.11.07.03.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 03:48:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2] hw/arm/virt: Remove dependency on Cortex-A15
 MPCore peripherals
Date: Sat,  7 Nov 2020 12:48:52 +0100
Message-Id: <20201107114852.271922-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/07 03:59:37
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using a Cortex-A15, the Virt machine does not use any
MPCore peripherals. Remove the dependency.

Fixes: 7951c7b7c05 ("hw/arm: Express dependencies of the virt machine with Kconfig")
Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
RFC because there might be some odd use case I'm not aware of
    (like instantiating it via device tree?)
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fdf4464b948..e2e9cc36eb1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -6,7 +6,6 @@ config ARM_VIRT
     imply VFIO_PLATFORM
     imply VFIO_XGMAC
     imply TPM_TIS_SYSBUS
-    select A15MPCORE
     select ACPI
     select ARM_SMMUV3
     select GPIO_KEY
-- 
2.26.2



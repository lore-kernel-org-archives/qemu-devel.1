Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5C9208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUh+ol+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5C9208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlkoX-0007rC-D3
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 23:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlknI-00066B-7B
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:00:48 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlknD-0005Lv-Sa
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 23:00:47 -0400
Received: by mail-ej1-x644.google.com with SMTP id dr13so4791704ejc.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 20:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rn1IAhGNs9/upHthsg/8AavsULB5jQuIWRYuBoQ3LOY=;
 b=OUh+ol+dugq2GndhqF7B3H/BcKQc5A7wIV51rBVlJ7x4b3pmu4Jl/tZRDQGNZDTG13
 B4djqGWQHV/jubkqjH5x8GX4xYPPtyD/qXGPEBBq62cJX1Lqs8dkm7S9lAmKYKa0x/A5
 NS/3OEYgqD1CYxyxcN5qyhLa/MDVewGeuvFjVuCfgTdlAx4428Dx2+fogsqmvSbuugsJ
 f1YnnzFZ4C7zPMc6mt//3n3IhabG2r6g5SIlFrgkdDr0SG4TfscAcIe9RLgVjwOo1KCQ
 tJFcNdnWf9Iu2ndl8y9pE0S27v+WI/H6As0id74u4ZJxGE/fyt8IhN39etHRyst7wp+A
 G3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rn1IAhGNs9/upHthsg/8AavsULB5jQuIWRYuBoQ3LOY=;
 b=PCSIxNDNpV7QQ9at18odnfglCBuL47bOl9772mxwF2NjroY6HD4uCF3gCX2tnxglXA
 nEyspKHpBn5jNJe4hIlUD/LIM+6RhgBU6f6ROBZvpS5xgODvcY5iU9tSBhvZrJ37bG1t
 +dIV8V1o/kvMakNCcUBrAz8BkpRnpXgAX1sL17LD10z1acREJLqCIA7eESvOq+VLtfEQ
 CJj9tE/gEtfnbXSny7O67iwaEMqjkWd+9yXvsg2K91wBlPXVw31MLhqgiuZTQVGAuUJ1
 UQusysCXhsfGQq4YV519qMlScdSw0F5Ex008Utw5Mw/ki6b3xPyOj+MaTrILDaOleor6
 kTKQ==
X-Gm-Message-State: AOAM5317+OaopXWoe+PnZ+hERx0JeH4sxCAiXQpy110ujIQSAzLecDeH
 XhVbU2iKB91OiFCOUnXlHbgvRNbp/5o=
X-Google-Smtp-Source: ABdhPJyc5aPhDTIeXhuhTi08Wr15iVQABpC2ugiFH9Dl7DgVT4gAU3j3DD1RK+7iApAoeoE+Q1QSjw==
X-Received: by 2002:a17:906:5e0a:: with SMTP id
 n10mr1963392eju.274.1592449242165; 
 Wed, 17 Jun 2020 20:00:42 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 l18sm1034131eds.46.2020.06.17.20.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 20:00:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] i386: acpi: vmbus: Add _ADR definition
Date: Thu, 18 Jun 2020 06:00:26 +0300
Message-Id: <20200618030027.759594-3-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618030027.759594-1-arilou@gmail.com>
References: <20200618030027.759594-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems like latest HyperV sets _ADR to 0 in the ACPI for the VMBS

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 91af0d2d0d..6d9df38e31 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1061,6 +1061,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 
     dev = aml_device("VMBS");
     aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
+    aml_append(dev, aml_name_decl("_ADR", aml_int(0x0)));
     aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
     aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
-- 
2.24.1



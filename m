Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4746C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906AF2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ2GPuzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906AF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVrn-0006Z8-Px
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVqn-0005hu-3f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:43330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVqj-0005K1-6d
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:24 -0400
Received: by mail-ej1-x632.google.com with SMTP id l12so1825748ejn.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aWndGdqKa1SXKyQPqVUUIP7N2TD8jiKpi3mQeXOmyP4=;
 b=AQ2GPuzsHTqzdWni5s5QrcH5jcix2loohMgEFs0s1hFEh1HXwnjeoH2yhVbVwaYWP3
 YUMUjySxlhwxfh7XDfhnDnplpJKHJTexVIy118Ol9uwp5mkpCHFaqD0/NNACz2Y25JUb
 1SLR7BGnoxG72fTKnBl813L1KFC54Y45oEO/+Ju0a5kA2U07ZGZghOWCRhObrujkDrlG
 whyybPbuTbRsjDorQWfPl5XOjPQx0d4EqYtqdvo9waN2epuASPMexzy16X3i2G+vrIr4
 S4XTJ3kY8UoduKmh7Zqd6RkPGdo+yzsyVdpuPIIyf/ixo5Kfw9WFa9o1th78NUM/qGpQ
 W/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aWndGdqKa1SXKyQPqVUUIP7N2TD8jiKpi3mQeXOmyP4=;
 b=L90AyhktcyfeyfBbW81CK0W3Xcx29BUn++0qDuKj6Yj1FdOv7YjyW9YlTlmXScPBrN
 k9XmwbJVtkHj4CmdSbC5eVbBBbXuv7pPN+L7MhiCjj3l9txw6ogV9+BI5sGpaZgY2quG
 R198yza3haM0/7WukJkONDtcqUtiqbSh6gsHNDEBf1CwePafF9BD/dzfQl9ggHnfROsR
 dBprCD8+ZVxoZpGXULVf9rXHXUaNFDHL1KnBlXz0aBzhijYwlhX7JuB2WmrokKwfE9cu
 5HbjA2OyYLzNakSgl4XNqO9iTT9jK73IyEcZgDBjyDRWq7d2PBf9Reb+b6lRdh9X3/ei
 uaCA==
X-Gm-Message-State: AOAM530p/qcFDqHdkuOTe4rzz0LhjVhPT8bzhaidTh8k6if4OF/K6bg4
 +6BVpL1OGN4TJDZ6e6KUDwbibu8r
X-Google-Smtp-Source: ABdhPJwuciFZHnxFyuULjk3xpPQhZHmQZXHFQ2Xse4FreETfV68NLUuTZZHMXxyiAOxSUhwCnjFreg==
X-Received: by 2002:a17:906:3499:: with SMTP id
 g25mr6813904ejb.518.1592391799100; 
 Wed, 17 Jun 2020 04:03:19 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 dc8sm11835806edb.10.2020.06.17.04.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 04:03:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] hyperv: vmbus: Remove the 2nd IRQ
Date: Wed, 17 Jun 2020 14:03:02 +0300
Message-Id: <20200617110304.636666-2-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617110304.636666-1-arilou@gmail.com>
References: <20200617110304.636666-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x632.google.com
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

It seems like Windows does not really require 2 IRQs to have a
functioning VMBus.

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/vmbus.c                | 1 -
 hw/i386/acpi-build.c             | 2 --
 include/hw/hyperv/vmbus-bridge.h | 1 -
 3 files changed, 4 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f371240176..1a3738a03b 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2742,7 +2742,6 @@ static const VMStateDescription vmstate_vmbus_bridge = {
 
 static Property vmbus_bridge_props[] = {
     DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
-    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 900f786d08..dce680e97c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1083,8 +1083,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 
     crs = aml_resource_template();
     aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
-    /* FIXME: newer HyperV gets by with only one IRQ */
-    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
     return dev;
diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
index c0a06d832c..0369dabc03 100644
--- a/include/hw/hyperv/vmbus-bridge.h
+++ b/include/hw/hyperv/vmbus-bridge.h
@@ -20,7 +20,6 @@ typedef struct VMBusBridge {
     SysBusDevice parent_obj;
 
     uint8_t irq0;
-    uint8_t irq1;
 
     VMBus *bus;
 } VMBusBridge;
-- 
2.24.1



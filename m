Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56918C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18B32065E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="CtAL8nJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18B32065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQmY-0007Na-Jh
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhp-0001hW-Fi
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhn-0005lC-FI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id c3so2624572plz.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tX9XLbRzvavvjyMGPc0edB0FeNbRKcsKHFO3wqmL2TY=;
 b=CtAL8nJLWNFsdH7iXEqobHGm3zrCOJZYbETTxmud7Rnuf/1hcBvSnjWiv9EL8V72pz
 mFDduJd/FDvru8WvMnSdm9dLMLjSouH6mbG/4EKjc9o4nta56Xh9pFgMizWpgXIiTrwO
 UawBrCxo3hgpVT9pc87WBjZ0HKr4eRfPDp5GEUZvo/BacJxgc5JmItSLXs6K/ugw4jHk
 M8QE5O2/ugT7oQCqjsCoues4c++gBfWuckSWF+S2SErxOCbjUKLfpEOpgmMWUCkNZY0W
 tUKFK1v/a3eZA5W1VKXLwihSvNM5RD0tIWtY5AixlilHPPw79qJecRQtIsfhoghcVbUf
 1Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tX9XLbRzvavvjyMGPc0edB0FeNbRKcsKHFO3wqmL2TY=;
 b=a0/dKNFJ4GMw82F4xfoahyvoM5z0aLmuy6MezIEgoEIv+bIm/XsSUAV0Bw5IPzS3kI
 /8ibfSD6C6nbmhPtA5o26oMDhZTBau8rAS0XcBt7aje459/kzX995xiPu3BOY8SsJMpm
 3p507iURloyYDSZW9YH8WsbteT8wXOew2m6NG3QIuIMEYSoHgw/phPOa8+TEg+ixm2CV
 3qeqGkJxZyck/Bmdu50lOXY0hIju67r7r9L2ysWca0cDJQ0YXFSPD9tnGVvkiHx5nmgC
 cwBC/1d2fDJyBRTqhZSP1PuPSh2BV81vNSCMRjlWIeBTIQf8diwuB4JAZ+4uHqwa/NL5
 5NUw==
X-Gm-Message-State: AOAM531xFuxZQdVh0ECzXrE0Z5w9nduVxVaH6Qu8lr8ggeRxzQHk7AOV
 gu97F7jqAYtlAbyQ4ZemJh7RYvZfAkTQSOfp
X-Google-Smtp-Source: ABdhPJziqO7SF8PYcMidjTSWzmqJ2Byf0cFS5hDjHliajpEiCSIpuL4KXrHtJswzhGcf9ytZecwQeA==
X-Received: by 2002:a17:902:8c8c:b029:d1:cc21:9056 with SMTP id
 t12-20020a1709028c8cb02900d1cc219056mr11302303plo.22.1600236848628; 
 Tue, 15 Sep 2020 23:14:08 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:07 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/11] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
Date: Wed, 16 Sep 2020 11:43:28 +0530
Message-Id: <20200916061335.14045-5-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::643;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When ACPI hotplug for the root bus is disabled, the bsel property for that
bus is not set. Please see the following commit:

3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus").

As a result, when acpi_pcihp_find_hotplug_bus() is called
with bsel set to 0, it may return the root bus. This can cause devices attached to
the root bus to get hot-unplugged if the user issues the following set of commmands:

outl 0xae10 0
outl 0xae08 your_slot

Thanks to Julia for pointing this out here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

In this patch, we fix the issue in this function by checking if the bus which is
returned by the function is actually hotpluggable. If not, we simply return NULL.
This avoids the scenario where we were returning a non-hotpluggable bus.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

change log:
v1: initial patch
v4: commit log updated as per suggestion.

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 39b1f74442..32ae8b2c0a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -147,6 +147,21 @@ static PCIBus *acpi_pcihp_find_hotplug_bus(AcpiPciHpState *s, int bsel)
     if (!bsel && !find.bus) {
         find.bus = s->root;
     }
+
+    /*
+     * Check if find.bus is actually hotpluggable. If bsel is set to
+     * NULL for example on the root bus in order to make it
+     * non-hotpluggable, find.bus will match the root bus when bsel
+     * is 0. See acpi_pcihp_test_hotplug_bus() above. Since the
+     * bus is not hotpluggable however, we should not select the bus.
+     * Instead, we should set find.bus to NULL in that case. In the check
+     * below, we generalize this case for all buses, not just the root bus.
+     * The callers of this function check for a null return value and
+     * handle them appropriately.
+     */
+    if (find.bus && !qbus_is_hotpluggable(BUS(find.bus))) {
+        find.bus = NULL;
+    }
     return find.bus;
 }
 
-- 
2.17.1



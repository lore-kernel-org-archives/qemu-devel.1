Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2967DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54ABC208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="gEPZTwzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ABC208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC4s-0000bk-A6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxf-0001wV-S2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:43 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxe-0007pC-1U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id x18so2633207pll.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WIzwySGHusyyqcxBP6wP/5K/w/rrBhlYTKtBQXK9Uy8=;
 b=gEPZTwzfEBUMm8MsDL8BMR1jtqtY4dopFxjnzxzZoKDP3mGPXKlv7OJGEbGnELGE24
 N6E5vylxmCPdJN5EVUp0ZtA9JfKAckuV9SmkaodCRwy5Xa9k/wNiIwpgN4g5gwvfLG58
 gbHaB5Uw+Q8TDfYPPKSBwdYz2JuLenrxnoEY9ngt4FSi4ht7Xx4TM0ppsJ2a9oZ3ILiZ
 KWfoADTiHbSeXILiBqEfByMK4i/pISYvsYwMb1yHbPEh/cE+Ue3xJmru8iGiR1d19gIY
 n3W1T1EFSrbcsrR4nrBYVSzdA7Tlo17rlkqkiHKxLv07yN7F/lcV3kFATJavhi41hEYi
 QL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WIzwySGHusyyqcxBP6wP/5K/w/rrBhlYTKtBQXK9Uy8=;
 b=NLNnjrZnLklsH3rQ0rzH3tQ33xEVEhNZZ26rYWoaGcDb5tpDaaIRhqO92rEkVH88aD
 1k3cUmZe+5qShJk0xqOSglLCWnyifS11KvUDM2AaozqHYkflgRg6UUXx1zUOhm2GZr1A
 A9l7bUNJ88xwS+ECZoMk0CArJCeWXaP3WegdRKBQNnnyJAGrJmbrzyhS3teQwD1khJgm
 8BbX5U4kBX3m2c7qwwVxVQm/j0WxwRsU9xS4cmLPT0Q8kJxc2L0gKJHQsXUCwBzzl35c
 T+7aVszoEWY/FxWY1Iz2Odr17ySs13FYEI4qAuv5kc6tk2GEEjXMNI+FXdxCuDVm5WFK
 2jKw==
X-Gm-Message-State: AOAM530sP8QQHxNtG1wKIcchKPQGJUbFgemeiRRYXgW1Zj5wG0AWWWeM
 dPCYU7uuynzh1QdivuIRgedfzg==
X-Google-Smtp-Source: ABdhPJzcbc+tfxbtg8JkTBaZ1hQ/OKoQXZXk75NRf2SAaPlypDD9FGvGsQ0Ri2YIJeCOAHU+SQKvsg==
X-Received: by 2002:a17:90b:1b03:: with SMTP id
 nu3mr12030580pjb.148.1600418500767; 
 Fri, 18 Sep 2020 01:41:40 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:41:39 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 04/13] Fix a gap where acpi_pcihp_find_hotplug_bus()
 returns a non-hotpluggable bus
Date: Fri, 18 Sep 2020 14:11:02 +0530
Message-Id: <20200918084111.15339-5-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
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

3d7e78aa7777f ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus").

As a result, when acpi_pcihp_find_hotplug_bus() is called
with bsel set to 0, it may return the root bus. This can cause devices
attached to the root bus to get hot-unplugged if the user issues the following
set of commmands:

outl 0xae10 0
outl 0xae08 your_slot

Thanks to Julia for pointing this out here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734548.html

In this patch, we fix the issue in this function by checking if the bus which
is returned by the function is actually hotpluggable. If not, we simply return
NULL. This avoids the scenario where we were returning a non-hotpluggable bus.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/pcihp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

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



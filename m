Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AF9C2D0FA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E8D20740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ZdCui0vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E8D20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpEe-0003CY-8E
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jYpAk-0006cv-42
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:03:34 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:41355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jYpAh-0002Uy-TP
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:03:33 -0400
Received: by mail-lj1-x22b.google.com with SMTP id j3so17250885ljg.8
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2j5Ly7B4QEkKhIFgs8Zvw/iU8lv07rrrXczgDV4BzvY=;
 b=ZdCui0vUwWpZ/z3j8fuPlk79W5KHlweyi/tZ+xapLNt2JA+GLAhV60vUF/picQgREE
 JowfmdDAEscwXJjos0profgJvpSZHMQCiE+o+k9DLP9C6m/aoFqk2K01u6VZ/wXc+iKq
 WFh5yAStT55FH8YkLYMTPkEohWe1WHtyzfNMp4XVHcsu2E+jyDb8WxqMUsC0DjblsY18
 kcVJXb9tt8/1c10rPnfjVMsyzWXB2Xno13VnFYwPsZStRmHBlkIL3ZRiwqxNH/2thI8M
 IKHqO63Ob71MXKCmRdni6OfBF1ck14B071SQ5qfzd/3BpUhj2Wu+0Ds0NyR+RqTZQV6J
 Unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2j5Ly7B4QEkKhIFgs8Zvw/iU8lv07rrrXczgDV4BzvY=;
 b=q1lLFTDYSL+oHIzqu+AQkVuN6FHxSlZLkUn+RrjKdlyiULC4LCSnc/rpmH0AotUvv1
 l7ijWJWBXB1pgbziRCtU9kIKwl2zj9HEz3BiBkF6QtKiIm6R2EmA0ZjAbbQzMYSbv64C
 F4tvVO32CjXXDMqxxBxLiDVdeu9pR+yHFU1KC4erGPk99McNUCRMVH1NExXJXWRCchGs
 eqE2erwLkJX0MKdOR32/O+5HmWugSWLcKRX06Jvgnr+REahJDoAA4Em0XFoa13Stx3vi
 9o3RSrqDh7lLg6mdfajeWbKelaYcRlRQND8GOHnUdDogStp9LlXGCRvPH+Y1iAiQgwsT
 9mPw==
X-Gm-Message-State: AOAM530MaYeuzcb8SBkobuwA8RbTjlzW167r41YPl2zrkjLMN0pVKPXi
 D/34mCtb25OMRQVjTqnXEKHt+nEaVxDieQ==
X-Google-Smtp-Source: ABdhPJyPMClqem9jUToFXHTYDV1qO3aPCECH3I0Crkp+5gLkSoGBB709Lu6D1ZScCPXJplAEhFyB9Q==
X-Received: by 2002:a2e:740f:: with SMTP id p15mr16975590ljc.151.1589367809782; 
 Wed, 13 May 2020 04:03:29 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id s4sm12045991lja.14.2020.05.13.04.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 04:03:29 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] e1000e: Added ICR clearing by corresponding IMS bit.
Date: Wed, 13 May 2020 14:31:25 +0300
Message-Id: <20200513113125.1465650-2-andrew@daynix.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513113125.1465650-1-andrew@daynix.com>
References: <20200513113125.1465650-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
Added ICR clearing if there is IMS bit - according to the note by
section 13.3.27 of the 8257X developers manual.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/e1000e_core.c | 10 ++++++++++
 hw/net/trace-events  |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d5676871fa..10212d7932 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }
 
+    /*
+     * PCIe* GbE Controllers Open Source Software Developer's Manual
+     * 13.3.27 Interrupt Cause Read Register
+     */
+    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
+        (core->mac[ICR] & core->mac[IMS])) {
+        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], core->mac[IMS]);
+        core->mac[ICR] = 0;
+    }
+
     trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
     e1000e_update_interrupt_state(core);
     return ret;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e18f883cfd..46e40fcfa9 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
+e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
 e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
 e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
-- 
2.26.2



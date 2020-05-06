Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A368C47257
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674DB208CA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="0AqCEme1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674DB208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWR8r-00068l-Fi
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 16:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWR8B-0005eM-KU
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:59:03 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWR89-0002tM-Fh
 for qemu-devel@nongnu.org; Wed, 06 May 2020 16:59:03 -0400
Received: by mail-lj1-x242.google.com with SMTP id u6so3927461ljl.6
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lifhjNc/+8n2VeRbNRRf7UQgSm7/0C49Qt1x2LZG53U=;
 b=0AqCEme16Hil182ogtEBnTHYLdlkTG7QaL0yhBc7bYXenbc+aGjU1p8qm6fS5UA+9A
 WSgP4HVfyAyCimgj2pfq8RpQ2k1O69qHxdeoqUg9fNmAL2XNG5rKT+7peAJvqEWYEFPK
 kBtXKy/6cNsvMB899sIasJ0Yb6FoKgRbZzZg4+Ak4CyEZB/snspaKwcJQq9puvfsH/EA
 WfL42BFYSsnq/ZTLAszWuO64KD1iBuSZizxiYkdtzwoYKmaixKTS47rg2HEtPEhLPsRH
 iKilFmEpHasEW1qtEZwwRZEXJ3c5IcvJdICaUihZQn9CAJSnGjOeiGd8tVM/878QNCJj
 zBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lifhjNc/+8n2VeRbNRRf7UQgSm7/0C49Qt1x2LZG53U=;
 b=UjjSTff0OjAVgrJddfVfDPywvpGS7TJ6hLYdykUNwU6XPcX6tjckzdKrt3o6lV5ViA
 DxZgesFUzxiNuUIgEqpPUoYj0ftWSd78SC66IRk2V11nXaS3omXYHJji/cY48B7IJ6CO
 TqH6DGwFlwoZc8nZfXs6t26VycmlB0NmdTtpmb5EtIAUwbkTmjri/bPyEpB3yMk7R0JP
 pVP5AvKUeoS4okLMgatzq/9gRFxsNrrP+3o+yAOblMHbJhG8cEjcT6FDLDQYd0/WV4+I
 dPcyFY/X4WPj+conT+Sfc6ICPt3hhq/ExsiocCtXM0i0ltauUMaFf+g7zPVr37RXbs35
 ZNGw==
X-Gm-Message-State: AGi0PuYAMMoXmGMYjIs5FPJm/eIvXZhy2a4CcySS7DjYR2tiRD7+f78b
 fGXMGmHzkXHvJ1W5E9qCKD8spVIYvr9yug==
X-Google-Smtp-Source: APiQypJv3uwClEdISONl/cNqVeewtTY6PEvvPfuf9QPctPDCZ399LItUY08BymFUUmM2TcqQ12yqkw==
X-Received: by 2002:a2e:8603:: with SMTP id a3mr6341940lji.153.1588798738717; 
 Wed, 06 May 2020 13:58:58 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id u9sm2029468ljl.33.2020.05.06.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 13:58:57 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.
Date: Thu,  7 May 2020 00:26:45 +0300
Message-Id: <20200506212645.894533-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::242;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x242.google.com
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
 hw/net/e1000e_core.c | 9 +++++++++
 hw/net/trace-events  | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d5676871fa..302e99ff46 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }
 
+    /*
+     * PCIe* GbE Controllers Open Source Software Developer's Manual
+     * 13.3.27 Interrupt Cause Read Register
+     */
+    if (core->mac[ICR] & core->mac[IMS]) {
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
2.24.1



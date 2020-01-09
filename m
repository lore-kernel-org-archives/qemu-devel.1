Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F1EC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE0B2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz5hzgJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE0B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUM6-00019Y-Ju
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipUJe-0005qs-0Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipUJc-0006Ht-Hz
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:41:21 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipUJc-0006CL-81
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 04:41:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so6646785wrh.5
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 01:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9HunfxuiwkdWwxS85akSuSigAnmPoWzb6MKVNjBibIE=;
 b=lz5hzgJoz17g6ofXpwEcgGRNKmxBEV9tTyzyJGxDgcjwSa3p7q1jn4nug2dmC6liZx
 5cKnInOwVmqOQmTptccEXbwENisO0YLhi/A7WDT6wx+VbAOLMb/RNR0pe04Qb2iut8SR
 +SRX2jl77/zdDGuRxOkC8JgHeA9/3fUJPsXAtF8KNlo5fXuXh6M9xKnAyqgjp1FClwAd
 bO1PHX1849MW9/bGirGDIiMsrar48C/jj1Fcro6qU4dzcNQJl0A2+5GvG6kkhFMjUFqd
 x6CsxbJpY7rSUg77yVISn9uyCCSIfaGuNy7uezIf/WYgh43zMZva/filRuA94DlsI8px
 u6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9HunfxuiwkdWwxS85akSuSigAnmPoWzb6MKVNjBibIE=;
 b=It640TUp+SVCFoxcesdxx5SMWcKXztU+Qp1O+EKV+FME7VkaRAmXTOSEbZU/YXUSua
 Z9Pg5ahJWmUUEu/eXkBHvMXdDUU3Q+m1Xsl0EGfB6nRz1UJq0MjhvP4WEj2MnOR3/Xhy
 qPdRXQfw29r9KdDc2HjaTz4nsCqROdsGVSEsGuw+2K1ewD351y6cvpleWOHscaxEk016
 Dzt3wbNvo6QIC4mu2db0KqsCDTD3oTBc3I2xROTFlgX9xL0rJw2q2eEWJc4vowrs2Ian
 hGmRFsKjFnrD+6EovCSH4kHw61bxDqUjsC43sQl68QVZuvROzBHwMFS09agKeLlhUVgY
 3yIg==
X-Gm-Message-State: APjAAAUcimDdPuqrO5OMAdAHVRY7i2h9+KM20Uryg9q+y9mvSkB2sMbx
 7TO32vXCxnnoxivOWcZw1Yt2FQ3M
X-Google-Smtp-Source: APXvYqymkDPuSU4unKcsEyWcbrZ0Vai0lakR6LfKnPkhDENri8RQoutbcvsC4fDc+CWh2esHP47RbA==
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr9266107wrx.253.1578562878555; 
 Thu, 09 Jan 2020 01:41:18 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id g18sm2138894wmh.48.2020.01.09.01.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 01:41:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hyperv: set priority for SynIC pages
Date: Thu,  9 Jan 2020 10:41:17 +0100
Message-Id: <20200109094117.16237-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On PC systems, system memory is organized like this:

- priority -1 is the PCI BARs

- priority 0 is the RAM

- priority 1 pokes holes in RAM whenever PCI BARs should appear instead
  (for example due to SMRAM or PAM configuration), plus it contains RAM
  regions in RAM mode (again toggled by PAM configuration).

(SMRAM for CPUs in SMM has "infinite" priority since it is added in a
completely different address space).

SynIC memory regions are overlaid on top of memory, so they should have
the highest priority except for SMRAM.  Implement this by giving them
priority 2.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index da8ce82725..dc8d3b31c3 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -53,8 +53,8 @@ static void synic_update(SynICState *synic, bool enable,
                                         &synic->msg_page_mr);
         }
         if (msg_page_addr) {
-            memory_region_add_subregion(get_system_memory(), msg_page_addr,
-                                        &synic->msg_page_mr);
+            memory_region_add_subregion_overlap(get_system_memory(), msg_page_addr,
+                                                &synic->msg_page_mr, 2);
         }
         synic->msg_page_addr = msg_page_addr;
     }
@@ -64,8 +64,8 @@ static void synic_update(SynICState *synic, bool enable,
                                         &synic->event_page_mr);
         }
         if (event_page_addr) {
-            memory_region_add_subregion(get_system_memory(), event_page_addr,
-                                        &synic->event_page_mr);
+            memory_region_add_subregion_overlap(get_system_memory(), event_page_addr,
+                                                &synic->event_page_mr, 2);
         }
         synic->event_page_addr = event_page_addr;
     }
-- 
2.21.0



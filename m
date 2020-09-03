Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E548C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319B2206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtR+DsnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319B2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwgk-0004yn-B2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLQ-00041s-9A; Thu, 03 Sep 2020 17:00:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLI-0007eN-Q8; Thu, 03 Sep 2020 17:00:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id t76so4498753oif.7;
 Thu, 03 Sep 2020 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8SgwdOy9TwvppyJLuavJtnAY1UT8MfcLqFjl3hAfheE=;
 b=jtR+DsnKOXbw7HYmPgw/LCA9u5flrRRuKZI+D3AGFyf6IMJ5EmaHIY2vrnQ1tafp7U
 h122r/JJ7dM2R1DlYEQcWGYxNT7jB63moP5iqXwnxJQCCTI4tPJL/BeLvFOAU/Se/NfC
 0xeEGYnI6SUkxhn2z9z0fRdMhpU5uqn7wYQmGqk1T45x4QjWasU/4KIqOm+ae8kE3RSF
 tp5ugjsZ2G8IhiwWymQbfC1VD4ZqsDfGtOURXzJDtRcyMhZd1I+TmEG0Hye3xYBeHPBI
 V/2p0JI1SZfjvrhYdyTnfeL/ay9B0pY8Y80fr5BHV4eMMN70ALE3ARoRy3mZVHJ2I+0H
 8oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8SgwdOy9TwvppyJLuavJtnAY1UT8MfcLqFjl3hAfheE=;
 b=Sc6hrkRMhdtH1fA8BHOkXbKm9A6P4p2p1fADvDwUk62Ah5kaz4GlMWlKKlDVj5cpBe
 ZxDHXnAFNcUsVBDUDIk4ZfqGcyz8hCOaNEsf6F40W2jKl099mKoHEKWwKkqcHC2gfhFV
 TV0B5/MS9YQFtpZU7ScbZoAdZgcxaq58kbTr6DvtQSDK4Yg6O1u5J+DCW3g1eVdvV6/X
 eunBv62cwVKQ1wHIuPKqNR9Vxe8LzOAvaexoxrdg9JlwykkfdDMFyyVERTwqLY38uYLm
 QsagFUliBdjV537D4AjcqiFoYJ+21XZ/2i8Bmwz3LydErdebSP6lLdbhPzH9BCNyAnDd
 EaOA==
X-Gm-Message-State: AOAM530ycTQGQEsJj/nLr6GFSgVl8fMIaVnPuzbt1gRf+BbJGCd0lbdk
 +BbiVkSZQFOmTi+zB+KNufc7jwzLA6g=
X-Google-Smtp-Source: ABdhPJwZ5cIu4iVoHE7fuxkAlz0CmRduev7XP90zHcvdRve34Dv00ENhoeNm7IpRvo5asLwe7YAocQ==
X-Received: by 2002:aca:db0b:: with SMTP id s11mr3290990oig.161.1599166821506; 
 Thu, 03 Sep 2020 14:00:21 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 91sm792953otn.18.2020.09.03.14.00.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:20 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/77] acpi: accept byte and word access to core ACPI registers
Date: Thu,  3 Sep 2020 15:58:50 -0500
Message-Id: <20200903205935.27832-33-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Tokarev <mjt@tls.msk.ru>

All ISA registers should be accessible as bytes, words or dwords
(if wide enough).  Fix the access constraints for acpi-pm-evt,
acpi-pm-tmr & acpi-cnt registers.

Fixes: 5d971f9e67 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
Fixes: afafe4bbe0 (apci: switch cnt to memory api)
Fixes: 77d58b1e47 (apci: switch timer to memory api)
Fixes: b5a7c024d2 (apci: switch evt to memory api)
Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
Buglink: https://bugs.debian.org/964793
BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
BugLink: https://bugs.launchpad.net/bugs/1886318
Reported-By: Simon John <git@the-jedi.co.uk>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit dba04c3488c4699f5afe96f66e448b1d447cf3fb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/acpi/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 45cbed49ab..d85052c34a 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -461,7 +461,8 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_evt_ops = {
     .read = acpi_pm_evt_read,
     .write = acpi_pm_evt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -530,7 +531,8 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_tmr_ops = {
     .read = acpi_pm_tmr_read,
     .write = acpi_pm_tmr_write,
-    .valid.min_access_size = 4,
+    .impl.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
@@ -602,7 +604,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps acpi_pm_cnt_ops = {
     .read = acpi_pm_cnt_read,
     .write = acpi_pm_cnt_write,
-    .valid.min_access_size = 2,
+    .impl.min_access_size = 2,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 2,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
-- 
2.17.1



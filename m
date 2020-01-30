Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62514206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hz+/JARD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62514206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCdC-0004WO-Gn
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUA-0005nb-SY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU9-0003DL-1m
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU8-0003Al-2s
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id g17so4828095wro.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gSLa+L8UHN8Zul6cdyurNAj3S1KEuk+YWX46WL96ynQ=;
 b=hz+/JARDrqZVsZNA29lVrQU3hCtuYg/Ib3X/X4YuHMgLnHukq6y16o/+SxkoCEIOKk
 3bGhGpaXwgmdq/SURP2etf5ymBR3aqgyUIwI6oZdhwKiQkSZzAb/wW65aHFvi3dEzMFr
 iiW4/uZxpI+Zk3xIs/Bbt34yuucq48tEeqt6X1N66YB5qAqHHc4QI9LA8xoov21l3hXH
 /UNn387K5aVbprooVm1pJLGs+CThXJbXAsWjM2pqppAuyagbWKFJGPGwVjKv62Bmc6Vd
 8K291f8xA4Mb0GUQRszEa+/gBOKA6uBvs7ewvITgVl/cf/yMDCeofyjeGfFo/oK8RHPg
 NcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gSLa+L8UHN8Zul6cdyurNAj3S1KEuk+YWX46WL96ynQ=;
 b=dbB4wwIpf83C1NaQjdw2pbiGYOgkd8B6PxjYnRVXkXpsSyRCJ97TqXT8N6oWnIHvLY
 svsI5NOKaQ4E0HhjfLDQJwk3Xin3wbIUQ+jzzDV49oNJ0PgfEfjX6moD+4zpBY0kFAfM
 6Iqo9fqoPz9JC0sUc4GybRjBmEkHwzcQr7rhhYNC0l62euRclgKH/z26LKkvpL5iD9wB
 mTzQ0R9A+NUOk1d+SOUw5RFZ7PSqriPz23/iJuR+poJsqjyTFzCTo73JJb3lVPev3VaH
 aLYYEA/t/SIbRbWrKTihARfSiZOn2eklfYU/tzLnyQHywgLQyKoE8ZfAGN0KVl9IKLHK
 n54g==
X-Gm-Message-State: APjAAAX/ztTmvQWsaClGrUxqI3SZb8Yq9n2EAlshw9qqir5sVEWkjyK8
 L740CjPcK3EbmG7xXKgRgsxS0BejY70FHw==
X-Google-Smtp-Source: APXvYqz9wkuvQmCsM7Q68u1crBLeZijzo2ujTn+Ln/vmpu4tDIMeVMWttPkXcBfmMhk8v3Ii+HQqGg==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr6801677wrm.219.1580400962838; 
 Thu, 30 Jan 2020 08:16:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/26] hw/arm/virt: Add missing 5.0 options call to 4.2 options
Date: Thu, 30 Jan 2020 16:15:29 +0000
Message-Id: <20200130161533.8180-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200120101023.16030-3-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 656b0081c2c..91d4b838b2e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2153,6 +2153,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
 
 static void virt_machine_4_2_options(MachineClass *mc)
 {
+    virt_machine_5_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 DEFINE_VIRT_MACHINE(4, 2)
-- 
2.20.1



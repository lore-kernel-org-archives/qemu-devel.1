Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A003CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50236218AE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUpnIJVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50236218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMubV-0001zd-Bi
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHQ-0003RC-17
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHO-0001Ye-UH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33287)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHO-0001YO-Ny
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id 6so3707781wmf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5lY7u62vI3+XxTunjo9vzWs8Uh4wfjIbh9S8L0HAuyI=;
 b=YUpnIJVdO6DVIbNG7gztL2UKLuTluVGPT5dZVuHXeqW22Nabtsfzs7SJSphwMf3Q3K
 SXM7gFBmGc0GlRBXyydypmQ9YSIMtZogEmly1Kq4cMEmZWT+1HRp1w4luYmo2Ae1O4I5
 8HIqjwBOhdJOgoTydEOYonGds+0HSL08K2vB8kIMCigQW+uXfTr5pnrjgFQiL+qduo9e
 ad1eGCkxZ1litqXZzLiZ/GaGcZFv0hjoIfkLprSwXhiDnT9IKr4Iyff/TITdQUXrLudy
 obTmxblWnIPsTq2CiHpG4sa2eibyzJ8OkpxLNSNdy8BLqyTazZUqJVypPwZldsnP4lta
 geIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5lY7u62vI3+XxTunjo9vzWs8Uh4wfjIbh9S8L0HAuyI=;
 b=aPz3K17CX1JUKMoDOgooIXvnaw6gyGDxAMsuAtafEYULOfwHeaf/sUPAx97n4Q09NX
 KZ6bGL0YMXFsxLSZqgZmJgo35Nw5kVF4IkeCuaDDf9MPdOgyU3l6/TPvQUE6/PPsUS/q
 Ho2Ksfgap7btLrB9PtRyAa4wUfkr8Ff60vcOJfvhQolzcmW1KU/6Daun9eWfTv4kpXYf
 1QDicaNGC/Ky9KekcLb+UB6qAcposRXrj29G9kMbrhxqf7whDHNerWRsn3brdEJoIo0S
 G1Sdw60Ii9K9YQGGP+HgtpDMIAqrEgwiPVUmRvKaTM32omDDE7G0ag8yelEs0Ep+rl/r
 egHA==
X-Gm-Message-State: APjAAAU+HksDiGLsHyTAH4GRvt/1Ksh2JXrJ+NmSmiP1yyeyZorQ5bC6
 piLloxxhEODoZp5e4ITopJEx9LPFtm0=
X-Google-Smtp-Source: APXvYqxN9qPuyM9ryWGtcGXi2+1fTh4qGE9WPNQvWPRj+P/k1LI5RPQ1QxvHR6dqd8VYjxvmx3FTNQ==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr3296553wmb.168.1571751172991; 
 Tue, 22 Oct 2019 06:32:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC
 functions
Date: Tue, 22 Oct 2019 14:31:26 +0100
Message-Id: <20191022133134.14487-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This file keeps the various QDev blocks separated by comments.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-id: 20191005154748.21718-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e08ec3e3985..82ec5c1b4a4 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1532,6 +1532,8 @@ static const TypeInfo sdhci_bus_info = {
     .class_init = sdhci_bus_class_init,
 };
 
+/* --- qdev i.MX eSDHC --- */
+
 static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
@@ -1734,7 +1736,6 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     }
 }
 
-
 static const MemoryRegionOps usdhc_mmio_ops = {
     .read = usdhc_read,
     .write = usdhc_write,
-- 
2.20.1



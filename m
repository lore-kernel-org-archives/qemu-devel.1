Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275AE2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CE2dzmYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275AE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF3Z-0006i2-94
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkf-0003Y0-8C
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:21 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:50462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkd-0005zB-1I
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id m12so25712670wmc.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qdOEMhxxvT6hbl7Fu0qDZqIxDI9xAolUTrRMAN8HlCw=;
 b=CE2dzmYR88uTDt/cuhSNBTP/cZ75uNRuE4ulNE8j3mka0zE45CsERDhWCitTA4UGmg
 jdX71aZyX4iPaY41JqpASrNXlFe/Y6BgZDHyXXyjQdxen4/q6Ya9UEOA+V/NQP2K12UL
 QiNVnN8F7CAv4D4RRAdQS5RK0UUgDz8ymGK/cKesjSOaZ9jZEb1sCTlvsDFLDFHQRjqN
 On174IQrw8mz5l8diezselRDT3sOOYdOvGoXFIjcCpzMeG03W54QGlaT7Jc26zQr0oN7
 8p8GvcZC3WNlW36aVRjTBzGjzLv49oXxp9OKZHP5K6gWHPe8RbedRDJ0vMTNu0/4KGlj
 Lqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qdOEMhxxvT6hbl7Fu0qDZqIxDI9xAolUTrRMAN8HlCw=;
 b=A3m35EHBYJfThBi5KS7lf+mZmNNiZung/2jBLaIH5unneITv5yMf+GYzShjPo+8QTh
 gdelEWtY1N4PNpUAMhZngotFzBHTO7VSEKjf6xIugf6CZw2EpfmEOabgtgAnIo8yaz6c
 tZCviaXj3EinW9ajAlpgtYgUV3NMsTx4QKhMh8LzCazs9MBwALT0Uv65GTmQtHy2gvwY
 CBIT7i5wLwtAySoKJ5taaUZwnsjnLUsZ/fBjcWKepnOttJylGwkW87Ip9O3WSBWIfLys
 0MOoJihsFnbrHWBpc1ek+L2gpQFh3QZSbpJt3FhRcTQUdRt58BDFBObax+iarhwU6USE
 2dZg==
X-Gm-Message-State: AGi0PuY6ZA3u+92uDZlUu3opfg4y679n6uGPeFUCcYoAOqyc5uzqmen/
 zNcfLsQw6l5iJqMNGZ0iYhKUVR4dJHnfkA==
X-Google-Smtp-Source: APiQypJVBxb+Rura5s3TU9T1xzpvQvlhn0NIaA5u01TXcFQ+ecM/mn9/4+A9wz7ZilWFyHJdj/jHbQ==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr47245775wmj.169.1589466137391; 
 Thu, 14 May 2020 07:22:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/45] MAINTAINERS: Add ACPI/HEST/GHES entries
Date: Thu, 14 May 2020 15:21:21 +0100
Message-Id: <20200514142138.20875-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

I and Xiang are willing to review the APEI-related patches and
volunteer as the reviewers for the HEST/GHES part.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200512030609.19593-11-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 005ee98a59f..f972e12bfdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1516,6 +1516,15 @@ F: tests/qtest/bios-tables-test.c
 F: tests/qtest/acpi-utils.[hc]
 F: tests/data/acpi/
 
+ACPI/HEST/GHES
+R: Dongjiu Geng <gengdongjiu@huawei.com>
+R: Xiang Zheng <zhengxiang9@huawei.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/acpi/ghes.c
+F: include/hw/acpi/ghes.h
+F: docs/specs/acpi_hest_ghes.rst
+
 ppc4xx
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-- 
2.20.1



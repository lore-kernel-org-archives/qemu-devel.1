Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD45A224F9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5nhTuii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD45A224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLT2-0005hV-5Z
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRt-00042l-GZ; Tue, 14 Jul 2020 09:58:21 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRs-0003Qa-65; Tue, 14 Jul 2020 09:58:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so21818291wrv.9;
 Tue, 14 Jul 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CfEDbVfF7kj/yGhqKmfevoqL1P6U47hn56zU8XjW1QI=;
 b=J5nhTuii1pZsU1Sqv6Y+C1OndYYy/sdGDHt+WzmO8Q8uvDD94Nq0Eawm/8m/+Cd0nW
 QoXtUYxlPSDI5mHmKWWWt10UcxctzLqHdA1Tq6wyhRskSF4UzLZxxd2vM84k9CzHl0sJ
 6yUzNsE51tST+yA4L8t0JQnByFNQRqdIuAzXQHLMLkLd2NdEA0eRyWBa5JIr9uCNMZcv
 Jr5YBbXwRAAunViqfxd7xxDvSdxS57WqCjOJjoaG273gkEDDA0z/DyrnSA+QGCQvID6V
 NSQWiprt9tUrSRIJKvBBm2W79XO4GvVkgGrsKcofFSQ3OVbByebkn8dEWPemT4gCA2Bz
 ibLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CfEDbVfF7kj/yGhqKmfevoqL1P6U47hn56zU8XjW1QI=;
 b=A9o7xDU4eXuxhyHsjaaUgexPZKnCsyJxEt+6+Ul/pf0FLByj4080ReqbeSn36EpL+y
 3wVajtTk2CB1KgL6k/Q5ZFedZuMbWMJwbx4cfvG4Hl0OkNNLe9biyZLqgvVqOgYgEgjm
 bF8wFsiDPUv2m0fdDZsFrpex2R1cmTr7liovn+PaCHde/SBm8nsToLPc0m5rNVBbg2Y7
 ahuqQugHjUv/Za7w/f16SYDc9u8zZZp+gN2Yq31kYJujGsamuyu4xDIRPqB7TPQyFyVG
 5mtv4ap3ibJCn0QhfsDZyMXSBqAYgIQSGwnRgIGNvyWe6ZVJJMbzmpOFIXFJ+8d54gRb
 g1jg==
X-Gm-Message-State: AOAM530iOeULwABth3p2N5n63m5nnyMGtRXSRfKB4KSv5OtFrkMAei79
 lYVrYdctwpHbpNm0wDygO6wto3fFXVg=
X-Google-Smtp-Source: ABdhPJzLIq6JuWT2lBax6hgxA46MWr4Majslvkci68+NGExI+C0teqtwYqAHSV+QOt27hvNt5kHnoQ==
X-Received: by 2002:a5d:424f:: with SMTP id s15mr6077364wrr.342.1594735098182; 
 Tue, 14 Jul 2020 06:58:18 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] MAINTAINERS: Cc qemu-block mailing list
Date: Tue, 14 Jul 2020 15:58:06 +0200
Message-Id: <20200714135814.19910-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We forgot to include the qemu-block mailing list while adding
this section in commit 076a0fc32a7. Fix this.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200630133912.9428-2-f4bug@amsat.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe8139f367..d9c71d0bb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1674,6 +1674,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
 F: hw/sd/core.c
-- 
2.21.3



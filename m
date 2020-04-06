Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE6C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532DC2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOTaqpwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532DC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOn0-0003TC-3D
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjs-0006oB-Jd
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOji-0002g5-Fv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOji-0002fD-9V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id h15so16686682wrx.9
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=c6ExD2X3dcz39DGT8m+VPmBHG2joiEfEyC25pZS66FA=;
 b=DOTaqpwIB1CAM2f39AnxbIyj6+33v2qPR0V28uC1RWqtslsOqYr5Tc/zAr2wqVI3Lf
 BL1Fb6Df+K15erLciRgvG/D8+H2qZEeO1jQKPwNxo5wPCl0REp2lgifZMeMHBTq/S2s0
 +7KjxYZ//X4xDFUAnYCxaSdycFFkJprmtnCx6IizP52V5C3qoDs5UJToAArIsQz4ZJ/e
 nlp4ZGz+TpxM29WG338qGT7nQU2YkzJ/0LGQcbqJkSmoEj5Mkg1ufRv3HNrhT1VuAJfM
 Cgf6BhKZ9Wl858P/vEovCrYUmaRQw76qja/JHG0DZZJayL685r/usuc4PPxo9b0kjJPa
 BMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c6ExD2X3dcz39DGT8m+VPmBHG2joiEfEyC25pZS66FA=;
 b=DLh31y4yJbAVmX/d64sG9eyARY0OhnD/0mUKax48ouKeLRQn4/2LRXSPKZSB4xuxd0
 LeyJQ3dezkC3wsE49JzDvGHlcesCuid0O97X4ypG5XXqi4yiKMeY4X5JZyk00AmVMA06
 oHG6Ttl+dCJ0gBydAFLzzimaEXNMi/o6j9bvQudjP2Mj3yiOr2TU5ayyYgnaURZSNXvS
 tJCm395OHxGq3rOCN0t9vC1ZMFIPCYfublFaBw6EsYRRNPJ69VBCrXC2vKmYSa92L1Je
 XP61bN6Y5i5qWSW4qZ7L1AJewSasTGzDY6C2tjloy54uFk6mRuN759GIsVKmNwruvqkP
 7xGQ==
X-Gm-Message-State: AGi0PuYUbwuvw8qgt4sp3hIn1U9nmR5dkI5tSfl+P6vwzwoCZwdJ1aAp
 tkgbD4m+Oehv2nX5R7EvrB3V9DFnMLZULQ==
X-Google-Smtp-Source: APiQypI3bY8gXArc+U8L7W4dCEZVpbrUxwuCbR7Q74lBCRCsue1hNEjJtaKz568lfvcsXANrIaJ81g==
X-Received: by 2002:a5d:5707:: with SMTP id a7mr19360994wrv.108.1586167928812; 
 Mon, 06 Apr 2020 03:12:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] target/arm: don't expose "ieee_half" via gdbstub
Date: Mon,  6 Apr 2020 11:11:55 +0100
Message-Id: <20200406101205.23027-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

While support for parsing ieee_half in the XML description was added
to gdb in 2019 (a6d0f249) there is no easy way for the gdbstub to know
if the gdb end will understand it. Disable it for now and allow older
gdbs to successfully connect to the default -cpu max SVE enabled
QEMUs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200402143913.24005-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/gdbstub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index d9ef7d2187c..8efc535f2a0 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -192,7 +192,12 @@ static const struct TypeSize vec_lanes[] = {
     /* 16 bit */
     { "uint16", 16, 'h', 'u' },
     { "int16", 16, 'h', 's' },
-    { "ieee_half", 16, 'h', 'f' },
+    /*
+     * TODO: currently there is no reliable way of telling
+     * if the remote gdb actually understands ieee_half so
+     * we don't expose it in the target description for now.
+     * { "ieee_half", 16, 'h', 'f' },
+     */
     /* bytes */
     { "uint8", 8, 'b', 'u' },
     { "int8", 8, 'b', 's' },
-- 
2.20.1



Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75089C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4011920720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oips26kA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4011920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04rd-000444-DY
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i7-0000zr-Bi
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i6-0003Ly-9X
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:23 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i6-0003LO-2T
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:22 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y11so2955785wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZA14UkL2KSdT01IcOZIpDKpbqjnmGKZmAXT+OMv/3DQ=;
 b=Oips26kArsZhthN9PTMEiDKyUhZ6GKNEp2jpJ0aC2nSK4f4vtvfNzTekVaDho38r/m
 6cK9ShuXDN3EB1dpcw0D3RQrcdXclX+eXO7zJnjXSoPWOMpI4X8iIVZNq2xMZqavcKXv
 wsxGmweEVX45zAOMdRF6Z3h0u79IdwCaQImPqhEygmvCMHSt+1UveDfN7ejLzBdDDmXW
 hxmc5ZH4M0o6rlOVqLRdhvqIcmCpKl0B2ZibMw+K9zWvRx9RF/PGtlke3jMoNQsfgCjD
 O9RKjYpeO7wObf4jA5ZGq7S7qY/joNr3FE5bjdcWlleyX0LfWLMm1qmueiOnfvvcIgFj
 vvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZA14UkL2KSdT01IcOZIpDKpbqjnmGKZmAXT+OMv/3DQ=;
 b=khEuLjquW5Mn6Xni+lDxu0k7J12uCuOx+MO9eZJvsAyukhAdLDS2sOZse0nIrFH2xU
 cQYyBdz0P8id2G7QI8gReXbg04TiiDUbuDnzV1ce0MMNWDkQkDFWdWjhKo2KVmVXGKh7
 SjwyRpBO6hLtAR9ZVV3QtqyCnA2Vo4JNIoUiFz7t83KOR8rRkHlluTGkZTlWXjSVgtBF
 1I9PQZ6jEayLh5unKDNlo7JNCkPKx/4rMJNRCF9+ofkbEo6FcVtNqtDeVCreQGsgxsy3
 ibr5KCsX3QSvWvyWeqIaJPs9P00GjJuRJ7TmEVDTp+JNp1/XythQCCaAC+I6uIhw+ABH
 CwRw==
X-Gm-Message-State: APjAAAVY3ndwSyRmfVygpIavatDmHbJPAy+udS2u9nevICxV9nr4hx5+
 6msGbVZc5167wEiDUnasV3ecBICdS8o=
X-Google-Smtp-Source: APXvYqxXx4xCDp9ioslK/mgYFO+cxbdev46LXQUWHJYcWWi6t0LqJFJFlyY8siaV+sOUrI71eM6Vig==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr4824188wru.87.1581086060949; 
 Fri, 07 Feb 2020 06:34:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/48] target/arm: Update arm_phys_excp_target_el for TGE
Date: Fri,  7 Feb 2020 14:33:28 +0000
Message-Id: <20200207143343.30322-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Richard Henderson <richard.henderson@linaro.org>

The TGE bit routes all asynchronous exceptions to EL2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b7b459314d..56a62b11d09 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8446,6 +8446,12 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
         break;
     };
 
+    /*
+     * For these purposes, TGE and AMO/IMO/FMO both force the
+     * interrupt to EL2.  Fold TGE into the bit extracted above.
+     */
+    hcr |= (hcr_el2 & HCR_TGE) != 0;
+
     /* Perform a table-lookup for the target EL given the current state */
     target_el = target_el_table[is64][scr][rw][hcr][secure][cur_el];
 
-- 
2.20.1



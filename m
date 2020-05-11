Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3922C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECE8206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHBiEABo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECE8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8mn-00024A-KV
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8a0-0002fG-3g
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8Zz-0007Fa-75
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id z72so9674843wmc.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/Dm7bjRavcMmPKQRrFPWV+NL07gZ+OPPPlKIrxR/axg=;
 b=cHBiEABoq9OgS1hidhVGrAiKc0tlb7CP23j4rtnuuPMCX5sOYS+KdfnxvKMaWTeYM9
 KwfAoEewOJ5JxwQSQw4TaQBGg09OvAKjfZsjPZosgGw5/UyhZdcmLC8Vp7nTJwWBzQfy
 bfnnsjXNFwPhGbtDIFtt+bKcKhOH9Xe25pWNYNbxtdw9fRMDjeXgPofxvQGPB65SC9hL
 XBbOVhMCRmkdErUWOrkxenbxBcKSLRoJ4MUGySHLBC/VzJza4FT9xmDF9VpzUYMJt8bV
 WY+ofEzmBDe6AU3W+YYo3rQFuHqSnwV9nkOCiGKh9TR3ut3Sg7bXVBYncdgdZBjx7DRq
 /MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Dm7bjRavcMmPKQRrFPWV+NL07gZ+OPPPlKIrxR/axg=;
 b=YTB6VwLeXgDIxnI7X/WdgV41xKGCM62MtcfMLB+OQxtFoukbk6jKkXXs1VygWB2mDC
 nGJxqa4VB5fiDpNq321JJO1zeIiH93M8vRfpGFp0kLsS0dFNQw58k7CDFLaa42EDORZS
 lK0JmxYKvg/tazjMjP5Bd3SC1FQa67/9y/lIaipjnTrd9eT4hdK02Hyl15KjYiWm49mh
 HUlLl+La8dsFMZKUiSVhBe9L32T4XK+tuzgUiucm9nFGPvxI+Z/nEjW9FcpjlEM9EdkB
 XuRxkNx/TfVs11hirW8a+lVU6PitrFVxtJ+YIWHRCepdalMevHkhf+CemhK6voSnVfu+
 nXzA==
X-Gm-Message-State: AGi0PuatGghLmpdC2BvjvbldccDH3IT8uHKAu4S91HMbIT0HwSXbKGGB
 1hnkGSYHJG+rKFfil6dxKYlw8Xwx6Ajmqg==
X-Google-Smtp-Source: APiQypK1dN2CDdeoWtaDapVXesDbnH+yNCMgpleOIg9+J6d4CdUuk7D7Nv4Hbd+2E6XHtxk6fWr/MQ==
X-Received: by 2002:a05:600c:2c47:: with SMTP id
 r7mr31120511wmg.50.1589204085540; 
 Mon, 11 May 2020 06:34:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/34] target/arm/cpu: Restrict v8M IDAU interface to Aarch32
 CPUs
Date: Mon, 11 May 2020 14:34:01 +0100
Message-Id: <20200511133405.5275-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As IDAU is a v8M feature, restrict it to the Aarch32 CPUs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200504172448.9402-5-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b4d73dd47c1..a10f8c40447 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2889,7 +2889,6 @@ static void arm_cpu_register_types(void)
     const size_t cpu_count = ARRAY_SIZE(arm_cpus);
 
     type_register_static(&arm_cpu_type_info);
-    type_register_static(&idau_interface_type_info);
 
 #ifdef CONFIG_KVM
     type_register_static(&host_arm_cpu_type_info);
@@ -2898,6 +2897,7 @@ static void arm_cpu_register_types(void)
     if (cpu_count) {
         size_t i;
 
+        type_register_static(&idau_interface_type_info);
         for (i = 0; i < cpu_count; ++i) {
             arm_cpu_register(&arm_cpus[i]);
         }
-- 
2.20.1



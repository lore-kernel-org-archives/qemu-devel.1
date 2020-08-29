Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0E2C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 10:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C6F20825
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nffiYWHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C6F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kByPr-00046N-S0
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 06:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kByPB-0003gA-L5
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 06:48:17 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:56166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1kByPA-000082-Ae
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 06:48:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 2so724589pjx.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1yo7JQ5QRR44B/zQ3mXm4YUcLjnziUu9+pZ2amneVmQ=;
 b=nffiYWHHiUiZ/Ohk8rkTYMXcXwSrhPZNx6+7Luw5LuIQNeKyVOypL/umCc2Y0Xi2os
 WjrOjke7stJAAPYZhx/7qmKCMXX4V+6rEYsM1HjFFEFmtixGXAnLA9PX7cjHoJHo3COX
 0wdYKUHWCebaDZeKk/gQrxEPqbu04ipBp0kCUrVDzUviJ2InnIWJ1X7C3zm/yVerWeAQ
 U7s7DxDAZF+dwu8RfWcuG9ZUNvk4cdFxZLHPtgCGnhQBDxLoGrIJSqpsJDxj0m4OpeJZ
 IMKd0JCgmkVNk8jKu4l0zfvavztZPHQsaQr0vUojrUpNeGWEkPuWyxoawsS8qGRs3bsi
 U2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1yo7JQ5QRR44B/zQ3mXm4YUcLjnziUu9+pZ2amneVmQ=;
 b=BCP5j/82H9X2VngHTfz/7fDfQd3DL0Khl84FTeexD2nFUjBVodv9Fy+9Vd5mStnGpQ
 9LIBrrrlUAFX+Ad+RSTP0pymASH3ZmPWOXgh9ZzlPTc4IFdr98gBqT1bsXDTLsHUoF5V
 HrKygzjUfKfHN1NCxYRZygP+otyaKed1MU8KYHHByzo50p2HSFXZczVPHq0Yex6OuvpG
 jR2ls+kRgvUotDvCGxdX7sbPEVJXkhYnNnyX+E5tx3xMGnd6tR05cYLTFmdyPs5Cws35
 tBURuk7vJJSxpblkyg3y/0LDM2tFmAjk4rZvzxTpk/1bNA1Wo/LdF0KJHfzQXW/4Idxm
 RMGQ==
X-Gm-Message-State: AOAM531GPuTG0fHLjEdOdAUeYpVVemk3maUAaAjbLqsKhyjuK2mRc3tt
 9ML9TbW5sMAvm3/csbe40jh9qGEsHK4=
X-Google-Smtp-Source: ABdhPJw4w7bHs5/29IFfu3rd74M+c3c6YhjouHL8ASvjOQl0A++PypBOAyhh4hrIrZovu6CYRtl6qQ==
X-Received: by 2002:a17:90a:bd87:: with SMTP id
 z7mr2589102pjr.187.1598698094215; 
 Sat, 29 Aug 2020 03:48:14 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:401:26c0:5caa:fe49:9c90:e47c])
 by smtp.gmail.com with ESMTPSA id ft12sm1789028pjb.6.2020.08.29.03.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 03:48:13 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/xtensa: enable all coprocessors for linux-user
Date: Sat, 29 Aug 2020 03:47:58 -0700
Message-Id: <20200829104758.22337-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Linux userspace always sees coprocessors as enabled. CPENABLE register
and coprocessor exceptions are used internally by the kernel to manage
lazy coprocessor context switch. None of it is needed for linux-user.
Always enable all coprocessors for user emulation.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6a033e778c95..88a32268a18b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -93,6 +93,7 @@ static void xtensa_cpu_reset(DeviceState *dev)
         !xtensa_abi_call0()) {
         env->sregs[PS] |= PS_WOE;
     }
+    env->sregs[CPENABLE] = 0xff;
 #endif
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
-- 
2.20.1



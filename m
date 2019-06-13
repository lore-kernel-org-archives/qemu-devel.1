Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA5FC46477
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783821721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnyNbH/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOxe-0003Uj-5P
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd9-0007uu-Va
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd6-00048x-1m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcz-0003zq-RL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so9867924wmj.5
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xzAVSfrVvqiX6ekYDb41MECWbYD3g8yVOK49nEoLOVo=;
 b=mnyNbH/ScqCopaOa5U/yB7M2FwK5+19T2DjqQMZv+EUVTo404O72KPHrAWlRooiTuq
 ugQsyUjg8QpJn/OuJTC+G0DlwLzJh+ejJpBHPF2M0x7bgf4lwUAbV+3dlAQu6857wbyf
 0sXTGVQ9qLur7vf8f1YxSzE9FvI8pTtwcs4cJ4KiSDSVAB559FoH9/zh6/XJplq6Xbfl
 Lx78YLn/hcDp9R1zNQbJdVTvgMRQZxHFeKuD84iqk8V2idVlvL9HQFw5mL3ezR3LKOOG
 GXDTnoMZxfYBAeXzcr5a3aZTkHochqark9YE9Wf81DkWCSZXkT02B3RzFdCB1+1g9Acc
 S9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xzAVSfrVvqiX6ekYDb41MECWbYD3g8yVOK49nEoLOVo=;
 b=SpG3IoMVrTPDwlXtaYYg/mnpurpCOp82fUoEVkwX4CeDB1e8QSRMX1P0TRYX6yzBbZ
 SfWbzkhWGDUNHrQieVq2ipW3OVuLLGGy+8tmu35bVfz5ixqEWjiWwRXTbMfSEIhTEY8N
 2Z/EUfYMs5NMnqJIBml2W0mQUBeKhpKfHQQW8TrOfRzGdbe8iUdPAnlyw7Y7DCbqIW6U
 pfnQrT7udSLG7xfFZJ87tRCYM7qTIaH/SUPVnU7fsgyXnHT35pvUtXd6FYlbL/JXJM4i
 NYhjTKgRqCxdGCIJXKN4Avb6hikNzqN6Z/e9nmZ44l3WFhZzh+jM260Laky8ven8FSNv
 wEwA==
X-Gm-Message-State: APjAAAWOnIERp9CakqypXi2RF/uG+m3nsQvCMSMizSLGL8zT9GvM7RtZ
 Rv0J1Hj08UYh6Uqz8wj+gCxLnV/wmRhXZw==
X-Google-Smtp-Source: APXvYqy7HWL1osN3iyi6Em33WVfvir2VVhdkNwSVGK19dimvxc+QLfz2qX03ZwVppQ3ndRzJGHSJkA==
X-Received: by 2002:a1c:3:: with SMTP id 3mr3727207wma.44.1560428087314;
 Thu, 13 Jun 2019 05:14:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:56 +0100
Message-Id: <20190613121433.5246-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 11/48] target/arm: Explicitly enable VFP
 short-vectors for aarch32 -cpu max
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

At the moment our -cpu max for AArch32 supports VFP short-vectors
because we always implement them, even for CPUs which should
not have them. The following commits are going to switch to
using the correct ID-register-check to enable or disable short
vector support, so we need to turn it on explicitly for -cpu max,
because Cortex-A15 doesn't implement it.

We don't enable this for the AArch64 -cpu max, because the v8A
architecture never supports short-vectors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c8441fc07b7..2335659a852 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2023,6 +2023,10 @@ static void arm_max_initfn(Object *obj)
         kvm_arm_set_cpu_features_from_host(cpu);
     } else {
         cortex_a15_initfn(obj);
+
+        /* old-style VFP short-vector support */
+        cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+
 #ifdef CONFIG_USER_ONLY
         /* We don't set these in system emulation mode for the moment,
          * since we don't correctly set (all of) the ID registers to
-- 
2.20.1



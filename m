Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7F120659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQXhPimm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7F120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgF5-0006IQ-1a
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxl-0007NO-VF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxl-0000nj-1s
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxk-0000nJ-Rj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id 3so3219201wmi.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=BZJHPhd7AksEx+H4Cy3rMhdQWffeBwbM7nZoccEAv4g=;
 b=RQXhPimmHEf6xAGxFC3DC1voMcBGEKGk3qf51Fq46Ss8d8IGR29OAUG4jCASSR4edk
 d2aEfQpv6SeZTkNpkj26hV1Rqjome8auSz3I4nGsX1G2SxW9GbXDCkd91MRh2JbGE55G
 3Sw4x+rqLFfuML0D6+B7CtJx9WJ1sVS5zGcojYugJLiPqvNTndlZra5YwiNUbLZof9ON
 azVQ6viNTTmIIDBTltIW6xA5rHTOZsCwaTnbrUlnCbrADiQ7cLhTj6NBmFjB156UBqqw
 CvkolqJmBp7toy/RjSh8YVk/FnSoglm4qv0BdqMoNcT66I1DQaSXTWAo41Cs4Zd/3HWG
 m03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BZJHPhd7AksEx+H4Cy3rMhdQWffeBwbM7nZoccEAv4g=;
 b=WmqbpRroaxN2hDVLxygGQ2tfnN2OWV7RlRo3mTWd38p7Qc4qg7TMKwAcMrOSvttf7x
 cuxsxTTa2rExy1scJ4/taw/f1o0piAb2GslbYYK5X3KYtkU+KaoYpggF/XNtRaio8JoH
 ewu/rwmDLJowgjhtokQEUsyDzMPDj3SX86EX7k45MMA8+QB7kTijK0rahMa6rxb3G7pi
 9aS/YAJ+lJinGgMe8G5UFjTSteL5yaBL+xI9Jf2WRd8s4E3hyOABf3EIkcrRC/ZkHAVr
 8XsuDEa7WwJecc7z51wBv0niI8x6d7cKn3CHJK+dsRK+/GBY0X4vIW2/t+B8eug2SxCK
 SPQg==
X-Gm-Message-State: APjAAAXHop6G5VOArORkQDbeOPXa9LYyxVcHIgLbnFW/uzxkGMCRnl4v
 uuxum3KU6IbfPwKxVTsDTSqkZwAW7co=
X-Google-Smtp-Source: APXvYqzALxotPMAiGlloMpeCPRe1blQZ/IYm1ELXdkZFUAZmJAUT9HAc3U7dFCp1wfHbp/nGDneeaw==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr6111263wmk.25.1571934467581; 
 Thu, 24 Oct 2019 09:27:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/51] target/arm: Hoist store to cs_base in
 cpu_get_tb_cpu_state
Date: Thu, 24 Oct 2019 17:26:49 +0100
Message-Id: <20191024162724.31675-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

By performing this store early, we avoid having to save and restore
the register holding the address around any function calls.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f7d3f257d8..37424e3d4dd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11225,6 +11225,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 {
     uint32_t flags, pstate_for_ss;
 
+    *cs_base = 0;
     flags = rebuild_hflags_internal(env);
 
     if (is_a64(env)) {
@@ -11298,7 +11299,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     }
 
     *pflags = flags;
-    *cs_base = 0;
 }
 
 #ifdef TARGET_AARCH64
-- 
2.20.1



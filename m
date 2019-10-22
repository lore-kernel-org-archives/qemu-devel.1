Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FA6CA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819D72184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enBx5zVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819D72184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuZR-0007Eg-2J
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHF-0003Hg-SC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHE-0001Tf-Mq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHE-0001TR-Ee
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id f22so16202883wmc.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1/mAfeRaj2VT53r9QN+14J2AmI4c8ehCDN6UkkQabK4=;
 b=enBx5zVx+83+XF2X/YJOZV2t9Bs3wsA1pK942z6am0+LU/m1FmZpBPSd1Eis+y5FMW
 z1VxqfNiOqY2uqZDR22wa/iEXoI319KDMUDnkAwaUscDnjyMLxcyu5fThVqYsCrj304Z
 fYcMILNVHTZdlemXhH8fTaL5uwaSgXKZDiR8R79H8ybAcH+VroO/RP7mWxBko/a4e/U8
 5cnMgqHflIN5MQVyg4WLlBT5sEwg/uQzfggCSijlhgGhFbAGchavVHCc+nQSOecm7Qmu
 CgBO1UpwiLENKkRqw5WUDWMjZuRFuko6oTQEAGLp+cFjbq8fB480uOQkVYUHwmzO6+Am
 Eoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1/mAfeRaj2VT53r9QN+14J2AmI4c8ehCDN6UkkQabK4=;
 b=rFWCjLM8uehtvx0a6w9+4zoEmGnVdUzd1PJDhE14EZ8xWATLSR5gRn3wYTFS7wTS/d
 mSxFts2LQ6Gz1G/p/HIHnd9q4+ix8JL2UOnmAyIBu11fNBvUJcxOBWFDKVmUVsies7lb
 lpOVqUv8pKp8XI+k9qwdw9aO8zYC8eW13sTfndJWY2P0PDxCtUho/MBY8M7jsxPwpvQN
 X40+W56E/buJJw4NaFF4nOFaBLUKK3F4XsoFAl6lZpuPPao3bEGk6O3tJWRqdEu0U2+0
 jlQYFL3xuFn3F0Y+kkR7cMwLKqquRkV18xRx1F4fLvcnZc6nQw3UzXolunm9y0UYVnWK
 Gdqw==
X-Gm-Message-State: APjAAAX6w2iC5CahZpv1WEfiDEyqQwWYo2x2QmNtugmSOqvX+LN26ja2
 zya7Npca8jH+PRrV/h12HFfGROVHpvM=
X-Google-Smtp-Source: APXvYqz5zQpAiIPzp9kfFjb4iho5a8d264BU+DRFKOS/HMDJbQpQgGdU4/GQLj8LfHKqdk99bBRePQ==
X-Received: by 2002:a7b:c186:: with SMTP id y6mr3251012wmi.67.1571751162933;
 Tue, 22 Oct 2019 06:32:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] target/arm: Rebuild hflags at CPSR writes
Date: Tue, 22 Oct 2019 14:31:21 +0100
Message-Id: <20191022133134.14487-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191018174431.1784-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ccc2cecb467..b529d6c1bf7 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -224,6 +224,7 @@ uint32_t HELPER(usat16)(CPUARMState *env, uint32_t x, uint32_t shift)
 void HELPER(setend)(CPUARMState *env)
 {
     env->uncached_cpsr ^= CPSR_E;
+    arm_rebuild_hflags(env);
 }
 
 /* Function checks whether WFx (WFI/WFE) instructions are set up to be trapped.
@@ -387,6 +388,8 @@ uint32_t HELPER(cpsr_read)(CPUARMState *env)
 void HELPER(cpsr_write)(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     cpsr_write(env, val, mask, CPSRWriteByInstr);
+    /* TODO: Not all cpsr bits are relevant to hflags.  */
+    arm_rebuild_hflags(env);
 }
 
 /* Write the CPSR for a 32-bit exception return */
-- 
2.20.1



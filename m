Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224DEC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EAE214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahN9HA/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EAE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf7A-00065v-2q
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeol-0003WS-GX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoj-0000Ng-OD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoh-00009T-RG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so6559706wrw.8
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IVKcFt3bQTNhlwTBnJF9A3eBweA7u2QJzYXmvDkdNOU=;
 b=ahN9HA/NCSehqBiKxEd0g57yLQ3KQYTdXCBp80wOUZN+vSVETqmx/HUv5EvWyjZQhT
 ypXP8K6in0Ins7LZooel9eNmflA8cMS9HiLqtp5Ftim3UFxdTjgRSHbgJHUiUT/IsffI
 JjRBNqqgezNdTe0LIckEZEIo7BQui2oqUWidoRM3GplcYaf79IK6+xcFhnBWU4p/u/MU
 ro7yMOLUJwwDusl8GRtM8re7yTpqr53WXQMmLhkWW0PYdbGwYMj4GjrF7GLSwfkSsT+q
 DRF8thPyJ4+9JtSxke1wVhKaVE1RznNKoVX/F7QhVkvSJlspi5WAZh2MGwTGOvzxEI0+
 IbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVKcFt3bQTNhlwTBnJF9A3eBweA7u2QJzYXmvDkdNOU=;
 b=YR6nzbbm95e1toMwT7N4IqrbNLfTTNuev1DdbKeaC3fxli4ukwACrxyy3uOMdCRXUw
 pa882REyWmi65XYZPMI50SJeprIhYN2oBz0MBMfqRt8rPJyij9nNDkvD2T1pL6+SGsxy
 e+TsqQNWho3fdeoB2WWxGPT3usF94xI67uPRjtibchY5qaagrVSmoa6KUveipoHhSU9u
 AK/W1zK7fUk9BDPU4+0cPQDUVAupvfMo7eNX0lyZAQGO1Fyn/Ym9I/Sq6pEAm+zcyJM6
 ckRiflkxAjtveogf2viRZz0J7iPP/+4WB9VqNXwy6/0XP7lSS8aE2Rrmuf7EeGh0Ai2h
 hK3A==
X-Gm-Message-State: APjAAAUtAexbrNSdz4cX7EG27TPxYNX2DjwGuu7vqFMFqHG/06prM3CK
 JiGNOE0Oc1PkIWjoWG/w9YVfkU5w1rhcbQ==
X-Google-Smtp-Source: APXvYqwxlivmNSZvX/nu+uLNMEJG33NE3ESbeGnDIBL6+fsTlCMrgC8qCBmWlr1apUz8H/ltlYnDHg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr3180151wrl.389.1580986523882; 
 Thu, 06 Feb 2020 02:55:23 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 40/41] target/arm: Use bool for unmasked in
 arm_excp_unmasked
Date: Thu,  6 Feb 2020 10:54:47 +0000
Message-Id: <20200206105448.4726-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The value computed is fully boolean; using int8_t is odd.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index fcee0a2dd4..4ffc09909d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -417,7 +417,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 {
     CPUARMState *env = cs->env_ptr;
     bool pstate_unmasked;
-    int8_t unmasked = 0;
+    bool unmasked = false;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -468,7 +468,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
              * don't affect the masking logic, only the interrupt routing.
              */
             if (target_el == 3 || !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         } else {
             /*
@@ -514,7 +514,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
             }
 
             if ((scr || hcr) && !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         }
     }
-- 
2.20.1



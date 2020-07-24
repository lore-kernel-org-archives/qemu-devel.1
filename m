Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8902074F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDO/lwhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8902074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrVj-0000ki-9O
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSH-00040Z-Ez
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSF-0000Fl-V6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id t142so866005wmt.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rsXsx8FncieYCf39ndgf29iTUZcqWDqZZxZPkE3/pro=;
 b=hDO/lwhMonVa+6SByA30W4yX/1mZvCsyFkHTmfLYKEOxRlHJN0y7onDCwKnOM3VLkH
 duGqS0EM10SmFFjez9sE+7/tGlk5QCILm4wAIsl5MPEcQIRYBGApx7yXsLcxkmzXFbF+
 n5H+FAnuJeYBxhFhF1ywSljI4FcWt1fI8RSzXQjuR2BfNUxo7lAukPomSadR4do0hu++
 sxktGJTVhUcAtKAZNaV9PSy969WCVfwzTdUsZFIKj0vlaEEyJVTkRPfDAmG4i46ScZdO
 Niry0erN/uBgRtZtgGA8GcJGgga4/5aBYqaYwYWjHAp5jUolQoj3+8HA84ail5FlEiYg
 AX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rsXsx8FncieYCf39ndgf29iTUZcqWDqZZxZPkE3/pro=;
 b=spHe/c1OJR2GwDgulQiFStCF2LuL3qy/ZI88BHvhVYI0aDFBKFbW+JVSM7JXZyB/9J
 Ry1Z4/wW05wMmqSMq2SxRbQxKhM2Hfhazox/JzlssSJ4snVSxkrYygNppWT7i5S1hquy
 z7XGLOMbe7bj9rvNCr3l27Uz3aidM2/Df4RVGnoUGBWYOqnNzYG7knt7KPPtLqiZQUpZ
 omjhU1KB6uxCEkW9SH3LWFVp4EvFcnhnc7Ytj0c/wkRxbgMzRnbfLP3GMyQBd1ElpwLi
 bmgaExp376vun5Ia9GvVxZJiQbX8Lv96QcYkxFfQEyk77G+q2H7tKYXCdsyEQldtwJMy
 gX2w==
X-Gm-Message-State: AOAM5304dWm1b1ZYUoEMzjI7hZESsaCfmB/Xpj5q8z5xk0AtDAdJBn02
 4Pj3fviVPeCoQBq31h9vuk8i1A==
X-Google-Smtp-Source: ABdhPJyOvQM5E7l5Yn6MZOm3JeuKb1vwzT+Lz5Y3USQG2MBNaq7131byl05UKdjYll6IyFKvIuaoxA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr7030985wme.159.1595573114499; 
 Thu, 23 Jul 2020 23:45:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c24sm172551wrb.11.2020.07.23.23.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 768181FF8F;
 Fri, 24 Jul 2020 07:45:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/16] semihosting: don't send the trailing '\0'
Date: Fri, 24 Jul 2020 07:44:56 +0100
Message-Id: <20200724064509.331-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Don't send the trailing 0 from the string.

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1592215252-26742-2-git-send-email-frederic.konrad@adacore.com>
Message-Id: <20200717105139.25293-4-alex.bennee@linaro.org>
Message-Id: <20200722062902.24509-4-alex.bennee@linaro.org>
---
 hw/semihosting/console.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 22e7827824a..9b4fee92602 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -52,7 +52,9 @@ static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
-            s = g_string_append_c(s, c);
+            if (c) {
+                s = g_string_append_c(s, c);
+            }
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
-- 
2.20.1



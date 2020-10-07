Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE88C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60504206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9g3K6TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60504206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCQe-0000YJ-3d
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0n-0004Ka-CL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:33102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQC0l-0003Cy-G5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:09:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id z22so4831270wmi.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nWlZIHI+U/6qxMevsv0oPEeqZ/4g0gvjXv+s06STyNA=;
 b=m9g3K6TQFZFdb7z4jShN2Ue0l1bovA0zAXF3qU2OExsyaTbQEiATI805LYcE1qU6pI
 ORV5D95aynh4hW79LkaG2HID2hW5ctoMz2gBNYvBA4VQxL7u0DAokyX+nvHIc1pTenm7
 eYOTpno+tA4vZ7jK9h6XNhxIes68seL9Z4fbjENrdT9mg2t9cT5fCZuuPQghCUyAA7SG
 Ujd+TMdOSDLg+NBzYr8Gf8LDQuny/8fTpFx0SmwAdOaMrHE5Vr7EqM4PlXh+UUtWLRFJ
 O/FXN1r1/lo4C3rQtFZ5ZaLdZIspGx1T+dYmoIMs/XWW1LfjE6/iSPqkZry56ovNbVlS
 hQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nWlZIHI+U/6qxMevsv0oPEeqZ/4g0gvjXv+s06STyNA=;
 b=JWrs/2rNJlOTMwxn8HSA6USPBpdmu/DpTWDFKzlMsRKDH4Bn6IhNHIohmHvJnmexnB
 1GuhbUuiXRaIDUUHbnoX7FY+WBTDo4p6hr7LWr31OM1nF06/9m+soqUEgwQebUPotXxD
 PjZcOq/KDOru4z0q9kli0dNWdBTWdujEj9dBlDFBBTADQogpx/hzRrkHcuPRuAhdiAXp
 xGZodml4dTeNCofm7feN9cRHng9jjcWtQQlQKShNc2R3XIkQhLciD82zfImrb6rZOI0Y
 4nT7wr+zLM1N/PhtDHGD4kNz/OWegmXOlUvR8KrRm2Wc1C6XtZAbKzI2NCbEHoKfg3wM
 pzHQ==
X-Gm-Message-State: AOAM531tufjjhc77II2TLlB8VgqRC5KCEAoLrW7bZfuBAuog2mFh1oWZ
 Cxfke4HGSsYNK0Ik2Ng4ZD+5CoL5Fohh1w==
X-Google-Smtp-Source: ABdhPJwCOnvdtCRaadD6PcH7OnMMXbN8KwI36lrauT/voL6fA7c89UOfQWuWcADmNuJvOy9cjG7yFg==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr3185137wme.185.1602086989902; 
 Wed, 07 Oct 2020 09:09:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 63sm3701673wrh.71.2020.10.07.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:09:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94ADF1FF9F;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 16/22] contrib/gitdm: Add Yadro to the domain map
Date: Wed,  7 Oct 2020 17:00:32 +0100
Message-Id: <20201007160038.26953-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributions from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20201006160653.2391972-11-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index d767620837..1572070cf4 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -32,3 +32,4 @@ suse.de         SUSE
 virtuozzo.com   Virtuozzo
 wdc.com         Western Digital
 xilinx.com      Xilinx
+yadro.com       YADRO
-- 
2.20.1



Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9610C20663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFktANPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9610C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdFr-0003rg-PM
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdER-00027u-5m
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:56:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEP-0005oA-DV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:56:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id q15so22525715wmj.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o9fzqGYWOKLSCCS48dXnjjFGr8lTIeZq2AiEKkz+F/8=;
 b=FFktANPMP1gm56eJM7vU0gICRUYK+rOS9MRo4BtozhbdvJOnEuRaCqUB4lIc5skdkE
 +YwdLD9Xq6absutuPfYPpaTiMIeV/KYrqreKfP0dc9mCi3+pI2SlbrY6Xg05qua5BzJA
 kZGmjnopSBlr0PFgwWjUqv6JdsKwsNb7V/l1xt0DbX1w6SiuDGxpWf9/i/62CJY67SvL
 aw1i6pSppiu/226mV9mrjW+FYTEkFZ8TCNV1c8avjJSbquKbdKlaoDfoSk5KRzf+MwPa
 841eF9hjogCuFDddcopaKgDj2YiIUN8kGdXY1pPt0j756ZR4j2HB3rKkLYrHzaJcJcTn
 TUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o9fzqGYWOKLSCCS48dXnjjFGr8lTIeZq2AiEKkz+F/8=;
 b=ePFExLDemzLtk5bGKFdGeqyfTMaXFXARet4pSQfkk25pBnktpFqDYipBbEWNtc6UEA
 u4ReUEAvsx2usZNe5P2yBSjvzgS+HuV2u/ay0kmRX6QHZetsN8ScfKlnVENEFmvJN2VX
 oYXActFdjgDcW2UVkJYkXDVQRFqEfRS72JG4AFO1En3hL4M8nIOIW36/I9CU04XbFuad
 Jd/UGnPE+f4HW3KaszXhxYXtBdpB09AyjT0lrvszvVOTad07Wl1nQN49/wfR+sFj94ZD
 B3FJEA2vdcxaHyb79/8xw4hj9V0f4tkxM9ah3OrqHPZGIlGkAtfQS9PchYJvPzB11FxZ
 +yRw==
X-Gm-Message-State: AOAM530czO9RYa2bPcweq2IMupb1/ZitCSYkMx3qI4OuESAAf6ILDZRn
 Ypyug+d514Ndi81yZsOO7m01Sw==
X-Google-Smtp-Source: ABdhPJzqEpQASPVcD8Szo5tbPw+oR67vF5YGbqDkAI2lV7QYZN2Fx352bKUSn3V6V2myyuQmGhGYGw==
X-Received: by 2002:a1c:7916:: with SMTP id l22mr19059046wme.115.1593611815975; 
 Wed, 01 Jul 2020 06:56:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 33sm7781948wri.16.2020.07.01.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:56:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2264E1FF8F;
 Wed,  1 Jul 2020 14:56:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/40] crypto/linux_keyring: fix 'secret_keyring' configure
 test
Date: Wed,  1 Jul 2020 14:56:15 +0100
Message-Id: <20200701135652.1366-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 David Edmondson <david.edmondson@oracle.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Edmondson <david.edmondson@oracle.com>

The configure test for 'secret_keyring' incorrectly checked the
'have_keyring' variable.

Fixes: 54e7aac0562452e4fcab65ca5001d030eef2de15
Signed-off-by: David Edmondson <david.edmondson@oracle.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200618092636.71832-1-david.edmondson@oracle.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 4a22dcd5631..65309a08dbc 100755
--- a/configure
+++ b/configure
@@ -6461,7 +6461,7 @@ EOF
 fi
 if test "$secret_keyring" != "no"
 then
-    if test "$have_keyring" == "yes"
+    if test "$have_keyring" = "yes"
     then
 	secret_keyring=yes
     else
-- 
2.20.1



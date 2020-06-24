Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C383C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C29920781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9gmfRWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C29920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo62L-0006Wv-52
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61H-0004mk-SF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:04:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61D-0003U8-JL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:04:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id q15so2441994wmj.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pp31LDbBMynakzVJX+RF0ypg4zh/bBa29zUb++Htq94=;
 b=D9gmfRWUKxwHohfHoYJsgG+1X0WI91GTOdJ1S8ZlUNDyhayRgm0+kCdETfntKMjro3
 4GrakiJ9zoOwBVudoThcL3hGhWWdKP4yS/PpaiIc2fWn9+HWTRD4I5Z01dsMKeUW/knq
 dyHf1OODjwyNpoCYM6cYobUdIpKR5ARMLo6U6000U+wfbsUqVHaVNvyhSmdbBQUOnnqa
 caitrgDsHV0+jTl0C4N1mWPggRsKZRfNxg5/NJ5d/Rjf0LFPI1QjsgZcPFAgdlso9tQd
 RxAihyAghIPfq+72oygX1VmhbRx1nr1Wmz261lzZYs1QFMRkNVVQhwfes5bLyQNqY8zO
 L28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pp31LDbBMynakzVJX+RF0ypg4zh/bBa29zUb++Htq94=;
 b=R5Xjp2HY2VX10wkEnYW0t9tThwhWtIvcBbzigmwUzvT8Mavp+zPMzjytyt5GzQuPO9
 lTWJVAdF83jwj8gjBPbP4uorMMVjFEH54K0iqShJzDTTZvlancWJ2WpH484kdYlhhRWi
 WtCbfPwJ23Iret4jdfUVbFcwcsCLz7fXW3W1lx6BNawImUsqIWi49e9LAzcbd2tewrnX
 Qp+fiMfHQ0TI2+/1OsZOrzMleblmKXW+eBdLZ7bYyGqAsTXdTPSsuSRz1eHIyzJUBMnD
 ODAaVnwUp2vC3Sva64xCCGI97xfDAwx+EjpfnnRo4jkCeY6sgXoXOWImlmwkutnokHCz
 bN5w==
X-Gm-Message-State: AOAM531/W9gINAOyevjwV+URmQRZCIY+PXnpWhefzqHUWmirEUGl/pbI
 OaQTMJmqXVq6j49S6mhMXMgomvU/bmk=
X-Google-Smtp-Source: ABdhPJxst9JPfoAEuEt+13DSWD7rj+UJY/SRqwv0cNqBJh8a+lH+KlOUHyzcut07JVTh4VrPz5OTRw==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr6471931wmg.56.1593007490169;
 Wed, 24 Jun 2020 07:04:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v5sm7368959wre.87.2020.06.24.07.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:04:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 610051FF8C;
 Wed, 24 Jun 2020 15:04:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/25] crypto/linux_keyring: fix 'secret_keyring' configure
 test
Date: Wed, 24 Jun 2020 15:04:23 +0100
Message-Id: <20200624140446.15380-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
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
Message-Id: <20200618092636.71832-1-david.edmondson@oracle.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index ba88fd18244..69ffd750dbc 100755
--- a/configure
+++ b/configure
@@ -6369,7 +6369,7 @@ EOF
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



Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F19CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F8121655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkSqSfkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F8121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbgO-0007T9-SR
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGZ-0002CL-2L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGX-00046W-VW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:50 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:39957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGX-000467-PE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id o28so25415720wro.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Vc+nT+KPxCdxDvyWLTbHjSdRMwRfzVEoPYWOARbj278=;
 b=FkSqSfkpevpI1wqK9zemfKDT2uqJPGv4Mceb1UjqvO0GHA98U4zPu2pAzNRV7d81L8
 EAE38ZYb+icDlGiPM98fm8MCZwc1kg4vdHaaB1nR0HxyjFW3iFbCp2vVLSY2ci3qHkDJ
 fnIRB1bLfM+S5457Da2uUkkYuc9Zu1WPHgObkMBXrTsKI5UCk+c09YPq/eixeEbuwZmE
 G/6Wc49yE9JRBi6ePl1o73d4f3NVk11hj4JAZD3e7usZsU4O1GZLDc/V/SWuOj2FoTmI
 3IWopQjulRia1Rn9HAmlRG7pqnykyWU9lCOfv6T+U6LUEtIxXq+7tabcoTMk4hlXz1GO
 6vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vc+nT+KPxCdxDvyWLTbHjSdRMwRfzVEoPYWOARbj278=;
 b=ih5XZgugI8o1KbEdi6Ajd9F0oH1uHucUUBd+coxrgq4ZMmKHBcCUaLP0tFK7tSrL0C
 u7EhD83s9RBOHoHz6FsBd4Cj3zKi7zFliAP2NjkHzar8zX9kXfPnysUTgZ16UEcopEx1
 +P4RzDXt7ehJ+8AhmfuMWpoLrJturx7Mtvr7mBy6FAtBkOB9NDGshG3q1wmNoyxWWiWS
 JnfqHJFKGZhGeLUUmMKSWWOkB7+sHgmWkCJShGzM5fWkhoz146t1qPM9+sGqQTj/TGW8
 SNCypBFrXs2LT8HfLLMEzZWjyVEj3e+38u3ViPYPOm8zBjt+Vz/KSpkYoYkP6x9S088E
 mdlA==
X-Gm-Message-State: APjAAAVOT6aFuS+rn7VfCNKbzpGJcWI0bmxAJxQkdNiRigLKv+WFoejo
 nzBb4SMGLfxYcA1Ypx5mnhC8HQ==
X-Google-Smtp-Source: APXvYqyyXgihKfQtTYzgoOjOJXlxigrT6rk8FLysYYp5FmuyjidjFJwKmlIXncTc/mX5Goz8W5Qlcw==
X-Received: by 2002:adf:f90d:: with SMTP id b13mr3036440wrr.316.1571912568619; 
 Thu, 24 Oct 2019 03:22:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r5sm8010904wrs.57.2019.10.24.03.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0EBA11FF98;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 08/17] travis.yml: bump Xcode 10 to latest dot release
Date: Thu, 24 Oct 2019 11:22:31 +0100
Message-Id: <20191024102240.2778-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to:

  https://docs.travis-ci.com/user/reference/osx/#macos-version

we have 10.3 available so lets use it. I don't know what Apple's
deprecation policy is for Xcode because it requires an AppleID to find
out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index f2b679fe701..da6a2063fca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -247,7 +247,7 @@ matrix:
     - env:
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
-      osx_image: xcode10.2
+      osx_image: xcode10.3
       compiler: clang
 
 
-- 
2.20.1



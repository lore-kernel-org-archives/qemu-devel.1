Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FBCC49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305CB20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwXfhb9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305CB20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cIq-0001IY-M1
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0U-0004Uk-Eu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0T-0004k8-3v
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0S-0004j8-UZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:13 -0400
Received: by mail-wr1-x435.google.com with SMTP id q14so18455804wrm.9
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mjkSIQ3d9vSaUq8363fKKG3DYG5g98JOky0YB54rlxI=;
 b=EwXfhb9a9PhOk9q+3Cvpp9UOTvCwVV2x2ErSEuc2VvWBmyCPu0NG/ChFBQGK4BZxEs
 +i0EFVJGSsa5q/9MY8qnIqghu2M8/q5Qgl/6EMvVygfU5JleixpJetq27VaVZrD/3Itt
 57CkUKrGIYyb/rLBpL5YbwtEHlbS2CIgIPyKl6KbOwA3ZmbNyfwi+Gj97jHGmOojT7K3
 lOTM1jJmMcWiFxFpemGg9TJZ/PaE7/uYi2LLs9xyOMAIFwzeMWEwLrgw8EhEjROvres9
 1xQ+sAtqdTjbxLPYA/tU+YSs/bxWqrNNXPhxLXYccpcn6Ht01p1XOhsBhJn+y4SIv187
 8caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mjkSIQ3d9vSaUq8363fKKG3DYG5g98JOky0YB54rlxI=;
 b=eiIM4PBnG/g6O3F14YnmuRri9CYIIneZwnc+sLxZh+bjnmzcd0sxBzEPLE1iYiwbXA
 sJEZONWbik6Aah8Y0JKdWVQessHMMoGxRDwb41aM8EqUUft/VyHcaDOiN4CjXdtDDkE4
 PkclUUtMrH4dybKsacqdjFU7pO8o3HMiw3fFx8aozcCi260c5XxXPDuIlhQfAVQyokwV
 pr7+F57BEOHjOV/oMX3FSozxJKdWiit2vHOXJmNL2QEsPx36vs3w5QLknvaYfPPY4CHH
 chRGWBHV1GeyzXqRZO3GhibYkVICh9yiBw1TomiSbgECt+IGERyOEEBIpLhCoEgX97cl
 83Rw==
X-Gm-Message-State: APjAAAVSUmdUE0QEyhN4kIZe8SxEEoDkBFOD4J5MBq4VKdCuJNwQj88V
 W7QVst8IjL8q4u93mt64ytv2tw==
X-Google-Smtp-Source: APXvYqy/VJFIGvVPYebRWItynYGJyUhnxfcWta4eM6gdOHVmEor1gWZglDaS//1fjBrIK4chkPHDGw==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr24660158wrj.168.1568106011797; 
 Tue, 10 Sep 2019 02:00:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm22032835wrg.24.2019.09.10.02.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3CE11FFBC;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:40 +0100
Message-Id: <20190910084349.28817-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 36/45] .travis.yml: Cache Python PIP packages
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We always install the same packages ever and ever, cache them.

See https://docs.travis-ci.com/user/caching/#pip-cache

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 7ae55dc41d9..0e3c2b0021c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -8,6 +8,7 @@ compiler:
 cache:
   timeout: 1200
   ccache: true
+  pip: true
 
 
 addons:
-- 
2.20.1



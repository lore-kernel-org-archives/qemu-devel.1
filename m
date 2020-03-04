Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9CAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B5021739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCQkguHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B5021739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9QsQ-0000ns-TX
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqp-000701-RL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9Qqo-0000Wd-PL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9Qqo-0000UJ-IT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:02:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id g83so1197668wme.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ljA/K0enCk+cxQzY+NtXvus6XERwMgueLpDeNPRhYg=;
 b=nCQkguHHdp1vCaeiq+brp8A84YpuA61FRDtY6ROEK5OKf+HsLZwBVzf8QCaOS18sVJ
 4U4296VxFquoQA2wglpzQm/3SzIf/31tBi/H2BMVFGhq6nfHs4gd2CCjUQ0j5T/1UqM9
 dwsTn1Ogo/XM7mg/F+NKLC5eGG0OzGJpIPSd0qTRW8Ggg2TjTUM+JBurSdB3WT3IpbxB
 w3qIBkxeZMsHKil87CV0TSwern3QXlaDj76OTMnnvsvg+RuYrI5a1huF2pIC7Hv7hsA2
 WiupLmClKsBSoICo+QBrrhxIkI0BmWfpOuSN0uQfi7HyzXnuKCFe95mbtq2fg+VM9zXx
 EydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ljA/K0enCk+cxQzY+NtXvus6XERwMgueLpDeNPRhYg=;
 b=Kw9NqXCH81Z0fNp/qXX7OShGDzZG2RteeaT4A03P1eTkZXUCXPXU3Nz5TSo4zc7sHt
 1iZ1x8iBvi/2rYkZTZ5jd+L8YJyAW17gPpTaE+eLD30i/Hi1QzDGmqyixvUZjPNJqqEJ
 GGC3ne55nmwPQBlWm9EYw/2RvKTroLlxr44IaPk/xKU9H59wyGKUG0AmcwcJQQYuimLI
 EMOr3BzKrQYXV2J2qSw9Y/aCi2GhwW2LBaJO2og5kT5pyFGNQ/QhMIxdLLs/UFVpCJXX
 9rK7LZImDt6ffltjBM8iAAwBOHD32UojNKkRnQl0i19t2vNMmuZi2RyWF4LCkTtzkkQK
 7DCA==
X-Gm-Message-State: ANhLgQ2L/JPWS8kLH7GJlLqcOJbSxpbjt9IXfV8vH6R1ZOdmvUHuGxFU
 yWQIxF0BTc+FLcDfZll6qjKu8g==
X-Google-Smtp-Source: ADFU+vsCLzjfh/Xc0T5IRaARj6sffqub8ltzlrJG6a++0R5YF8k32T3B+v68hT29V04uHBSYCi7xNw==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr2999445wmk.65.1583316121560; 
 Wed, 04 Mar 2020 02:02:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z10sm3323397wmk.31.2020.03.04.02.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:02:00 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B3CF1FF93;
 Wed,  4 Mar 2020 10:01:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/9] travis: enable tools build on OS X
Date: Wed,  4 Mar 2020 10:01:51 +0000
Message-Id: <20200304100154.14822-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304100154.14822-1-alex.bennee@linaro.org>
References: <20200304100154.14822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

As we can build tools on OS X we should check we don't break build
when we submit new codes.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200302154630.45620-3-lvivier@redhat.com>
Message-Id: <20200303150622.20133-7-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 9867272177d..70a24bf2fc8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -273,6 +273,7 @@ jobs:
 
     - name: "OSX Xcode 10.3"
       env:
+        - BASE_CONFIG="--disable-docs --enable-tools"
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
       osx_image: xcode10.3
-- 
2.20.1



Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF767C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877C7206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inkxh9a3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C7206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8BJ-00035c-Ml
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89w-0001OF-Bz
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89t-00009O-Eg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:55 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89t-00007c-8q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:53 -0500
Received: by mail-wr1-x441.google.com with SMTP id y11so3625903wrt.6
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FfT7m1jbJbEksVqHry1chhG6iYlVTrg1LtA/1X1U3WE=;
 b=inkxh9a3PFWMYsEwTrB2AHeU8TrtM7yvcJ9sNz0+Y6GrC5xDGGenhIrV+vE9YA/f56
 Ag+3WcxLGAF8wG/9ICykQ8wzjBUw6PQK9G3nYuF1YoAO3TIgIa3iuu5khe5xfN4FNKqA
 8v2OtiCsW/P7YQ26EvefVeWEafqJq0amg2mHaVVi/vz3hNpgK2qAI+iKJ/1Tg6EbdxoS
 AlvmPBaySG2y2cYWE0ZgvNxGwg2nSjc7F2M+e1ZCu+6b/IAk7ib5pvUzGLHJAn5Qt2cX
 1oHTlWDKHDwOCCbHSZMyHB6xy6d9102pwt8oTZKeoKiTU8qSsYyterznXSEbmX5lXVwn
 8RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FfT7m1jbJbEksVqHry1chhG6iYlVTrg1LtA/1X1U3WE=;
 b=uhS28n0kqsCAgaZG2jfRmiGoqcsAj5v93ne6TlRVIGyBPuyHdszlDhyAyYJfEGz/J3
 wmqLwoGqQLBP/zXIXEs/HqkWrSMm+SxujLr3BdH8KCLbUrpRIYeLGluP1A5U8q1YuUHv
 Tdbdh0fOx5j+ldIyD3Mjv+R2QARqt0bo4+DW3AvleFArB0gguNfmSjbhVIGMAyxIRNBD
 FkOSP+8OHNeaimJmXuFbRyf2wyELTFmLIyVXJ98CcjFbNMKH93VKccLYivNeL97xlS+2
 FwQR+nUyOlRmHz+DkCpefZBREkLRKxwVKrs9RiN3ZKk9SVeEaHNxNYXaTaiwQ9XunwpU
 rU1g==
X-Gm-Message-State: APjAAAV5rc8aAdmKgCkb8hA/6Wt0fa24uEOSXdd7YV+v8FB3eJnzAo0C
 vleKDXuSdu0iiQAF6D6ctGmUlA==
X-Google-Smtp-Source: APXvYqw7RF7VG8JdhyBafw5eSXsAw80CFx77lczPmF9YH0PwRsbQ/Q4UWzQNRSxQ3Zs5Pw+eZpqMPw==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr4910643wrq.137.1580384331729; 
 Thu, 30 Jan 2020 03:38:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m21sm6191264wmi.27.2020.01.30.03.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:49 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8DBA1FF96;
 Thu, 30 Jan 2020 11:32:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/12] .travis.yml: Drop superfluous use of
 --python=python3 parameter
Date: Thu, 30 Jan 2020 11:32:18 +0000
Message-Id: <20200130113223.31046-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

As we require Python3 since commit ddf9069963, we don't need to
explicit it with the --python=/usr/bin/python3 configure option.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200125184217.30034-1-f4bug@amsat.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index e75c979b6c..7526967847 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -270,7 +270,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG="--target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
         - TEST_CMD="make check-acceptance"
       after_script:
         - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-- 
2.20.1



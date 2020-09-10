Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EEC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA58207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y342jato"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA58207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMUS-0003uZ-Ua
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMQ2-0004CE-UA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGMPw-00067J-NH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:15:18 -0400
Received: by mail-wm1-x332.google.com with SMTP id z9so14070wmk.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eti/00xuqW2aTyT+ZU1Cdkbf/mkV1wbPcRPArTMTYBw=;
 b=Y342jatoHXMXkVZ843PLKIXqJVZB9SUySXLH+EWRBDClBaVt0muSjmgtyV8IOuxSZa
 X1LHJYqv/8wj8jsXfxyC1oSO7qxW+yXCEEmO/ZjL+mQxx5ey1Npctjirs2D+CRjeAOSZ
 rJ1zpoLN8abcFnCtqRE00BdGveXDEskX6TzLEjgncmU/UTI1CnTAwooXlS+5tt9XAx32
 lItHa+hxb5LkxDm344hXNbP6Dv0ZbddJ3XcLoMzhBRN0LiypKbxjUix/TyFVVQOPsWt5
 U6W8E4LGZkYSDWHAyRLGPHkB9LmdDJrDhFgkstohiuK7ROblQiDJQVMEOKFnZ8IIIvk2
 nfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eti/00xuqW2aTyT+ZU1Cdkbf/mkV1wbPcRPArTMTYBw=;
 b=tGkKSPuPHUB8JwT+vfhgeb9hmOqILypB/Jos3oV9Jid+Pc2O9eT0I4Gbl1vZ8wciV9
 qqeEVR3YHC+yIhRLk1VYk03D5JC9U4KZV29c4P9jDaWo6VrawYEK3Gb+6GhIdsND5aTq
 Mun41GsyUokOvnY3mXKbD3jDqHib4PStXIGPcFT432rqk7uXNTIB7kZbfJm1sO6liwII
 0n7XCYqC58v2B9itfsZZryVQ/ypg+VX9CfIr6WUHZj4h4u4NFPlKf7cIeh7dSkQ7nNsq
 9wATrZ1JCxpK5sNGUEZ3eZiewXV9Zc37rzV3lvqy9eUQAvowW+ogNPXKPV6+n1O1n71O
 4KdA==
X-Gm-Message-State: AOAM532ssdXVj+JunEvQjVTD7O3OErC3wpEzSVIyZJMqsv51/EMAu9ql
 fC84CA00ruIIl+FhxspEwc9yDA==
X-Google-Smtp-Source: ABdhPJwxdhzQKJF+WthDET5Z9eYPGGvlAtC3xdtAuvaPOvNTP9bCS9/yYFu823Kkoh3zLe7jrrJv4w==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr58823wmj.72.1599743711217;
 Thu, 10 Sep 2020 06:15:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 59sm9542540wro.82.2020.09.10.06.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 06:15:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A59B61FF8F;
 Thu, 10 Sep 2020 14:15:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/10] tests/meson.build: fp tests don't need CONFIG_TCG
Date: Thu, 10 Sep 2020 14:14:57 +0100
Message-Id: <20200910131504.11341-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910131504.11341-1-alex.bennee@linaro.org>
References: <20200910131504.11341-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the tests build only softfloat.c no actual TCG machinary is needed
to test them (as is evidenced by GCC check-softfloat). Might as well
fix the wording on Travis while at it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200909112742.25730-4-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 1d0ade0a133..65341634d02 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -138,7 +138,7 @@ jobs:
 
 
     # Just build tools and run minimal unit and softfloat checks
-    - name: "GCC check-softfloat (user)"
+    - name: "GCC check-unit and check-softfloat"
       env:
         - BASE_CONFIG="--enable-tools"
         - CONFIG="--disable-user --disable-system"
diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f90..dae8a77df14 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -259,8 +259,9 @@ test('decodetree', sh,
      workdir: meson.current_source_dir() / 'decode',
      suite: 'decodetree')
 
+subdir('fp')
+
 if 'CONFIG_TCG' in config_host
-  subdir('fp')
   if 'CONFIG_PLUGIN' in config_host
     subdir('plugin')
   endif
-- 
2.20.1



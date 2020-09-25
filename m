Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35161C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA6C21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSuXRZn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA6C21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLque-0002Qh-UA
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVj-0006qs-Kk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVd-0006qs-Kl
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id y15so3947997wmi.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IBvSe9U4y9OyrW59Pq+7GIi7CePKnagVOSmaXWRdN60=;
 b=nSuXRZn+qUU5qIYn5Y7l1NVzBY+e1Ew+5TO241KwdWoxEK0KN4Iwl0V+LFOEheZjlO
 hKdWPZ6Fv+28M/kmUUW+teDzI5X/4YGJT7eKg6pfQZWOOXBXn+oFZ4/hfw62RvJMuMvF
 NOwXocmtppq30VPBXIurhtePfmd6RWy9Qu4vEM2ySMBYTkD43By65fzhfux9zGXfGrh6
 ilG+J07fAwUNbIVQhZ3OciCxmyBhudau35DQUW5yCUfnmQSd9CKVMqbH5vVF48qk8IjJ
 u0ib3lBddIdIQOnHAFLkY73pHU1ka37YCG3Zwau72yOjMU/+Sr2+bDemtf1jeprN/P9E
 pf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IBvSe9U4y9OyrW59Pq+7GIi7CePKnagVOSmaXWRdN60=;
 b=klp3gpeo7rAiqCP5LBbffHk344XLsc9iUrGqyBQiQ3qskAGlUopmRIi0eSXMZ9IQ57
 be1YY+LHzDHBQv96mVjTzZ99vwtcg0gNyqDTqT3afPQ0lJrEiiNl2t5Md2qVfemhae7Q
 oYe4j7f1BYUPkXvIhLfhOFZCLK6Tj8v8cLN2b5mpJfvqRz+iizHXsxY+wdLdwuXusGTK
 NMvmoR95THno+tDdoseeiXogXkBgIJWJYgOlVegYSzd9lP4hr6tL6vdvn8V5mUy5vtaP
 A08YcW40hxHdCQh6JN4BGiJF4PhRsvTLN16UrL6OPWNPFKvJ/xrzB4CzNYNcOZSamsIY
 z4Jw==
X-Gm-Message-State: AOAM531ewFqDkc5e2cXBySn9HnI6eDDpG62W3sFPXdADSsFAEij4gmZV
 VPzFJYnd/jLBN5ntYm6MctuyxQ1I6oHwAsyE
X-Google-Smtp-Source: ABdhPJzNvXY+iL3QOA8WWmeGgC7/LfSm1SsgDKUSW6sdIl25Xh3TnKbcbkQC//HJtKf5i64bobIQKQ==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr3951436wme.27.1601051022631; 
 Fri, 25 Sep 2020 09:23:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/21] configure: Drop texinfo requirement
Date: Fri, 25 Sep 2020 17:23:15 +0100
Message-Id: <20200925162316.21205-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the texinfo and pod2man programs to build our documentation
any more, so remove them from configure's tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index e8e8e984f24..190d88ffa37 100755
--- a/configure
+++ b/configure
@@ -4873,14 +4873,14 @@ if test "$docs" != "no" ; then
   else
     sphinx_ok=no
   fi
-  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
+  if test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
       if has $sphinx_build && test "$sphinx_ok" != "yes"; then
         echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
       fi
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
+      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
@@ -6300,13 +6300,6 @@ if test "$solaris" = "no" && test "$tsan" = "no"; then
     fi
 fi
 
-# test if pod2man has --utf8 option
-if pod2man --help | grep -q utf8; then
-    POD2MAN="pod2man --utf8"
-else
-    POD2MAN="pod2man"
-fi
-
 # Use ASLR, no-SEH and DEP if available
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
@@ -7455,7 +7448,6 @@ echo "HOST_DSOSUF=$HOST_DSOSUF" >> $config_host_mak
 echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
-echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
 fi
-- 
2.20.1



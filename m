Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB4CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E2F21928
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9frGU0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJtH-0008Py-OZ
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp3-0004iF-16
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIp1-0005Ws-Nx
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:16 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:34108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIp0-0005Pr-W2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:15 -0400
Received: by mail-qt1-x833.google.com with SMTP id e14so13184339qto.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/AKbLHXTnM8m/9emDbjfL8Myv0gqqIqdV5s6THzE+7U=;
 b=C9frGU0AzZ7BnyrHTHH9SfZnuJGxFsRol9ai81q7DPmj+TZAlXLm2UZJm1RyH591z4
 uGtpGcZmP3LxSQZk4vwhzXR2j3m14aMX9C4R7o6pFultK4PKS1mFHKpThXsaobnmb7kb
 fYBS4sU9N+CPR45APZke8b9i+cfu3Ox4akvLQlzMfbVk/qcp5+wqdK3y1gCh4VQ0ax3c
 jvf5pUy/0suRMmJqADyg7MYg5hHKroeOp33XJocDZ8eSNz0kFUbHPWppmeHtjV4VYpxd
 5keHgySgfUuS0Xc/RL45RzxkxoHC8LQohSYw2thj96dFav8KvCPv2PtkbGJqsXN4ivAp
 uLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/AKbLHXTnM8m/9emDbjfL8Myv0gqqIqdV5s6THzE+7U=;
 b=OlUbLE5fshO9Xpy8qf6kQQ7N6VEYBxFMzSY4h1vrNoQEsl3Tkyj9zBlrQzZSRT/Fa0
 tpYx0ZSsRbUohfj0/juwxGeCqIx8bvxFTTUhg/iSyFsbmg944sLyHm/hN2WbWIPdpNLq
 /VwUNIB/iMBHOEPWjmhkIPBaj4GGbu3N33zgpUslx68GUJKGP5x035WE6VVOSdHkmc91
 FilnK4t86HPTtx+u0TkJxWucxECGW48ECVHi1rMbgyue7rV36qKx20lPFD6PGMXCZsIh
 YVT9sE3o4kSsAcamkVSmxjUiZmpED3DH0pQRLcj0uXzyXEPUKWOE5W+wt+NYkdJkz07+
 M7vA==
X-Gm-Message-State: APjAAAW9xyRjoSWnrBYqRZuZBCHWNlN61APpL34rsQ1K4YEYmVH9ps1l
 ECeQKiLxjIVr9/xFoCdSwmHf7ZG0QrY=
X-Google-Smtp-Source: APXvYqyVks026fWC02gOchDmwaZKGKv5LNjSigxBXb9gMxFgvtwYNxLXjuq1jTL0I5PdtBZgEXRopQ==
X-Received: by 2002:aed:3225:: with SMTP id y34mr9955341qtd.353.1571845511156; 
 Wed, 23 Oct 2019 08:45:11 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] configure: Detect compiler support for
 __attribute__((alias))
Date: Wed, 23 Oct 2019 11:45:01 -0400
Message-Id: <20191023154505.30521-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
References: <20191023154505.30521-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::833
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Such support is present almost everywhere, except for Xcode 9.
It is added in Xcode 10, but travis uses xcode9 by default,
so we should support it for a while yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 145fcabbb3..3a9862fe5e 100755
--- a/configure
+++ b/configure
@@ -5518,6 +5518,21 @@ if compile_prog "" "" ; then
   vector16=yes
 fi
 
+########################################
+# See if __attribute__((alias)) is supported.
+# This false for Xcode 9, but has been remedied for Xcode 10.
+# Unfortunately, travis uses Xcode 9 by default.
+
+attralias=no
+cat > $TMPC << EOF
+int x = 1;
+extern const int y __attribute__((alias("x")));
+int main(void) { return 0; }
+EOF
+if compile_prog "" "" ; then
+    attralias=yes
+fi
+
 ########################################
 # check if getauxval is available.
 
@@ -7083,6 +7098,10 @@ if test "$vector16" = "yes" ; then
   echo "CONFIG_VECTOR16=y" >> $config_host_mak
 fi
 
+if test "$attralias" = "yes" ; then
+  echo "CONFIG_ATTRIBUTE_ALIAS=y" >> $config_host_mak
+fi
+
 if test "$getauxval" = "yes" ; then
   echo "CONFIG_GETAUXVAL=y" >> $config_host_mak
 fi
-- 
2.17.1



Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5488CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD642072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIeWE+PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD642072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqbY-0005al-9b
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVl-0003ku-Je
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVk-0004S0-HR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:37 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVk-0004RS-BT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id k1so4504660wrm.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DZhF2Eah6PBu0UmOWylByF6k8/eL6tyE6oC8t+Hk8gw=;
 b=UIeWE+PUqdeeMcb4I8uiCEgsyj25vatF1rEm1kwXx9rHPR8KxR3JVBUmy6EBiMz1lv
 jQjUzahruWdAtRlS0MxxFEWXl+wy0NL8QUstg69IOdg+I6UmCwdqK+tUyC5+sNkNWmc2
 H3cVLXuvJlmHA4b7/jVwsAf8FdTlFO6biW1kYjuzWzvIicuRFlNA1r43To462wMOYrQx
 O5ZSCwI+tPlcYrcMzGAKptjcS6Zw6uWCjmW2HwmOlg6Ic8JC8p4yedzxWz9GIEq/soXE
 4SPVlaJ0COcvCJj7NjHGi9egVeEq2sMJ8ptDjCCfnVcP8gswkJPukxbzMNksVLKSstpH
 85Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DZhF2Eah6PBu0UmOWylByF6k8/eL6tyE6oC8t+Hk8gw=;
 b=WzF05OBTv9M46xcu1nLqVi9ybWTLNgsHkQHp/LhXyMuKSX1IM+GFx6PaUETeL98xwp
 jbkbXu7FPvLileu9RwJRiCWPb7CTHxa5xTxuvutoSD75SyyeiwmUs8l1UEYMrScyOO+Z
 YQK2npe8BEfmeqL+D4InjB+l4F8uNzeXrtQyqtgNvGV4fQTgQs5xwvdxtcdfDprVjWGo
 XRoMAB7mlFnosPStEuEMEdEV+B6+T/yXfXWE32Xbr06h410SR+vAf7pY1H9o0UTwtpxt
 3Wt1Yjhyb8btWs6a0fwt5zTEdlhoFLAzjJhfwM0RqlZgWAp1j3iHrdMySZ7enQeY0TRJ
 VPog==
X-Gm-Message-State: AGi0PubslbtdTi9tzy9805i7KKGKguyNvnbxgcqgcLQfsMEd0G9/DSnf
 ZkKXRpjTC0ODF4ZD53Z4mQQe9A==
X-Google-Smtp-Source: APiQypJjyQC4nhuXBrRzo9HiHGAOIvGV6uAAsoIWEvL52UYelOOTmB40hJswWbFrqV6FP5tbgWukAQ==
X-Received: by 2002:a5d:6204:: with SMTP id y4mr3625126wru.410.1586274695169; 
 Tue, 07 Apr 2020 08:51:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s7sm6888848wrt.2.2020.04.07.08.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 52D221FF9B;
 Tue,  7 Apr 2020 16:51:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/13] configure: Add -Werror to PIE probe
Date: Tue,  7 Apr 2020 16:51:17 +0100
Message-Id: <20200407155118.20139-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Without -Werror, the probe may succeed, but then compilation fails
later when -Werror is added for other reasons.  Shows up on windows,
where the compiler complains about -fPIC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200401214756.6559-1-richard.henderson@linaro.org>
Message-Id: <20200403191150.863-13-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 22870f38672..233c671aaa9 100755
--- a/configure
+++ b/configure
@@ -2119,7 +2119,7 @@ if compile_prog "-Werror -fno-pie" "-no-pie"; then
 fi
 
 if test "$static" = "yes"; then
-  if test "$pie" != "no" && compile_prog "-fPIE -DPIE" "-static-pie"; then
+  if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-static-pie $QEMU_LDFLAGS"
     pie="yes"
@@ -2132,7 +2132,7 @@ if test "$static" = "yes"; then
 elif test "$pie" = "no"; then
   QEMU_CFLAGS="$CFLAGS_NOPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="$LDFLAGS_NOPIE $QEMU_LDFLAGS"
-elif compile_prog "-fPIE -DPIE" "-pie"; then
+elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
   QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
   QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
   pie="yes"
-- 
2.20.1



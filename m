Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B4DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD8021726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONZrdF/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cWv-0006RB-97
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvT-0008DM-Cl
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0006kM-K7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bvD-0006fk-7i
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id k2so190360wmj.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ugB33z9NULKx/y//kwM5sEJ+zrs1rMaIgZwF0Y1O2S8=;
 b=ONZrdF/ke7J58UfmcBcLGVufiSjJNdkGTluszm70JwS9xFifXl1NzJYycYGlzENQby
 HEvIn3vBN2ZddS8fh6PcSVe7wlwLbDjGNKjL0slBfrJd3/MIlfqC79DHeOC1+y/X0vPk
 QOibbXE3K1RLT3xduUojvFa441lXeVKF672z9lhWUpcdU8vhylBIU6F9ePcSv/aFfY0H
 iLXiCFb9YA5fOhvLH+Jaq1QN9Lr/FyyHL02U1rHmt+vWW91CwJuIK+fItX1oH0xQfPbR
 q6gVSSMddMJfeFwDZj9/NtR/TK47XD2tJkg+cKwS3wxOjwIQJvLIhgungBr5nqcI4UeH
 IFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ugB33z9NULKx/y//kwM5sEJ+zrs1rMaIgZwF0Y1O2S8=;
 b=thgflFZp0j52JfXETpK9BsIIb+Yye0AgQwKO8xgi3u8f6sV5ERQ6aSpB8QhF+3+gqN
 +SJ/1AHSE7xTRe9c8ecFOQXpmfx824FWcsggm3vWP3cpWpUbYlx3X+5iV1+yTwQLn5cn
 hQL+1b+zBGxMkx4bXn8ELOUYFO0ch+omYf9jyPAhT5u9jzE543D1c1fcib6MTyvFG4dC
 7OxxFvJ/7z6mP5QNAhTzDGCI8jeiVwoT0s9MH2V7LH6NvHRyqkdUqTNG20l4SsFya/k6
 eI4GU1/7heCfgJ5StnU9fcN+Aw8Y2g52xl3o6MX7+yhDHCGPHOdZZ+PmgIAaift9K8Os
 ZwPg==
X-Gm-Message-State: APjAAAWE4TgtNv388So3fUEDOnikXz10dCzz0XQUEdjc3ITu414uBduI
 qZdmOx5i+Ao9ECyZgdAbXur6SA==
X-Google-Smtp-Source: APXvYqxf0PY9pgCmAZnCgGQcyJ3uDQVpKOubt7FP2/eVPA+e3CFN2pWznZiZWVj04j3eTrse5Q1PZQ==
X-Received: by 2002:a1c:3bd6:: with SMTP id i205mr72432wma.135.1567629029318; 
 Wed, 04 Sep 2019 13:30:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y72sm281324wmc.26.2019.09.04.13.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BB421FFB4;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:00 +0100
Message-Id: <20190904203013.9028-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 29/42] configure: check if --no-pie is
 supported first
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For whatever reason this doesn't trigger normally but because
compile_prog uses QEMU_CFLAGS we end up trying to build a -pie
--no-pie build which confuses compilers on some non-x86 hosts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 7860bbc3121..30aad233d17 100755
--- a/configure
+++ b/configure
@@ -2021,6 +2021,12 @@ static THREAD int tls_var;
 int main(void) { return tls_var; }
 
 EOF
+  # check we support --no-pie first...
+  if compile_prog "-Werror -fno-pie" "-no-pie"; then
+    CFLAGS_NOPIE="-fno-pie"
+    LDFLAGS_NOPIE="-nopie"
+  fi
+
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
@@ -2036,11 +2042,6 @@ EOF
       pie="no"
     fi
   fi
-
-  if compile_prog "-Werror -fno-pie" "-nopie"; then
-    CFLAGS_NOPIE="-fno-pie"
-    LDFLAGS_NOPIE="-nopie"
-  fi
 fi
 
 ##########################################
-- 
2.20.1



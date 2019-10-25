Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D17021929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y//VJHjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D17021929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtkt-0002GE-T7
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-00087a-OZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN4-0003Fq-E3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN1-0003AN-Kc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id c2so918749wrr.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Fxm3k4cHBOBik3KvWndMPIE/3gLAlHObkdSa6YWSiE=;
 b=y//VJHjPi8oXoP6/pCX4mtHAdC2aDme2FqibBFdXwCDak2KW5iuftmUI68lfFNlU5P
 Y0UUxtv0RS+rzCzWbIFkUO17YM4Hspb54IqLYqz4xSKesSBMsAfIT2qddWEW1QphbWQZ
 hxjUfBUfAGonDKrDhwVis6x4sgqLITPKAUEQuwqPro6rA4zdlF/1zeV8rJuwMXdA/uUM
 9kefSIsLm3rFtu51qHmOsGQPr9V+kn3S7NLi3LMeK1UEXM122Uw8ukZYMu7Fce5UiAE/
 vjkQsBVPtzaZxEGoBIJg2yxocb3Wg3/4GwJpPP3F6i0gSExt2T75BDcO6fLcmZO5BJjn
 c3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Fxm3k4cHBOBik3KvWndMPIE/3gLAlHObkdSa6YWSiE=;
 b=i8e0ccQTmAr+iP/gxtsVsv42mg5Sv5JDScHH1lseQGQVckDgCyrKrheh2E5TEjIHQA
 LAJYAZoAhCBsqW1P4HIvyYuZNU7BOBW1AgqlwEfbWvLlmOsMHVMw0EZJt92Ur9EQG6jf
 ZUhRJ4KxB/sm6FcOZNUnCiQmklZT0yUBCDmpCcoCyrohqetZPqI5mSI9BTo3593nyR25
 OpyJxuh469xBlpYg9LYjuKKkg1ZAeJk0dvFFetFZQS8YBgYn3mQMAqWwb6tM/LnXLFrN
 /dme6y/3wCvdmgNjJlvzrIZriT95RpNblAI+cDvqyZDqpBGhyj++NgDirSctfMTkO8J1
 5Wlg==
X-Gm-Message-State: APjAAAXsrzNrnVHe3CBjlgz09d8znYbF2yC7veoUFBTGRbHjnq18vzlw
 eoKOWdcf+6nhSt9GwjWwlghU6Q==
X-Google-Smtp-Source: APXvYqypB003AuR+zRqO8bRVPwIaCRvPx2qPTR4OpozGNKVKp3ERVzeumH2MIt1CMi1j1TvmXS5z4g==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr1353853wrw.175.1571985999073; 
 Thu, 24 Oct 2019 23:46:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f17sm1136353wrs.66.2019.10.24.23.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C35C1FFDD;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 71/73] scripts/checkpatch.pl: don't complain about (foo,
 /* empty */)
Date: Fri, 25 Oct 2019 07:37:11 +0100
Message-Id: <20191025063713.23374-72-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's quite common to have a mini comment inside braces to acknowledge
we know it's empty. Expand the inline detection to allow closing
braces before the end of line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Aaron Lindsay <aaron@os.amperecomputing.com>

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index aa9a354a0e7..db67b4da872 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1639,7 +1639,7 @@ sub process {
 # Block comment styles
 
 		# Block comments use /* on a line of its own
-		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
+		if ($rawline !~ m@^\+.*/\*.*\*/[ \t)}]*$@ &&	#inline /*...*/
 		    $rawline =~ m@^\+.*/\*\*?+[ \t]*[^ \t]@) { # /* or /** non-blank
 			WARN("Block comments use a leading /* on a separate line\n" . $herecurr);
 		}
-- 
2.20.1



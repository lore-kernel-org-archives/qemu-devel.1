Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40627C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F67E21655
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRylIbBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F67E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsFf-0004ea-GK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsFA-0002rp-5q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF8-0004No-Bq
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:04 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsF8-0004Bs-0C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id y4so42643517wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UnzyRxO8LdQ2pkjo8SoYMr5p6k7VTvscFEOudhhqpPw=;
 b=wRylIbBKsXBYTEcXi4fMrOvUpPwGx6YIalHlWc6iBc/xW8q2SrFKtJcs0U11MPhSyR
 QnkgvCAHH8BkSKMeH9fXYquRGPY0BbpI9yIFohNIaLjg80w8H+GeWMy8GBh8HjFX/m1T
 RjXGSbmR4kOxpO9pW2ewGMdVPXymMRU8SlWH+sH+1RnAcEmM8cnvMJ8X8VDYj5Q0Slcy
 jqq67j7ytwD/pMNv2EuKjlJwiW1grV/6GHcp2/kL62sRQuERbS96OkXBGBX3sg7nEmEx
 MBTRINg5aeQstlJpABq3df0RRwfNn7s3NxF13w6YLqsueSfK54KwMLSGdhl/1VukriTG
 bOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UnzyRxO8LdQ2pkjo8SoYMr5p6k7VTvscFEOudhhqpPw=;
 b=GqZL6pv5IvyYn8N8YVnSxfxCReniOer1pSWGCfO1LRzD7R84lggwDY7kImhbHDRKWu
 Fq7vyyALGNemwf9A/9sjz85n5tY7kuXAm48SP88ejRdcOlKzijLJIa3E5QtK053JuBSs
 nmGrDZE4iBgVfkJmLdTIia/3uKhTi2qtlv8iVUHnbq8mtjn2Ye9s7QzQLUeoT7txMZeO
 kxoIsWNuvJcVQIDAE/ysGUO6IMv0Kh0WYwJseqsZOd4RpvUkiCLDurxv5Gsg36feBYHq
 mK/v8nF0QIey20USvE6WDLzmwcLgHFAACXOq+oWrVz7kf/satxjt5Bj+Ip3FjrErQNsY
 lgAA==
X-Gm-Message-State: APjAAAX0k5CXkmrKaSu5nqejxTKPrFxKs4B51uKu7PNYMcVtbKwVH2z8
 fdDRwUNrdH4li89CPn6ooOMAYQ==
X-Google-Smtp-Source: APXvYqzKqMGVeLsUsJdrpxawpOjOzVeFY5koh9k6qL+Wcn/mcZiskMXwLcQTspSzlntpAuHYElSXPg==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr84665697wrr.41.1563878515157; 
 Tue, 23 Jul 2019 03:41:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o7sm14676591wru.58.2019.07.23.03.41.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 21E351FF87;
 Tue, 23 Jul 2019 11:36:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:09 +0100
Message-Id: <20190723103612.5600-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 20/23] tests/qemu-iotests/check: Allow tests
 without groups
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The regular expressions in the "check" script currently expect that there
is always a space after the test number in the group file, so you can't
have a test in there without a group unless the line still ends with a
space - which is quite error prone since some editors might remove spaces
at the end of lines automatically.
Thus let's fix the regular expressions so that it is also possible to
have lines with one test number only in the group file.

Suggested-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190717111947.30356-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index f925606cc52..c24874ff4aa 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -488,7 +488,7 @@ testlist options
 BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
         | while read id
         do
-            if grep -s "^$id " "$source_iotests/group" >/dev/null
+            if grep -s "^$id\( \|\$\)" "$source_iotests/group" >/dev/null
             then
                 # in group file ... OK
                 echo $id >>$tmp.list
@@ -547,7 +547,7 @@ else
         touch $tmp.list
     else
         # no test numbers, do everything from group file
-        sed -n -e '/^[0-9][0-9][0-9]*/s/[         ].*//p' <"$source_iotests/group" >$tmp.list
+        sed -n -e '/^[0-9][0-9][0-9]*/s/^\([0-9]*\).*/\1/p' <"$source_iotests/group" >$tmp.list
     fi
 fi
 
-- 
2.20.1



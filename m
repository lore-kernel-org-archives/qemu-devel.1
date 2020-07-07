Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FE120675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRv6DbNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FE120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshtV-0000Wg-CJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjD-0004t6-Nt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjC-000464-4f
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id b6so43951047wrs.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YDO/x/b94zhIGLCoE0QO5NlUEy4S35DFUXq1lVsSN7c=;
 b=SRv6DbNzX+7Wwk1aRSvwZJ4D4Vy80rygPlGFJ+EXIu/mU/bLf6ZDyD0NuUjQdDURiG
 0lhv2N5UwoVhbqK66W68BcxWGIVPc0SeaZH72ZhmlSrDOcGhs58eAYJ4khg9OK/Pm1Qn
 JenOKeGEY1vKxlmnoH5EC+zhG8rnzEgbJpt6cpxCvZZlAaJzJe4i66waKwpfAOnStRmV
 aO0f8Ig/tD510En6s5ZLok2avf2bo/PBcl+qGYWUlpSFXKWQe4K7HCNFDX9iTfUyt917
 D3cmXoxLfTqSR/qWnuhm5IcwB8dCuKYQ3sSI0mxS/V3/aUI4wLZgSEM7wJGnw8crkDDM
 rbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YDO/x/b94zhIGLCoE0QO5NlUEy4S35DFUXq1lVsSN7c=;
 b=nGOboFVjhzyQh7AST62jZpy2Gb9N5m6Y0sm5SABF6BDPhHULW7Utu/J/hp6W7B2+Rv
 jT+BJCYCG+vo7j0So7m7FhZgATBgu3hUKfc5BTswtFlY2JcF4SmfcLJv4CMCSV2BuCj9
 WUWCFxDnbyUPiEYmBAnRd0+Vis4rLVtLeZfT0XaqB6M9/W+OhwZpohal/ZENeT5z/Qbs
 qD9DfFHoPKO+R2Bif0Kz01VutJJSuSXLyXMLegZH3oun+Yy1EVB6OjVTnEQqWLp3GI3x
 JHunnmR6/n17rArWpGBbRaLoTTLLk6NHbiiZBu3LlbGtW0aRbkrSKvuoZmC7YXa6CqsB
 xxDQ==
X-Gm-Message-State: AOAM531MyfuR4ZWSb/n7Tc+5qsK+QAQdFkjVIT2pPeJVMHujcLBt3ikT
 o2WXsmUBQc1YKfy1BMnzLipy9w==
X-Google-Smtp-Source: ABdhPJwgNggmXBOb08syE7t2gKFfMHJw1GOGZqrzIy4pRiqIV+3Vbz1o9iEf9wHdCDGL9oKBcSo5Jg==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr55959035wrn.179.1594105756726; 
 Tue, 07 Jul 2020 00:09:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm2128427wmo.44.2020.07.07.00.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D16711FF9D;
 Tue,  7 Jul 2020 08:08:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/41] tests/docker: check for an parameters not empty string
Date: Tue,  7 Jul 2020 08:08:31 +0100
Message-Id: <20200707070858.6622-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Message-Id: <20200701135652.1366-17-alex.bennee@linaro.org>

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 02cd67a8c5e8..ebc5b97ecf91 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -47,7 +47,7 @@ build_qemu()
 check_qemu()
 {
     # default to make check unless the caller specifies
-    if test -z "$@"; then
+    if [ $# = 0 ]; then
         INVOCATION="check"
     else
         INVOCATION="$@"
-- 
2.20.1



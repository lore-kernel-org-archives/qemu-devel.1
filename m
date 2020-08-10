Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89779C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F1922BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7z6nRyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F1922BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dql-00056r-UK
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doa-0000HA-Pv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoY-0004ko-OB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id f7so9325117wrw.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IXHFRWhIT8ijPgjKcnwuZX4OYMB2Jdnl5joMznYN9yQ=;
 b=p7z6nRyoyFFTNdzZXfHH/eI+XFfn1u/E2qs1WxAvgvcw9oa1WjS8waJmG7ft2KhvGS
 y2o3ANDXzBb0yZAaigXWTdGTeUQpJ48stdtEohZ6nXVfoQQCbB4lDojxbJWhKaPEsrGC
 nnuZozIoyYQ6jxvHMxZsure1nQs1iaF9HckDvSb4lcT/avZ4T9CxOjuMXfLnvoJxAd6B
 om/J9mam925GSLedf4aUXAJk4NDghLghCLfLuHpfZa0rnP9AV8kaJsGAkl0+hxMbv4he
 2/J6Cf6bzfPHlfzozymNRFOgr0V9y6Vrs6Twf7A3LNe4wR25DYjz8FXJVpTNmk+3KKUC
 ip+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IXHFRWhIT8ijPgjKcnwuZX4OYMB2Jdnl5joMznYN9yQ=;
 b=NpDMUw7CuA+kDskkQuEo0O7+uJc+l4pYCIDa8WVlDiiwPmWGPOiigBbJJ27nqbRe9B
 F01D9cxTIcsqbwoT6pWDn5SKKelo9oh9L/YvngXlXf02Yj6YxWhhlLp3Qt1UP4hdvhiH
 cFqmjQA2UhCC2WGFGNdOLnKCHd08CF2OXOXx+tUOIrGDrBq9XQ3qYeJYwr9HOsnEzWfx
 Az6rDHUrGimbLyTjdkDxK0EiMH5sXemTG1XLt/z4gEPK4n/9C75dFtuXB+v0czjqDdq+
 u1zmffCFJOKlgcfeNHm3Wxs7yBLSrYG2JrjXitqR1dzqHRlDxRS2C9jceBCin+D8AlYj
 0Rng==
X-Gm-Message-State: AOAM530noRy8tkiNi9alrF8hTaWVhBpYCRFqyTdJG85b1zek1YAno6O+
 MEL5jbqW73cr2vY2J2ehp/5DjPc/njbpEg==
X-Google-Smtp-Source: ABdhPJwSS2wl1htKCtgIgJXZNawTsDuuA5PVlIInhWen7i451wRLDGXzU33zT8IkjcuINd/hJ0gKNA==
X-Received: by 2002:a05:6000:1211:: with SMTP id
 e17mr2934539wrx.263.1597089032550; 
 Mon, 10 Aug 2020 12:50:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/20] tests/qapi/doc-good.json: Prepare for qapi-doc
 Sphinx extension
Date: Mon, 10 Aug 2020 20:50:05 +0100
Message-Id: <20200810195019.25427-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

doc-good.json tests doc comment parser corner cases.  We're about to
largely replace it by a Sphinx extension, which will have different
corner cases.  Tweak the test so it passes both with the old parser
and the Sphinx extension, by making it match the more restrictive
rST syntax:

 * in a single list the bullet types must all match
 * lists must have leading and following blank lines
 * indentation is important
 * the '|' example syntax is going to go away entirely, so stop
   testing it

This will avoid the tests spuriously breaking when we tighten up the
parser code in the following commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v4->v5:
 improved commit message with Markus' suggested text
---
 tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
 tests/qapi-schema/doc-good.out  | 12 ++++++------
 tests/qapi-schema/doc-good.texi | 12 +++---------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 9da72a1f556..c6822145c49 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -12,25 +12,25 @@
 #
 # *strong* _with emphasis_
 # @var {in braces}
+#
 # * List item one
-# - Two, multiple
+# * Two, multiple
 #   lines
 #
-# 3. Three
-# Still in list
+# * Three
+#   Still in list
+#
+# Not in list
 #
-#   Not in list
 # - Second list
-# Note: still in list
+#   Note: still in list
 #
 # Note: not in list
+#
 # 1. Third list
 #    is numbered
 #
-# - another item
-#
-# | example
-# | multiple lines
+# 2. another item
 #
 # Returns: the King
 # Since: the first age
@@ -68,7 +68,7 @@
 ##
 # @Base:
 # @base1:
-#   the first member
+# the first member
 ##
 { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
 
@@ -116,7 +116,7 @@
 ##
 # @Alternate:
 # @i: an integer
-# @b is undocumented
+#     @b is undocumented
 #
 # Features:
 # @alt-feat: a feature
@@ -134,7 +134,7 @@
 # @arg1: the first argument
 #
 # @arg2: the second
-# argument
+#        argument
 #
 # Features:
 # @cmd-feat1: a feature
@@ -143,6 +143,7 @@
 # Returns: @Object
 # TODO: frobnicate
 # Notes:
+#
 # - Lorem ipsum dolor sit amet
 # - Ut enim ad minim veniam
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 6757dd26a2f..4c24eb96486 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -74,25 +74,25 @@ doc freeform
 
 *strong* _with emphasis_
 @var {in braces}
+
 * List item one
-- Two, multiple
+* Two, multiple
 lines
 
-3. Three
+* Three
 Still in list
 
 Not in list
+
 - Second list
 Note: still in list
 
 Note: not in list
+
 1. Third list
 is numbered
 
-- another item
-
-| example
-| multiple lines
+2. another item
 
 Returns: the King
 Since: the first age
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 7f28fb7a0fb..12808989ffb 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -6,6 +6,7 @@
 
 @strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
+
 @itemize @bullet
 @item
 List item one
@@ -20,6 +21,7 @@ Still in list
 @end itemize
 
 Not in list
+
 @itemize @minus
 @item
 Second list
@@ -28,6 +30,7 @@ Note: still in list
 @end itemize
 
 Note: not in list
+
 @enumerate
 @item
 Third list
@@ -36,15 +39,6 @@ is numbered
 @item
 another item
 
-@example
-example
-@end example
-
-@example
-multiple lines
-@end example
-
-
 @end enumerate
 
 Returns: the King
-- 
2.20.1



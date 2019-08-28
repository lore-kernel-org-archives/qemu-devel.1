Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270DBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C0A20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h5O45xVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C0A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2wzW-0004Y2-UP
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wki-0001Rs-1x
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i2wkg-00041N-QZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i2wkg-000412-KV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:08:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id t16so2254003wra.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KSEgW/RlIiuzqLmIOofMJWxF7Te87Mr+srbDIEOWTAs=;
 b=h5O45xVMIE/aXUkqO5qAyhAgGRse5ewMDIdqI+Vahx3q0FDwg50rI0w7IIfsf7F1wW
 aKXcfRfYNxfz9v9+2jeO0itagNxgCzTsPP3ThFbisdBS0STjMoVjDllOsscbeAL8q0Z1
 bmo+8atk4TaunVHAwEM5VyuVl5Ur39zircQ0NhY8MG2BdghXx0yP1yYHoLHJtlw+KfG5
 LfCLPbgWRIfCsNMF68ET7PDTeesY1WirOMZCFc8dGnNSOeytQD85P10YmhbT6a4KZ/jQ
 sbVkOEjnNLUHRfQQAfTkaqkktXyN664ZZY9MSdKMNEzyMeqKjbe8vWzssvnMKt7SmSRr
 Mc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KSEgW/RlIiuzqLmIOofMJWxF7Te87Mr+srbDIEOWTAs=;
 b=c76iKRSZNYLN76Inoj16oJSsjvqrd47jgr6Ycislvy6xOCnp/0vOSTFHjuBAYAdol1
 H7NO2Nwu0om0RuDx4w2wIIfCO5JvJEgyaXxF7F4fWtg5bzE03zf8CIYNcGydjVIFhqki
 DroUfqH/orJ3J9bQegeGN1NGVV32WUw223/0/hgYLhuKX1Tk8DYog//DvMLzIW0BjekJ
 pjOVrYnRJbkqaz7vbjWqzE6JE+/jVoG6NVFqs6+yOKN/LhgdbGut15PdTlUXNeUXD4Yb
 B+PaLSdpyUDAaOuo+k60GLJ+bWqXZ+jQXmuKT3X+uIs9bgojpymofSbbeyLRB/9L2oZO
 04Dw==
X-Gm-Message-State: APjAAAXpjA+HDbNQLctb0SqCqcZ9Narohn/7oFE+/B5Ho65QN/qXNaWu
 /cmiBqB2AmgHbdO+ZLE82aHAMg==
X-Google-Smtp-Source: APXvYqxj8wPQIBI1C/MYMctXtG9Kb3Kbk2LYjlqca+98OaopOkHYc4/BMq+TMpp/j5bUZBDarE+SXQ==
X-Received: by 2002:a5d:4f8e:: with SMTP id d14mr4378575wru.207.1566994117512; 
 Wed, 28 Aug 2019 05:08:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e13sm2599327wmh.44.2019.08.28.05.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 05:08:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 043E81FF93;
 Wed, 28 Aug 2019 13:08:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 13:08:30 +0100
Message-Id: <20190828120832.9208-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828120832.9208-1-alex.bennee@linaro.org>
References: <20190828120832.9208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PATCH v1 6/8] .mailmap/aliases: add some further
 commentary
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The two files are not interchangeable but a change to one *might*
require a change to the other so lets flag that up with an explanation
of what both files are trying to achieve. While we are at it document
the many forms .mailmap can take in the header.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .mailmap                            | 14 ++++++++++++++
 contrib/gitdm/aliases               | 20 ++++++++++++++++++--
 contrib/gitdm/group-map-individuals |  3 ++-
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index d0fc1d793c6..0756a0bf66d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,18 @@
 # This mailmap fixes up author names/addresses.
+#
+# If you are adding to this file consider if a similar change needs to
+# be made to contrib/gitdm/aliases. They are not however completely
+# analogous. .mailmap is concerned with fixing up damaged author
+# fields where as the gitdm equivalent is more concerned with making
+# sure multiple email addresses get mapped onto the same author.
+#
+# From man git-shortlog the forms are:
+#
+#  Proper Name <commit@email.xx>
+#  <proper@email.xx> <commit@email.xx>
+#  Proper Name <proper@email.xx> <commit@email.xx>
+#  Proper Name <proper@email.xx> Commit Name <commit@email.xx>
+#
 
 # The first section translates weird addresses from the original git import
 # into proper addresses so that they are counted properly by git shortlog.
diff --git a/contrib/gitdm/aliases b/contrib/gitdm/aliases
index 07fd3391a56..c1e744312f5 100644
--- a/contrib/gitdm/aliases
+++ b/contrib/gitdm/aliases
@@ -1,6 +1,22 @@
 #
-# This is the email aliases file, mapping secondary addresses
-# onto a single, canonical address. Duplicates some info from .mailmap
+# This is the email aliases file, mapping secondary addresses onto a
+# single, canonical address. It duplicates some info from .mailmap so
+# if you are adding something here also consider if the .mailmap needs
+# updating.
+#
+# If you just want to avoid gitdm complaining about author fields
+# which are actually email addresses with the message:
+#
+#   "...is an author name, probably not what you want"
+#
+# you can just apply --use-mailmap to you git-log command, e.g:
+#
+#   git log --use-mailmap --numstat --since "last 2 years" | $GITDM
+#
+# however that will have the effect of squashing multiple addresses to
+# a canonical address which will distort the stats of those who
+# contribute in both personal and professional capacities from
+# different addresses.
 #
 
 # weird commits
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 05e355d30ec..1c847174380 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -2,7 +2,8 @@
 # Individual and personal contributors
 #
 # This is simply to allow prolific developers with no company
-# affiliations to be grouped together in the summary stats.
+# affiliations (or non-company related personal work) to be grouped
+# together in the summary stats.
 #
 
 f4bug@amsat.org
-- 
2.20.1



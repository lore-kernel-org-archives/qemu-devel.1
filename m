Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBE9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955FA206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClTW9mEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955FA206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNmU-0002Zo-TL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUt-00077H-70
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:32 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNUp-0005i7-8H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:32:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id y20so15957894wmi.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4LEU0pltPGXSZOYL7F80Ql3BPnvdmnM8vPzgdqbMG+Y=;
 b=ClTW9mEP2z1SuAZrbYrN4X2uyDDtTeaMHTMAuXtQb0dWLZ7UR/tU9sR4XnTOKCVcYo
 10R5TGdKkfpm9h9E6Mfs7fRDDbZ8zKKrQ1e9EoxFYXA2HnkHhp+Fh9LY7dLVvFZgXmk3
 nJ1xxev4DfzGB6vxdA4eQzrBQpS2xqN0hvGoeMCot1tAooqIhQ1m/M1NOtsPEBa9scpq
 1WOMm6wEmF+E3L+7Tonqm+Y3ZD5KiQGTZrzLk5e4Yr8drt7+lBqQJJE6gs0PzhW+Qwih
 bwDPP3WPgmugRSAJ5vYid0YEMdFrJGEIVagVckv//ROeuvx9D9KQIKdfIg0QNCSYKjnW
 2IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4LEU0pltPGXSZOYL7F80Ql3BPnvdmnM8vPzgdqbMG+Y=;
 b=JMjQBW/Dqpqz+68gSwqK77cF7iefdGNFSVrkoe/72a1I6r1q9xFtDebYW0RQNRXlu/
 icoJ3kL+Wd76tb/qiaVCcEfRgoSaJswXQCGMALsDduSBL9XDKavI31k+XfSD6Qg+LOVo
 c3UAJtygXgMQRGbKdRP6SbG3tQHQCdXWNMWn1i0EbXnsAtTe2XkBeXKM71sjPW0CRYU6
 kfWgmpYTHWTC1WFuAuzDNUb7i6dVkAWZ1oQqy9qwyS/9kHHUxeoEXrYT8re/xQkTObtp
 jfg05iZNiUrE1Yb1+oJEWwpI3x3clwMsEsgoo42aUxE1A+hynRCMq6uv0gaigKf7urMM
 XWjQ==
X-Gm-Message-State: AOAM531sN2V+Pmzn5/5DHEfwHgFox2eyY1kvewmKFqz91wqTYIYrjtIw
 uE1RR7JTFxhUQd7/Q4F5ILcWUw==
X-Google-Smtp-Source: ABdhPJzem75xc6RN0sszS/iqc9X5FMbeb2RGvMm2eiWSB3XX0SgrcpOvbDmNws5HlQXFPPdGc9zpEg==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr20322718wmg.16.1592836345796; 
 Mon, 22 Jun 2020 07:32:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g16sm12906153wrh.91.2020.06.22.07.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:32:20 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A3FA1FF9C;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/18] tests/docker: check for an parameters not empty
 string
Date: Mon, 22 Jun 2020 15:31:59 +0100
Message-Id: <20200622143204.12921-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 02cd67a8c5e..b27ce17e333 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -47,7 +47,7 @@ build_qemu()
 check_qemu()
 {
     # default to make check unless the caller specifies
-    if test -z "$@"; then
+    if [ $# == 0 ]; then
         INVOCATION="check"
     else
         INVOCATION="$@"
-- 
2.20.1



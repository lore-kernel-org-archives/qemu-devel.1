Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A995C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F2620674
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMcpUkgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F2620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPS0j-0007Vs-Ep
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPRzR-0006td-Qg
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:01:25 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPRzO-0000aW-SY
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:01:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so1260384wru.12
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QOHe2oYrgTMeKrwE6+D3djK5XE0/uX0gytH265nYLwY=;
 b=UMcpUkgyb25m8gBSztZHpT2Vm27KCm0q8LvZB+1B2MjKsYRKU4e3AQERI0gsXVeqn+
 YWDTVZ322gwur/jJwaLSb1Sc2wOKi0T1+5LNwPFsFCPWdousgnazTi5dF46z8KCXRV+3
 4HlezkfXBrdlLgEmfZn6fxd0+nHh9aYfDidF08b4ybKewEapgVZcTZcR35veJK/5g6Ul
 dy+swqAtbRnayOYUZkJbtu+3k7WnJqnwqiUia5pxEuvCtWBj+dm9N5YB1UyGG2QlAB3r
 HIOIOBGStqONlO6BEWRBpxpqZHpGSCVDuZF8xvuP+0+hwWKRIcoEUYmdvPy87kViaOEr
 hRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=QOHe2oYrgTMeKrwE6+D3djK5XE0/uX0gytH265nYLwY=;
 b=iPT+epcvqCk5P0nGWvZP9s5cCaOJNQ3Odcd27cWwtYxTr8PNKDCxZ0jq/gznW+RIjw
 A6tJyoEQk46II/YsYkrKRGe/7DhFVwPahRMZEylSgTaPRWgBZ+I5w8VJ7RXADiHN7qhY
 /8AIf+OcHGZDZWcubcKJgIikA8mhyfvmqd4razLb7Iu2ntNrFo+gkbpabTcyBbgCfZOR
 hnEGzLnb5r717zEQtFhsXQim94JR8vrIA8TjTPJv+Ir2VdfySwRnWcgpL870OJpDhamx
 vMeZ+snwcRovnbLyXkkQtSVpsVIL2BkC40ocqJiZNFCUya9YwgseuxY4iPAvrsm6nYnf
 kE3Q==
X-Gm-Message-State: AOAM531m8gcoIORdEzWM5Hdq6o0D195aE8PgFFfRzoEjDcL8GVGGdBBy
 XWgY1QLr4w6Gd5A85MSax6X23U0ZCYI=
X-Google-Smtp-Source: ABdhPJwFPTOyjZ48OJxWdB8wRXKDX41nD9Y2y9ybrM8boCS0sjb9HDgsHGhXxYPt9X2IgoWS4UN4sQ==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr555242wro.2.1601910080975;
 Mon, 05 Oct 2020 08:01:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id i3sm309688wrs.4.2020.10.05.08.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:01:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] readthedocs: build with Python 3.6
Date: Mon,  5 Oct 2020 17:01:22 +0200
Message-Id: <20201005150122.446472-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The readthedocs build is failing because we do not support Python 3.5 anymore.
Bump the Python version in the configuration.

Fixes: 1b11f28d05 ("configure: Bump the minimum required Python version to 3.6", 2020-10-02)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .readthedocs.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.readthedocs.yml b/.readthedocs.yml
index 8355dbc634..7fb7b8dd61 100644
--- a/.readthedocs.yml
+++ b/.readthedocs.yml
@@ -17,4 +17,4 @@ formats: all
 # we require for other Python in our codebase (our conf.py
 # enforces this, and some code needs it.)
 python:
-  version: 3.5
+  version: 3.6
-- 
2.26.2



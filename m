Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DB8C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C8E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgihsrZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C8E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGO9-0002I0-3O
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMm-0000H1-JL
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMk-0001f3-1t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMj-0001TX-Px
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:50:57 -0400
Received: by mail-wr1-x434.google.com with SMTP id y2so11392628wrn.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6P6zv/6ofxs/2NCuAiUr9RMgFMe7GhXKsA0Z+BVz5bQ=;
 b=YgihsrZ54bnA1c40o3Vr8+QqmMt3O5w3JPapOZCabBRP0GV6qFJfS0IoH5QZIFRV9H
 oDkU8AGnrkZ+y4TmpYCn0PGZaMveg3igNs8HLCFyCORr6DpXKmWLlJYxVzbiukCzvIgJ
 8GvuVc2jSBImvFCWw1zS9HCvw5bV/HgbsiyEExoSsLolFEn+acAlSZVtbeiONtNr17XW
 pqEhW5+wufJr94qxkk6XGpHzQ2oiJX4qyr9J5rfhOlPHSd/WJlusNocnnm58Do8AATMj
 91k2A0c619Al6rm8irl7ys65QTgLVP/OtbvXAOYXc1oZHGlJtkRtxLUmBWrHeLMEBvdp
 MogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6P6zv/6ofxs/2NCuAiUr9RMgFMe7GhXKsA0Z+BVz5bQ=;
 b=OznHl8OwhUfW5khcG0died25MiL8fwyZBQT+R4tDDUPorLa4iFaD9DJePCJ+pZ+gqC
 rhDzP5IhQuE/9ZvYHzuNrrS94buwie6iYuuOZvngFJmUTc3Xzpd5zqp7PULl0fOyIIcF
 lW0VAmcOClYCV4gFrJk29OZ49bK/fLhFmJehweYQSKK+EGfsNfmAjPXd7T2OeCnTj6V0
 HKLHXCacdirSCg149ldSLr+ZZVr7ZysxWNH0SF472GVAFz4/sLSJTrQ1VGxL9WyvpI43
 xwT6eioA5MxPxYnZvCianMC0Kn2Cv7EOAWh/aOqWWWu/w7omx/l4kztixyYFgzh+PMyT
 poUA==
X-Gm-Message-State: ANhLgQ3wFTimcQIok1lvLlzZHFGzeNcZvYHr0aAgWfqwVPgZWGLRhP0V
 R4tz7JM/qhbc4EcK3MfycSjNjA==
X-Google-Smtp-Source: ADFU+vvRuCN/6j+X/I908P4E57EOtBj4JX+TuWOHJZ1SPCMIzxi1CVXS9qRdcWSHM0trqA54hgestQ==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr197284wro.226.1584467456614;
 Tue, 17 Mar 2020 10:50:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l5sm223591wml.3.2020.03.17.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:50:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F85F1FF8C;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 02/28] tests/docker: Update VirGL git repository URL
Date: Tue, 17 Mar 2020 17:50:27 +0000
Message-Id: <20200317175053.5278-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

freedesktop.org is moving to a GitLab instance,
use the new url.

- https://www.fooishbar.org/blog/gitlab-fdo-introduction/
- https://gitlab.freedesktop.org/freedesktop/freedesktop/-/wikis/home

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-2-philmd@redhat.com>
Message-Id: <20200316172155.971-3-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 3b860af1068..b67fad54cb7 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -27,7 +27,7 @@ RUN apt update && \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer && \
+RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
 
-- 
2.20.1



Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E6ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D2F2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocmx/8Ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D2F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNaMq-0005Aw-0v
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGU-0001yk-Dn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGT-00042Y-AU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGT-00041g-4O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id q70so2188553wme.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5vC+pMfoHMRBCEotAUlhODbfmp7Q411uv5PGK4WJaWY=;
 b=ocmx/8UbiQhHb5b5H126z557EjDX7hcx7uzpP5T+xv+ArcQP87r6gzmqWe49dRK68q
 LYSXY893FsEbg4TuIbfeK/2PfN1GmVUk2EEHdBL7cU9ytJooSHeYzqWDqM7zNjN0WQQW
 CYF9zf9Drl5jlEwrHFfhZkeWG9JUQ9s5oN0fj5UwQYqLOp+elq7vNCENtNOSoWplow5N
 93DCzH5gXG23CsPU7wXsm/B/8TO/2Gfi4z7l1eK+LMOTmyPdHuOoDwaLvnAmE3yCwPdm
 Bs4za/nWUvP1rAs4JAiVmpz/9KnBKtO0j3PGa16Zg8SKWM/5Ofu9Ky0bv15TRnV7NQLN
 P9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5vC+pMfoHMRBCEotAUlhODbfmp7Q411uv5PGK4WJaWY=;
 b=No1kVQc+1IpR4DHEZ/wMAPSZ9hpTt05nrmgDgnoKWRIxvJMUimWkPJJvw7x3MCprp4
 jwXIA/hG62RpLEXCsyd2n5fYcvvmEiD15KNjWXQBUDpUu5AgveVL9c63+e7+fVwWdDiK
 r1Ylru9OiVkUa1wjdaSyJa5rDeZ3xIcVOZi0cQhz566f1u9h65NZZbfTfJV3nSRJrbGw
 J2jUA7hpHsmxlICZgIdB9mvPwa12GaLuv7Yw/Xq4zqEUwN/lwaHIrvUEWbnZH63y+1Hp
 V6zJXvBYThy8iSt03YrfMpggXgq71M/WsBsIFdrhAueDxWGtC2hyPetfNCQJHMg6o1ko
 fBAw==
X-Gm-Message-State: APjAAAXu9rs+CQ/TBwqR06B+8KDQ/csCv0GrHihl3kX+1lp5VtNYH+7W
 UNwA/2qMHKKYAUhVw7QAhr5Sug==
X-Google-Smtp-Source: APXvYqz5XvQP2MQEW1krSQdFJs1oVkrYZrrHdcD0w4Rc448JTxx+xjGj+GDqyQg5k3gdShF1YoxCSQ==
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr3836445wmf.159.1571912564011; 
 Thu, 24 Oct 2019 03:22:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a4sm1869609wmm.10.2019.10.24.03.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB83C1FF91;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] travis.yml: Use newer version of libgnutls and libpng
Date: Thu, 24 Oct 2019 11:22:27 +0100
Message-Id: <20191024102240.2778-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

libgnutls-dev and libpng12-dev are not available in newer versions
of Ubuntu anymore, so installing these packages fails e.g. in the
new arm64 containers on Travis. Let's use newer versions of these
packages by default instead. (The old versions still get tested in
the "gcc-9" build).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191009170701.14756-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index b446e04e8ae..e65e53f3d7e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,7 +29,7 @@ addons:
       - libcap-dev
       - libcap-ng-dev
       - libgcc-4.8-dev
-      - libgnutls-dev
+      - libgnutls28-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
@@ -37,7 +37,7 @@ addons:
       - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
-      - libpng12-dev
+      - libpng-dev
       - librados-dev
       - libsdl2-dev
       - libsdl2-image-dev
-- 
2.20.1



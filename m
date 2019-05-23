Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9EFC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548E520851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PacjGqR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlGL-0007Kv-KR
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:47:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2i-0004LU-SA
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl2g-0006ZW-NS
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl2f-0006YD-MD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:33:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id m3so5679297wrv.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U7WirZ4xKeMbMxcY96b9jNQO3HlUTGEeG/vNICAL7pQ=;
	b=PacjGqR/f2kmB3AZYCSTcJ0sUmAxsyG6kM9R5D74PRopjLSJHyDHTQwej8sguNFtS1
	EoLgKSufHkNVOUG40IH1vY4NKxkiy4jt91JnvTGEiYiMT7tYFcYLinSl/YZAxLLdlNZy
	rUYSwFQtai2N7nhGxiIui/o9IN0q0s/Hn+vqaYlMxE3jQgg0yps6Bl6aqpwQ0XMh15dR
	zkFmwYbRB/Zax86HZDlpIWl2RDTgQmElK9+gyjzYCu3ofCAlfYPSEFis8ufrcqBuUBWe
	r7SYU4MaQS2P8lmQC4It/5C1+Ku0PnSf5mZ5GMqQYMmLOow5tMRNFiJ4JKc40tx0D8ZA
	Afnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U7WirZ4xKeMbMxcY96b9jNQO3HlUTGEeG/vNICAL7pQ=;
	b=EvDnQ0hom+Pb4Ty1ofTadxAWsa7AYXsQLH0r5X33iBTMPxcb5y99FabvuI46ruqypb
	EpxypcQbTSWQmI3FtahxkFaNFrSU/lZHhe02VPGjKhOQC9yxKq3OaC1EjM9FAsmF0llj
	w5sEi/jr/OAzr6mYLyMj+rWTyF+XPwiweH2aL3kXhtP+NewXkkHVY24ZQIGoWiWVmKdp
	iQcrx3Hj6ARRN7VxwijlSHaCMOpeovBs8oWIiEUjlfk6yhWAOAfnjUTOA31Q9pmXpXuR
	4mBrPrA3Jj/a1jePLtYZ4U6CN/wjt4AlMK/DZ/6MtCUfDXoqFQQHHlTQig9bJO5USCSu
	nz3g==
X-Gm-Message-State: APjAAAWjpLRov/Z8J6Ht2h8ML32jhfTB1SH4MQil7xKKH4Mhypf23R8g
	TaOwkK/XN6C1D2u6kuZ3XBDOWw==
X-Google-Smtp-Source: APXvYqxRT0oloiTvR8GZ6A6rY1TJ5l3wekvFagIWa6hJlUKWMp8sn1Nt7e3tB7cdqmmRJRu8GXqPtQ==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr9644661wrm.151.1558607623561; 
	Thu, 23 May 2019 03:33:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s10sm23788922wrt.66.2019.05.23.03.33.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:33:42 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 676161FFAA;
	Thu, 23 May 2019 11:25:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:26 +0100
Message-Id: <20190523102532.10486-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 22/28] .travis.yml: enable aarch64-softmmu
 and alpha-softmmu tcg tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 6fd89b3d915..b053a836a32 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -284,5 +284,5 @@ matrix:
 
     # Run check-tcg against softmmu targets
     - env:
-        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu"
+        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
-- 
2.20.1



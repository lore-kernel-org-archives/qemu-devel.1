Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41B0208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkhSg1Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41B0208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYzY-0002Wz-Sg
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:06:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYtf-0006LC-22
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYtd-0005VI-7C
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYtb-0005Q1-Jz
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l2so19504874wrb.9
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=kpShySiWy3l2UEoMR7e5vE7RIjHCSmX22N18+VLA+QY=;
	b=EkhSg1Z8xuAx+kGiEPZcYgXOnnOtCAid2TQqolLnLOCKILjMYPwdvpYYFVo6fL5zpe
	FnZfqQKhslUz32ipb6c17ioJY912nupRK625grQ27XsbH+u50MtgSVHfMdhh9BFfMd7p
	wwX58IcpKGv8PoEa1mZ4ViJGQYGNHNYX9Z8Z/dsM7IxxJBagv+ntNL2sDKoWeSMoK/An
	12V54DG9LYHaHqSNMIPh9djG6VguZgLz4EN9iBF4g0vLkbx/URDSngB+hflDGbAVqhd+
	zjQxPEsClGjtd68GNI3nyYeaZ5DmYjW07gP94LbnQbfscvAAq2ZgpWwEzGKxi3dbwLno
	lHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=kpShySiWy3l2UEoMR7e5vE7RIjHCSmX22N18+VLA+QY=;
	b=j6yLmG7LPH7xtADi42NK03ZS++XUKFclUzARZjvzh9Nu7XGJKyFyxXC6+qWiZXdNoM
	UWo2XhG1eKH2FsHexyaYyhcwkHWaZ1/lZkBBXToOaNFxzWqIfspHLHsGbwugQPLjuEDj
	x23zISc24aL0rLPNlqDeDrRe1ysxe0Dd0WuVH8mv3EaTSN8oAccFH/7CoMpsVbjl67t5
	I5nocx/FwLA8EpQUnU/zwg+IKqbIc/tacAwS3oMb9cOazDV16zyWo/sDxj4iib6jwaEb
	a8jgT1MR8d2NAkrF+Am4KvUzvFZTwhd9Bh/Uxp11T8SObrDDWBl9nioCEhbviZiNBPwG
	VcbA==
X-Gm-Message-State: APjAAAXF1/kwDwipBWx9WnkHk/2SYWBYRTaXbxElx/wBW4lxx64mZn9M
	NQrWiRPvrUtc7QTB3Q+i+iLIfg==
X-Google-Smtp-Source: APXvYqw8Q8k2DtJ4iKmBxORbpspQXHq2qzbP/SFfe/G6hB3eHz3Yt5z/LSnjZnlUXOK0owEnKmR0YA==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr12674092wru.326.1559037588940;
	Tue, 28 May 2019 02:59:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f7sm1527452wmc.26.2019.05.28.02.59.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:59:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6AB661FF8F;
	Tue, 28 May 2019 10:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:47 +0100
Message-Id: <20190528094953.14898-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 22/28] .travis.yml: enable aarch64-softmmu and
 alpha-softmmu tcg tests
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
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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



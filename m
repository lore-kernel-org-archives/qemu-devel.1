Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02416C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07072070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSwYB7WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07072070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Kt4-00077K-Rp
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Koa-00036a-MH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6KoZ-0002QU-9c
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6KoZ-0002Pn-3x
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id s18so7850222wrn.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6aSDXZV12+Yb+O7zHlWgDpxv7rNjm8/B+pXS1On7uhI=;
 b=QSwYB7WZHb8rBCAP1KiMJE8V3oOcgEO6ZLUDo76WWcg6kbhIqEr8IXMUBo4GmyRGQR
 ke+eJe2LpQpHZRBPAfYA/0HBiFD67CpJVLRJXhlHLHwz+5tdsaw7rSrTktAb8SO8AU7m
 oPZq3i6vOF+3S5VISUrP5Nvoe09zk+/BwgHu31xNlollfe6VHET9XpqGNdy6IjkD4ocW
 y42IV0ExGkdsKaAAn8Ce24SDo0xVbQtU0+I9K2JiUw6ZcILICxBoias5we9FxdG4pDCr
 a+lj63a0N96Yh5l70ZKbjam35ePzl+tGKoc0vVygvHiOWy6DwTxfTx0hj8Q9s649loIv
 o44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6aSDXZV12+Yb+O7zHlWgDpxv7rNjm8/B+pXS1On7uhI=;
 b=aGKCOUjyTGwsTP6gqdPRzRyAJuKEpQDv+3a2iAp7+xV+s/IZCLTQXZ0dEMk5hzaagv
 2u+qVqGEpkXZtNOo3MYZr+TjMCTWEGkNAJY2mi0zh1ScVFfocI9gDiTtp+U6A+fVbvS2
 rDdse1YpWn10Js7Y0Uj7RA9a7HFJR6P7q04sPMPk8z0B94YGG0KLt31HGf5P1evRNkGL
 XB/Ff3Ezvg8v8Lxm09/pd8V5UvFdmtvlPqlbZCrRpB3Ds4Ga8rNeH+i62Rh/TUMeL44h
 /kOo7thwwpqluRveag515n211HEtWz2Pj7qHI4GOFg6wEBhYImpdY3Thc3E2ZPqB54l3
 6aVQ==
X-Gm-Message-State: APjAAAUev11hFbk8tOLZI1mgrs5J8wGZmKqLqbHof0m6REbPw/lKlj2w
 D1D5LAf9CaW1aLmTcZxN0pJyow==
X-Google-Smtp-Source: APXvYqw4J60/Tx3oRqMQ6IW8juZeE1M9pscxdSQkjaSZ0r6Q3paHUCsqbu1oejYwFkdG4slNp0JT9A==
X-Received: by 2002:adf:e607:: with SMTP id p7mr9210591wrm.230.1567801597821; 
 Fri, 06 Sep 2019 13:26:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f66sm9379143wmg.2.2019.09.06.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 13:26:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2874A1FF87;
 Fri,  6 Sep 2019 21:26:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 21:26:31 +0100
Message-Id: <20190906202636.28642-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v4 0/4] semihosting at translate time fixes
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

Hopefully this is the final version of the semihosting at translate
time patches. I've applied Richard's IS_USER changes and gated the SVN
for !M profile.

Alex Bennée (3):
  target/arm: handle M-profile semihosting at translate time
  target/arm: handle A-profile semihosting at translate time
  target/arm: remove run time semihosting checks

Emilio G. Cota (1):
  atomic_template: fix indentation in GEN_ATOMIC_HELPER

 accel/tcg/atomic_template.h |  2 +-
 target/arm/helper.c         | 96 +++++++++----------------------------
 target/arm/m_helper.c       | 18 +++----
 target/arm/translate.c      | 24 ++++++++--
 4 files changed, 48 insertions(+), 92 deletions(-)

-- 
2.20.1



Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80BC31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634C9207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYiyGj30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634C9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haM11-0000t7-Ei
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haLzk-0008Ob-0H
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haLzi-0006Dc-0w
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:13:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haLzg-00069q-13
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:13:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so9580000wre.7
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bCQjupjYbPKVI6CLraG6/Ohy3550ckI72zFhxI728pU=;
 b=EYiyGj30grQs3rltyyXpC2Ml5GdzQmng4jVzCRZKNpU0NEHIpnvSCFucwuo8sxmydK
 /npCBy5tk17yfTD4YPxdN9I5RT46jJx0sqMnFh7x8tOm9+g8AssdwNpoEuJfgHd654ny
 CD3UnR/MzuIMwIDPcqxRiF4QZg8vE1UsmSuc5Ik5tIirZVVVwHMfJ9UgxR8Vc6hJtMOa
 Ok35sbMhIMGh4S3bqHfzux9gsYkmfZjA++gSjllU9zgERc5sKpQHmKsWp7gU9BygHUH0
 ZF2ZsRFkBnqsel0z7sESk5ME53ovG1wjALJyQBkrl6fJU5ujoE5HKsLG4ZJZu0JNiEwk
 sUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bCQjupjYbPKVI6CLraG6/Ohy3550ckI72zFhxI728pU=;
 b=DWZEPkIUwFTJiNTFMAntjLJe4bR8XeajDgZaky++iHC4yDO6CLgaVVrG+dIFmMCiH6
 IC6m8amN6udY+6ClB7GgAdX2zPHTzaL46miwonaxMGVfkG2mofhjUi52mBVeogBVxAhI
 bvIaBjB3TZeSdHuvdHSrGSlYo2iOMPqRxjYnZ42gHLZzyBNKYCpAOGLO6sA8F8B1rqCl
 L2Z95cV1q4JmYe5nTopj8MPXHK1hc+WM9rNN5+qLTph/IN3f5KzrMAGCzF9H5yfwqu/A
 2fAG8YEcvjrQG/ke2BHLbnViWrW8JWH+oF/PHp3p27/FGjO3LNvY89lUtK1v6G+ksELT
 GUeg==
X-Gm-Message-State: APjAAAXTvKPpg53sPuKpiViWJvzky2mOOvMUOZaTGgw7ZT8FotMANejf
 43UkiJsLaLsfa7VCYINOmYaIyAszTMg0KA==
X-Google-Smtp-Source: APXvYqwYyypSCvF06y00bZOgbJolBa5kMhn8pLQ8NHqV1JeVn+l49TRDHsJYB12nrarVS3SU5u6LaA==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr2699949wrw.189.1560179629670; 
 Mon, 10 Jun 2019 08:13:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z5sm9409753wma.36.2019.06.10.08.13.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 08:13:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 16:13:47 +0100
Message-Id: <20190610151347.13212-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 0/2] docs: build and install the 'specs' manual
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the recent addition of the XIVE documentation, we
now have some actual .rST format documentation in
docs/specs, so we should start building and installing
this manual.

Patch 1 in this series fixes up some minor problems with
docs/specs/index.rst which we didn't notice because we
weren't building the manual. Patch 2 adds the makefile
and config runes to do the build and install.

NB: there's a trivial textual conflict in Makefile
with the 'convert qemu-ga' patch I sent earlier today;
this applies direct on top of master.

thanks
-- PMM


Peter Maydell (2):
  docs/specs/index.rst: Fix minor syntax issues
  docs: Build and install specs manual

 Makefile             |  7 ++++++-
 docs/specs/conf.py   | 16 ++++++++++++++++
 docs/specs/index.rst |  9 +++++----
 3 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 docs/specs/conf.py

-- 
2.20.1



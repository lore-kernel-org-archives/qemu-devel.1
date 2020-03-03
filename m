Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A8C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1553D2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwM8UelJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1553D2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j999C-0005Op-8y
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j997r-000360-R7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j997q-0001is-Pp
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:27 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j997q-0001id-DI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:06:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id z11so4737335wro.9
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=40VqK8jPsAfNiKDMmU2z329LI8OTUlE5dvtFHurUE+4=;
 b=rwM8UelJcrf01vLIzE1olQpEALJFMmI9IHa7TINXAimc9to5hmiwNgESL6x5HxduqT
 vQ3uP56U8Ujfi0TaIx/qSXnk/VMED0LqSH2WZka4JPzL+G/9X089dgMMeuXgfulF/6dP
 RsGS5YzFHLOKSMD1UcGg3uqNc4fylnxF55W2YEpBU0Vg7dhEd10tjXH3BIZYnhslnZYW
 9xR7N+WtWMJfvlSt1KRpFpzXTJJOJ0SbFMJcsprfYHLCVDyTSWCYSDd3QAUwptonuWt0
 ixfr8fEi5cpQZ0G112gqfOG9zZpwF4XLva2S53GXti8xhfUzJzlO4okdu3gM87G1dWzP
 I27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=40VqK8jPsAfNiKDMmU2z329LI8OTUlE5dvtFHurUE+4=;
 b=fqy0qe/sTifh+KWE3O5yLcom+YtEvbMYY9zu45Hiht4fLiZZ4c1Oe2PiXpEzWnEHgo
 rZXT5pDIffLRWjtiYdskdzP0oK4lTHGTrJo768NNpOMLq9HSe1ki7n2asWEFyJqT1jWV
 Ii/3pRu1TAKLNp/aRa6jN5MRu3TCv3gZ3BE6qk7ct4ZDvhydnI9YlKuwpLcbuiO+SruZ
 G+L4hTwnzY+Efji/IPK6zzAHrjQqIXGlOjubEHMYv8DhuaG8M/KwejU42m6PaLhPb1YK
 FZ+uamUVLX1Mv/wG7iNFe6ckqbrhOijvn0lsa+hrYZMCQYARhM9D+WU9MfZD+7o/KBMR
 QKOw==
X-Gm-Message-State: ANhLgQ2wLmos4TuRbOQ6W2VTeHjYZST6rEg2QmgJvJAdXsieXk58gSmD
 lXg9Da27SPHA1G3txJNN5+QtOcU1rr8=
X-Google-Smtp-Source: ADFU+vsGBHBbSIp/k8GHAu26zrAFv//fGgjx7ge4+tm5+tqyb3z96QshCi31RMdydHT4b4CXYTG6fA==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr5558398wrp.97.1583247985341;
 Tue, 03 Mar 2020 07:06:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 4sm4067513wmg.22.2020.03.03.07.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 07:06:23 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6928B1FF87;
 Tue,  3 Mar 2020 15:06:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/9] testing/next (buildvm and re-greening tweeks)
Date: Tue,  3 Mar 2020 15:06:13 +0000
Message-Id: <20200303150622.20133-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Hi,

The main change from v1 was bumping avocado up a version instead of
moving the skipUnless() decorators. I also dropped the configure
--exists patch as that just broke the build.

The following still need review:
 - travis.yml: install python3 numpy and opencv libraries
 - tests/acceptance: bump avocado requirements to 76.0
 - configure: detect and report genisoimage

Alex Bennée (3):
  configure: detect and report genisoimage
  tests/acceptance: bump avocado requirements to 76.0
  travis.yml: install python3 numpy and opencv libraries

Laurent Vivier (1):
  travis: enable tools build on OS X

Robert Foley (5):
  tests/vm: use $(PYTHON) consistently
  tests/vm: Debug mode shows ssh output.
  tests/vm: increased max timeout for vm boot.
  tests/vm: give wait_ssh() option to wait for root
  tests/vm: Added gen_cloud_init_iso() to basevm.py

 configure                 | 13 +++++++++
 .travis.yml               |  6 +++-
 tests/requirements.txt    |  2 +-
 tests/vm/Makefile.include | 16 +++++++---
 tests/vm/basevm.py        | 61 +++++++++++++++++++++++++++++++++++++--
 tests/vm/centos           | 33 +--------------------
 tests/vm/ubuntu.i386      | 37 +-----------------------
 7 files changed, 91 insertions(+), 77 deletions(-)

-- 
2.20.1



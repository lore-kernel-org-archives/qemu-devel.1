Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41DCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB53820679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fsz5fsUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB53820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbXZ-0004pq-8r
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGV-00023S-PI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaGU-00044o-KR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaGU-000439-Dy
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:22:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a11so9343078wra.6
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmWZe7YRnWYQvnMO9Ft+oK9d0E1Wp0RQ12k34wleFcU=;
 b=Fsz5fsUNy9O5dVOrwtJWSX7eiXtPZJWeP+wHVOzeNe4RTk2KLBgNNr3iZf1ZqT0chg
 1MQyrFSKd5YFbOWB7Jj2cUVpWXDkwEbrfw/ldKLTQ6fHPLvcstuCUhPHGIag+gw9DMOF
 0jmK7xo2tvDa4b9KTZZYN433RyuHaB3tdU5uHGwKWodcWCvXYF55Ir9tnPHTzigRwmBS
 fuA2cdI0Mx8ZIgMhvtfk1CEwj5A4odgcR/CJdXtsVu3pQl4PWO65rcR7ZmmqxQsZ4XF0
 v5SI+1FcXk00drOIqxjsukq3zCX41TTSeToigXaCAHkRIFIyCHF3r4UPhqb7R5S+4lHd
 r63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmWZe7YRnWYQvnMO9Ft+oK9d0E1Wp0RQ12k34wleFcU=;
 b=IfjzlupRaBlsWIPWn7LGiVW9nMQvb/ZE6xqGypfB/Fk50X8NHa5lrzw0j0FMTXDaLh
 S7ZQuCHm5y08I9VPdd1pAraS0s/R+AZGNnmSKH/jszvfFX0fQg3RKtd50zkmk42t2WsO
 n5teRnlKHoCUQ6IDQMInTLJlfIGtTrkNqJHj8c5qiZGuFdlfu//uDuHdFNYVn0qtKYfF
 4zsKFTDdGNnFmo6lLmbLPSyB5t7FL85itwalB7XM0sGVX8aCe0g7tyG4XzISF/BvZR+s
 Vw7zHRmV2aZAINzPojyuEQgJM63PrpjL6m7egJL2Xq1xRNtv8cbKP8UOeIhFhL4I9IZg
 lmzQ==
X-Gm-Message-State: APjAAAUn87nRYPUuDectVf467osUm5cnkOT2z2s4XOeF6Ql50fwSarOL
 I+VmdGk6cVcCio8kxmVtk5K28A==
X-Google-Smtp-Source: APXvYqxZGiYRQLl+HuzfSOyfUaOW8+13v+CMVcXhZldgMOWfgqYUZ/GEpzFj01pamzRikc/QRBhMGw==
X-Received: by 2002:a05:6000:1051:: with SMTP id
 c17mr3047410wrx.124.1571912565048; 
 Thu, 24 Oct 2019 03:22:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm22512855wrx.84.2019.10.24.03.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:22:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 51FB51FF87;
 Thu, 24 Oct 2019 11:22:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v2 00/17] testing/next
Date: Thu, 24 Oct 2019 11:22:23 +0100
Message-Id: <20191024102240.2778-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current status of testing/next. I've dropped the iotests
as they should come in with the rest of the block patches. I've
included a few more stragglers including some docker tweaks. Currently
the following could do with review:

   07 - cirrus.yml reduce scope of MacOS build
   08 - travis.yml bump Xcode 10 to latest dot release
   09 - cirrus.yml add latest Xcode build target
   15 - travis.yml enable debug tcg to check tcg
   16 - tests docker set HOST_ARCH if we don t have ARCH
   17 - tests docker update Travis image to a more curren


Alex Bennée (8):
  travis.yml: reduce scope of the --enable-debug build
  cirrus.yml: reduce scope of MacOS build
  travis.yml: bump Xcode 10 to latest dot release
  cirrus.yml: add latest Xcode build target
  travis.yml: cache the clang sanitizer build
  travis.yml: --enable-debug-tcg to check-tcg
  tests/docker: set HOST_ARCH if we don't have ARCH
  tests/docker: update Travis image to a more current version

Eduardo Habkost (2):
  tests/vm: Let subclasses disable IPv6
  tests/vm/netbsd: Disable IPv6

Gerd Hoffmann (1):
  tests/vm: netbsd autoinstall, using serial console

Philippe Mathieu-Daudé (1):
  travis.yml: Test the release tarball

Thomas Huth (5):
  travis.yml: Add libvdeplug-dev to compile-test net/vde.c
  travis.yml: Use libsdl2 instead of libsdl1.2, and install
    libsdl2-image
  travis.yml: Use newer version of libgnutls and libpng
  travis.yml: Fix the ccache lines
  gitlab-ci.yml: Use libvdeplug-dev to compile-test the VDE network
    backend

 .cirrus.yml                            |  14 +-
 .gitlab-ci.yml                         |   2 +-
 .shippable.yml                         |   2 -
 .travis.yml                            |  50 +++++--
 tests/docker/Makefile.include          |   6 +-
 tests/docker/dockerfiles/travis.docker |   6 +-
 tests/vm/basevm.py                     |  15 +-
 tests/vm/netbsd                        | 195 +++++++++++++++++++++++--
 8 files changed, 259 insertions(+), 31 deletions(-)

-- 
2.20.1



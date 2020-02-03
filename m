Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F8C47409
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18992080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYhkwswQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18992080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXkc-00087u-08
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjd-0006Rl-BC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjb-0000gu-Ty
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:37 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjb-0000bN-MB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:35 -0500
Received: by mail-wr1-x435.google.com with SMTP id m16so16879120wrx.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kJ72brjtmUoICoUOJWaPOcrAdzkzYnvnYNHzEMoCbhw=;
 b=zYhkwswQacLrbHHJ+ul1KLzC8+qR3d1wtu7BXN7Y4QxaEiWJ57+RVHa5Vt1z/GfuGd
 +ATJyYPaXXZc+GMM827jtUWBTTPRA3GtpFYSAUphFgu4iabM1Pe0s/ux/b784vWp87Fy
 6H8dOc72wW2Byuq2lWnxdwLNs80+jas2QVQ2XwuGVg0xaRfU/idc72JeCBGTZhUBDO26
 gjMwfvleor1aMiI39wAKvmunqnrb+sbO2ZnHcVHTmd/XbYy2kJXbvERmDIt9gs+YsaEr
 myyc/FutcD59y6fAePGkpmV3zkqOgBY0eTsFLk02/iHXCcpOFrU9A73+l4cARMrjJrYp
 DFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kJ72brjtmUoICoUOJWaPOcrAdzkzYnvnYNHzEMoCbhw=;
 b=WS+yq1rzjE/Gu4mZEc8kxlefrrVHWud9dev/02IFAgibPmk932wQZfuY5Y22pz1jsA
 QYBKkQt1QRfMnhYdBTEuJkkF6W5Ux7O7A/ZTn+UdFppbbxlsKYiAekaSFNeQedhl29tH
 RioogPGikHEw8Luq6PSvMnuSHwPplQ0CXl4bAl986hxgetj8gHpr6U10wVFqLZvC94jE
 yN6fPkUowNCcWK95jPK3Q0n5P3s0SY/5rAg4YkNwKPBKF763sbGY8Ww+mtvJS7tEMnVV
 JdfdbWiTpQ+MutKfOf7GNKVq8oJeq9gW6bcYPHQtqs5CK1lRZjbqZ/99rpqOw3dCmt6Z
 uq1g==
X-Gm-Message-State: APjAAAUPhHNF+t3RnpvZwHppaON1Bj/vDOOrbCGgS2pbdFvUTjCos4g9
 KmYGDo5uSHM3kCZTtJmFzClUFA==
X-Google-Smtp-Source: APXvYqx+urk5mRAwHf6rRQyxYGenjnYUbaSBCqohflFGKR0gKhuzohscHxQsM+IzJxTGtj2QfBh1Pg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr13646046wrr.32.1580720974146; 
 Mon, 03 Feb 2020 01:09:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm1995227wmh.26.2020.02.03.01.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AEB61FF87;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 00/17] testing/next (with build fixes, finally GREEN!)
Date: Mon,  3 Feb 2020 09:09:15 +0000
Message-Id: <20200203090932.19147-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

The main changes from v2 are dropping the travis_retry (the aarch64
timeout was simply taking too long on the same failing test) and
tweaks to the parallelism of the various bits of build.

The following patches need review
   03 - gitlab ci Refresh the list of iotests
   07 - .travis.yml Drop superfluous use of python python
   08 - .travis.yml Add description to each job
   13 - tests tcg gate pauth tests on having compiler sup
   14 - .travis.yml introduce TEST_BUILD_CMD and use it f
   15 - .travis.yml drop the travis_retry from tests
   16 - .travis.yml drop cris linux user from the plugins
   17 - .travis.yml single thread build tcg

Alex Bennée (12):
  tests/docker: move most cross compilers to buster base
  tests/docker: better handle symlinked libs
  .shippable: --disable-docs for cross-compile tests
  .travis.yml: build documents under bionic
  .travis.yml: move cache flushing to early common phase
  .travis.yml: probe for number of available processors
  tests/tcg: add a configure compiler check for ARMv8.1 and SVE
  tests/tcg: gate pauth-% tests on having compiler support
  .travis.yml: introduce TEST_BUILD_CMD and use it for check-tcg
  .travis.yml: drop the travis_retry from tests
  .travis.yml: drop cris-linux-user from the plugins test
  .travis.yml: single thread build-tcg

Philippe Mathieu-Daudé (3):
  hw/hppa/Kconfig: LASI chipset requires PARALLEL port
  .travis.yml: Drop superfluous use of --python=python3 parameter
  .travis.yml: Add description to each job

Thomas Huth (1):
  gitlab-ci: Refresh the list of iotests

Wainer dos Santos Moschetta (1):
  travis.yml: Install genisoimage package

 .gitlab-ci.yml                                |  12 +-
 .shippable.yml                                |   2 +-
 .travis.yml                                   | 164 ++++++++++++------
 hw/hppa/Kconfig                               |   1 +
 tests/docker/Makefile.include                 |  16 +-
 tests/docker/docker.py                        |  16 +-
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +-
 .../dockerfiles/debian-armel-cross.docker     |   2 +-
 .../dockerfiles/debian-armhf-cross.docker     |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   2 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   2 +-
 .../dockerfiles/debian-s390x-cross.docker     |   2 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |  12 +-
 tests/tcg/aarch64/Makefile.target             |   2 +
 tests/tcg/configure.sh                        |  18 ++
 16 files changed, 174 insertions(+), 83 deletions(-)

-- 
2.20.1



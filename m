Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF4CC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973DC2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9B8AGTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973DC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8Pi-00074c-R7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix8JU-0007c4-8y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix8JS-0001RY-Sf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:55680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix8JS-0001QT-Ks
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:48:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id q9so3427097wmj.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5w4Pj6Ii5lOk2XwHikFhDCSX9sBpUJLfRoy/bCyMb8=;
 b=j9B8AGTKtTy+JutA3lk0uya032Iez4UpRDtcadq6q3EIWBGTE7S3DyrEtq9kn5JOfU
 i2QxARmBF/ZObJxR0d9u5ZUd3oQm5xMew2nYrO6i8W8xOeUeP9tQs59tNbD0G5FxZbNT
 7qp8dFQi3YNvEJqe7shQlkFH2hYsuboA0dgfgOwqgqkBIoWG7Xpx0KsfjjvEca8tsyX+
 oNaaMb8zZT3FsXlKjUGUu10wMnYoUkO3Fz+Y70i8bK5I2UwdZ8hfyzTks7Z69BMwE9Ju
 jl7fLn/Ba7V1eUC29lWqbUKV23qEVPbof8XNkC/hj2UVxA021/RluVelstlbB1+WhfLP
 77QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j5w4Pj6Ii5lOk2XwHikFhDCSX9sBpUJLfRoy/bCyMb8=;
 b=SK2HSnvI6qzoEJCRN9Gm+Skv5LWOE+lBo5Zur2oJ/5XKqDhE9NfhrrOMR7BPOwIpxi
 8hLtt8bQ+ou4Y9yLiW0l0WKSWM+KHw5SmyxPQT7lTu7MWt+N1Sx7ACWjkN7yV8ddUI5D
 UFMga3hxetkPg8wECkHHnvToB0yJL+mqpJ0ntOMDLI8rcTUygnQ+t1HPGLRvCxb78MSl
 TtRbOK8OKrgFA99rVPkm0hX3RMCfU3ipvFMqjnuxUEMM1lFKKjzF6xmSuhFotH5gF7/I
 mhLMVjVniBZ/a46Dh731ysnmq97IB6rhYwm52ARTaXBJuOdyjbuZhHa10Q3d48ENCohK
 oGaQ==
X-Gm-Message-State: APjAAAVL9RFAtGY6kw6CM8BbFREhYusIP1OtLaP5AZrGHSQixwPR0Y40
 zGgs6jUiq/ns0OK+kCaMSb0fgA==
X-Google-Smtp-Source: APXvYqwSQoaKELXpTV0RojyxPBiNMlTRDKnakbK15fvEEK8OrgFd1rJPAFO1VhTMhtNW+hNkwX7QDA==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr5316023wmj.28.1580384925219; 
 Thu, 30 Jan 2020 03:48:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b21sm6374356wmd.37.2020.01.30.03.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:48:44 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C1B01FF87;
 Thu, 30 Jan 2020 11:32:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 00/12] testing/next (with build fixes!)
Date: Thu, 30 Jan 2020 11:32:11 +0000
Message-Id: <20200130113223.31046-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

It seemed the CI degraded while I wasn't looking so I've rolled up a
bunch of fixes to try and get things working again.

There is some messing around for documentation builds (disabling on
shippable, moving to bionic on Travis), a build fix for hppa +
no-default-configs and some attempts to squash timeouts on our new
multiple architecture builds.

I shall build the forthcoming PR directly from this posted series.

The following patches need review:
  01 - tests docker move most cross compilers to buster 
  02 - tests docker better handle symlinked libs
  03 - gitlab ci Refresh the list of iotests
  04 - travis.yml Install genisoimage package
  05 - .shippable disable docs for cross compile tests
  07 - .travis.yml Drop superfluous use of python python
  08 - .travis.yml Add description to each job
  09 - .travis.yml build documents under bionic
  10 - .travis.yml move cache flushing to early common p
  11 - .travis.yml probe for number of available process
  12 - .travis.yml limit the arm64 target list

Alex Bennée (7):
  tests/docker: move most cross compilers to buster base
  tests/docker: better handle symlinked libs
  .shippable: --disable-docs for cross-compile tests
  .travis.yml: build documents under bionic
  .travis.yml: move cache flushing to early common phase
  .travis.yml: probe for number of available processors
  .travis.yml: limit the arm64 target list

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
 .travis.yml                                   | 145 ++++++++++++------
 hw/hppa/Kconfig                               |   1 +
 tests/docker/Makefile.include                 |  16 +-
 tests/docker/docker.py                        |   5 +-
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +-
 .../dockerfiles/debian-armel-cross.docker     |   2 +-
 .../dockerfiles/debian-armhf-cross.docker     |   2 +-
 .../dockerfiles/debian-mips64el-cross.docker  |   2 +-
 .../dockerfiles/debian-mipsel-cross.docker    |   2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |   2 +-
 .../dockerfiles/debian-s390x-cross.docker     |   2 +-
 13 files changed, 121 insertions(+), 74 deletions(-)

-- 
2.20.1



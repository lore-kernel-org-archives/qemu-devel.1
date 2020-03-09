Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70791C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E65B20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GomJNLkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E65B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOxp-0005jz-F6
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvr-0001oZ-8S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvq-00058t-2d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvp-00058P-Pv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id a5so966606wmb.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Br0hpXSyz8LFoxnWD/7d3qeWt8tdVAzKh4fZzFVQe4g=;
 b=GomJNLkqukwQrJIyAXdqeFX2KV9svd7RdLg6JRqj5gVmistoXehjQ7wyaObObvVIE7
 tXbAjpckwhdkBj7b67LQjM32uaq4qyv23/tT7fU9h0suk4Ip9frgvR7FXogIfQhZXw5t
 RGxNOTbQwHn8dH22N6Zv6p+aYh1mRFAlERZTVwlW971YMS0CpuN9ZBstBk07lwwuW26S
 YX5L3MNBmFsix50uOaPjWmDqG8AXh9oJtChjJFtwsy3PeRN8WcimLwUnRhDEHEeVZ3Z7
 N63ZABAiT2JFb8iILdhXOloyaP+uWjR592QZUZ3+tCefRUwRBYsO2KuRkiZRhD4Oou56
 /UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Br0hpXSyz8LFoxnWD/7d3qeWt8tdVAzKh4fZzFVQe4g=;
 b=p23Yd33O/nJL4fOeBIgGasfNqdzGjcPnq3eCsRrb4ffSmCww44oukzPrSjnZZbHNSm
 JVz6+IdGsApD/KXyLJrre/jumKcWeRm6/5y8pauCp/M3H1XQh88X56Cs4D4bHDCx/6em
 Ob6XLXoE49Kv8FfMuleifkIk59oBv3zcXj60v0b0yVOPqK3R6ii1BKyvRB1GHiaRX+1n
 gdmYHbyU7ZXtFPKkUoj/tcBD21Kfh+yPWyEl0V9kKLJDZlGCnrCxWk0pwWOMvHoCNGhx
 HOs1Fca3K+WLYinSNDxutmL2BTocvgosDDzLIKYC7vcQcmdUo5zrU95yB/zykl6J6kl/
 4m8g==
X-Gm-Message-State: ANhLgQ0Nkt/xKxTFLjVaH1/nDn4WrmI+uMgoFMD1QxGQeHawQvhRdzMb
 K1XccKsS2CAx/oPyXMvqQod6kYqz4CE=
X-Google-Smtp-Source: ADFU+vs1Qzv8FBDsL+J3D74/3C9K3onjg/s4Cmogbxk546iWeInGtbqdcMboCIoLuXXccpcSSuqerw==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr940500wmg.69.1583785400384; 
 Mon, 09 Mar 2020 13:23:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s13sm11439473wrw.29.2020.03.09.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:19 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8171E1FF7E;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/5] testing updates (docker and acceptance CI tweaks)
Date: Mon,  9 Mar 2020 20:23:13 +0000
Message-Id: <20200309202318.3481-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

Another week, another testing series. Apart from gathering up some
docker tweaks from Phillipe I've also added skips for some MIPS and
SPARC acceptance tests that are timing out in CI but not for me
locally.

Alex Bennée (1):
  tests/acceptance: disable two more tests while in CI

Philippe Mathieu-Daudé (4):
  tests/docker: Install tools to cross-debug and build Linux kernels
  tests/docker: Update VirGL git repository URL
  tests/docker: Remove obsolete VirGL --with-glx configure option
  tests/docker: Update VirGL to v0.8.0

 tests/acceptance/machine_mips_malta.py       | 2 ++
 tests/acceptance/machine_sparc_leon3.py      | 2 ++
 tests/docker/dockerfiles/debian-amd64.docker | 6 +++---
 tests/docker/dockerfiles/debian10.docker     | 3 +++
 tests/docker/dockerfiles/debian9.docker      | 3 +++
 5 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.20.1



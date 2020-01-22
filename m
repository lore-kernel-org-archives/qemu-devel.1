Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA747C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2A12467C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tb56kvPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2A12467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDAs-00077U-Al
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9Y-0005vm-S8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuD9X-00084w-H8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:28 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuD9X-000841-9L
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:22:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id q6so6596936wro.9
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ILObp3uKcTl5UbsZ/J4Dh1H+U/yk39sjY3mormT1eE=;
 b=Tb56kvPFNx8vQUVxkavhpmB0O8BzDcuHOuGiRZX6FhzSdYuUTLrUj/5IvEmPhd50WM
 EvL50YGz+VWSCAC56URgUe+QKaTa8JwV6I9BBrNL99G17YJXN8ZstA6/1784sPiLfMNv
 4nOPChdLldXox7y1o48gCEPguR7wwotUwc4MQFZ8rZ3puOHaI93+3sPBuKTO1C3kE/sQ
 AWTBQzI5liQW8Oct3Fo1eoqmeaT4fG+wushcrwB25gpvGQ8aXhpxhYQa40u7qDeP0Gjj
 2fcDopT2O85xAk4mo1G0L9KbduE+vRma8I/Xr0pcd8hexVBC901ZPSn99VnLPttIbURd
 ShuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ILObp3uKcTl5UbsZ/J4Dh1H+U/yk39sjY3mormT1eE=;
 b=tD2cqD8dF/Gka/YKMX9t4w1VJxrwhAhbk66gMEj/B7CM0goThuz7HngCLgtf0OZsTR
 T2rJ7wjXr7Z2wJe7wvuVFytPgcetzN9MtFfSVgr0ebxmnVT2Jdet/nQy4hflDQvPeBen
 WRCvkUbWBthnBiXiwvdhsSwCLTgcdNTbPugSBZ/Sl65vWZ8wJmLvSlnxJRXeDK7mkp1J
 /Wjg3cxn3UpI9yXoL8NcZGW7+spcAOiwtkJpG6BFCD7F8NMOzdw4Jbd+I6P4w6ROU8wl
 hfshyRYk0/OirVO+4OAsnlPzqZgQ6Jn4wkoXOcQp/2Bdv+CHS7vOuu928vclcgibTzsb
 2WTQ==
X-Gm-Message-State: APjAAAUivRxl+CTi7e7irsIv761wsOrg4aUNbRTNPYq3rFqO1jXRuxml
 54eN+KP62/ik+A0kAGPztkQuHQ==
X-Google-Smtp-Source: APXvYqy1ksxfl5uYMNWqm+PdkAaUfgQHvsNtIo2wylP6k7gb8yUn+OeOHtRKCcr2lihWU02m4FPceQ==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr10000677wrq.43.1579688545406; 
 Wed, 22 Jan 2020 02:22:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d16sm61209606wrg.27.2020.01.22.02.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 02:22:24 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A99A61FF87;
 Wed, 22 Jan 2020 10:22:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/3] current testing/next queue
Date: Wed, 22 Jan 2020 10:22:20 +0000
Message-Id: <20200122102223.20036-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

There isn't much in my queue at the moment. The move of the various
compilers to buster fixes one of the shippable problems. I have a
longer series cooking to support multiarch docker builds which I'll
try and get posted by the end of this week.

Alex Bennée (2):
  tests/docker: move most cross compilers to buster base
  tests/docker: better handle symlinked libs

Thomas Huth (1):
  gitlab-ci: Refresh the list of iotests

 .gitlab-ci.yml                                   | 12 ++++++------
 tests/docker/Makefile.include                    | 16 ++++++++--------
 tests/docker/docker.py                           |  3 ++-
 tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
 .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
 .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
 .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
 .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
 .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
 10 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.20.1



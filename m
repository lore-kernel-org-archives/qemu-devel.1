Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D99C4727F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092D6215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RT+wdnFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092D6215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCB9-0007zv-UE
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBrz-0005B1-9J
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBrt-0000se-FP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:00:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so2827207wre.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VjOULhkTXDSoaVBnrNj6AWvIOwwKNW7fA5FR7tjb1fI=;
 b=RT+wdnFtBDRR0rT622mHLDZ23Qw6uAuQ7Ev7dnmqFeppN50jaOeRaAlo9xNoZsaZbK
 vtpZ/QrQLajuZmVgK7cz6P4MWfhTZZIdTDk9ZvatgUAHbehxPJF/Evg4ONjN2kA5jKoj
 Zejdo2a9MCV0ypTXsPBoTdmuHqlG6f1/F70HL3qW6c/SDp5E4pnQJcAmGCZ5wkVJnbpH
 FFQvhcMaXeTwFHTTb086c/tQesrELCoi+jxC5ofOhzW4nry7mYMc5XHygF1wqNX/GPgh
 bdnXi2VbDyuUZsiyNNAjVAfuBnqOwAixsbzedCMsYFe1lM6gyEH1DkU1yrRwf4lD21Lb
 ZYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VjOULhkTXDSoaVBnrNj6AWvIOwwKNW7fA5FR7tjb1fI=;
 b=mkW/qTH/SZAKXUgVgui6kknZV/NHgdL909t7wVK0bVIgzHrWkDvNOniUd5kSAhK3hF
 X68ICbzICLhYz0/tM1JMXtVpX5WTWrxk55dHzYJL6s1Lz87Dyl1ySLhQ/TADmtz8e2dS
 e182jy1Yo8LuXM067Pz8eWLc4N+6dob8swrHCYyiYA5uJ9NUhFw1Yj8WhiFRm5djted7
 OMlhMndisIpQ+LuVQQo7MW+1ATwOkI1PYVE03ExrF8i0xVLw6N96uEB7+jXKggg/dd7t
 UQFYVxA0IrTWQXQgT13h85EHKAR9f1niG6GAkFpft0CGkWwHEO5KSTM+Zt77vPOhUzDb
 874Q==
X-Gm-Message-State: AOAM531pEa8RoW1VHT3Qe+CIVKJedvlgTBlH0a0u78n90BdUHgPIKQ2u
 fPDUVy9jeseQrvIMHrONoLRxVw==
X-Google-Smtp-Source: ABdhPJyN5x5lCKdHs6doQg5GdM/5xiu4kg6v6pyCIJWYRgPYANze+dORzig11YqWgFF7HR+U/tMOsQ==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr4697465wrs.153.1602086440004; 
 Wed, 07 Oct 2020 09:00:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm3644156wrq.0.2020.10.07.09.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 235741FF7E;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/22] testing and plugin fixes with gitdm updates (pre PR)
Date: Wed,  7 Oct 2020 17:00:16 +0100
Message-Id: <20201007160038.26953-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This is a pre-PR which fixes up the failing check-acceptance as well
as some plugin fixes and the first batch of gitdm updates from
Phillipe. I've also included one of Paolo's in-flight fixes for
speeding up TCG. I've managed to get a green run across our CI with
it.

There are a couple of un-reviewed patches:

 - tests/acceptance: disable machine_rx_gdbsim on GitLab
 - hw/ide: restore replay support of IDE

Alex Bennée (2):
  hw/ide: restore replay support of IDE
  tests/acceptance: disable machine_rx_gdbsim on GitLab

Paolo Bonzini (2):
  configure: fix performance regression due to PIC objects
  cirrus: use V=1 when running tests on FreeBSD and macOS

Philippe Mathieu-Daudé (13):
  hw/misc/mips_cpc: Start vCPU when powered on
  contrib/gitdm: Add more academic domains
  contrib/gitdm: Add more individual contributors
  contrib/gitdm: Add Baidu to the domain map
  contrib/gitdm: Add ByteDance to the domain map
  contrib/gitdm: Add Google to the domain map
  contrib/gitdm: Add Nuvia to the domain map
  contrib/gitdm: Add Qualcomm to the domain map
  contrib/gitdm: Add Nir Soffer to Red Hat domain
  contrib/gitdm: Add SUSE to the domain map
  contrib/gitdm: Add Yadro to the domain map
  contrib/gitdm: Add Yandex to the domain map
  .mailmap: Fix more contributor entries

Thomas Huth (1):
  tests/docker: Add genisoimage to the docker file

Yonggang Luo (4):
  cirrus: Fixing and speedup the msys2/mingw CI
  cirrus: msys2/mingw speed is up, add excluded target back
  plugins: Fixes a issue when dlsym failed, the handle not closed
  plugin: Fixes compiling errors on msys2/mingw

 configure                                    |   1 +
 contrib/plugins/hotblocks.c                  |   2 +-
 hw/ide/core.c                                |   4 +-
 hw/misc/mips_cpc.c                           |   1 +
 plugins/loader.c                             |   1 +
 tests/plugin/bb.c                            |   4 +-
 .cirrus.yml                                  | 121 +++++++++++--------
 .mailmap                                     |   2 +
 contrib/gitdm/domain-map                     |  10 +-
 contrib/gitdm/group-map-academics            |   4 +
 contrib/gitdm/group-map-individuals          |   7 ++
 contrib/gitdm/group-map-redhat               |   1 +
 tests/acceptance/machine_rx_gdbsim.py        |   1 +
 tests/docker/dockerfiles/centos8.docker      |   1 +
 tests/docker/dockerfiles/debian-amd64.docker |   1 +
 tests/docker/dockerfiles/fedora.docker       |   1 +
 tests/docker/dockerfiles/ubuntu2004.docker   |   1 +
 17 files changed, 107 insertions(+), 56 deletions(-)

-- 
2.20.1



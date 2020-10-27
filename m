Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171D1C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899DE21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5QDfoY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DE21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLmf-0008Fw-Dk
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLla-0006ec-00
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:46 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlW-0000Nf-Sd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:45 -0400
Received: by mail-wr1-x432.google.com with SMTP id y12so1151530wrp.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KJqFwRz9gm+3prhZqia7bIKgqj8u4FMA676MUorTz74=;
 b=l5QDfoY6YTmtHRc9a7rSLnW41VYxmLWz8v9YqRmrA4nx22UbKSCnK95sfELWa5uwj1
 fq5YuEwbsM0F3fmMgYVi91bP9QFtOeDXVQV0TeicUIi2hwuYHQh4jvXKHfkexMWP4UxL
 t8L/ZC+Uum6y5pxwxH9eyhNxWpiAVQzbgDlP2Z5YUfw1Qg/zcM8ygij38i2HZcflARjo
 6SEI3poFkMsv01J0bFYKFHTpk45JJSEcLrVa0YbF+Eyu+4i2wsbFomC5rNvQRVM3/fNq
 96MBS3CQfurdN++tPdziHt2RFIEzYXYYrwqpPxvBRk0kyw4EyYgz4OyB7t1hO1Nk4IeN
 +GeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KJqFwRz9gm+3prhZqia7bIKgqj8u4FMA676MUorTz74=;
 b=q5No94xilQjIyDaoGHl1jYF/5JfE6O+qUS3leH7RnSS6xR+fvPiVGbvJ9FWQMkzaYZ
 yZGYWYy3DAwKeHQqfDy7KxYkQm70BRgY/E2AlRHtKORkHIGWrSDa5M7YppxVtHm22AW+
 ZiAhm28IDTBPSHVm2CNTjE1FHz/fL2e8eVCJVEhmjsO8almDYt3HO3avX50NnVZtZ5/l
 nWVYVuPD86UOmR34w1OkFyoTENEe7PuvHSgfjuQKCDLGDutRiCd0STspFr69dvjHTro0
 IQaIpAHg98QWeJ8KbzB/SFDZ7eR5YWwUjeKR7PFYajGIVqqZmkNh3GuCzVTHK02/VO1W
 Ubjg==
X-Gm-Message-State: AOAM532ylCE61jLdANua5SmP/V/ITkgtznBmgDpu9wLzS+fQRbHI2I/D
 /3i2czGGKcdk5/ld0jZ0NyFhdQ==
X-Google-Smtp-Source: ABdhPJw23pkYhujeNv8vx5Z8rhQOrK0nZjUT/z48WvVTyqzRzWfgzdlo4QAXI1eYsVjGPrEsmc3TFw==
X-Received: by 2002:a5d:4a82:: with SMTP id o2mr1918417wrq.10.1603792780678;
 Tue, 27 Oct 2020 02:59:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k16sm1263585wmi.5.2020.10.27.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B85A81FF7E;
 Tue, 27 Oct 2020 09:59:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 0/8] testing and misc (gitdm, gitlab, docker, make)
Date: Tue, 27 Oct 2020 09:59:30 +0000
Message-Id: <20201027095938.28673-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-271020-1

for you to fetch changes up to c8e6cfba1291df2202bf406bb5137c9d365505d1:

  makefile: handle -n / -k / -q correctly (2020-10-27 09:53:51 +0000)

----------------------------------------------------------------
Testing and gitdm updates

  - add some more individual contributors
  - include SDL2 in centos images
  - skip checkpatch check when no commits found
  - use random port for gdb reverse debugging
  - make gitlab use it's own mirrors to clone
  - fix detection of make -nqp

----------------------------------------------------------------
Alex Bennée (2):
      contrib/gitdm: Add more individual contributors
      tests/acceptance: pick a random gdb port for reverse debugging

Ani Sinha (1):
      Adding ani's email as an individual contributor

Daniel P. Berrangé (2):
      gitlab: skip checkpatch.pl checks if no commit delta on branch
      scripts: fix error from checkpatch.pl when no commits are found

Paolo Bonzini (1):
      makefile: handle -n / -k / -q correctly

Philippe Mathieu-Daudé (1):
      gitlab-ci: Clone from GitLab itself

Thomas Huth (1):
      tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1

 Makefile                                | 10 +++++++---
 .gitlab-ci.d/check-patch.py             |  8 ++++++++
 .gitlab-ci.yml                          |  1 +
 contrib/gitdm/group-map-individuals     |  6 ++++++
 scripts/checkpatch.pl                   |  2 +-
 tests/acceptance/reverse_debugging.py   | 12 +++++++-----
 tests/docker/dockerfiles/centos7.docker |  2 +-
 tests/docker/dockerfiles/centos8.docker |  2 +-
 8 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.20.1



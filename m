Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3C0C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245EF20936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YirndOqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245EF20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHHA-0000WR-4z
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1i-0006PZ-Vj
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1a-0005ZH-F1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so3869730wrq.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b0c9bV8E1GevhOEJ/MXFc3Aeb9iLyV9L88L5uWwl8q4=;
 b=YirndOqJjbXwrA+472ZTP52UtUvcRQNkSNpy0OLzi/PpXhBtNXfDbhRboxnB6dObzN
 Xq+jlW593/eipMsIdRFhsHupd+JkVKg7rUIsoUps30wnpXrAH3q5EZHUcn67qYU/rS0q
 nMfhDDHA1HsNTyahETgnFKwekmA3Xlj9yWRreQ9O0kg6yRvsucTuE34GSNfXWYP9tgwQ
 kpTi3J+BgmmMtZpziEM9fJozoiIYQR+b1qC9QEdqtZBaZm2DBNTNF2xFKL9rCApOmhl4
 xseeqoWvHCYgU4Ol4cWH2O1BenYArtAwS+pMVgAFu2dVx6GPLFl63Almhi/1c4Nm+ruv
 q6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b0c9bV8E1GevhOEJ/MXFc3Aeb9iLyV9L88L5uWwl8q4=;
 b=FB5zDPVjoGNSNeQGrXpk/J/bTeTOqek5Mv+IyIgg5qOC8FcKd4YxuNlk8dQp2K6k2S
 ziJ7qgcJT17/euL3To05jV2y5SRzx4iu1HZckpCoPDCknucTm4LWg7W4jMSZHjjzT0CW
 kJw7CCtTjEsvqQu0Ro5IJ4FIOnsc3nec4NrgLLcIRSfyLO4NJHc1CpbjRoW9Z2oiIIxX
 UbjpkkNHmA+AuJ9IqW+bYvdziqoYSRoqwqGMYVfylPNVUWpSaMEZxfxzI/vqU8D5b4jm
 wXc4gU3eDCV2UesgWarcXkZQ6T4wXdI0TKuGRU3TA3ep3b9cvaZ6DYV6j8ocNLZUsvYG
 Z59A==
X-Gm-Message-State: AOAM533zf4/sahM2DfpExvu7hFe3CPDlDRlYS0dNlz6cm5Q4WdKwdrsK
 b6tMjzefjnUamuR8FYtnvNYnlg==
X-Google-Smtp-Source: ABdhPJwL1xElIvTKz6fciwaTd5tXcVWKHt3qGT9CTk7pYAq37rzvye27v89xjWVCpD4QAWRR9k3+ZA==
X-Received: by 2002:adf:de91:: with SMTP id w17mr5638874wrl.84.1603297899283; 
 Wed, 21 Oct 2020 09:31:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h4sm4971768wrv.11.2020.10.21.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE8971FF7E;
 Wed, 21 Oct 2020 17:31:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/6] testing/next (gitdm, acceptance, docker, gitlab)
Date: Wed, 21 Oct 2020 17:31:30 +0100
Message-Id: <20201021163136.27324-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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

This is the current state of my testing/next branch although it also
contains a few gitdm updates as well. I'm not proud of the reverse
debugging hack but at least it works more times than not now.

Currently requiring review:

 - tests/acceptance: pick a random gdb port for reverse debugging
 - contrib/gitdm: Add more individual contributors (6 acks, 1 sobs)

Alex Bennée (2):
  contrib/gitdm: Add more individual contributors
  tests/acceptance: pick a random gdb port for reverse debugging

Ani Sinha (1):
  Adding ani's email as an individual contributor

Daniel P. Berrangé (2):
  gitlab: skip checkpatch.pl checks if no commit delta on branch
  scripts: fix error from checkpatch.pl when no commits are found

Thomas Huth (1):
  tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1

 .gitlab-ci.d/check-patch.py             | 8 ++++++++
 contrib/gitdm/group-map-individuals     | 6 ++++++
 scripts/checkpatch.pl                   | 2 +-
 tests/acceptance/reverse_debugging.py   | 6 ++++--
 tests/docker/dockerfiles/centos7.docker | 2 +-
 tests/docker/dockerfiles/centos8.docker | 2 +-
 6 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.20.1



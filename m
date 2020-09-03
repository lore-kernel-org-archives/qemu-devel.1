Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A650C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21062083B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbwXoUSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21062083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnJZ-0003cA-Pz
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIm-0002PK-T3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDnIl-0007Yd-45
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:21:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id l9so2491145wme.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nJOFSwlz75Pbc2Dwox4nGF0ucnikSim5QW753DzsYXo=;
 b=KbwXoUSYTPeit0P1hDdFZtuiCBWmXAsfdKrAyWDTyXLXHv6RAS5i8fs28buBpEaB0X
 fQ+P0Vkg5WduiyYT056lIc8fBWRM1zG7qIWaTmbgFqsaM8b02WAUt9f7RsSKDgyyj6aG
 2YYsJWa94ghp7JSJtLe5Leb3EcszMqE1ACv/C7hqb/Jj43a2mw7kKKxQkvX8G5tg8xgV
 QQ8UVDiXttIAxPPvoRI2WwM+H+k15gWIz+03AZh5SGg9knKXFGzzySbr4mQ8tIdgnYUm
 mIBBVtfWFjuBsxVFqq+xhmpnobSS+u2TGE9VsM356/3vOvykf8UH0uCZJLnreByMPKJK
 ZktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nJOFSwlz75Pbc2Dwox4nGF0ucnikSim5QW753DzsYXo=;
 b=rCI7/XRVzvXBKlD4NXh/RaCP9XqmntEnGEBNlq8hnL84SxtwpGQ3TgQI0meDnWYveS
 t5mqqieqS6TBytF5J5oK/PLhvNnBx/5RTCfwjZrtKiPRYRCPAQIhSIea9EIVhTAuMaDm
 RGVRVyKIvOJKNgaAXq810vAiKH1uru7GqMOhtBuLuPxtduEsghbwJRmfhQnCg9i+NwCU
 RXRhaoaqFPYRhnpYYNEO/LYocks3T5QAe7/0VeTzHzmIi2wjeuonPO4/7v+F45D5UBi6
 6e4NEF3otEuRlmv+Xv+LsR7Tt1zjt6mVCOpykQss9SXEEPnPe5U41VBykzUW4XrV6HOX
 zadQ==
X-Gm-Message-State: AOAM5326RIQlnKzGHuSkBJZT5GIZ/gEOAMELzHZfD8Gjrm+2UHnZcdW3
 CewSuKKfw8IdT10clMJ5IDmQ/w==
X-Google-Smtp-Source: ABdhPJx/+IFA+7MhukpQVwBTCAqWZ0PwtR+SeSQJ3XjFuN8d6gDd+9pGJZ3325wN67NeSJTtrTKhIA==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr1947512wmf.109.1599132069399; 
 Thu, 03 Sep 2020 04:21:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x16sm3750139wrq.62.2020.09.03.04.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:21:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD96E1FF7E;
 Thu,  3 Sep 2020 12:21:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/8] some testing and CI updates (re-greening)
Date: Thu,  3 Sep 2020 12:20:59 +0100
Message-Id: <20200903112107.27367-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

My first series after a holiday is a bunch of clean-ups for testing.
Currently they all apply on top of Thomas' pull-request-2020-09-02 tag
which is currently in flight. The fixes to shippable won't become
apparent until the main registry has been updates with the new images
but I have tested them locally.

The migration and mips fixes where just quick band-aids so I would
appreciate the appropriate maintainers having a closer look.

With these we get back to a mostly green state although there seem to
be some acceptance tests that need updating.

Alex Bennée (5):
  CODING_STYLE.rst: flesh out our naming conventions.
  tests/docker: add python3-setuptools the docker images
  tests/meson.build: fp tests don't need CONFIG_TCG
  target/mips: simplify gen_compute_imm_branch logic
  migration: use pstrcpy to copy run state

Daniel P. Berrangé (1):
  crypto: fix build with gcrypt enabled

Gerd Hoffmann (1):
  usb-host: restrict workaround to new libusb versions

Paolo Bonzini (1):
  qemu-iotests: move check-block back to Makefiles

 CODING_STYLE.rst                         | 31 +++++++++++++++--
 configure                                |  2 ++
 hw/usb/host-libusb.c                     |  2 +-
 migration/global_state.c                 |  4 +--
 target/mips/translate.c                  | 12 ++-----
 .travis.yml                              |  2 +-
 crypto/meson.build                       | 42 +++++++++++++++++-------
 meson.build                              |  7 ++--
 tests/Makefile.include                   | 15 +++++++--
 tests/docker/dockerfiles/debian10.docker |  1 +
 tests/docker/dockerfiles/debian9.docker  |  1 +
 tests/meson.build                        |  3 +-
 tests/qemu-iotests/meson.build           |  4 ---
 13 files changed, 89 insertions(+), 37 deletions(-)

-- 
2.20.1



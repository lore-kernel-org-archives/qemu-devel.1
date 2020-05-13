Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F0B205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsfH6GG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F0B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvYj-0002Fs-2Q
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXf-0000j4-Ty
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXe-0004wx-QX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id y3so567530wrt.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hFXTYj+YAzm9lYWklCeVODXebnxAC/En9uZ8P2j69tQ=;
 b=nsfH6GG56el11B52l8KsH2/aelDh4lkH9p3xZzHZBSYNJ85IfRoMrGythrmr+CUzuX
 XWUWwPNye5uO10IPpesMbGXx1SXGvzZPrwQfdxL9/nnlzaYpH2BicHNLbsBkXEjr1n2F
 rxDJRWEk6jXrJigtVUd/Fd4N/m7/KBDaDiD8kGh7IHdTKIscVR9+ONYd0ZC+J4yaMlKU
 TupAuMN5RNcQyWAKp+Huw8foPkyovhBg/zGN34/VeNtrCJsdeu9ru4NaJzOTcmJ2dovl
 RgAU0082wiXEP/kX+3LpUu4YGB7GiUDhnrlHKLDrZOjv7x6Rf7VWOB9yyfZRhgY+Yau2
 4dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hFXTYj+YAzm9lYWklCeVODXebnxAC/En9uZ8P2j69tQ=;
 b=Hy8HJE01X/mAGfaXzxbiKXd8z+O5c7oOHyHoDBRhL5EYPvkxtOjMFMr7QL5gB1IK7F
 dORWUWaUQ5cUkHnyx02WS7pbfAnQRqx3QR5HOyT437RQeCivm01M8/mF7/sXRw70Htlf
 cH6wssEHw8VXsoojzzH5nZ3NLKdIzQAkSi3BhRH2GsPQ0QAd/G30EwMKgtGRiDD/xfqi
 h5ygcaFfLq+3xh8gaBGTO+VQDVTyreS51ch5HPQy/wcaSQleMJZZ1YMqh2STMWRPz0ec
 ePbJGUeqnVlrNQ3fv6eSRz8+uHeiODECdZxvxqoWzwlHmuirVK1rKryTwn/Gp0PwppZU
 1yYg==
X-Gm-Message-State: AOAM532SbSMzEFt5Pk9ho2CyMCHO6MsYCAxnE9glSe4e+XA10hVvC77o
 c2ZfrFxnytaDP1nwQmqdmfM0z3H22f0=
X-Google-Smtp-Source: ABdhPJwqu42Z0uLrahbEg59fop+y6U8hOsI1Cj7qK4E6zvku2aIXoWvuLwvHTGiUQLVBviy4iyAMwA==
X-Received: by 2002:adf:f38b:: with SMTP id m11mr497729wro.65.1589392296914;
 Wed, 13 May 2020 10:51:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b2sm376700wrm.30.2020.05.13.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CD70B1FF7E;
 Wed, 13 May 2020 18:51:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/10] testing and tcg tweaks
Date: Wed, 13 May 2020 18:51:24 +0100
Message-Id: <20200513175134.19619-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

These are the testing and translation tweaks I intend to include in a
PR by the end of the week. Of the un-reviewed patches:

 - translate-all: include guest address in out_asm output

has been looked over before and needs a final check.

 - linux-user: completely re-write init_guest_space

has an Acked-by from Laurent and was written by myself and Richard. If
anyone else has some spare bandwidth to check them then please shout.
It's fairly well tested as I've been using the changes to enable
santizer runs on the other guest types.

  - tests/guest-debug: catch hanging guests

Is a fix for the gdbstub tests which otherwise leave a bunch of
hanging QEMU tasks which older gdb's failed to connect to.

Alex Bennée (6):
  tests/guest-debug: catch hanging guests
  linux-user: completely re-write init_guest_space
  accel/tcg: don't disable exec_tb trace events
  disas: include an optional note for the start of disassembly
  disas: add optional note support to cap_disas
  translate-all: include guest address in out_asm output

Philippe Mathieu-Daudé (1):
  tests/docker: Kludge <linux/swab.h> breakage by pinning linux-libc-dev

Richard Henderson (2):
  exec/cpu-all: Use bool for have_guest_base
  accel/tcg: Relax va restrictions on 64-bit guests

Thomas Huth (1):
  travis.yml: Improve the --disable-tcg test on s390x

 include/disas/disas.h                    |   2 +-
 include/exec/cpu-all.h                   |  25 +-
 include/exec/log.h                       |   4 +-
 linux-user/qemu.h                        |  31 +-
 target/alpha/cpu-param.h                 |  15 +-
 accel/tcg/translate-all.c                |  54 ++-
 bsd-user/main.c                          |   4 +-
 disas.c                                  |  37 +-
 linux-user/elfload.c                     | 503 +++++++++++------------
 linux-user/flatload.c                    |   6 +
 linux-user/main.c                        |  27 +-
 tcg/tcg.c                                |   4 +-
 .travis.yml                              |  18 +-
 accel/tcg/trace-events                   |   8 +-
 tests/docker/dockerfiles/debian10.docker |   9 +
 tests/guest-debug/run-test.py            |   6 +
 16 files changed, 398 insertions(+), 355 deletions(-)

-- 
2.20.1



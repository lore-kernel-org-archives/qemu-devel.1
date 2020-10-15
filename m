Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6878C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200CF2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 21:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4uKU/mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200CF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBEl-0003uc-30
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 17:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCG-0000je-0S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:37768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBCE-0005Gm-6K
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 17:54:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id hk7so224284pjb.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/CJt1ti1bc3lxOpPR6juiEHbN3Gx+k4QlRzxvnRswdQ=;
 b=S4uKU/mzKdH+NxJGn9qAwQERCKierTFtZ5bCJkjuRqHXWybcHXeFIbi6KWJ2z9cPAt
 ZfL1rCyvrLssPq1ZueT1lipwbTJuEgoDZEUQa/7oQLJ87KzjG+BmwJIEQvV7aM42XP8z
 jcgNel2bguJLwChwx6NE/IYSB9O5S/TNMdLYJYade3zAHsBEXKX1f9rVwJW+py3Xlupt
 kiLRgI1oAf5doyVpwompLHSfJyU6zne/kY4Bfkm6pHRN6OlBD3kLvlRlvWUwoGH6/TlD
 qPxeAB1uMEJSc0DnMZP7h8u6A4tbZIveVychdxtkE5pOnnCdAsCV2FbARwEYXaeTpgsq
 6UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/CJt1ti1bc3lxOpPR6juiEHbN3Gx+k4QlRzxvnRswdQ=;
 b=kPk6ry5dXtiyl8F8fYGkVSH0uXFRmT3y6mXV22wtqyWt9IYnENrulMeRQgHaa8pojD
 qzbbTBs7W1qGyffWbTfjsoEDc934x5E3PD4s6GyZK+q9cb05bI4467lfnbggXw+m6Tx5
 B729rSrqHK+bejDhaqvm0Kfu1FoD7Sy/9mSE4WUUFb3oZN7qJimRv/q2aXbPKg9IGZLT
 sfPqi33wmsCXpmVkneAdSCK5K912r8rz0W/tjtZGOwDsikumQ6WuyHqXV/wwPNMa7eNc
 9tw7N+aH62wFxLezp8bMsJTeKw25MSvlfFZKFlV7SlSiR7mwbgVK41NYVqw54Cf2hyG9
 6llg==
X-Gm-Message-State: AOAM532RpDwV3xGup+RyYV7lxKtKb4z9gndhlpKcdOKyKLf32insbmsE
 1E/Khcu5ZZulxjQbqsfggJXRaM/xCaq2yADb
X-Google-Smtp-Source: ABdhPJwI7Emnyv1/sx4CleDxvovMNPnR0InYp+CdmK//5d9jfIXoy6p7Zlxp0lUR324RU8yIsFtQRA==
X-Received: by 2002:a17:90b:4006:: with SMTP id
 ie6mr738094pjb.102.1602798839889; 
 Thu, 15 Oct 2020 14:53:59 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f66sm252856pfa.59.2020.10.15.14.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 14:53:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] Fixes docs building on msys2/mingw
Date: Fri, 16 Oct 2020 05:53:41 +0800
Message-Id: <20201015215345.173-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2-V3=0D
No need convert perl trick to python script anymore=0D
after Paolo's removal of ninjatool.=0D
Revise Meson: Move the detection logic for sphinx to meson=0D
for pass other platform by letting SPHINX_ARGS to be empty=0D
when build_docs are false=0D
=0D
v1 - v2=0D
Also move the docs configure part from=0D
configure to meson, this also fixed the pending=0D
ninjatool removal caused issue that docs  can=0D
not be build under msys2/mingw=0D
=0D
Yonggang Luo (4):=0D
  docs: Fixes build docs on msys2/mingw=0D
  configure: the docdir option should passed to meson as is.=0D
  meson: Move the detection logic for sphinx to meson=0D
  cirrus: Enable doc build on msys2/mingw=0D
=0D
 .cirrus.yml                   |  6 +++-=0D
 configure                     | 62 +++--------------------------------=0D
 docs/conf.py                  |  2 +-=0D
 docs/meson.build              |  4 +--=0D
 docs/sphinx/kerneldoc.py      |  2 +-=0D
 meson.build                   | 59 +++++++++++++++++++++++++++++----=0D
 meson_options.txt             |  5 ++-=0D
 tests/qapi-schema/meson.build |  2 +-=0D
 8 files changed, 71 insertions(+), 71 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


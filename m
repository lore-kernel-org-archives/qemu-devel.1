Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A315C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315AA2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAZjq6Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315AA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBA7n-0004LS-CT
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6u-0002tZ-QE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:40720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6r-0005dz-B6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id k18so2552317pfp.7
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 22:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vniRuLy9oaWQgxB4s7ZLPuZdH+uA7ntw8bf40dJEyKE=;
 b=WAZjq6GwDYnf1yS+9OAhhXk/uLUkX4ZOWygvl8xSg0iQMurvpWT44dS7+Sn58tmcWB
 ec+gIbuU1kjxEznG0zkKIT5kXZIfv9/+oZTxHpQmvNNYueVCPtBMPhKAuzU1wIZ42LRV
 mSs1P2d6exgZf/sAX7WT7jN52K5ocRHf7iJeJGylFpv7lrssDM3jLw7jXC7kiyK6tFHd
 CALh7F3btjsyVkTmFeypoHrovOhdkyX9A1uXSL14j8wr7Z09MKtmt9yCFd4giSkddhFL
 e/Uznh8MjvJmZFgenUgi8ytnIVtaKF6io2XRe1M/vWZhNKIOVL3Juqj91hD6epWm1vRT
 u7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vniRuLy9oaWQgxB4s7ZLPuZdH+uA7ntw8bf40dJEyKE=;
 b=JHb/aeHX+0dv5fPLqpIs/UwOccNNu6eg7knmF9XaI8xPcuw8RYCsNFLfAvMemfnC5N
 xRXiOHC+l+Zfnhb+lhKDfe+d4P6gBERP/vewH9XZ49izX5K+3CECshDgKczWuYZAM6Gn
 Idx9MqsA1vopS66Sq9txbeRSq7uCztsnYuyL2fW5wnkbOEO8duEe/4pl7MGZbGSN6v7w
 EQPh/y3arf6pV09qPmkynuTL8rbdw8t8AkHkGoIZTpF8Qq4g4L8sYojGEsT6LHtwZCDe
 1/LO+shoxCL8HNxHQPwrr2IHsU9S83lk1wX8twxkvXkdbcczqh5p0c3/cSQcH8ZGeQcZ
 +V9Q==
X-Gm-Message-State: AOAM5305bd6T2+itHUORJtZl3HJ9oy6TL+4YR/zdmFoF0EFz5yliAKi8
 V0+c85dIu2W+LawRT3MepsALazVl+gYAEgUQ3Pc=
X-Google-Smtp-Source: ABdhPJxG7X5gzy81eCbBLpLv1F80MvoEXzga3JpXMKoPsVTTMFJMmsYOMEgg11o6RLqHET4G2KnOfA==
X-Received: by 2002:a17:902:a403:: with SMTP id
 p3mr14824170plq.104.1598504758925; 
 Wed, 26 Aug 2020 22:05:58 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u3sm724213pjn.29.2020.08.26.22.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 22:05:58 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Fixes msys2 building after the meson convert
Date: Thu, 27 Aug 2020 13:05:37 +0800
Message-Id: <20200827050543.44-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42a.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>=0D

These patch series fixes the building of newest qemu under=0D
msys2 environment=0D
=0D
Yonggang Luo (6):=0D
  meson: Fixes the ninjatool issue that E$$: are generated in=0D
    Makefile.ninja=0D
  meson: fixes relpath may fail on win32.=0D
  meson: Mingw64 gcc doesn't recognize system include_type for sdl2=0D
  configure: Fix include and linkage issue on msys2=0D
  meson: Fixes ninjatool can not be recognized as script under=0D
    Window/MSYS2=0D
  meson: Convert undefsym.sh to undefsym.py=0D
=0D
 configure             | 28 ++++++++++++++-------=0D
 meson.build           |  5 ++--=0D
 scripts/mtest2make.py | 11 +++++++--=0D
 scripts/ninjatool.py  |  2 +-=0D
 scripts/undefsym.py   | 57 +++++++++++++++++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh   | 20 ---------------=0D
 6 files changed, 88 insertions(+), 35 deletions(-)=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.27.0.windows.1=0D
=0D


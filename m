Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B781C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A36208DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9yUCdfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A36208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERdS-000859-0T
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERc9-0006Pr-EN; Sat, 05 Sep 2020 02:23:53 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:42795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERc7-0003UL-Pk; Sat, 05 Sep 2020 02:23:53 -0400
Received: by mail-pl1-x634.google.com with SMTP id j11so2116941plk.9;
 Fri, 04 Sep 2020 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q/gexmTa/YH7hhTv7O7ttDMEBUVZAx5Bi9pjOkkesPI=;
 b=Q9yUCdfiLMdWB24qmJxvLJHDufKp5nPxRiIm7xIu9lNf2UPmPgkBdgi492zC2wuoSJ
 9r+oGX+vro7UHNeqN3BV6itGIZhbtVgB9xrvl/wCKJf6qbxxVonxofB3E8E2Xajh8LaJ
 ptOly+bdn0i1d74p9b1Ll6HTHdsGMggMJqm9WisvYIVX8PL5HMjKu5EEmv6eiTUBw2R+
 372R86QlXQVYMpe/QzXXFeBKTsGwv4XkyVxc/0UyrL0cfk4YgQ+kfTz/bshm+y4PZdvO
 kkwI2+vY0sgQiHzFla0nQv3jYd2knI5UM2Wbl2+eYYxLf+aHwLaH7QMp64K+80Pg4obI
 HaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=q/gexmTa/YH7hhTv7O7ttDMEBUVZAx5Bi9pjOkkesPI=;
 b=rqgXKeJfhDpTOqNVKgFDRA8izBvZdG8jMLlb+0aZ5htddaJKdHk7D/0ymNSRbmMijY
 NrXjEiB0GZpCOMqTAO9SLjm0unGQG1OL+3vct1FPcG3pk/Lz2WM8WJPhG3/N3xlt/gyp
 +58ah+vecfP0UvctgMi9Jfnv46dBWepVSX1QTMqBTsTllIK05KU8n0/KDcA1Eo7g76Ny
 VArp/elIBCqJi8CoZZCVBT2Gb7TX24dGc+efNVmlefNJpniLJprLHv0QIHks3vOjcES8
 k+ny1LJWwRWxNISt9zA5dFK5nCSEicmVdGDhtkWXvYs+oAzFgWDl4nn6yXjMMNsGN0Qv
 0f+w==
X-Gm-Message-State: AOAM531seNPwYKQal7ifFjVudnXOCiOEedu4Ho1s40XCxWcRVZQO7XK9
 98jQEoNktnhHR/rdTTiv5eXDPVvrLc26rA==
X-Google-Smtp-Source: ABdhPJxA9RdohKCULkCxgJDCM5lC5fnKnWihjO8tcadnNOENYu8L4EFwJQNQikU1R+cqRAFmcjskRA==
X-Received: by 2002:a17:90a:c24a:: with SMTP id
 d10mr11650904pjx.31.1599287029077; 
 Fri, 04 Sep 2020 23:23:49 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:23:48 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 00/11] Green the msys2 CI make
Date: Sat,  5 Sep 2020 14:23:22 +0800
Message-Id: <20200905062333.1087-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x634.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also it's fixes issues about make check=0D
=0D
Yonggang Luo (11):=0D
  Revert "configure: add --ninja option"=0D
  block: Fixes nfs on msys2/mingw=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  meson: upgrade meson for execute custom ninjatool under msys2 properly=0D
  ci: Enable msys2 ci in cirrus=0D
  tests: Trying fixes test-replication.c on msys2.=0D
  block: get file-win32.c handle locking option consistence with=0D
    file-posix.c=0D
  osdep: These function are only available on Non-Win32 system.=0D
  meson: Fixes qapi tests.=0D
  docker: Add win32/msys2/mingw64 docker=0D
  ci: Enable Github actions.=0D
=0D
 .cirrus.yml                           | 24 +++++++++++++++++++=0D
 .github/workflows/main.yml            | 31 +++++++++++++++++++++++++=0D
 block/file-win32.c                    | 23 +++++++++++++++++--=0D
 block/nfs.c                           | 26 +++++++++++++--------=0D
 capstone                              |  2 +-=0D
 configure                             | 18 ++-------------=0D
 include/qemu/osdep.h                  |  2 +-=0D
 meson                                 |  2 +-=0D
 scripts/ci/windows/msys2-build.sh     | 27 ++++++++++++++++++++++=0D
 scripts/ci/windows/msys2-download.bat |  4 ++++=0D
 scripts/ci/windows/msys2-install.sh   | 33 +++++++++++++++++++++++++++=0D
 tests/docker/dockerfiles/msys2.docker | 11 +++++++++=0D
 tests/qapi-schema/meson.build         |  3 ++-=0D
 tests/test-replication.c              | 17 ++++++++++----=0D
 14 files changed, 188 insertions(+), 35 deletions(-)=0D
 create mode 100644 .github/workflows/main.yml=0D
 create mode 100644 scripts/ci/windows/msys2-build.sh=0D
 create mode 100644 scripts/ci/windows/msys2-download.bat=0D
 create mode 100644 scripts/ci/windows/msys2-install.sh=0D
 create mode 100644 tests/docker/dockerfiles/msys2.docker=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


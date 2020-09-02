Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7154EC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EB3207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RemxNqek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EB3207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaXn-0007RE-8b
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWY-00065F-P9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:46078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWX-0001Pt-7H
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:34 -0400
Received: by mail-pg1-x52a.google.com with SMTP id 67so361464pgd.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LuZzvSM7AIb0tiPi8yJdNa7HhFE5jx57QL3jKKiiUes=;
 b=RemxNqek7L221YQFpoL9VE7MWDeMER65xuhTCZULx0NZxAMcsDpPPeJsMdw9HgpRVj
 7aSkuD/ype+Cf8dseHZ8cBMgnsR+AYyM4G3qUU0FPlvYm1Ccg+VhkebdftOC1eFh/fyy
 VeIBWW9ZquO5zmambrioHOrWjaT+OKURbEGm4M8yKozSaPsVVzuAmtVuUcX3DI/byVPi
 MbouFetHBdhB8s1mAiAp1N9I2s/giKaXnbaLBBV3C94kui6wSCJNPLxV4Ei9s6dMM74K
 jes+rqOVe6JAp9vZt3glAkDk7xpPIKa1So+jfww85k+32lFGFlGhURBhmU3yLP8PcPw5
 W9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LuZzvSM7AIb0tiPi8yJdNa7HhFE5jx57QL3jKKiiUes=;
 b=O+NN2ZYclCK04j+WrXzFleDoS5APBfbYWW70btTxODsqToW2ySh94k5E4Orhv5BnuX
 jtUNmzu8XtFn1XOI5OzfZBdpTric+ZiNzD6RATVk4aI2PWKJ/N76C5aijryacgVH1Bn5
 h0Mob+cyeTiPM3h8Kbw8xNy6FAakghL9hH9edyq7bhtXKMoDaAcjnl8uODMFbIKvN75T
 BMbs8f7KxT/NJCT6IRkZFjBUiTScp6oNC0aARCxh8zKRbsMCCBoz7rHM7UXZEqRQFmz5
 Q/D54ma3LvOqyTVU7Mgs0e12FDH0B4og/gpI9L9eTtGWbpVrNXzd2qjG0xcR4nNRPWj/
 XDlA==
X-Gm-Message-State: AOAM531hySupNlPLh4dnQWw1dNg/vSJq+Gd0bwVlzeVFndZutE6T3jYL
 3JqbYC9/rTDgGFN+neK0CEXdFIsd4BwjDQ==
X-Google-Smtp-Source: ABdhPJz77RwdEBmAgUWEOu98kyUkR/BpRprB9Q5rTmFC2jU+dk03AORt833ibudu7WrBrZ4y5nbA9A==
X-Received: by 2002:a17:902:bcc3:: with SMTP id
 o3mr374126pls.241.1599082951288; 
 Wed, 02 Sep 2020 14:42:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x12sm328863pjq.43.2020.09.02.14.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:42:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] Green the msys2 CI make
Date: Thu,  3 Sep 2020 05:42:02 +0800
Message-Id: <20200902214211.337-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52a.google.com
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

Also it's fixes two issues about make check=0D
=0D
Yonggang Luo (9):=0D
  configure: fixes dtc not cloned when running msys2 CI=0D
  meson: Convert undefsym.sh to undefsym.py=0D
  tcg: Fixes dup_const link error=0D
  tests: handling signal on win32 properly=0D
  configure: Fix include and linkage issue on msys2=0D
  block: Fixes nfs on msys2/mingw=0D
  osdep: These function are only available on Non-Win32 system.=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  ci: Enable msys2 ci in cirrus=0D
=0D
 .cirrus.yml                         | 23 ++++++++++++=0D
 block/nfs.c                         | 26 ++++++++-----=0D
 capstone                            |  2 +-=0D
 configure                           | 48 +++++++++++++++---------=0D
 include/qemu/osdep.h                |  2 +-=0D
 include/tcg/tcg.h                   |  6 +--=0D
 meson.build                         |  2 +-=0D
 scripts/ci/windows/msys2_build.sh   | 34 +++++++++++++++++=0D
 scripts/ci/windows/msys2_install.sh | 31 ++++++++++++++++=0D
 scripts/undefsym.py                 | 57 +++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh                 | 20 ----------=0D
 tcg/tcg-op-gvec.c                   |  2 +-=0D
 tests/test-replication.c            |  4 ++=0D
 13 files changed, 204 insertions(+), 53 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2_build.sh=0D
 create mode 100644 scripts/ci/windows/msys2_install.sh=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.27.0.windows.1=0D
=0D


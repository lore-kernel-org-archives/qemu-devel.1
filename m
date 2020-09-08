Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0FF20768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdtsYN4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0FF20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjcM-0005vh-BB
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbc-0004ax-Og; Tue, 08 Sep 2020 15:48:40 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:53526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbb-0002TD-7F; Tue, 08 Sep 2020 15:48:40 -0400
Received: by mail-pj1-x102d.google.com with SMTP id t7so136190pjd.3;
 Tue, 08 Sep 2020 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nfKpDhdQ85i17fDlPzLWKKKGwEE0hhwXmW/L+QQBwhE=;
 b=QdtsYN4AWLjfk2AXmhxk5Ih/QRCuzpagjH5ACGm9+sZ8wEsordvEm3qEMoHu6FE4Yk
 MULnjSRgxKEsp+4OjivO06hb5tvzhIu7XyA1iuxHhYjiXJLM/bsx1702boiqkEva0pRk
 pfpsykk3Q4H7sbPQUX7P5zQv3/BbaAjB6wpZ5o0xQPylOc/LDUqASxHJzZD+s3E3b98M
 YY/l5MtW2eCDv6PazyxaQyk+kEe0hyk4OlKPrh9COUIzOd2kmgcOg6fHBc8hwCXOSKNQ
 5/FKEper4EZcsZFMg1p3QtFsQc6d2BUTIKp5J/2kr+Rl789rZbeaGRBRir/2qZGn5BIV
 oJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nfKpDhdQ85i17fDlPzLWKKKGwEE0hhwXmW/L+QQBwhE=;
 b=D94oPWh4fnLoyEyp0EZpxg3Wsz4LrJLhk68rlBAICT+dB+8N4SPlhEldBsTBZ6d+fv
 ESidIPPx5tN0cbLgGu+BXLKf2DxrA3onhJDdDBXt/bKtaOUf3QjryzZ1dd+X4Fgc+b2i
 0fNAXeMSTcorqEDhgDc3jSsxCjRrzZe8MOo0DY6B9iWj6n1t3L/yW3vPazo48bVV2Cxb
 MBXUn0AbsDQBG5QkKD1ObTjPx5uj/IRMxAdT4+KHgJrKUtzb6jy3tJEs4wiZwo4mHE3l
 9yYV/ax0eFG+3wcSSsJZVtK/kxxUpWHIe/OKgg7PpmQ9DFUjFsguMu+HDU4VM/mHP/U9
 Nbew==
X-Gm-Message-State: AOAM533gDvBz3pB817LfWiJgKiOKnR6w5MX3nHb0GL8hA4zb46+PX9If
 9bHK0ZzJICkEn9YfOcYpxkKKP34laVeGnOc1
X-Google-Smtp-Source: ABdhPJzBP41YpuB+vwt+st365VwcYFVLthS5MTTsBiY906B4werH/4/+V4eoqCF6Eugc5aKmIWUg2Q==
X-Received: by 2002:a17:90b:a44:: with SMTP id gw4mr392577pjb.26.1599594516912; 
 Tue, 08 Sep 2020 12:48:36 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:48:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] W32, W64 patches
Date: Wed,  9 Sep 2020 03:48:04 +0800
Message-Id: <20200908194820.702-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102d.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and=0D
disable partial test-char tests.=0D
And then fixes a number of unit tests failure on msys2/mingw=0D
=0D
Yonggang Luo (16):=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  configure: Fixes ncursesw detection under msys2/mingw and enable=0D
    curses=0D
  curses: Fixes curses compiling errors.=0D
  tests: disable /char/stdio/* tests in test-char.c on win32=0D
  ci: Enable msys2 ci in cirrus=0D
  tests: Trying fixes test-replication.c on msys2/mingw.=0D
  block: get file-win32.c handle locking option consistence with=0D
    file-posix.c=0D
  osdep: These function are only available on Non-Win32 system.=0D
  meson: Use -b to ignore CR vs. CR-LF issues on Windows=0D
  meson: disable crypto tests are empty under win32=0D
  meson: remove empty else and duplicated gio deps=0D
  vmstate: Fixes test-vmstate.c on msys2/mingw=0D
  cirrus: Building freebsd in a single short=0D
  logging: Fixes memory leak in test-logging.c=0D
  rcu: add uninit destructor for rcu=0D
=0D
 .cirrus.yml                         | 59 ++++++++++++++++-------------=0D
 block/file-win32.c                  | 23 ++++++++++-=0D
 block/nfs.c                         | 26 ++++++++-----=0D
 capstone                            |  2 +-=0D
 configure                           | 11 ++----=0D
 include/qemu/osdep.h                |  2 +-=0D
 include/qemu/rcu.h                  |  5 +++=0D
 meson.build                         |  6 ---=0D
 scripts/ci/windows/msys2-build.sh   | 28 ++++++++++++++=0D
 scripts/ci/windows/msys2-install.sh | 33 ++++++++++++++++=0D
 tests/meson.build                   |  3 +-=0D
 tests/qapi-schema/meson.build       |  2 +-=0D
 tests/test-char.c                   |  4 ++=0D
 tests/test-logging.c                |  4 +-=0D
 tests/test-replication.c            | 13 +++++--=0D
 tests/test-vmstate.c                |  2 +-=0D
 ui/curses.c                         | 14 +++----=0D
 util/rcu.c                          | 37 +++++++++++++++++-=0D
 18 files changed, 205 insertions(+), 69 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2-build.sh=0D
 create mode 100644 scripts/ci/windows/msys2-install.sh=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


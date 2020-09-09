Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C28C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E7D21D79
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hncZkODm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E7D21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwjS-0001wW-Ud
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgX-00062T-Nn; Wed, 09 Sep 2020 05:46:37 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:54133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgW-0007f6-0b; Wed, 09 Sep 2020 05:46:37 -0400
Received: by mail-pj1-x102a.google.com with SMTP id t7so1062651pjd.3;
 Wed, 09 Sep 2020 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AFCLvdTLM0MkPTvvP8K6WJoQtH1sTS9qVLxByUIIgtU=;
 b=hncZkODmbg5KhaMnDb9kD6S5GRdJS4rVaCp9N7h9qkaEWOxLBqKIOEg9PDaTDX7VFH
 +9viuZjdiWhLXDG2ljxTFmUcd2+Ny+/PUTMLj+/yz16AU/DNtDv6hHNXRhfAKsQgfdVa
 H1nQBw3vM64TzFi6DVeGI6c8NVAwVfqztKPJngynuXWkkp+hfGwgbXrA7stWiNpZF6S5
 oPjC9AvVF7VKCh5zQJQe5hFzhsLqtm86UI6nsugzDEFOczNKPdA2YkUVJr6/lbqB7n8V
 aO7udc8Xq6fsQx5s91475fZJR39mVwJWmMLhIBE1F474k/7CmODKPP0Q+74UgM3aK7ZO
 OUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AFCLvdTLM0MkPTvvP8K6WJoQtH1sTS9qVLxByUIIgtU=;
 b=Ukn1lcea+eo7tLaGAyeKOhy6x0PT3ciKDZGog/AVMEA7GRviF18XLyBfK0klLJLrjs
 M3tZ7CKf5anevTXhag6fC0O7c7c/p1EFLs22xrBaNbv8fVc8q/SG0tgvXJeZRPNbvB44
 qdTrizUlhG9CIHDHXtPRndNDpY9NHhSxzQXeR/rfnjiyw/bw7fAehq3Q0vVSb8woDR7I
 F3gtjsOUiDpD+EuM4lqdYJeNDHB4yz0CS1BNPsJ0SZVjIinkjIVo7riKonDuqL7BiOlC
 Cnr01042GaU56+umNJLjo8gZGC28wI3yqjwTzwt+SQikiudEJ3Qc6MhOTaGKh0dH60lN
 Ul/Q==
X-Gm-Message-State: AOAM531QKU8MDWab590Y3yygbG2l0bfpVPmYkBf1HcMj6v283jBSyEh6
 kUqjc6Pcx7i8tUapayWF+TxMO6qkijqFCGG+
X-Google-Smtp-Source: ABdhPJw4BwhOLJSUtzUhthBOgyGSl+bT8xrv+P7dMtAidPjv21cwiZRuihYiYjbWoTbYmXFCV4M/Zw==
X-Received: by 2002:a17:90a:d315:: with SMTP id
 p21mr127168pju.88.1599644793748; 
 Wed, 09 Sep 2020 02:46:33 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:46:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/21] W32, W64 msys2/mingw patches
Date: Wed,  9 Sep 2020 17:45:56 +0800
Message-Id: <20200909094617.1582-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102a.google.com
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and=0D
disable partial test-char tests.=0D
And then fixes all unit tests failure on msys2/mingw=0D
=0D
Yonggang Luo (21):=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  configure: Fixes ncursesw detection under msys2/mingw and enable=0D
    curses=0D
  curses: Fixes curses compiling errors.=0D
  tests: disable /char/stdio/* tests in test-char.c on win32=0D
  ci: Enable msys2 ci in cirrus=0D
  tests: Trying fixes test-replication.c on msys2/mingw.=0D
  tests: test-replication disable /replication/secondary/* on=0D
    msys2/mingw.=0D
  osdep: These function are only available on Non-Win32 system.=0D
  meson: Use -b to ignore CR vs. CR-LF issues on Windows=0D
  meson: disable crypto tests are empty under win32=0D
  meson: remove empty else and duplicated gio deps=0D
  vmstate: Fixes test-vmstate.c on msys2/mingw=0D
  cirrus: Building freebsd in a single short=0D
  tests: Convert g_free to g_autofree macro in test-logging.c=0D
  rcu: add uninit destructor for rcu=0D
  tests: Fixes test-io-channel-socket.c tests under msys2/mingw=0D
  tests: fixes aio-win32 about aio_remove_fd_handler, get it consistence=0D
    with aio-posix.c=0D
  tests: Fixes test-io-channel-file by mask only owner file state mask=0D
    bits=0D
  tests: fix test-util-sockets.c=0D
  tests: Fixes test-qdev-global-props.c=0D
=0D
 .cirrus.yml                         | 59 ++++++++++++++++-------------=0D
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
 tests/test-char.c                   |  8 ++--=0D
 tests/test-io-channel-file.c        |  4 +-=0D
 tests/test-io-channel-socket.c      |  2 +=0D
 tests/test-logging.c                |  5 ++-=0D
 tests/test-qdev-global-props.c      |  6 +--=0D
 tests/test-replication.c            | 22 +++++++++--=0D
 tests/test-util-sockets.c           |  6 ++-=0D
 tests/test-vmstate.c                |  2 +-=0D
 ui/curses.c                         | 14 +++----=0D
 util/aio-win32.c                    | 11 +++++-=0D
 util/rcu.c                          | 37 +++++++++++++++++-=0D
 22 files changed, 215 insertions(+), 79 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2-build.sh=0D
 create mode 100644 scripts/ci/windows/msys2-install.sh=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BFE2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pO3ryE1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BFE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiiO-0004fW-B0
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigW-00027N-R1; Tue, 08 Sep 2020 14:49:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:35754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigT-0002aj-E0; Tue, 08 Sep 2020 14:49:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id g29so206010pgl.2;
 Tue, 08 Sep 2020 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3kHibY70lINvCvokAJ3PeXuKGyHbKaVCxn28UMXSbs=;
 b=pO3ryE1TTCgkUcnukSMTVyfzXVjSnQMaT1hh9ywUoku7eNddW58zOgYuKSIv8NKM9v
 0XqVQt4DFCtZJuCXqnHMzdF3uU/I5v+8l5HYN+PEbkc1oGtjE+6PR3IkgGiGZzmMOKqD
 GD7rCxXkN0o5nCGfSeWSPSGnrwu/jW1gDCPeKDFdNz80CBf31Z6ao4sxr/P+OYuVkS+Q
 ds6SzgUkQ6zPwW63JWtzK33HsDU+Mgkhuo88EypR0Sy5hSgGhrURUVNr041KSdZRVdJh
 NkMZ+IiuAmucLLnFvMtQ3zdDkJZYL5iRWuGtCuZxuW5kRHuFotJMi7koG6vWiS5omNfF
 c1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=J3kHibY70lINvCvokAJ3PeXuKGyHbKaVCxn28UMXSbs=;
 b=mjCTxnjKyfs3rCnyw0GSnFzYpM6gk52Mv6veQSQtlJG9fxW6zEN1CmPf1z2y1B4RSN
 Y9g+0/x88quFg6Yf46WflL6crV1m7cHQ7pR3SCGotwSfvSNC4UBv5RY4bbFUCgrdEYfK
 FzXDBBr1rBLfubbSX19IbFA27tZgc/bkCVBG+vnoxdLJBRD/9oUJi6qyCXWG4nJycFCs
 aFQHKWSbPCM95789C3/h4CgIqMyp4in3tW3EZtITK6dW7hTAJ7gfZ3opfNG4g0VAaWSI
 go4b61uucGGVk+y7+VWAGSspvc+WEcjxOdANPQdAVPKhatCf5k1HMOIl1psMwrsBxfyt
 hcwA==
X-Gm-Message-State: AOAM533bnJsKDvkhyymPnTeVeQYPIr4VDwcOjPgmI79LoNS49TUgu3mD
 mZ0Yl53Vuh6sElXxKcnfgyG9iyQm5ZJydfkK
X-Google-Smtp-Source: ABdhPJwa6e+sReTdHZ1wIG9hQgEHS2ezIhYGq371k6MtRvEUxo//PygKFIQQ9lNFj08tEW8ZUe7FOA==
X-Received: by 2002:a63:4e4f:: with SMTP id o15mr122794pgl.202.1599590974725; 
 Tue, 08 Sep 2020 11:49:34 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:49:33 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Msys2 patches patches
Date: Wed,  9 Sep 2020 02:49:02 +0800
Message-Id: <20200908184918.1085-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52d.google.com
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
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6779038537360e957dbded830f76b08ef5070161=
:=0D
=0D
  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-08' i=
nt=3D=0D
o staging (2020-09-08 17:23:31 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  http://github.com/lygstate/qemu tags/msys2-patches-pull-request=0D
=0D
for you to fetch changes up to 1892e4360f55ac8cbeeeae0043e0a9dc05c50269:=0D
=0D
  rcu: add uninit destructor for rcu (2020-09-09 02:34:59 +0800)=0D
=0D
----------------------------------------------------------------=0D
msys2 patch queue 2020-09-09=0D
=0D
It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and di=
sa=3D=0D
ble=0D
partial test-char tests.=0D
And then fixes a number of unit tests failure on msys2/mingw=0D
=0D
----------------------------------------------------------------=0D
=0D
Yonggang Luo (16):=0D
  block: Fixes nfs on msys2/mingw=0D
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
--=3D20=0D
2.28.0.windows.1=0D
=0D


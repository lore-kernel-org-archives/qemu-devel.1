Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F80CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BDE20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/EbFaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BDE20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJsM-0007SL-Im
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrO-0006VA-8E; Thu, 10 Sep 2020 06:31:22 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGJrM-000342-HV; Thu, 10 Sep 2020 06:31:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id y6so703166plt.9;
 Thu, 10 Sep 2020 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xNA58CMYg3J4BDUUZZNyKBJkTAFEv3p0kfY/snZM+Qs=;
 b=E5/EbFaR1dccCm6cc964KQO+y1nwMyx1EyY4PmhN7PEjQOdX7ScO3w63MbNKCsu//6
 AGC2EZI8wMOgmhY1MT67I+L4qWYJDUPvrgmBXTTXmCJjZNecaUoDmW64Xm0bW0NtLv0Q
 2sgk8G6ePBAu/uBo1mkel+KqSfsK1NWojUN8oMCkpV0u21tOZ0F8T9eto+KMOynQjaRd
 TdkMOpdBet+F13HjLfKAdDyPxmzM7BtNpTBbqPdZ/BNiWS97G/xV2sR2wjZwe6cbidhi
 GFnBqR8rKwEtTd1Qp+Rm8FKKrc3LBqO9ZmALottKFU+xzrRT59S9PEjnbglXHpl1KIay
 1sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xNA58CMYg3J4BDUUZZNyKBJkTAFEv3p0kfY/snZM+Qs=;
 b=aof85ISRP8skEk2biTBHhl/z+7uPespoDtGrS50/e+yrYH0D01BHtt8lcYcN994wjM
 4PINX0W6qUXpGDhTjtU95aYF+Ec7VIVuH7uEyHRsFZytVa4Fwz5fpV9jOJopo5vlFZhk
 /yP1vY+sBbrOXrYDhvPl7430bnA4sFdocxFEvGCvI0tWhwMQaz6TlKHhA98/BA4oY6OJ
 xT9PqfF/nZiGwhtL0jafAcLsg5YG4kyZZZ2qQByXM/z4cR2CMyN8SmR9BrPw9VnB6IK8
 PO2mSqm7p18RFvcD5Fx6+9ibA92AvCqRZ3I/oyrch1tOIxVTJ6CCi/K0kRqKP6sWaB88
 4GDA==
X-Gm-Message-State: AOAM532HrLSaSDKxnUbb87IAgOV4AG+i7CtLd9FCiriI+N7zpaIh15UW
 72HsIjM9ykUj+nvjHY++jzqkJb7vL5m/HY1KN4w=
X-Google-Smtp-Source: ABdhPJxNoT6H+qFQU/ttLBonV4Wr8XuQXu+fb2NpriVwuRHZo+jEKLunfkEPY4srQ05WPA33P5uxRw==
X-Received: by 2002:a17:90a:a60e:: with SMTP id
 c14mr4832203pjq.31.1599733878216; 
 Thu, 10 Sep 2020 03:31:18 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id g21sm2000203pfh.30.2020.09.10.03.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 03:31:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/25] W32, W64 msys2/mingw patches
Date: Thu, 10 Sep 2020 18:30:34 +0800
Message-Id: <20200910103059.987-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x642.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and=0D
disable partial test-char tests.=0D
And then fixes all unit tests failure on msys2/mingw=0D
This fixes the reviews suggested in the mailling list=0D
=0D
Kevin Wolf (1):=0D
  file-win32: Fix "locking" option=0D
=0D
Maxim Levitsky (1):=0D
  rcu: Implement drain_call_rcu=0D
=0D
Yonggang Luo (23):=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  configure: Fixes ncursesw detection under msys2/mingw and enable=0D
    curses=0D
  win32: Simplify gmtime_r detection direct base on=0D
    _POSIX_THREAD_SAFE_FUNCTIONS.=0D
  curses: Fixes curses compiling errors.=0D
  tests: disable /char/stdio/* tests in test-char.c on win32=0D
  tests: Fixes test-replication.c on msys2/mingw.=0D
  tests: test-replication disable /replication/secondary/* on=0D
    msys2/mingw.=0D
  osdep: file locking functions are not available on Win32=0D
  meson: Use -b to ignore CR vs. CR-LF issues on Windows=0D
  gcrypt: test_tls_psk_init should write binary file instead text file.=0D
  tests: Enable crypto tests under msys2/mingw=0D
  meson: remove empty else and duplicated gio deps=0D
  vmstate: Fixes test-vmstate.c on msys2/mingw=0D
  cirrus: Building freebsd in a single short=0D
  tests: Convert g_free to g_autofree macro in test-logging.c=0D
  tests: Fixes test-io-channel-socket.c tests under msys2/mingw=0D
  tests: fixes aio-win32 about aio_remove_fd_handler, get it consistence=0D
    with aio-posix.c=0D
  tests: Fixes test-io-channel-file by mask only owner file state mask=0D
    bits=0D
  tests: fix test-util-sockets.c=0D
  tests: Fixes test-qdev-global-props.c=0D
  rcu: fixes test-logging.c by call drain_call_rcu before rmdir_full=0D
  ci: Enable msys2 ci in cirrus=0D
=0D
 .cirrus.yml                      |  95 ++++++++++++-----=0D
 block/file-win32.c               |  22 +++-=0D
 block/nfs.c                      |  32 ++++--=0D
 capstone                         |   2 +-=0D
 configure                        |  61 +++--------=0D
 include/qemu/osdep.h             |   2 +-=0D
 include/qemu/rcu.h               |   1 +=0D
 include/sysemu/os-win32.h        |   4 +-=0D
 meson.build                      |   6 --=0D
 tests/crypto-tls-psk-helpers.c   |   6 +-=0D
 tests/crypto-tls-x509-helpers.c  | 169 ++++++++++++++++++++++++++++++-=0D
 tests/crypto-tls-x509-helpers.h  |   9 +-=0D
 tests/qapi-schema/meson.build    |   2 +-=0D
 tests/test-char.c                |  26 +++--=0D
 tests/test-crypto-tlscredsx509.c |  47 +++++----=0D
 tests/test-crypto-tlssession.c   |  68 +++++++------=0D
 tests/test-io-channel-file.c     |  10 +-=0D
 tests/test-io-channel-socket.c   |   2 +=0D
 tests/test-io-channel-tls.c      |  51 ++++++----=0D
 tests/test-logging.c             |   5 +-=0D
 tests/test-qdev-global-props.c   |   6 +-=0D
 tests/test-replication.c         |  22 +++-=0D
 tests/test-util-sockets.c        |   6 +-=0D
 tests/test-vmstate.c             |   3 +-=0D
 ui/curses.c                      |  14 +--=0D
 util/aio-win32.c                 |  11 +-=0D
 util/oslib-win32.c               |   2 +-=0D
 util/rcu.c                       |  55 ++++++++++=0D
 28 files changed, 536 insertions(+), 203 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


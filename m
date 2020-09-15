Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06027C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944F7208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7B8uy0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944F7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEpI-0008Qs-Or
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWz-0008Og-2q; Tue, 15 Sep 2020 13:14:13 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEVj-0002cK-QC; Tue, 15 Sep 2020 13:12:57 -0400
Received: by mail-pg1-x541.google.com with SMTP id z17so2332586pgc.4;
 Tue, 15 Sep 2020 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uq19f9xUw48l5aXNxxsd8+DiZHX2ja2v+vKEiZxAu2E=;
 b=e7B8uy0dw+crxqUF38VkbKKY9MA1ud690/+tOccJTABxcq6dmNOLjiDhod8nAT4IJ+
 JXsRX7ePWaQJFe5qAg00nCdEvFQqTscHhSDDJ4werhFjhAmXTZfbnllXHL2vB/AfsjKr
 Xxr4XZ1zAJx3jMekBumjRZG+OzX5qc+eArJL/wfvtwtuw2J3J2zhZPScidi+2QRwKoBB
 DdGGgvCG1WTHmGdUERWDlFHgCI1+dSlIIlOdIeDLFHxMi3lWKlL7f2LVumJIIILPiVx9
 IHK2v4PGwEwGuVqGrDd0FrFtSEanPmuV3nvUbmYVPVLYieSl0Jd+FRcZTsGlMcICpX/6
 6HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uq19f9xUw48l5aXNxxsd8+DiZHX2ja2v+vKEiZxAu2E=;
 b=Xh/2spXJktU/mfGnn6qx0vK8ZI5H3NPDiyQAYUAj8D6pZzE1zGKgTnmXNR1YGD/3wX
 MmVItF+umI+cBCBNf7CDQgPx+xwnOjhE8TEMVX9aL8O+Hhrha5h6f2K78MJsRENB5GL0
 XtQF+lOlup6xv7j+mTzY9Tb+5JVsKNkUhA+c7TMUNZobq/zxEkqdDJ0/yIVqMky0ByxP
 y/nfxzAAMKAA+a8q7Pgjmh6haMbB8o1NMMz5l/4u7NcWT8KSStkL6i4Fu1IzgDn/kiBI
 vt+rjcGyJRJ4NC1qZTPHBlyeOqaO0jy3uBpHwOK7DNCCMEYnuQmS69o6Nvv1G7a3880t
 dyvg==
X-Gm-Message-State: AOAM532KryW7aopx9uTzt7A/iXQs19ZsCEq1id+l3m/xJevB9wLi5pZu
 fQPRD3qtgSwhMTxi7Xu50h+pQAvuhjM5uVg2p98=
X-Google-Smtp-Source: ABdhPJx9H5cSUYhwOKMTdt1zNwd08euPKS2Fsvbr9Fm9cPPguJN6XVUgZQckLkfkA4vo7xUWvDKmOQ==
X-Received: by 2002:a65:6412:: with SMTP id a18mr15737240pgv.215.1600189973055; 
 Tue, 15 Sep 2020 10:12:53 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:12:52 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 00/26] W32, W64 msys2/mingw patches
Date: Wed, 16 Sep 2020 01:12:08 +0800
Message-Id: <20200915171234.236-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
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
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V9-V10=0D
* gcrypt: test_tls_psk_init should write binary file instead text file.=0D
  Split #include <glib/gstdio.h> out, that line not belong this patch=0D
=0D
* tests: Enable crypto tests under msys2/mingw=0D
  move qemu_socketpair into oslib-win32.c and rename to socketpair=0D
  move qemu_link into osdep.c=0D
  Fixes code style warning=0D
=0D
* tests: Fixes test-io-channel-file by mask only owner file state mask bits=
=0D
  Update comment place=0D
=0D
* ci: Enable msys2 ci in cirrus=0D
  Fixes misleading error message=0D
=0D
Fixes all checkpatch error messages=0D
=0D
V8-V9=0D
=0D
* ci: Enable msys2 ci in cirrus=0D
  do not install libnfs, libcapstone and jemalloc=0D
  ident lines properly=0D
  Do not install libnfs when the add the msys2 ci,=0D
=0D
* Revert "configure: add --ninja option"=0D
  Skip this revision=0D
=0D
* block: Fixes nfs compiling error on msys2/mingw=0D
  Use typedef long long blkcnt_t; for libnfs on msys2/mingw=0D
  for futher implemenation, still disable nfs_get_allocated_file_size=0D
  on win32 as it not working yet, but preserve the possibility implemenatio=
n=0D
  it in futher=0D
=0D
* gcrypt: test_tls_psk_init should write binary file instead text file.=0D
  only fixes the file open mode parameter=0D
=0D
* osdep: file locking functions are not available on Win32:=0D
  Reword with "Do not declare the following locking functions on Win32:"=0D
=0D
* meson: Use -b to ignore CR vs. CR-LF issues on Windows=0D
  Reword of commit message=0D
=0D
* tests: Enable crypto tests under msys2/mingw=0D
  Reimplement qemu_socketpair in a simpler way. without thirdparty code=0D
=0D
* block: enable libnfs on msys2/mingw in cirrus.yml=0D
  New commit=0D
=0D
* tests: disable /char/stdio/* tests in test-char.c on win32=0D
  Needs review=0D
=0D
* tests: fixes aio-win32 about aio_remove_fd_handler, get it consistence wi=
th=3D=0D
 aio-posix.c=0D
  Needs review=0D
=0D
* rcu: fixes test-logging.c by call drain_call_rcu before rmdir_full=0D
  Needs review=0D
=0D
It first introduce msys2 CI on cirrus by fixes nfs, capstone, curses and=0D
disable partial test-char tests.=0D
And then fixes all unit tests failure on msys2/mingw=0D
This fixes the reviews suggested in the mailling list=0D
All cirrus CI are passed=0D
=0D
Maxim Levitsky (1):=0D
  rcu: Implement drain_call_rcu=0D
=0D
Yonggang Luo (25):=0D
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
  meson: upgrade meson for execute custom ninjatool under msys2 properly=0D
  ci: Enable msys2 ci in cirrus=0D
  block: Fixes nfs compiling error on msys2/mingw=0D
  block: enable libnfs on msys2/mingw in cirrus.yml=0D
=0D
 .cirrus.yml                      | 97 +++++++++++++++++++++++---------=0D
 block/nfs.c                      | 37 +++++++++---=0D
 capstone                         |  2 +-=0D
 configure                        | 61 ++++++--------------=0D
 include/qemu/osdep.h             |  3 +-=0D
 include/qemu/rcu.h               |  1 +=0D
 include/sysemu/os-win32.h        |  9 ++-=0D
 meson                            |  2 +-=0D
 meson.build                      |  6 --=0D
 tests/crypto-tls-psk-helpers.c   |  6 +-=0D
 tests/crypto-tls-x509-helpers.c  |  6 +-=0D
 tests/crypto-tls-x509-helpers.h  |  5 +-=0D
 tests/qapi-schema/meson.build    |  2 +-=0D
 tests/test-char.c                | 27 +++++----=0D
 tests/test-crypto-tlscredsx509.c | 47 ++++++++--------=0D
 tests/test-crypto-tlssession.c   | 64 ++++++++++++---------=0D
 tests/test-io-channel-file.c     | 12 +++-=0D
 tests/test-io-channel-socket.c   |  2 +=0D
 tests/test-io-channel-tls.c      | 49 +++++++++-------=0D
 tests/test-logging.c             |  6 +-=0D
 tests/test-qdev-global-props.c   |  9 ++-=0D
 tests/test-replication.c         | 22 ++++++--=0D
 tests/test-util-sockets.c        |  6 +-=0D
 tests/test-vmstate.c             |  3 +-=0D
 ui/curses.c                      | 14 ++---=0D
 util/aio-win32.c                 | 12 +++-=0D
 util/osdep.c                     | 16 ++++++=0D
 util/oslib-win32.c               | 78 ++++++++++++++++++++++++-=0D
 util/rcu.c                       | 55 ++++++++++++++++++=0D
 29 files changed, 459 insertions(+), 200 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D


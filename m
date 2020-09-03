Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D32C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF013205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpgAxD8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF013205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkgK-0000f9-Mr
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkf6-0007ah-GQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:38285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkf4-0001VZ-NB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id ls14so1117538pjb.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vw4UA1w8luzE/0cIBASrTyETv70ytELCPdmgHKlAMIE=;
 b=bpgAxD8kuOYkB7cxLDy3P2KnWqZA/CEaMJZiWMq+RjPMYX8k7K4pdzacUGRY5Wi54l
 WkuxBWx9tesjPadxKxKiu/cvcQiTwDwGHNbypMrDhhbAg8bqB8MWrwnDo78dQlWRN+6J
 oEXjUfsNLKFkLBYY4nUhPAPJp1iJlSY5FFI3YbABljG59fn3kMWBRbLyNLvAG6yW6At3
 JfFpY1iDnAAU80A/oqS9sa9c0ukVIoCJS3b/tK3ki/HiVC+yqIR5CsYXUUovTe0uxiT2
 V6aj9Vg0iDV9uO9kTFCG0/UnmQgTdBhME3O5LjyJY9rGXNoBt+e4/H9wliuJLXJwyXuV
 4SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vw4UA1w8luzE/0cIBASrTyETv70ytELCPdmgHKlAMIE=;
 b=XGpwbGB1GpYV4i6GsutPSh2kkkQwkwc8gcsrplqyYwb5zom6EUGevlYGYGl6ROe0Y5
 65XnzYS+DA7tIBCH91MdDHvwqTCpCf9rOjPu4ZOrE/QAe6otuT9Ns55oSGZzLlWXI5yB
 gjVWDaXNLjlZB5HmqmPbF/Gc59EMQgfInxsT0sKaaWuuHE18JYhdKg1nV8KiT1ZqCa0h
 MGtOMTkaCXjx5VyPwtSWqguX3U10spJFiv6YU2mHIhg7PX5b4hpjJQBQLHARL85iestg
 l1VK/ChD/ekF3v1ls+xQlV8gMjCeq0H7Tb5C6cE5O13UrzeWbQot8sDExbNlPvkofLrF
 iACw==
X-Gm-Message-State: AOAM531quGnlARGfyhOisomVKkXgiS67HqEDz6nuv/INaZ9nKm0s10+L
 f5BZfO7UmOW0ykwzpARHo1hDDFdPWg0zJwdZ
X-Google-Smtp-Source: ABdhPJwB2VSQxlAMCKIL1nTwMjzOt5XVM2I20D+1yvmsQNaMGuAI/TuQOK9L4Egs1MDVYQ3JW8R8yQ==
X-Received: by 2002:a17:90b:4a04:: with SMTP id
 kk4mr2248203pjb.153.1599121920690; 
 Thu, 03 Sep 2020 01:32:00 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:31:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/12] Green the msys2 CI make
Date: Thu,  3 Sep 2020 16:31:35 +0800
Message-Id: <20200903083147.707-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1032.google.com
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

Also it's fixes issues about make check=0D
=0D
Yonggang Luo (12):=0D
  configure: fixes dtc not cloned when running msys2 CI=0D
  meson: Convert undefsym.sh to undefsym.py=0D
  tcg: Fixes dup_const link error=0D
  tests: handling signal on win32 properly=0D
  configure: Fix include and linkage issue on msys2=0D
  block: Fixes nfs on msys2/mingw=0D
  osdep: These function are only available on Non-Win32 system.=0D
  ci: fixes msys2 build by upgrading capstone to 4.0.2=0D
  stubs: qemu_notify_event have no need to stub=0D
  meson: Fixes qapi tests.=0D
  tests: Disable test-image-locking that not works under Win32=0D
  ci: Enable msys2 ci in cirrus=0D
=0D
 .cirrus.yml                         | 24 ++++++++++++=0D
 block/nfs.c                         | 26 ++++++++-----=0D
 capstone                            |  2 +-=0D
 configure                           | 48 +++++++++++++++---------=0D
 include/qemu/osdep.h                |  2 +-=0D
 include/tcg/tcg.h                   |  6 +--=0D
 meson.build                         |  2 +-=0D
 scripts/ci/windows/msys2_build.sh   | 33 +++++++++++++++++=0D
 scripts/ci/windows/msys2_install.sh | 31 ++++++++++++++++=0D
 scripts/undefsym.py                 | 57 +++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh                 | 20 ----------=0D
 stubs/notify-event.c                |  4 --=0D
 tcg/tcg-op-gvec.c                   |  2 +-=0D
 tests/Makefile.include              |  2 +=0D
 tests/qapi-schema/meson.build       |  3 +-=0D
 tests/test-replication.c            |  4 ++=0D
 16 files changed, 208 insertions(+), 58 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2_build.sh=0D
 create mode 100644 scripts/ci/windows/msys2_install.sh=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


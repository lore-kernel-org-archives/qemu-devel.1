Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DC32071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKvK2pTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DC32071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjuu-0000o7-Hg
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDju8-00080P-Tn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:32 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:43137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDju6-0003qa-GI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:32 -0400
Received: by mail-pg1-x529.google.com with SMTP id d19so1430370pgl.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TP1wfnt1fUrZxcZpHycHd6YjkINzLnoIuvr4/6Aq1OI=;
 b=MKvK2pTzh5z/7FaajQwKMyRwTNfq1xfnW9mTkpm8LlJv9Zff3yzDfWuaWJ55gaPw92
 Fmje0MoruRBAOMMW174DDCtL5swEvRaE0L+iPg2urXGnxoS34oQPCippx0gR5jLsEMsd
 /D6fMu9braEyOGPHWwdLXYe7yx71cWDw5/eUYGoUzLa9aD7w19BQYM2SpP+m3jQZ7097
 tthzR4MUTurFak9ak0RsYpy9iFEEiy+DdTTATYFRJPhrCq5h1VDsZjr3bWykQKZXTPqW
 WRgGa1RxrsV70CH03a2lTXugKkXtBLBre3O9biCvn5XvctgMKSRpP9ilcHt/ZPjxbYQT
 rhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TP1wfnt1fUrZxcZpHycHd6YjkINzLnoIuvr4/6Aq1OI=;
 b=mXRDhHCE7oGAlkU0jfUeD9LRnz3X9LiJC00vfs6Nzq4ecY8X0aBkEMwTQCTvAjm16K
 3JVO5pdXDwrLPUGgTKdHy2D6mMmqq+dlgyV+veX4tcRmxdh2MRh7TkOBDbAC54F6Z9a2
 NngUR2FbOV6OfjDbA1HPZ1fcjtMdEwDXS7JSswgwa51r/MMl5oKRE8WxxdbWD0oPZW6H
 O8rhlUFu7FXu3GpFA7YikJxNwHPTsBwWn2/U1gsyrByaeLl6s0tqXEoScWMHqruiD6nA
 mNzhth0ANOHOBgSIjHctFK6If3DKZ5P1OPwasg3ZH2BMmaGd4l+DdzCOZJ7dHeLbxZxM
 2Ppg==
X-Gm-Message-State: AOAM531DUpcKaqSl9ISiz+/K/FfA8eEZpS51/PrQG5YNe4WbIsVE3no9
 +DEL7Kn45lWqVHLIwwg8y/e1fAG36wMsAw==
X-Google-Smtp-Source: ABdhPJxAQNEg+4O4T/F9gi8VyuOZyMsvSeUFdyYbHW23abUPnuSC7Mb+B0ydk1UuxBZ5ExP++SejxA==
X-Received: by 2002:a63:d14b:: with SMTP id c11mr1961646pgj.64.1599119008475; 
 Thu, 03 Sep 2020 00:43:28 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:27 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] Green the msys2 CI make
Date: Thu,  3 Sep 2020 15:43:01 +0800
Message-Id: <20200903074313.1498-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x529.google.com
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
 .cirrus.yml                         |   108 +-=0D
 block/nfs.c                         |  1812 +--=0D
 capstone                            |     2 +-=0D
 configure                           | 16560 +++++++++++++-------------=0D
 include/qemu/osdep.h                |  1372 +--=0D
 include/tcg/tcg.h                   |  2898 ++---=0D
 meson.build                         |  2994 ++---=0D
 scripts/ci/windows/msys2_build.sh   |    33 +=0D
 scripts/ci/windows/msys2_install.sh |    31 +=0D
 scripts/undefsym.py                 |    57 +=0D
 scripts/undefsym.sh                 |    20 -=0D
 stubs/notify-event.c                |     8 +-=0D
 tcg/tcg-op-gvec.c                   |  7012 +++++------=0D
 tests/Makefile.include              |  1086 +-=0D
 tests/qapi-schema/meson.build       |   451 +-=0D
 tests/test-replication.c            |  1214 +-=0D
 16 files changed, 17904 insertions(+), 17754 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2_build.sh=0D
 create mode 100644 scripts/ci/windows/msys2_install.sh=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


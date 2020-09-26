Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B4CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C974C2076D
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 14:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+NxUoax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMAty-00071Q-Uq
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 10:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoV-0000Os-FH
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kMAoT-0005Lb-PC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 10:04:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id n14so5657911pff.6
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I6x6otXY7uUyd5hpFd6j3oDYMPCejJZ+VKVh/VFGT2c=;
 b=J+NxUoaxdzRA8jjfh2eDWSFwsjxmI5Pe4A8ZPaMRiBHg4K4m6y/WUm/JPv5Ef3g7Tq
 bDknm74/eofxuG8CsuY+OuVL2fglkGd4rC+GIURQogviZuETc038wczTelRbm/mIsQUz
 7R8AJzx4F+jc6qmZMWBeetjnUlpEznniDb4dTfPx7sEUN7vQ6JHUJpl4wCCmpbIr2L1D
 DwdgANacK14+Pay0tBfBX/x7g19fb8bVtKulyjeTT5swQetkfy+HSxOOZiiVvnwvmt8C
 tFD2CU/1Axa7+dMLtXaaMsgYi2gOrZCpT1tbWrp4jtYfX298+VQd93WFrZhquRYj7v1V
 ubtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=I6x6otXY7uUyd5hpFd6j3oDYMPCejJZ+VKVh/VFGT2c=;
 b=gECo6CKNYGV8f7R4lsRvY/HTllQkEhVg3LKQ6FR8GPYV0YS4yxPL+sAn4GJPM9+h3u
 WuyHaqBXKcHcomV+gu2Q8+y+I87U8V5a7tTg6aX72cNZtH8ZYviR1NYfgF0/IhnGyZpQ
 FEdHPqWZVIi0L3aqHd65YDLiVIvLugWvyUaTB9uxl7sebKWAvGPkMMofRtYi/e6NRliR
 EOgetdUXLgKeyV2ggUqYOU68mO/miM3LPchwPzhKBpN4k5w8dgZ1mZYE7PH6q/bAAoFy
 oI8gUqgr1to+Sw4lfuA4aP2HJlsX111vHUk/pDqjs76NdS4tMm564UHnHs9SA1vFuEWG
 EOTA==
X-Gm-Message-State: AOAM5310yj/roapMvbs9/2SEIAwSDuth9I3A2Cw/xgvv+B1zLrZuxssm
 KeDEp78/7hhY9Wt67ymhrtVpSKfNRqgzWQTk
X-Google-Smtp-Source: ABdhPJyQkxMXUhmut9xD1TW1wOUl+w7WUGwx8t97e4iibreAU1ZkZCTbunWBqVpMyh564ycMlAl3hQ==
X-Received: by 2002:a63:546:: with SMTP id 67mr2833511pgf.347.1601129071151;
 Sat, 26 Sep 2020 07:04:31 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id k3sm6091109pfp.41.2020.09.26.07.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 07:04:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Enable plugin support on msys2/mingw
Date: Sat, 26 Sep 2020 22:04:11 +0800
Message-Id: <20200926140415.1286-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add this feature on msys2/mingw by using glib provided cross-platform dlsym=
 f=3D=0D
unctional.=0D
=0D
Yonggang Luo (4):=0D
  plugins: Fixes a issue when dlsym failed, the handle not closed.=0D
  plugin: Fixes compiling errors on msys2/mingw=0D
  Getting qemu-plugin works under win32.=0D
  cirrus: Enable plugin in cirrus for windows=0D
=0D
 .cirrus.yml                  |   3 +-=0D
 Makefile                     |   1 -=0D
 configure                    |  71 --------------=0D
 contrib/plugins/hotblocks.c  |   4 +-=0D
 contrib/plugins/hotpages.c   |   2 +=0D
 contrib/plugins/howvec.c     |   2 +=0D
 contrib/plugins/lockstep.c   |   2 +=0D
 include/qemu/qemu-plugin.h   | 184 ++++++++++++++++++++++++++---------=0D
 meson.build                  |   6 +-=0D
 plugins/api.c                |  65 +++++++------=0D
 plugins/core.c               |   7 +-=0D
 plugins/loader.c             |  21 ++++=0D
 plugins/meson.build          |  10 +-=0D
 plugins/qemu-plugins.symbols |  40 --------=0D
 tests/plugin/bb.c            |   6 +-=0D
 tests/plugin/empty.c         |   2 +=0D
 tests/plugin/insn.c          |   2 +=0D
 tests/plugin/mem.c           |   2 +=0D
 18 files changed, 224 insertions(+), 206 deletions(-)=0D
 delete mode 100644 plugins/qemu-plugins.symbols=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D


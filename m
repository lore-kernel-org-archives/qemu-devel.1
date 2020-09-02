Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F1C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2386C2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NILlm+EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2386C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW9I-0001gH-9r
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8K-0008UT-4M
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8H-0000GO-Kx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id l9so34194plt.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=39PZFdCRWxyDjf7lXdkvBy8HTsNhEwVlnQrm2I4OESk=;
 b=NILlm+EK8hJIem9qr1Gr232jyzX2GflxWLqKXfTh2/KHNEFJccyzQtgESwZeqqYCre
 /LSI4auFvxp6SYN+kMxNJLVBrQjj8ubJGXS5QOabj33eoG/j+FH94D+b2D0avBZTV8m0
 CyHT5k1xEOdF5dtlYvcEyjNi5Q7yxTCIlS/ANa7WvIu3soaOEfghk37ogL8lG1G+NArA
 k7+LY49pmOaokgnYBfaro6QI6PDScuW/l45MhJ2kCXr9DcSoUaBAqBzAezBQOlOabtv1
 TXjyKz/oB1sfQ0r+VWjMIBLqRLWibUiCMoXv+CPgvXGVgELk4XgjqAsMtTzvUBO0U48a
 /ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=39PZFdCRWxyDjf7lXdkvBy8HTsNhEwVlnQrm2I4OESk=;
 b=Izyw6R1qHSlmU3m/saVNDsxhOV6metMqfiM3SIbOZqqCbzCg38qXNNqzLfMb+2pAOq
 MHrLTtNtm7tHa0YxoFbljNHxXPrjJQiRVidOQYqPNeLVLNVCJTCTXaaySkVkxF3N8r2E
 DosRXxn46GgEukgK0Zd0OoWPaWXV4dxHO8E0GiawUG/SeEeY7FuoRn0JJWXl/pjqfr9l
 5xuzdJ2c2CsOsgdZo83hnYU6e1RWaz6LjycgEL+8Xz/3tJNDYuvXCN8wpNVPWW3lIi/u
 CC64JBMtd61745ZOp0fgNZYOAQ57j8b/RfTaLS4ruNvg5uTC5mj4aPG23yOjBHVuox3T
 I5TA==
X-Gm-Message-State: AOAM532a/LIte1KlTQefoTS1XTh5jeNBmt6RcMMg3Zvgqj4jDCdwPecO
 VauRuhH8gRmaunV5zUhE/6kA1hpenWU=
X-Google-Smtp-Source: ABdhPJzGiPlQbHFfAv8t7POlJ4wAjY2dPar2CEkFLI4vPCHCzRfMx/g1M2L95TxKnQCAhZng2NIvCQ==
X-Received: by 2002:a17:90a:d493:: with SMTP id
 s19mr2988268pju.91.1599066071423; 
 Wed, 02 Sep 2020 10:01:11 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x4sm40527pfm.86.2020.09.02.10.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 10:01:10 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] Green the msys2 CI make
Date: Thu,  3 Sep 2020 01:00:48 +0800
Message-Id: <20200902170054.810-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x635.google.com
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

Also it's fixes two issue about make check=0D
=0D
Yonggang Luo (6):=0D
  configure: fixes dtc not cloned when running msys2 CI=0D
  meson: Convert undefsym.sh to undefsym.py=0D
  ci: Install msys2 in a proper way refer to=0D
    https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2=0D
    ci in cirrus=0D
  tcg: Fixes dup_const link error=0D
  tests: handling signal on win32 properly=0D
  configure: Fix include and linkage issue on msys2=0D
=0D
 .cirrus.yml                         | 23 ++++++++++++=0D
 configure                           | 44 ++++++++++++++--------=0D
 include/tcg/tcg.h                   |  6 +--=0D
 meson.build                         |  2 +-=0D
 scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++=0D
 scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++=0D
 scripts/undefsym.py                 | 57 +++++++++++++++++++++++++++++=0D
 scripts/undefsym.sh                 | 20 ----------=0D
 tcg/tcg-op-gvec.c                   |  2 +-=0D
 tests/test-replication.c            |  4 ++=0D
 10 files changed, 194 insertions(+), 40 deletions(-)=0D
 create mode 100644 scripts/ci/windows/msys2_build.sh=0D
 create mode 100644 scripts/ci/windows/msys2_install.sh=0D
 create mode 100644 scripts/undefsym.py=0D
 delete mode 100755 scripts/undefsym.sh=0D
=0D
-- =0D
2.27.0.windows.1=0D
=0D


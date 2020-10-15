Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32793C43467
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5AF2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1GoWbYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5AF2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9c1-0000TS-71
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aR-0007Go-Hk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:10:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:44529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9aP-0001iQ-Se
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:10:55 -0400
Received: by mail-pf1-x429.google.com with SMTP id f19so70667pfj.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgSfyIoJ3jcjpLzUjsk2N0nO/eSxwWgAaz8SOSNqUQY=;
 b=G1GoWbYKQ9BSl6hRW+ZCvnST0KtkeW3I3UfjqnfvWAKTJ0AOa3w79GNW/pGI5EtLaU
 eg/2joou2ItlWc6x3vKTVlAuMRwu7F2nobSN9YF/gBMHn2ajRWHnkG6rgNz+cryPN3Ru
 2i3jznbXqxhKMD5C+p8q21orbzDHHoxRV2em6hFvYTtjWUANh67usoBoFffP+BkGsVX/
 HuI5PDv2hp0fg2AQnNMjj218ZNhbeIZM2lVtzXqh8agg9ppRihi+ByxfSIQPdTFspdfe
 3fNGshTA7qZA9Cx6GZP7A9fTlnpRS54c8C3PWDKKimkpFTJcoAHnD6XFEwh513W/HVnZ
 ivVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CgSfyIoJ3jcjpLzUjsk2N0nO/eSxwWgAaz8SOSNqUQY=;
 b=JoQGIANn8WlihncftBdWMNLIFmDoDauH1sEQQxIO6INKenIPXDZkujLSPKLqqgYW+q
 ufNi+nwW6R8hVFKuD22a6SZPdMuKCpC2TsJTOfaV6xmUwkZj1ORXKHG/kPY1aq7IgNni
 skQxrfByQ68xNAUZrfqNW3gBh4i+KOycfL8dmCvzR7gsNIIJs8kc7Ex20qrW2Umhc/Qm
 2b78OMD5w0Wx8HuyqAE9l7zGpERtDyHrcEWWinv+ZpqcWDyAh7Xk/NkaMbaRXUs+qyF+
 0Dvjz7E//qMLM1u76H8JGGWFjD363uzCMSFmkfiyirDQUP3yvWMZmWKTxMdqDvM7Lin+
 xVAA==
X-Gm-Message-State: AOAM531QGJNPS7JWz4yLNrIqtNpqMoGvgUZewCnaCSsH6bN0Mv2gPlqq
 R40vgr5Ra2xg6b7qHwRUR38sAyn1jDPX/DXg
X-Google-Smtp-Source: ABdhPJyk1SZgKpC/JdR0A7wfT7AQJLNYeRDKgdVFT6vqZ1BjWDafsK1hkR4MPTD4xfvU1vmXgN2unw==
X-Received: by 2002:a63:6c6:: with SMTP id 189mr203884pgg.133.1602792651277;
 Thu, 15 Oct 2020 13:10:51 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x18sm104734pfj.90.2020.10.15.13.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:10:50 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Fixes docs building on msys2/mingw
Date: Fri, 16 Oct 2020 04:10:31 +0800
Message-Id: <20201015201035.1964-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x429.google.com
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

v1 - v2=0D
Also move the docs configure part from=0D
configure to meson, this also fixed the pending=0D
ninjatool removal caused issue that docs  can=0D
not be build under msys2/mingw=0D
=0D
Yonggang Luo (4):=0D
  docs: Fixes build docs on msys2/mingw=0D
  configure: the docdir option should passed to meson as is.=0D
  meson: Move the detection logic for sphinx to meson=0D
  cirrus: Enable doc build on msys2/mingw=0D
=0D
 .cirrus.yml                   |  6 +++-=0D
 configure                     | 62 +++--------------------------------=0D
 docs/conf.py                  |  2 +-=0D
 docs/meson.build              |  4 +--=0D
 docs/sphinx/kerneldoc.py      |  2 +-=0D
 meson.build                   | 59 +++++++++++++++++++++++++++++----=0D
 meson_options.txt             |  5 ++-=0D
 scripts/rst-sanitize.py       | 21 ++++++++++++=0D
 tests/qapi-schema/meson.build |  7 ++--=0D
 9 files changed, 95 insertions(+), 73 deletions(-)=0D
 create mode 100644 scripts/rst-sanitize.py=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


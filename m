Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B200DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7122076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8efMlxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7122076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBQG-0001Mj-Pk
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOa-0008TZ-3Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:45634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTBOX-00071e-4v
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:06:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id e7so240424pfn.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y1egukY4aVZ+wQwbp0t0lSshR4gnN7tGouDscFBFSrA=;
 b=W8efMlxSDMbF8pBzA6Slwa9kjP3xckWiJ+GqtEWio83MZyIMUWGbXEfvYOT+epesL6
 P7gZWs/g9yvoie6QADHAktDQhPRP4q9f4thbAbvf4PCzKe8aGdfmEqXnCYIAr6HazchX
 /IGHW3YAIUeTRhGnjqiVRQ0v9GaB8ePZTrjZ4spq3S99FzjfbpDMqikxGcQzshnNghU3
 tZe8iLzoQxtACgqtfk/QEKk4O9hMj1z+H0Qe0twpBZlJ9CkARNgRZ3vpvidZLn+UGTCq
 3sPZZsk9Ps0BaEsQLNq5WphC+N0IliaE/bVlt5fyFkpYo8vOAjhrO1WOTeIcWQDs9R13
 rzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y1egukY4aVZ+wQwbp0t0lSshR4gnN7tGouDscFBFSrA=;
 b=eZhNSEzvoKUSarZIn0adDe+FlyG0jM44M+S5XU8tlS4yXQG/2GhVblt+8nRE8s3yyu
 wmwHtg/0civvVpcFpwdIdC0ZhwjQrkXAgEQbM4KbYYpFDDV08sqlfaElZRMeJtmf++eL
 FqDkRxAJA4dCcog1cJzReDTlQFs2zQ8Of37fWn0m9t9RCAx7a99NdNDr9tbrIEUcJqCX
 Y0gyfTMyHufnhIxxb084sF2jkKcort13J/lnSycQHneBqK8HMpp7leZkSySBvnoGC2Rp
 KPi9SMx+WRNhtO4TR6e048zB0ahsWdSoeVrV/W4KHYckqpHIym8hbBmozgzgucPG6US3
 XLQQ==
X-Gm-Message-State: AOAM533I39EYgLl54T0K49lvfddGI98GFZCSZM5/ib5Hhzq8hZzjKxZJ
 AwIcbkvy1J9Wzr1WloTkIBig8h3SGbMd1CpX
X-Google-Smtp-Source: ABdhPJzU92kALQpJj4c9tgXcohCzKa8TnrJLuPt+Lh6vVNys60r8omMVd3AXo8wsg3cP7aGhM6D9Hw==
X-Received: by 2002:a63:5352:: with SMTP id t18mr514743pgl.51.1602799602297;
 Thu, 15 Oct 2020 15:06:42 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x10sm261468pfc.88.2020.10.15.15.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:06:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] Fixes docs building on msys2/mingw
Date: Fri, 16 Oct 2020 06:06:22 +0800
Message-Id: <20201015220626.418-1-luoyonggang@gmail.com>
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

V3-V4=0D
Quic fixes of=0D
python style=0D
if xxx:=0D
=0D
tested locally=0D
=0D
V2-V3=0D
No need convert perl trick to python script anymore=0D
after Paolo's removal of ninjatool.=0D
Revise Meson: Move the detection logic for sphinx to meson=0D
for pass other platform by letting SPHINX_ARGS to be empty=0D
when build_docs are false=0D
=0D
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
 meson.build                   | 60 +++++++++++++++++++++++++++++----=0D
 meson_options.txt             |  5 ++-=0D
 tests/qapi-schema/meson.build |  2 +-=0D
 8 files changed, 72 insertions(+), 71 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


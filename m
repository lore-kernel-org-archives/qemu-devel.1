Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69220C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72E92080A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca7UD3pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72E92080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKxM-0001bZ-Df
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvP-0008Px-Nz
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:19 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:38630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTKvO-0006F7-3h
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 04:17:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id u3so1040925pjr.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 01:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mijvyCc2kGkUHOD2Ga/5m/xG1Qr5QuhpLzhPHuC/O4E=;
 b=ca7UD3pD5TavIseUkAV/ikLnYw/YFGCCXdZbv0oy8ZdkcnJ+eS1lrCOO3ZX8e90fCc
 ypRfL80CdFUHfiWZXvyv0cMNV3bQYDsi0vI2y9LEhtt6PmLpq0RoSQp3zInxTR3gH7IW
 KA9PVRJuaZ6Te6RXo0ScXoRfUdeLuRzcGJ0BLKLE9WZJ0h2tkkGsvl5SeBSSp83g7paJ
 ZJ/9c/K7oJCr/p00wCb0dYgee4ftMtwj8Vd25p3K20qGpFjbjU5lkeRDaIvpmGu2isUi
 SP/QSAHOflYKd4aMvtNZGI+APpX0ksqQmw6S4LIowIYr3abkVjz/bwjl+mMEbxkI4xuo
 JKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mijvyCc2kGkUHOD2Ga/5m/xG1Qr5QuhpLzhPHuC/O4E=;
 b=Z7K8JC8fu9TRaRm8fgQkTabzMnGnjbbSRW3uxPZCIbi3WgQKz2GWWpPtlbmUeYr+Lg
 JqRS3q1fohsyHROIuafazabP8kPUu5VoL6vrx+3y/9+G4MFLrOoMMvVz7qYJ1ZLsOfEk
 DqoU98wQV0NDBi/4WwJs2spDzU4anL17FZINf+uqlLUqozoMzpRzbROXqpsCNYwsVkzK
 2WvaMVIVO4O95CvOFBfYQ/AQfvVIBe5rrABpcANIjrFN7lDtd6yERP/bk1Lv87e7vuY+
 AJ3CmVlJ1INL0eMY7E2OArJEOCLud38EaZr/h21np7vh1Oku/SumbOllWYBQDuBYV9PK
 Sctw==
X-Gm-Message-State: AOAM5322PWWfUE8O4NRDNmoxW/gJGqrwsJrhrnxTYfqNL+hnZ0k/xJUy
 yzTHxLmeE6YNSTmXvVLnPC83SCAsK8yd9kdY
X-Google-Smtp-Source: ABdhPJy7CMXMFs0ufqRq3kBiPvr9cNZdK0+bYJHwie/QcR1B9YAJANHlGUrnPblzq02I/Sw2i3syiw==
X-Received: by 2002:a17:90a:ba06:: with SMTP id
 s6mr2953383pjr.13.1602836235021; 
 Fri, 16 Oct 2020 01:17:15 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d2sm1940343pjx.4.2020.10.16.01.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 01:17:14 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] Fixes docs building on msys2/mingw
Date: Fri, 16 Oct 2020 16:16:54 +0800
Message-Id: <20201016081658.1890-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1031.google.com
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

V4-V5=0D
Revise * docs: Fixes build docs on msys2/mingw=0D
For easier to review.=0D
Revise * meson: Move the detection logic for sphinx to meson=0D
According Paolo's suggestion with fixes.=0D
=0D
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
 docs/meson.build              |  4 +--=0D
 docs/sphinx/kerneldoc.py      |  2 +-=0D
 meson.build                   | 52 +++++++++++++++++++++++++----=0D
 meson_options.txt             |  5 ++-=0D
 tests/qapi-schema/meson.build |  2 +-=0D
 7 files changed, 64 insertions(+), 69 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


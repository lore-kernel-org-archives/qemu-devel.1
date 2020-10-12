Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB94C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1EE42076D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 23:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH2Y/MhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1EE42076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS7QG-0004Ma-KR
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 19:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OG-0002rA-IW; Mon, 12 Oct 2020 19:38:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:37236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS7OE-00072r-KB; Mon, 12 Oct 2020 19:38:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id o8so9602745pll.4;
 Mon, 12 Oct 2020 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B7IjE2xUJ+z4Uoif5FJHL1Lc3PIu0CWe7/RpAKb+qHo=;
 b=qH2Y/MhB34dp1Fo9uC1mrybE7ZzSNXqKBZecLvVSPOzmYyhORAkdMjItgQxoF2bZ+u
 oSsdxYGc/b/OR7jl7L6m2lKEzrst3pMPyYh9pBsvCBLl8hh6swFmo0mL5epYxC4hj1bU
 Moh2X8sPUiOnxtJTS88isazMGjWGhSrD22jCOgnSLJDjquKU2h9cklpZOJ4YbA14ols4
 08II4RgYN7a19vkIYV1LQTYNKHPWwf+5rKrX7DZnA9EhU9W91QzNq2xVXYIh7wss0UgH
 /nHnDj9UZ24VL1VoxSailsQpp9jEGb3tg0QmKtM02gHOaacEAsHoV53pCZHkpr4n2j/g
 wgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B7IjE2xUJ+z4Uoif5FJHL1Lc3PIu0CWe7/RpAKb+qHo=;
 b=e09sL64bzrRMvd3h2s5XPrqiRm4To7uVeGm+cweRSO1Pr3q1auedNZMx51mpuhaKBo
 SAy4UW5QQQw9csR7yYuHNJOHb28dQyWuLEfJSk8+QMTIu3eqVmD/JFmPCn+sThVBsgeA
 l5mEM34ElYVes6e2zTVgi8clncFUceHJGfAaRmJHORAQSKbtgsz+gRYTD/AZacirsH1i
 s97mt8iuHOVFzx+s1tDWZJew0e1u2u3CymVIhRhr1Odp42sjcuiMsIdX2tNT/JQm6k7b
 U0fRzk64j3BDwsloZ3DBqTTWiMTSvo2h8qmt3SKARedwjD9kLniqWV17OMVuEaAg6Muz
 OSaQ==
X-Gm-Message-State: AOAM530xZcmPROjh8KUNZZvNgMJm6Yodny0vKhwsA/GkD4exHRU2mxEJ
 Hfy53zbwz+vOAP9Pt3ppV1CtjKcIT+dgkA==
X-Google-Smtp-Source: ABdhPJxQwg9AVQplS8vxfwGBJime9nqBqCNBlKRoYt0LOSlUlCBBStgJTmL+JwsCfJGhm4wzQfcPkw==
X-Received: by 2002:a17:902:6ac7:b029:d3:9c6b:9311 with SMTP id
 i7-20020a1709026ac7b02900d39c6b9311mr25156393plt.0.1602545879749; 
 Mon, 12 Oct 2020 16:37:59 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 x12sm21975783pfr.156.2020.10.12.16.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 16:37:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/4] Improve cirrus msys2
Date: Tue, 13 Oct 2020 07:37:36 +0800
Message-Id: <20201012233740.190-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the broken msys2/mingw ci and speed it up.=0D
=0D
V6-V7=0D
* cirrus: Enable doc build on msys2/mingw=0D
* docs: Fixes build docs on msys2/mingw=0D
* gitignore: ignore a bit more=0D
* scripts: Convert qemu-version.sh to qemu-version.py=0D
=0D
V5-V6=0D
Remove the university mirror, the main repo are back.=0D
rename to setup_script.=0D
Add fixes for msys2/mingw rST document fixes=0D
=0D
V4-V5=0D
Now the cache are usefull by using 7zip to archive msys64=0D
Saved about 18min, compare=0D
https://cirrus-ci.com/task/5093551157542912=0D
https://cirrus-ci.com/task/6177196538593280=0D
=0D
V3-V4=0D
Using cirrus cache to speed up msys2 ci instead of downloading archive file=
=0D
=0D
V2-V3=0D
Add one more patch:=0D
cirrus: msys2/mingw speed is up, add excluded target back=0D
Do not build sphinx on windows, that's failing=0D
set the number of parallel count to fixed number 8=0D
=0D
V1-V2=0D
Resolve the cirrus conflict=0D
=0D
Yonggang Luo (4):=0D
  scripts: Convert qemu-version.sh to qemu-version.py=0D
  gitignore: ignore a bit more=0D
  docs: Fixes build docs on msys2/mingw=0D
  cirrus: Enable doc build on msys2/mingw=0D
=0D
 .cirrus.yml                   |  6 +++++-=0D
 .gitignore                    |  4 +++-=0D
 docs/conf.py                  |  2 +-=0D
 docs/sphinx/kerneldoc.py      |  2 +-=0D
 meson.build                   |  2 +-=0D
 scripts/qemu-version.py       | 37 +++++++++++++++++++++++++++++++++++=0D
 scripts/qemu-version.sh       | 25 -----------------------=0D
 scripts/rst-sanitize.py       | 21 ++++++++++++++++++++=0D
 tests/qapi-schema/meson.build |  5 +++--=0D
 9 files changed, 72 insertions(+), 32 deletions(-)=0D
 create mode 100644 scripts/qemu-version.py=0D
 delete mode 100755 scripts/qemu-version.sh=0D
 create mode 100644 scripts/rst-sanitize.py=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


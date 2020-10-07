Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA6C3279D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4FA20838
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 03:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdus7t/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4FA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPztg-0001dc-NX
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 23:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzs9-0000KJ-Ps; Tue, 06 Oct 2020 23:12:09 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPzs8-0005jZ-4a; Tue, 06 Oct 2020 23:12:09 -0400
Received: by mail-pg1-x536.google.com with SMTP id 7so465802pgm.11;
 Tue, 06 Oct 2020 20:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+rHS8gcj9fhrGPfwl2fBVV4zOPJGr9HqOqeeN8Xpa/U=;
 b=Sdus7t/nAW5Gefaqfvi3c30siPPGcKS51Bqz/lcOYPARGNB9BS4i6CiaFWGFakLgey
 9j0Ilwu+vNcclrbNJUDwmDggN2rUxw/au0ZCSVsUtnluqISzTqT4nt/FSu4Xl8z24I0w
 yQa7FKWG+6Pg9gWYnofFRf1RKy1UzVAOK99aGThEn1LLgbhwuUW2RVw6nUnl3h5FeOTX
 gTi7ILqaVZ2tZbuJJpy9mWxK6Raj9cw+TuMnwKVonDcPq/7PmJ4x5P6hiOIEv4rUc8jr
 +NqlBPwgET/hcZtOP8cRFxCXEdiiEhL7b6djqNFWSL5WKbp+ysJ1MO5cSODORxGq+Uvf
 bwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+rHS8gcj9fhrGPfwl2fBVV4zOPJGr9HqOqeeN8Xpa/U=;
 b=ivip61O8tRjHAJNlBQNKqes6nINu8uGE+oruxZ3u3pLbDGj9skF7cJ9EFW3d+rvHKo
 nVsCOBSJnkCHGO+vNa2Ge7GDr51/nNAi6sAcrHlk7IOiUC8pEJWyHjBp/9h3nwU122WM
 /nMVGDUfysh3kPn7/AbxQih+FAUp3K/0VTJYQWvPj8eGLhxDj8q7p2GJ387hUHxaloeN
 eMQNTMPIsGmN8oghSr+EBJdO+UVEOYA5i/i9AzMC5cJn6BNb7JDiU26En3GVkLk98qPj
 1hDwwFWd0qY4ry4+XAGYZZM1LuwO7OnXsXqvhSxXPiId1gJ2yx2BdidW5yX4YY5kFL15
 zzgg==
X-Gm-Message-State: AOAM532z3a+S8UHoVhklPpE1KhVkNN0GVAK51QlXvzyX+PkSEllQlfH2
 nV0SmZv3tQ8tlh+3TFbLiOg4VIf6jSi03g==
X-Google-Smtp-Source: ABdhPJyXS0QBKaKwHcE9Hp6MrtRJIRsl6RhznxfwLjL97GN9XvU3ND6gGWaJgAcXvgURVhMldWpbxg==
X-Received: by 2002:a63:1825:: with SMTP id y37mr1160573pgl.307.1602040325649; 
 Tue, 06 Oct 2020 20:12:05 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id cs21sm9001614pjb.0.2020.10.06.20.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 20:12:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Improve cirrus msys2
Date: Wed,  7 Oct 2020 11:11:46 +0800
Message-Id: <20201007031148.232-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
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
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the broken msys2/mingw ci and speed it up.=0D
=0D
V1-V2=0D
Resolve the cirrus conflict=0D
=0D
Yonggang Luo (2):=0D
  docker: Add win32/msys2/mingw64 docker=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
=0D
 .cirrus.yml                           | 58 +++++++--------------------=0D
 tests/docker/dockerfiles/msys2.docker | 57 ++++++++++++++++++++++++++=0D
 2 files changed, 72 insertions(+), 43 deletions(-)=0D
 create mode 100644 tests/docker/dockerfiles/msys2.docker=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E54208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYkE5TqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E54208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAqm-00062g-2q
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAp0-0004cs-L6; Wed, 07 Oct 2020 10:53:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQAov-0006lC-Kg; Wed, 07 Oct 2020 10:53:38 -0400
Received: by mail-pf1-x442.google.com with SMTP id f19so1448162pfj.11;
 Wed, 07 Oct 2020 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kbGEm3EbGzEmJKqtgZ7++E9UoagfgdWtumbA/uZFN0=;
 b=PYkE5TqT2sO6/WFUWBnU9rVS/M0QJZS/SZVDBRXCfpW+grlprQ8nTQzIfsZqu5AfH4
 56YlR4FwckuDr2CUCFJbNMzybO1wZWZ4TgcF93NkEp8t8d9rxoBWdO84EtvPGJdJP8vQ
 hZDXAPNasUnb4NhTjbcuv2iFmGLIXHDP1rusAqFeIEKPHyOp/d1PQFMgedto6fIbn9u9
 VuvLiEcI6uNfRTnePrO0OZdQ/jo5GlzC6EzzlZqukCbMXE0kTQIXxTY4a/mQi4fVMM7D
 pB2zMgGevBqKyhy9/f8YdhMKjQ+hG8gTYTVYcwZH1anYRVXQmfKYYfCXaMW7yGvQ4s7H
 HBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kbGEm3EbGzEmJKqtgZ7++E9UoagfgdWtumbA/uZFN0=;
 b=Mh4MNHZfDrC9NUFROLi7T1iRd95/GZh9CIXy/Gv3ChEyUfH7wE4egBxD0ygm0tKELg
 goMpQKdp+pJrH3daKBwmlMywF/MDyv66895zDaSmx+a/MQlteLSCOpIXSykc0pbAgk4Q
 mDVSLexmr/PKLWh4Em0irsETKk3fK7qYxo08h89r5uvilph+daAyErC+RM0hdy9mT0ll
 hYbY5ZCvI114kAUg+7/YD6j4IeU2umuWe/NJLKKF1TjrujjJVy+Ajm6m9vVKydMx80Uz
 0iWp75KDU+ZrSkV0REe2mt584xVBTDjqc6bH+jsiZKdPLEtTmvyTAOXP9YYkl9/cxIjV
 SreQ==
X-Gm-Message-State: AOAM5319S96xIlz+bVeQumBLJ6D0cWMpA7/at2IcrLDIzyrGAush8rvR
 edGFbLuXptboPybQ4Hqa9b/+U1iXE21pTw==
X-Google-Smtp-Source: ABdhPJyOONQOeE/4HYH82Eb52eOXSCdaLswNoKl5CzRz7FfporyZhTkg802+SK5czC5qVSTBezL/WA==
X-Received: by 2002:a63:145c:: with SMTP id 28mr3295608pgu.451.1602082400289; 
 Wed, 07 Oct 2020 07:53:20 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u14sm3301514pfm.80.2020.10.07.07.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 07:53:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] Improve cirrus msys2
Date: Wed,  7 Oct 2020 22:52:58 +0800
Message-Id: <20201007145300.1197-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Yonggang Luo (2):=0D
  cirrus: Fixing and speedup the msys2/mingw CI=0D
  cirrus: msys2/mingw speed is up, add excluded target back=0D
=0D
 .cirrus.yml | 113 +++++++++++++++++++++++++++++++---------------------=0D
 1 file changed, 67 insertions(+), 46 deletions(-)=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


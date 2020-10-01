Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268E622204
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S69p07qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268E622204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2le-0002jQ-3i
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2UK-0006x5-84; Thu, 01 Oct 2020 13:35:28 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:33704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO2UG-0005Km-7D; Thu, 01 Oct 2020 13:35:27 -0400
Received: by mail-pg1-x531.google.com with SMTP id o25so4588559pgm.0;
 Thu, 01 Oct 2020 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p+PdtlFhZvZMf7BCsHxu1J7b2TEb49Uv54DWYri8UQY=;
 b=S69p07qxglcxtgpbUNGRGPWkew5MQKuzKH7cJTB8m8b8wvGR+s+jlcVFSt2OU6EsPE
 Pa/GtkogMPWgRBPA9R/ytpN0lVUSSHtVVq/wie0yXSEXBzl1pPC6f4pm9vgABjjTmUDU
 HPlD0jI+Sz3o+y8AfeNh4bvhw/M6oZwTUEa23XfsQ7UTIcSeHp7i1xfV/kQg4h0KviNE
 SzEZwHvF9OgmP6DWM1UYUCEeie8eBSWsEx5bwKJzZImn+tiC0fChIPcvLs/DdiIELlzL
 I0CAO2D2cZLis4SYmx3ccXDNdOKDZBUcVx4Ty6W5VtPNLOy7Z6juFPwdY2wriiGtg9rm
 lH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p+PdtlFhZvZMf7BCsHxu1J7b2TEb49Uv54DWYri8UQY=;
 b=MfP1ml/gZtRlMWgks2+n19006HNRPQ0mlZbh5BaqdrGdo7oUlTerY9qGgo4D/W+QOV
 Clr+2F/gkC2+0axeWMMbtq2cnUkOmu0EJ1PE1IJjEGM4vuXpLhsVJYuaDN9fwFkqRgSt
 SX6OxS8zHfOKk9auhR55MTc2iCn5j/kes0kn++Gppa1mWhNPhFzFIXbMl+FNLifpRVLJ
 Pumqsjxr4/hODndolq3l3aFnMfFWD5hHwBvolF4zLi8w3LPfI1QAfXS9tyrS3v2qi/j7
 oBZokm4JuP7ahEUFdOQPMk9aUF/4+S+0cc+KBL6YrD0X5klVG7c9vEvonYyCfSOTJuQX
 4Efg==
X-Gm-Message-State: AOAM53023a522me+sIdMiR02oasEHACxgNEfBBocakTYMh4pMUqdRiWi
 RlZmW3s8ttBgR2KAkq+9IERu/ZQotch4XQ==
X-Google-Smtp-Source: ABdhPJxviQoj2zAsX9gtAUtUaj4mwCn0l1adcThmYTRf2LSHDjGRYPiY0OAQpxhFrAK0xNvvk2YAwQ==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr7283230pgd.0.1601573721919;
 Thu, 01 Oct 2020 10:35:21 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id b7sm4445646pjq.1.2020.10.01.10.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:35:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Texi cleanup
Date: Fri,  2 Oct 2020 01:35:02 +0800
Message-Id: <20201001173503.1107-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x531.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Texi cleanup=0D
=0D
V1-V2=0D
Fixes with=0D
 doc: Remove texi referenced in qemu-img-cmds.hx and target/i386/cpu.c=0D
=0D
Yonggang Luo (2):=0D
  doc: Remove texi referenced in qemu-img-cmds.hx and target/i386/cpu.c=0D
  doc: remove hxtool-conv.pl=0D
=0D
 qemu-img-cmds.hx       |   2 +-=0D
 scripts/hxtool-conv.pl | 137 -----------------------------------------=0D
 target/i386/cpu.c      |   2 +-=0D
 3 files changed, 2 insertions(+), 139 deletions(-)=0D
 delete mode 100755 scripts/hxtool-conv.pl=0D
=0D
-- =0D
2.28.0.windows.1=0D
=0D


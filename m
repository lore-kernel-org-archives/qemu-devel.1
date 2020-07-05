Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03349C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB307206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CORyJxFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB307206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDLu-0006H7-UD
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKj-0004Fh-Ur; Sun, 05 Jul 2020 18:42:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKi-0002gW-1a; Sun, 05 Jul 2020 18:42:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so35933348wrw.1;
 Sun, 05 Jul 2020 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ehwRSFQGbul2713ne007jhYfeW7ho7isnAn84wqa/OM=;
 b=CORyJxFU70lpQxXAXsTOsr3Kt/xvnQr1cKeRAdlE5BSh2LQw5mgcStbCEIgnI3dsg7
 9HDe0+KH4Vc+cVbwCfjt6BXR3IHSthoe05+2YV8F53vWLxhDsyz0wUxgamE0sD9f+eyR
 pZkjbClj79etwCzM9KAQFP+xqKP+LgoSu+Pe34ECWsl2MwEQbmDCdeY/z5TitY+RKDRS
 5adXnntAENT/FjlsMrsuu4nZil71cygGTTtZ8GMbGF6YmyGDswDaFuDPPUHEDXWYNFxJ
 Mc8VGDRluNZ8rRMl2gHqvYXMEiDT3LXZY9RVwkhxNAg8tQuodXJS69jEnmb4e+OXK4rS
 q0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ehwRSFQGbul2713ne007jhYfeW7ho7isnAn84wqa/OM=;
 b=FnRoJ6T4Z5YbCqtTSMQ7tlIhAjMFQPIdYCh4rSLmnvgOxxDeXBmgLfzyqcBMF0Zc8p
 bvFGSVV1q/OeStClaGuDWM/Z2Y3rPjkw9oxi+ulwteH1s1qlsW+xs3+Xc2VDtfKd9k5/
 yL6IjtimGnsZNE7JUm7WdgNubJdSnFmPxkQU4nXpnjajcNeQy/cgBM55+xhUD4LIVXia
 lTO1Xd4aAIfSgp1w4xfxZDGAncvYl9NyHHgNpyoMQtSMGXGGLueHfmrD9OU/b+MgUyn/
 iYzT1mP2KPlNxdZtF0DA4l44SeSPlTNND/qNKDoBhagGHIYIPcuZF62Grn85vcsSgQdA
 /sTQ==
X-Gm-Message-State: AOAM530udnIxc5CdMXqbUPSPkpbCjvtH9ec7zPtJRtJH6TbViCcIXdeZ
 +LHY+yckoxKOwvG1Y9MXL3IowCXMY9c=
X-Google-Smtp-Source: ABdhPJzhw4jNUfabvWaoiyjfNjlQTftpsyE4SI+VQ0wphZRqENHmgt5/RLcd0/KkP9phMd2jSfASrQ==
X-Received: by 2002:adf:f546:: with SMTP id j6mr45390722wrp.167.1593988917445; 
 Sun, 05 Jul 2020 15:41:57 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm9151467wrr.85.2020.07.05.15.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:41:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] hw/i2c: Rename method names for consistency and add
 documentation
Date: Mon,  6 Jul 2020 00:41:49 +0200
Message-Id: <20200705224154.16917-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit d88c42ff2c we added 2 methods: i2c_try_create_slave()
and i2c_realize_and_unref().
Markus noted their name could be improved for consistency [1],
and Peter reported the lack of documentation [2]. Fix that now.

Since v1:
- Addressed Markus review comments
- Added Markus/Corey R-b tags

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08997.html

$ git backport-diff -u -v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/5:[----] [--] 'hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()'
002/5:[0006] [FC] 'hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()'
003/5:[0004] [FC] 'hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unref()'
004/5:[0006] [FC] 'hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()'
005/5:[0012] [FC] 'hw/i2c: Document the I2C qdev helpers'

Philippe Mathieu-Daudé (5):
  hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
  hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
  hw/i2c: Rename i2c_realize_and_unref() as
    i2c_slave_realize_and_unref()
  hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
  hw/i2c: Document the I2C qdev helpers

 include/hw/i2c/aspeed_i2c.h |  2 +-
 include/hw/i2c/i2c.h        | 54 ++++++++++++++++++++++--
 hw/arm/aspeed.c             | 82 +++++++++++++++++++------------------
 hw/arm/musicpal.c           |  4 +-
 hw/arm/nseries.c            |  8 ++--
 hw/arm/pxa2xx.c             |  5 ++-
 hw/arm/realview.c           |  2 +-
 hw/arm/spitz.c              |  4 +-
 hw/arm/stellaris.c          |  2 +-
 hw/arm/tosa.c               |  2 +-
 hw/arm/versatilepb.c        |  2 +-
 hw/arm/vexpress.c           |  2 +-
 hw/arm/z2.c                 |  4 +-
 hw/display/sii9022.c        |  2 +-
 hw/i2c/aspeed_i2c.c         |  3 +-
 hw/i2c/core.c               | 15 ++++---
 hw/ppc/e500.c               |  2 +-
 hw/ppc/sam460ex.c           |  2 +-
 18 files changed, 123 insertions(+), 74 deletions(-)

-- 
2.21.3



Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FDAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B9B5255C9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t84tqg7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9B5255C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxlK-0007R3-86
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjg-0005iY-IU; Mon, 29 Jun 2020 13:38:28 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:38377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxje-0000Gi-Rq; Mon, 29 Jun 2020 13:38:28 -0400
Received: by mail-ej1-x643.google.com with SMTP id w16so17478346ejj.5;
 Mon, 29 Jun 2020 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CbXVqMd5vJMxBHVtqpKaOEGGqymEdOaUOg0cMYCy9qQ=;
 b=t84tqg7K2rR/OaO4b5kqbOXgGMyaWE8jw1sfUgMIluDYAcCDem9jnc/a/pnyy2H3di
 xzCe/TvumI/MqN3ID4+lhSNfD1XplLnGin2BLKNrZCCNsGKQqXTSlFXRBhZ44L8Nf6bn
 Bg8z3ScCyIsThXK73kPgSe5gc4oMtlxpQKV/3lKtE7R99BcjX5kjvZwZzNNpSfxCRVOX
 wM2z5nYo/4s6VJeevjWwLef+bZ0zEI9DkQL+hAoiakLV0DH1yo3dwjedZXe1wOrgTIaw
 suF+WAvCWyB5UKJ0B5E54RZhpX7bJh/I6LCyLHoba8ZLfjjKyj0EAKsZ32enB5kiZkA9
 Misw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CbXVqMd5vJMxBHVtqpKaOEGGqymEdOaUOg0cMYCy9qQ=;
 b=TjiGr5adXwXyioOs6H6xIy5cviVGTI/kHzVoDOPeQygsD5AkFBPfpYxRo1AOwnXvdt
 UBDB745qQw+/cfDJ+eMqNM1QuhO4SW7YJmvf1on4CtyVTNuN0QT9R72zcNgGnaodKcJ/
 OvrMJYY3iViiiyPo02nYz1ge2ZUEY6TMa5u8sJ0O7Yh0rNQ10CnKYsMabnl2nM+KQ7C+
 nssYxOd8YE/8ihAEwLVLdsA207IuvAuVelM142QUddhlZZcTUC2YgZwVgwoKWBbD3HSB
 dKurZ90nMCJMd6JihKyQPyTKLG5O/sO9yppo6RjTxcblokoWIW/S0BNFvNYqcHBBgv+Q
 Tqsg==
X-Gm-Message-State: AOAM531e/bcLq6ZyGxeOCCXdgbm0hIvgvjHiSpDQX1fIGDCUcEAxrFSv
 B1BsEE8bu20fSroawsIIO2hbNYaCuK8=
X-Google-Smtp-Source: ABdhPJyQUMY3ST+PMG6TIP3uZVCIIshcNfhQBOpi+mdG3KlEoAHX57MqkpxoEj3Wa+o6nfAptVSXNg==
X-Received: by 2002:a17:906:2c43:: with SMTP id
 f3mr14733438ejh.38.1593452304295; 
 Mon, 29 Jun 2020 10:38:24 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce19sm216029ejb.24.2020.06.29.10.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 10:38:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/i2c: Rename method names for consistency and add
 documentation
Date: Mon, 29 Jun 2020 19:38:16 +0200
Message-Id: <20200629173821.22037-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit d88c42ff2c we added 2 methods: i2c_try_create_slave()
and i2c_realize_and_unref().
Markus noted their name could be improved for consistency [1],
and Peter reported the lack of documentation [2]. Fix that now.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08997.html

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



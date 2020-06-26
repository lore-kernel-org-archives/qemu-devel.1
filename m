Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F235207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTtc03u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F235207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop0r-0001rK-6Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joozf-0000B1-BL; Fri, 26 Jun 2020 10:06:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:41805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joozd-0005vK-HL; Fri, 26 Jun 2020 10:06:14 -0400
Received: by mail-ej1-x62c.google.com with SMTP id dp18so9491853ejc.8;
 Fri, 26 Jun 2020 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Y4ui6W+HkPW/y/bkDNWfGq3qEgEM61+MM+QUv/DDP2s=;
 b=oTtc03u5mP+n6xA/1l6k5c8hq0mdaylGuSsP9K1ZLpdLiUg0rmotaTT7x0ghF0Jx3x
 7a1q8pYsvXK4xfmf2MHndzuUsrr4jrAAIjxUb8YbJKggFfRlU5Br3dz1LhQcNFAHdnL3
 NnGkJSzFGLd7MrZPWLVzSWAU0ElKKBUJJ++jzhsV/xQ9q83cuWUZDfoJ7evN9GQ/G/6Q
 IVD+TuF873Bov7dhMK9RHX5qxlIq0HNNFNq7J4EkHB4PyDFFzsrVQlIgDM4cmm7ZN/Lt
 HZR3lt1Ixu6XTW8DrbCaYJWC4iWxXpFijOhl7Hc9eBpQeSehT6RbGLJw5qACzc2Ua8SN
 InlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Y4ui6W+HkPW/y/bkDNWfGq3qEgEM61+MM+QUv/DDP2s=;
 b=RwawZhYWHUJYqK1DPs+PZXRN+LwhitP9A5HjkWXuuzvdc5yVEVwKeUdwCGTkuskTLh
 AVCMSAt3rew8rIsK2hRCx2qyJ9PgoWz2Yk4lV9m2UZqjD/ToifbDyH/181r0g6GfgOIx
 aBxZqxiIhSy1wfcZvouiXGA0qlZ+ZQBMZtaGG2jAoTz7Jk3ia6uXFX708mBhi9SaQt/H
 RC/8zwO5uJbAIllxC/yZK93H9dZ9BvAZJx+Cz43yIYLRg5wDWEeTvYYyJ+QB4K40rn8A
 kp3nhLPC3Hsm43XpUd4GgzgMax75iNNH1XcpKrW1DmuEc2toS1PRv78+ZWV22YcVSzO3
 p1ZA==
X-Gm-Message-State: AOAM531+79u9MtMj+Meki0slNvTuDfHVQQc1TptaHTw5DF1HQKArO0E6
 RcYWz1FLhM+lyh8qdvC+1uNaM/HNpRYbLX8LLT7lvrsCGnfUxg==
X-Google-Smtp-Source: ABdhPJxFojS6/qaUqPZHHKFRS0j8y8BFnq669I53Cu53brb8xR/jYdOIskd7kIK77eJtg/ST9bOxzpQUOEgAwtOfz50=
X-Received: by 2002:a17:906:a156:: with SMTP id
 bu22mr2642501ejb.322.1593180371432; 
 Fri, 26 Jun 2020 07:06:11 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:06:00 +0100
Message-ID: <CA+XhMqyDqh0y=4YVjDXU-ZoYBFEtNzYL4MUwZQFk33NnazrajA@mail.gmail.com>
Subject: [PATCH 0/3] second batch of haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From a548479cab82200d9df33a70f24aeebb00eb70ad Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:04:30 +0000
Subject: [PATCH 0/3] second batch of haiku build fix

David Carlier (3):
  Include endian.h for Haiku to solve bswap* macros build failure.
  drm build ignored for Haiku.
  syscall skipped for haiku used only in qemu_signalfd anyway

 include/qemu/bswap.h | 2 ++
 util/Makefile.objs   | 2 +-
 util/compatfd.c      | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.26.0


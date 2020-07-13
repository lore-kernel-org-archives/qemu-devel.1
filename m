Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E536C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBD220771
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpvQ/CgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBD220771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3GW-0003d0-Sg
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FQ-0001wG-5d; Mon, 13 Jul 2020 14:32:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:38678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FO-0004Ey-3d; Mon, 13 Jul 2020 14:32:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id br7so4610364ejb.5;
 Mon, 13 Jul 2020 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hy1Mw1X0UV8T5pA88kdwrvpVTDUrgbn0jd8z4NyjRrA=;
 b=qpvQ/CgI+I464ZwZ+5HNbyXXtt5zUYqEZ6mR587d/zNdB0gVeJxB6ZPH2UXQK5rg0G
 PlCp28uDnxorHGlNz/LzQ9J66bwYUEf7if8YU65O4xjmdCxETs5w9NUD9/+moinCdbXt
 t4O46vJyaiviPCyUxzRqfbBJO5nBN8jtt1MtA0Fojh1nz9hcB69k5gAKR+M4xDe3Scci
 PnSyWjSDj4mE90sxh2J32Vu0PGB+dzkyUS36rG5hvCsuROt/FWUstr6y8onM4dFq6mDZ
 aB+C9l6XimO6JhVdr7o4CTydtHnFYIltWTpD31li56OIp/pnMZoyMpq1hz8nyL2Gwli8
 z41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hy1Mw1X0UV8T5pA88kdwrvpVTDUrgbn0jd8z4NyjRrA=;
 b=YGURTxcFFo95qHgQJPeWaw9SCM5QlG/fJSaM4NKBFyZ94x5JR+S1MRyyXUZgUpjjzR
 a43qeN7V3l7emLGgzP24p5mCC37MNxnucT5pGlNnuN2wLwcl3ZCXWlyZNUyOUhDOW2K1
 Rdv3G44QnVsGegKjtJiDjd16ShOpLTycoxMPNd1ngSNQt0u6z+KgL3BNQFaJ/huuIHA/
 Ff9urfBE4/HPqIA+bnjvLGODKajTeJUvQHtEZfVww/PbbAvPBjQKSSloXa1jQt9EZs08
 JIAp634TNQaGXVyY8CxLyOnWne+Cyf/V+4pbR5kv3caMzyMSwE859b2L4N12BO8MoTl9
 aT/g==
X-Gm-Message-State: AOAM5337CKJqIWhjHblQk45kk0ix+BmJaIe0A2XEY/m9Zqcwnw6qWQwr
 pyTv3n6jKpWfb4+DC4CbRe8ZGGlDxjE=
X-Google-Smtp-Source: ABdhPJyWTRM3Rn7Na5kIzDKJIRwZko6FnS7aRQWWLqZrMnDpdcgrAtLdThFfemqH1pQix3NSw8ebQg==
X-Received: by 2002:a17:906:c187:: with SMTP id
 g7mr1090461ejz.108.1594665131539; 
 Mon, 13 Jul 2020 11:32:11 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] hw/sd/sdcard: Fix CVE-2020-13253
Date: Mon, 13 Jul 2020 20:32:00 +0200
Message-Id: <20200713183209.26308-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes CVE-2020-13253 by only allowing SD card image
sizes power of 2, and not switching to SEND_DATA state when the
address is invalid (out of range).

Patches missing review:
 3: boot_linux: Tag tests using a SD card with 'device:sd'
 4: boot_linux: Expand SD card image to power of 2
 7: hw/sd/sdcard: Do not allow invalid SD card sizes

Since v1:
Fixes issue due to image not power of 2:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720737.html

Supersedes: <20200707132116.26207-1-f4bug@amsat.org>

Niek Linnenbank (1):
  docs/orangepi: Add instructions for resizing SD image to power of two

Philippe Mathieu-Daudé (8):
  MAINTAINERS: Cc qemu-block mailing list
  tests/acceptance/boot_linux: Tag tests using a SD card with
    'device:sd'
  tests/acceptance/boot_linux: Expand SD card image to power of 2
  hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
  hw/sd/sdcard: Simplify realize() a bit
  hw/sd/sdcard: Do not allow invalid SD card sizes
  hw/sd/sdcard: Update coding style to make checkpatch.pl happy
  hw/sd/sdcard: Do not switch to ReceivingData if address is invalid

 docs/system/arm/orangepi.rst           | 16 ++++-
 hw/sd/sd.c                             | 86 ++++++++++++++++++++------
 MAINTAINERS                            |  1 +
 tests/acceptance/boot_linux_console.py | 30 ++++++---
 4 files changed, 102 insertions(+), 31 deletions(-)

-- 
2.21.3



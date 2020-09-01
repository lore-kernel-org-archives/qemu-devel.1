Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB590C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7C3206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9nQMdBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7C3206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6uJ-0005Yk-AY
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tV-0003uj-Hm; Tue, 01 Sep 2020 10:04:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tT-0002m9-Qd; Tue, 01 Sep 2020 10:04:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id l9so1280507wme.3;
 Tue, 01 Sep 2020 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bbQjn7jdICczKXWnuGrKW0cjDhzzaQp/zOw9b8QB4zM=;
 b=r9nQMdBxf3iv1KSRlQO2MPX49mIPJIMMKxCqVibBhtDtquZf11R00kUwekWSTduwi5
 D9Lj8T1YV8Kad7oSklgQz6A8MWESisf7Iwapu8rGt/YBFjr4sUYD+NuiW/2C1a8Ywu6+
 K+aCHF5HGwfkHKEogtyendq/7NBHulHUmXxJZE6L4oTMRZKn9kKcuy2aJG09axvgD/3Z
 wwC05UjiWKc77V2nlwqweBfyweXdDz7C6fgFLguQamTph5Ucm6DhqXPJlNqrYGTj1ESl
 03Nsk8dG0iq+I3ZOM4CCVa1GTktA+1c9nU4/pRfc0IBWR1dhn2Hd3HRV8xC7V7b5rmtl
 u3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=bbQjn7jdICczKXWnuGrKW0cjDhzzaQp/zOw9b8QB4zM=;
 b=bMZv7b0HzCg57JiV0qJpEtBbvitC4Vq2Ft2Mxb/WZEul5Fo752xHxzol60toLme6iI
 WIGpzh9NYE+J+B1OtQlX8BqrYvbn9XEJtC1ThjQggMWvVttyfQLVaVYtfZPMAENL2nlY
 35TIatmg34mp83C4zupMboktiqsRw7GDzvneox1gMNugbbSjxxTrtRQbeVWpEEmXotni
 oPiiquicF3XoMrXYWORIj53LmUp2rf54ZJVLXg/Yo4wE09+07BHgqx0tKB+EMRyFO3V8
 QA+GHNEVLNMyfU2pr36C3lhiD3FnxDWEg69t0DXvk3Y0/f/ECOLzXMENCvHThgktUoet
 6ClA==
X-Gm-Message-State: AOAM5338HAdJZGcd3gY4uWwK6T5BUC9teN+f/e6+lUoqFvyRzjsj+FJ8
 EjBqJj9RzWMoakRvSS8nfBeTpewhVzk=
X-Google-Smtp-Source: ABdhPJzJ7XUuaaJdggiyyHgGojGKodn213Ii4jiXVNQgNcB8mI7weXySYaBM+gdK3UMNzKNKXHN7lw==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr1899367wmf.31.1598969053628; 
 Tue, 01 Sep 2020 07:04:13 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p22sm1872505wmc.38.2020.09.01.07.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:04:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/sd/sdhci: Fix DMA Transfer Block Size field width
Date: Tue,  1 Sep 2020 16:04:08 +0200
Message-Id: <20200901140411.112150-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the SDHCI issue reported last week by Alexander:
https://bugs.launchpad.net/qemu/+bug/1892960

The field is 12-bit (4KiB) but the guest can set
up to 16-bit (64KiB), leading to OOB access.

since v1:
commited unstaged change in patch #3...

Philippe Mathieu-Daudé (3):
  hw/sd/sdhci: Fix qemu_log_mask() format string
  hw/sd/sdhci: Document the datasheet used
  hw/sd/sdhci: Fix DMA Transfer Block Size field

 hw/sd/sdhci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.26.2



Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090DD206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3DX0v4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090DD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRR0-0004V3-BA
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQ9-0003Ap-0R
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQ7-0006Td-DU
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id f2so32760wrp.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 13:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nlUGA/l9KHjOACUxwV12D0UYc6yzxeVSlKZBFjnWV4w=;
 b=d3DX0v4kk5uaBV9xetFw+5p504+Wt+hQMii/Ch3MrNCISkYd8ZBB0WaF0lAra1hVKD
 zQ4WwDP7gBgArR5SChE4hobe4jYdLmn6s+rem/ZdOiimckpG6ZoJaTFjpvCvhsX4LGbP
 ltjicr7qBi58mlUYduVpGZ2KzAUzWNhci9QpnAF5PrIZg1FD/VZrNAcnNNDFCvJZoPum
 j35TqGu97mFR2N3O8zRoviv6den3wEkeysxjXlUMC93mYLEDtovVdTE03IcMnU52x2lK
 EI1yaPm47yRCGbI4IIwtMohCORF7lnDDxnchS+RrNoRZ3K8peCZer7nw+BeLyAvKMytx
 pq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nlUGA/l9KHjOACUxwV12D0UYc6yzxeVSlKZBFjnWV4w=;
 b=hjTCP7DZLGYEi6xHEmWXFypoNi/T1sqX7LmJkyvCOmQPOt7K3wE7Q8+VaLWl6HkRp3
 5WLQhcVHRbHv7ya6vOrBSu5mE+OR2Q7jhL+Xm941gzYdLuqoAAmO/qpnarvhx6t7T0hJ
 cgWfMM3KBcftitzb1+Kjb0dJiHfRr8asJD4pCG2penf1p20sm98IzYgKmx+7BECslgqY
 AatBHIoLYQE75Q+9Rd94vk3Q17uXoJxhqTIews18AN/qs76jdcb1BdtWKu3IxC6T+usm
 n1PvfopZL2Ej1AELHTz+FV6dpUw8rzaw3cyh/I9kjdMY/2SBeq58kmlphuCf9WvNQBn8
 o22w==
X-Gm-Message-State: AOAM533MCuygebyurhd9ew8TRP833lDeUFKNkQe9O1Tn9ADw5iX3QnqW
 k51Cf2S7+UuENx2NwwLizO215gJ/IC8=
X-Google-Smtp-Source: ABdhPJwnxwXDKRHFUTWpO5uZeUDn3vgzfxNMm1rH/mgZxkJk3fjUkvMMXwQUYh/FgZDHkBTSvbAKRQ==
X-Received: by 2002:adf:8024:: with SMTP id 33mr8196331wrk.117.1594758053292; 
 Tue, 14 Jul 2020 13:20:53 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm7245217wmb.1.2020.07.14.13.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 13:20:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] MIPS patches for 5.1
Date: Tue, 14 Jul 2020 22:20:48 +0200
Message-Id: <20200714202051.13549-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1a53dfee92284d3016a579ef31d53367e84d9dd8:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-07-13' into staging (2020-07-14 13:52:10 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/mips-next-20200714

for you to fetch changes up to 15d983dee95edff1dc4c0bed71ce02fff877e766:

  MAINTAINERS: Adjust MIPS maintainership (add Huacai Chen & Jiaxun Yang) (2020-07-14 21:49:33 +0200)

----------------------------------------------------------------
MIPS patches for 5.1

- A pair of fixes,
- Add Huacai Chen as MIPS KVM maintainer,
- Add Jiaxun Yang as designated MIPS TCG reviewer.

CI jobs results:
. https://travis-ci.org/github/philmd/qemu/builds/708079271
. https://gitlab.com/philmd/qemu/-/pipelines/166528104
. https://cirrus-ci.com/build/6483996878045184

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Remove identical if/else branches
  MAINTAINERS: Adjust MIPS maintainership (add Huacai Chen & Jiaxun
    Yang)

Alex Richardson (1):
  target/mips: Fix ADD.S FPU instruction

 target/mips/cp0_helper.c | 9 +--------
 target/mips/fpu_helper.c | 2 +-
 MAINTAINERS              | 4 ++++
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.21.3



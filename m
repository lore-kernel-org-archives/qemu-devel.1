Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33796C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D411A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWbeLGIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D411A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3jX-0006HO-Us
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ic-0004VC-NG; Tue, 01 Sep 2020 06:40:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3ib-0001rU-8i; Tue, 01 Sep 2020 06:40:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id v4so659720wmj.5;
 Tue, 01 Sep 2020 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AS9iE5jICxt728QvQddccBLJxmpLmZSe3J8QH1ar4ec=;
 b=pWbeLGIUG6DEWzohVYh0R3MPCT/wYTFQff8wIJt3ANIJTFzgkRIqJC76+yYfXX0DRK
 ap7/sLZ/97/yXBAfeUbeNHqICanWYLTYZFr17HHBGcspdXfa0XD6mR6sDw+mgE9811Xc
 Ol29xXEj1U1lAGw+xO59p/bQYP5N7tPaKgDz6ZiZ/OV6oBVC9e3cStMJKRrZaDhicctI
 k9/Ll0ktPxTtAIVp2pXE8sD2OoV1KWAAn7dP72jlpSpgLkKUDafpph0nnjIR517RSsdY
 6RkCeaE2eYMBYDr3QT7lU9DHBf7W9hMfF0LkV0ui3R3rBF8q1/GwmeTkvXa7tQGBztip
 VhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=AS9iE5jICxt728QvQddccBLJxmpLmZSe3J8QH1ar4ec=;
 b=ImbQdPNQtQ5pApZMlW2Gym4w/JNp5NNYJXoSheaVQf/rDF9le72Dzhgzb+W9iTHvG9
 WKs5Tck2xD5p+NtpOdbUHbFMKJKFs5BfTV5wwrSMYuNK4QNikAxkU156fAtpdqgkaURV
 VwDvqq/oqF+Y6HN80rxTLptFzZqBYaK5FwycBbXUKAwRkCTK2hIYGEpQ075cC0vHaqxd
 NBMzzZ/15eKGN9eVW7cbZREr03v05HTyXg+Xay10e3Yv5kf7joPNwIZLuWEzbhuGZALe
 CNiiN0wfH51pCh2djtMOvY1VB0n6Uwo+qLbGZKtfA3M3uSkGpGxdVvqJibexAnaRa+x2
 kkIw==
X-Gm-Message-State: AOAM531sn+BqZj2X8M4b+L5+qno1f05d9Pje2r+AYfMnVq1SW6XSOuTd
 tq8u+KHZrtCzLgDrl8l2cOmce11vJMo=
X-Google-Smtp-Source: ABdhPJy+00Mwj/k3JHchfxDpB++xNiiepqxnw7B4l6xczQWOmbmg4x59eB4/MknpCMdSKMesvbnygA==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr1107714wma.113.1598956846547; 
 Tue, 01 Sep 2020 03:40:46 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o9sm1541461wrw.58.2020.09.01.03.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:40:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw: Replace some impossible checks by assertions
Date: Tue,  1 Sep 2020 12:40:38 +0200
Message-Id: <20200901104043.91383-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches removing unreachable code.

Philippe Mathieu-Daudé (5):
  hw/gpio/max7310: Remove impossible check
  hw/mips/fuloong2e: Convert pointless error message to an assert()
  hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic value
  hw/ppc/ppc4xx_pci: Replace pointless warning by assert()
  hw/isa/isa-bus: Replace hw_error() by assert()

 hw/gpio/max7310.c   | 4 ----
 hw/isa/isa-bus.c    | 9 ++-------
 hw/mips/fuloong2e.c | 5 +----
 hw/ppc/ppc4xx_pci.c | 8 +++-----
 4 files changed, 6 insertions(+), 20 deletions(-)

-- 
2.26.2



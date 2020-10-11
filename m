Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83735C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DDD2087D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajutJh/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DDD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRhPD-0007EQ-7s
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLQ-0002n2-E7; Sun, 11 Oct 2020 15:49:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRhLO-0000GZ-SU; Sun, 11 Oct 2020 15:49:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id n15so16612544wrq.2;
 Sun, 11 Oct 2020 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pIznuQJBfjIhMVRi03M+UmBAIkUkz+Jt+syvLGOkuXk=;
 b=ajutJh/hqHzw5t1kuXfIeRIepyuiDgPGpPvweYOJ22fN9fYisWroaUP2PF9m4edwFT
 TdkQs24UWY3344KoAOrphWPWEh1/mV/9pVf/PryTnGL+GcFUkYf7VKSHrZBqWvCCjBC7
 x64ArX0DC54p9UzGwxZ+6UKNneqWQFuXP7R9AVp5XZc34X06vXVWcroc7uOhxkbV08Wp
 Pkco8pREY4Dr8Ck6FLHFMRNGxSbHCIfKQxOyfpnL6i/Vc1fG2XFc4JBaHCr/4qhVcIkJ
 Q23IWg+GhvcpS2C+NYzXlJaQPvVk1wv00ToFvKSwI54Tw3K4iHX0dREIXXRb2fPnk1+9
 hv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pIznuQJBfjIhMVRi03M+UmBAIkUkz+Jt+syvLGOkuXk=;
 b=ZUwwlGZ/PcD/NRQg5dwqsWZ1VmmaRAevFZRMO/D6lkyHyaLlmV8o5eWXr19r+m05Zk
 ZXRksqmNPgsmpEiojzYI26kfk1+xSpMl8tnA6zzkNNg+pTcQITbtNvN9h/yiw1tAkONp
 FqouvJZhxJAor9CfDyBpoKUjOs3TFgWm/aElzGMX8kT5617JEmiXqV5o39Q5lVBfpHEy
 CN2OFA1Wg+3J/W3Jkuarga+pDya4mqzTR8lRlC4Ft3XFK9uXO8FsJPh6gDXsq26VTGWJ
 o5TvempQfc7qfWRAf0rt/vprhD6nq3Uj9SmW+9hxEiIVpbTzpygz6cZMoTLID05o46kI
 5YDw==
X-Gm-Message-State: AOAM533L4J6/0/GQGFCUaXw5DWgjGXlQj6giGUp6CsL0DMhKy4KSj9PG
 AUmFXc0JLXjSNfnqf7e51kXLkyJC7uA=
X-Google-Smtp-Source: ABdhPJzlervUDnBOfnIIv5xqDBd3GKG43XJ86kl2M8Ykuj+PkgmlYQ8U2Ow/hECPwTFZTmohUqm8Kg==
X-Received: by 2002:adf:dec1:: with SMTP id i1mr23840960wrn.50.1602445760569; 
 Sun, 11 Oct 2020 12:49:20 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d7sm19229439wmd.48.2020.10.11.12.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 12:49:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw: Replace some magic by definitions
Date: Sun, 11 Oct 2020 21:49:14 +0200
Message-Id: <20201011194918.3219195-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bunch of trivial cleanups, replacing magic=0D
values by definitions to make the code easier=0D
to review.=0D
=0D
Expected to be merged via qemu-trivial@.=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  hw: Replace magic value by PCI_NUM_PINS definition=0D
  hw/pci-host/pam: Use ARRAY_SIZE() instead of magic value=0D
  hw/pci-host/versatile: Add WINDOW_COUNT definition to replace magic=0D
    '3'=0D
  tests/qtest: Replace magic value by NANOSECONDS_PER_SECOND definition=0D
=0D
 hw/arm/virt.c           |  4 ++--=0D
 hw/mips/gt64xxx_pci.c   |  2 +-=0D
 hw/pci-host/pam.c       |  2 +-=0D
 hw/pci-host/versatile.c | 34 +++++++++++++++++-----------------=0D
 tests/qtest/rtc-test.c  |  2 +-=0D
 5 files changed, 22 insertions(+), 22 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D


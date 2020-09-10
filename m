Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1D5206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV1O5ouY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1D5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGxb-00022u-NX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGvc-0006iy-65; Thu, 10 Sep 2020 03:23:32 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGGva-0004Io-E1; Thu, 10 Sep 2020 03:23:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id z4so5524952wrr.4;
 Thu, 10 Sep 2020 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IiUNInL/307o83xAPoEOVWsbuFJeacWIMWUZqFjFjKg=;
 b=EV1O5ouYb1hrMPao8ECJKuezt3lKVJVlYgpfS8p7oKejc/N35zkPLblK3QvTPLnCur
 tSA+ZJ28wnYaux9AyAQL4BF3KfGaKxTtQoKX1cQ5eAmK2kSFxhjr324HRqlErKAWSxh5
 MdB8lQEKy5vGk9l7BtvYDK1TUMaA/flRQWWsajizBtFat6euSd/e+OBg9WKwU9ARyaGk
 33dANB97NsQnobSYMAwi9Lf8ITbxw/nm/2jfDbADmtE30WZXqBBfRn89BfClqzXOfJBU
 57MigVyhHuo1TtSPgPqvpdgVnf5giDb+U6yDV1QBezpMT80sK3+pewArA3N74eRo6Xyl
 NDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=IiUNInL/307o83xAPoEOVWsbuFJeacWIMWUZqFjFjKg=;
 b=t0UyEuJgqUZlM7ZgE94DQvyQvXU4xNlNoRelP3mXmJP810QbCZ2qPB/mnKJ2ltPJhF
 ucj9XAxQ+x82OOT0mi1iErg1r0OBBrpO+D+QbY/l+9Rjjr7tiQO3gs72rFvAzo8trlaw
 R3EDzRS58CKqOBobXizyKCuPdIxIm5m3bD0Yk+rYiJOD5Rzri3JN6jFHDHTrpz6OQDFT
 JqIPZqXk/R13OAqfMkgVHsjVnms4Qo/VIsSR2jZr5wlT0NJFX44/ngXCYG8NOLggpyI+
 ZdlKeniU6ff1o1lDdxQWAIeZytmwzWiSAcb7LZMlQ4dnwjTUfX6hELfWPbBVg2wlpaKa
 CG4w==
X-Gm-Message-State: AOAM532E6mJE+EfVLgKxk6OVBJLG6/JE+MtZ/mC109DrP5/KPau2i4TO
 mh4UxcGBsnqw0k4KffDS7H2zKCXUWzg=
X-Google-Smtp-Source: ABdhPJyYfKznX8/g+KZ8ebcG81Le6+PRqHD7XmdoCskSgHkPInY6fDqbzwHCo5jazT/YS29DaapCrg==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr7187535wrv.138.1599722606993; 
 Thu, 10 Sep 2020 00:23:26 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id x2sm6783804wrl.13.2020.09.10.00.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:23:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw: Replace some impossible checks by assertions
Date: Thu, 10 Sep 2020 09:23:23 +0200
Message-Id: <20200910072325.439344-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches removing unreachable code.

Since v1:
- dropped patches queued
- replace dead code by assert (Peter)
- use PCI_NUM_PINS definition (Cédric)

Philippe Mathieu-Daudé (2):
  hw/gpio/max7310: Remove impossible check
  hw/ppc/ppc4xx_pci: Replace magic value by the PCI_NUM_PINS definition

 hw/gpio/max7310.c   | 5 +----
 hw/ppc/ppc4xx_pci.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.26.2



Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8D7C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70092076A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU8gbfCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70092076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8L4-0002it-Ty
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JK-0000Bw-6X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jT8JJ-0005GG-KA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:16:53 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:36724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jT8JJ-0005Do-83; Mon, 27 Apr 2020 14:16:53 -0400
Received: by mail-lj1-x22b.google.com with SMTP id u15so18650890ljd.3;
 Mon, 27 Apr 2020 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jjhg4QYAOWYZwZu11uVJpfLsdLA4NrQAXKFJHCI6aYg=;
 b=JU8gbfCSPVgJGF8xDacinxmrzn7CPt4jZeYg5uKL2icxVPasSj009lm6t03+3mwMou
 IXBLmmESdRxP9h10cSR5eVCVmcqXLkfORxNhfymsTuNe91o02XFNEJcxNO82ghtWUEmd
 yMSF31FzWXyWOggMFxXpzuFYZ0IQIn+VuJxbhQb25xjAMDTPUfWduw2yEMjnmRy6RfeD
 /M/DInxRk822ogTCmkOIICvBysotu9Gf85jCmtB2V/Hb73QoX77VDaUsigBWioxvFYTa
 aaI2OoL7aZIivXkIsQN2dQEsIjDWlyviVpRU6WoxOsREWm8vF54zI7N7CzJ+Y3BPanqY
 ptCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jjhg4QYAOWYZwZu11uVJpfLsdLA4NrQAXKFJHCI6aYg=;
 b=nIRTZS6Px4z3ECza62hBsSVIGMPC+dKmjeD5TpHY7cjsNR7ppX7jZR26V7mAxHQpYw
 9oITsCby5YTvIWteX4FnNsNSr6iw7nWF9j0SjWI/Hiq+in0vdMa+sM8TZXOSqQ1rneGB
 FEANzoB1TXot5YoHpEFy0RtK7v5EuJ/12lShTnbGUxGyfxruz/svKBr6E/UdtM6L7f8s
 xQA6OJglXpml62kKdLr9H7A0id/6r6tMSDVoLTgkRfzQAeCBVs6qsI+2+JNUnBM4YbiG
 fuhrE4isgFdu3ClUN9hwxdq0pMijt+PhmNjbWC5D7TG+a3ENA6AWUI+iuUXkqVnzi0KO
 V7wA==
X-Gm-Message-State: AGi0PubQ08yQYFIYD1TTJ6dj2fRnt/CkKnQhl9h8D6drg70GP2FTk85E
 GHxm/QqxxdoG1mAYEWTulvMAJUmJnhE=
X-Google-Smtp-Source: APiQypKZDM/rD3Gnd3FBaz+szCL5Tor76qBCMXO1c6jAMCKn6NrJIjexPoDF5FJnjefYKB5qKMPVQA==
X-Received: by 2002:a2e:8083:: with SMTP id i3mr14893506ljg.175.1588011410829; 
 Mon, 27 Apr 2020 11:16:50 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 130sm11857486lfo.42.2020.04.27.11.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 11:16:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/11] hw/arm: versal: Add SD and the RTC
Date: Mon, 27 Apr 2020 20:16:38 +0200
Message-Id: <20200427181649.26851-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::22b
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series starts with some basic cleaning, continues with embedding
devices into the Versal SoC (as suggested by Peter in another review).
We then connect SD and the RTC to the Versal SoC and hook it all up
into the Versal Virt board.

Cheers,
Edgar

Edgar E. Iglesias (11):
  hw/arm: versal: Remove inclusion of arm_gicv3_common.h
  hw/arm: versal: Move misplaced comment
  hw/arm: versal-virt: Fix typo xlnx-ve -> xlnx-versal
  hw/arm: versal: Embedd the UARTs into the SoC type
  hw/arm: versal: Embedd the GEMs into the SoC type
  hw/arm: versal: Embedd the ADMAs into the SoC type
  hw/arm: versal: Embedd the APUs into the SoC type
  hw/arm: versal: Add support for SD
  hw/arm: versal: Add support for the RTC
  hw/arm: versal-virt: Add support for SD
  hw/arm: versal-virt: Add support for the RTC

 hw/arm/xlnx-versal-virt.c    |  74 +++++++++++++++++++++-
 hw/arm/xlnx-versal.c         | 115 ++++++++++++++++++++++++-----------
 include/hw/arm/xlnx-versal.h |  31 ++++++++--
 3 files changed, 177 insertions(+), 43 deletions(-)

-- 
2.20.1



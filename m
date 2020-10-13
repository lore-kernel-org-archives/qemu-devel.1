Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6758F20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV+X+Z0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6758F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHS6-0006xW-7d
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMw-000204-Oa
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMv-0001ZJ-7X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id n18so23332920wrs.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=II5s3PrMx9JAfE6WS0RKBXpeNP3nxGPfnMgubn1ABWk=;
 b=OV+X+Z0rqmkEgWVtw/cK0PVgxkTChPNG0v6QStQjYy0NyuKAuDzAsreLN0XInnhZNj
 8qCCIjN6As+Vdzk7uwA1crE4rFOiHM9p164xOUDb9A+ok+oDEydUbCW+Umfdo2NEQaqn
 mU/143uP4Xp8KuZ+c9Da9vlypc9YxRHP4sJPcMc9YK6RSA9W+S/fwxX3O3X4it2vUxAP
 DB+tZ7RXDJO8vFqv1wJaRG2FEi6NcnkCwObmmSsjAkFbl9dBZ07hdLXEgNRjJLfhd/40
 yP7S3XbhvlSVs3WknjCD0pVq8bwBsl+I112HNdPkOvpJ7bCydLqFRDPRIGy+hF3gcrNE
 XOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=II5s3PrMx9JAfE6WS0RKBXpeNP3nxGPfnMgubn1ABWk=;
 b=FF4wbasS7PgwdEXPQBDbQtrNLgD8bobs8KORuIve14MXyQoHLD54wBiEsnmx4CYTNS
 Jzj3PXozsDsqaNU2zFAWwqaI0fwz0R4x2dYqLtGLRjhH+qJxdcevA/ov4OIHBszfJ6rE
 t19R60MOPitIZdH8ZQaQCGdirgecrlX3Tkiu+IKtSxYw/4Cb6nJcxua1CPtlJOtCHUIg
 fvZoQ1C99KarPwxASvTi4bfXjBgjGcnep+jGNC9E1s8i/ca1bL1FpsDHaHnPjl+yNwAt
 N5M+dDglhCrXj+feYOS4OvFFhLTIYEdgsJYygsTjUwq2/DX3+YXIF742ZjRs6reEYltZ
 HwwA==
X-Gm-Message-State: AOAM530+nr5quoVk89SXQdcqCb+o2wV+0Maaidvn2hVWfQd0X46d0iL7
 Jz6lcrUh+HGNvK1igUq7oZfnxq5ftLc=
X-Google-Smtp-Source: ABdhPJyZga9l1CV4hrEkDqnVQOLasr4LHjjhetX5i0iSy/bHC/UDTSZpEP/p6ftdnQg2vUgvTCO51g==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr34634022wre.78.1602584239688; 
 Tue, 13 Oct 2020 03:17:19 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t12sm18991504wrm.25.2020.10.13.03.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:17:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] MAINTAINERS: Move MIPS GIC timer files to Boston board
 section
Date: Tue, 13 Oct 2020 12:16:59 +0200
Message-Id: <20201013101659.3557154-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013101659.3557154-1-f4bug@amsat.org>
References: <20201013101659.3557154-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MIPS GIC timer is only used by the Boston board.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 702f73823fc..62db288bfc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,11 +233,9 @@ F: docs/system/cpu-models-mips.rst.inc
 F: hw/intc/mips_gic.c
 F: hw/mips/
 F: hw/misc/mips_*
-F: hw/timer/mips_gictimer.c
 F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
-F: include/hw/timer/mips_gictimer.h
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
@@ -1167,7 +1165,9 @@ S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
+F: hw/timer/mips_gictimer.c
 F: include/hw/pci-host/xilinx-pcie.h
+F: include/hw/timer/mips_gictimer.h
 
 OpenRISC Machines
 -----------------
-- 
2.26.2



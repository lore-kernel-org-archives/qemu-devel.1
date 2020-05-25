Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B98C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB2B2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9bak53e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB2B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd452-0001VZ-8C
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd42y-00087Q-ES; Sun, 24 May 2020 23:45:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd42x-0006v8-QX; Sun, 24 May 2020 23:45:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so5351792wml.1;
 Sun, 24 May 2020 20:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=db/d0pBfWleUK7liSAo4LtpX/4+ln+wNp6AlFQFcv74=;
 b=o9bak53eRsisYbEBkvwpBMJZm5yvs45djVC33gB0OaoBcDrzCgIS8v1PrAWhv4QYmv
 EtpVBVhfkXmOAlvR/F0G+xNx5/DzfAOyYInLpYtAP2/CxmVHvvxuWTnBghWQ++igUBxM
 W4mxy5u70983w6XtaIA0cxsFKr3SAdSVAW5umLbdibCgqcFeWFRk/HCcnxe9zV0aHq4G
 uhQS5S0445jdM3SW9Rpn2isFP4eCSxdo5D5v1PVrCwt6Hc1/JxIO6EdeRJzJNHTCBLre
 756DXT7qQXibVpRFMOsIvURJM/Zfy0hFct9JqZY+EyKVMso+mlqTKm1IByH6X5/OLmbq
 Bk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=db/d0pBfWleUK7liSAo4LtpX/4+ln+wNp6AlFQFcv74=;
 b=k3ilFcCFuSoYz8I6Q8XzuWF1KB3qaBQLdiemY2KKPWkR9eYsUIPu0q8TcvJK0wnLo5
 B5nJyQjSgVWDtBfbTYoj0hMvI+odPl7Kfs+LZE8W+YFDEu7JDSDFJnCwQxSLwVNFc11U
 DX2IgA+cqolchETSa2cmNvqdQwai4R2VrRQv5dYFuPxXaDdiH43TOpCRjNBp7qQCOIZ1
 cML6jKT3kFNUbDwzbZ9r5KvyKtbXX8HHDGeAQxfL8NHRzWTdnC8UuqTe/U0W/0dkJN7J
 GYh49R0sZ80QkAafVnhOIJ0Fq8RXgUaStcm3lyXDfzXPQLToy1rFNAjTFQalHB70PFVZ
 g6zw==
X-Gm-Message-State: AOAM53080SZxj+xEPO8N0ovNryCdeVPchfdghQUF00FPnVvEKVgSvfqb
 GOAmrMQehadQujGtGAF5TMNeQjL9eyI=
X-Google-Smtp-Source: ABdhPJw/FYvrZ8yx2oWRV0kdFhLenz0JAuMXBaKvvifbbit/8iRPzxs8JqaujuI7TkqxMi1y5kwo0g==
X-Received: by 2002:a1c:a5d2:: with SMTP id o201mr16184821wme.27.1590378301297; 
 Sun, 24 May 2020 20:45:01 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n9sm17555150wmj.5.2020.05.24.20.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:45:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/display/xlnx_dp: Fix memory region size,
 improve logging
Date: Mon, 25 May 2020 05:44:55 +0200
Message-Id: <20200525034459.28535-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A collection of cleanup patches written while fuzzing
the Xilinx Display Port device.

Philippe Mathieu-Daudé (4):
  hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of debug printf
  hw/display/dpcd: Fix memory region size
  hw/display/dpcd: Convert debug printf()s to trace events
  hw/display/xlnx_dp: Replace disabled DPRINTF() by error_report()

 hw/display/dpcd.c       | 20 +++++---------------
 hw/display/xlnx_dp.c    | 14 ++++++++------
 hw/misc/auxbus.c        |  2 +-
 hw/display/trace-events |  4 ++++
 4 files changed, 18 insertions(+), 22 deletions(-)

-- 
2.21.3



Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48B020722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMi1OpVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48B020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJSQ-0001p8-3E
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPb-00073u-QO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:11 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:41797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqJPa-0007yZ-6O
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:47:11 -0400
Received: by mail-ed1-x535.google.com with SMTP id e22so16849663edq.8
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gcm+rSiBZKj3BDkKsCjIrFDz+yJHWruFvbBExCh4pSE=;
 b=dMi1OpVUMvG9Wl3O9uWhSHS/IO6b4bRVvzh9blFYxVPMF104QXo88eyh+wOEf7+K9M
 HRSfmcnyI1mxuGEFl7tEQSc1VPo3nW9yibfd01YyxrH1znNLxWoshJBE3SoIfY1sA84m
 NdhlGUF6eJCPGAVjiPd15y0njM2ZiX3QJZRjaKtEGEailfBtuJGME5K/OSx6u8p7xYBU
 5GVrZ/hH4HFlXn9BE20he4r21bPoV1UqfpnsXpaN+RNebKmP7L82VIdqmOu8uVpL28/T
 OIa9WQgOvENVxIuU84BLu9f40LE2EZbpTe59S4TeJByDJmOF/WJfQPSUXk/PuJoVCsHt
 VVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gcm+rSiBZKj3BDkKsCjIrFDz+yJHWruFvbBExCh4pSE=;
 b=OEUTTlk9G+mN5m3rFXg1SGnd9aRtODlUbM1TE2lzFoV1WTPizXOLOayok41k4RF4qI
 iyCttsCscnc8TsmADz9xY07fRy4U/4xfy66gl8Qly5UoYDoA1/SY6r1EvCc60WjlKNAM
 tuG4/Y7RQUr7Y2d+Y1BayM2VksUZuX4Y+r0Qwh3OCrd/vOO8u8k23P14rykTBz3NlY+H
 ldlBTQu6CjoUp9ca4ZauRfrfTKjF6FdprASDOXaS7SZgWmwKfMxmuTKFv9I3hytxQ4BC
 +1shftmQ30uKaiY1DiWtt2dGKk8wY93vdt1WaU/5FbO3+Gx8oiYLlhML0Iofny8GnQ7b
 bOWg==
X-Gm-Message-State: AOAM530YbSm42IKSk6AXGpkW4ha2vJIaZYtdL4iZReovPWYpfci11BPT
 uxWGjmZxjSIijKbuvisNHA+szQN/
X-Google-Smtp-Source: ABdhPJzsEEnVc5mERd6u/eZpnWTS+oJl0XcL65kC+oUV66ZRz+0Edfxof6WNzbl/OCkmCzqDOwN8RA==
X-Received: by 2002:aa7:da89:: with SMTP id q9mr24385293eds.273.1593535628650; 
 Tue, 30 Jun 2020 09:47:08 -0700 (PDT)
Received: from localhost.localdomain ([109.245.225.97])
 by smtp.gmail.com with ESMTPSA id d26sm3233096edz.93.2020.06.30.09.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 09:47:08 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] target mips: Misc fixes and improvements
Date: Tue, 30 Jun 2020 18:46:50 +0200
Message-Id: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x535.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A collection of pending fixes and improvements.

v1->v2:

    - minor content and commit message changes

Aleksandar Markovic (2):
  target/mips: Remove identical if/else branches
  MAINTAINERS: Adjust MIPS maintainership

 MAINTAINERS              | 15 ++++++++++-----
 target/mips/cp0_helper.c |  9 +--------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.20.1



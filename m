Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7072EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38313221E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Y2VSgrw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38313221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwIG-00041i-Eu
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHS-0002hw-7s
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAwHQ-0003rL-BD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:20:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id a5so1983197wrm.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xLa6iW2a9vdfZQ+4WCOodX8y0oiavSuYPUAbM3Vgv0g=;
 b=Y2VSgrw6RUwTcqr0DSzyYkCbjltHQ6aq4EfbIXQDmyFkhHiFwDDNMFXBIFQreXGGJb
 KVj0qzv1VlE2SiqRSuTFxhtwy95WompwT4RJtc6uMXtJVICWKCXn8sOqrqclRQAF7CXO
 wOKa51xm5YM5mKxnoApoj3j9lwZ2/Ssud5s4L5YqN0UiN5rLZpo+1+nyXYBfY7/XSCG0
 WEtHB54rM4RG85PULOTSMCwNspkaSTgkFxVbOkupWDKHRxwSlR4nnGwGzX5BzQR3EtDp
 wPiPLSp1EvIzXNQzwdDrSd6iU5nON0WUBLpLqgUeeLd+1pczrAOogbA4DY5SLEda9y4u
 eJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xLa6iW2a9vdfZQ+4WCOodX8y0oiavSuYPUAbM3Vgv0g=;
 b=Z1ZcK38N8wlH0ABR4NQI5NZtB5k/kHvtX8LDeY4aHRpPPTcS6rt92RCO1Hwl/IvVzk
 +nCDvt9Xb+pvzZIEfG0t5jsu1sNLQJ0BasCfQXwXdJauaARH2y1GFhDChReSOKX8sKh/
 1roAceE2EK60LcfKFJcMJw2fExctyV92kCnJn957uvYfWRPCb0K0IMcak2Ul78CmZo9p
 xTesaWr2c4TxhNKdTDBTUulXyE5vU/HPQdcWofeR2MEoNez6eb1szt1zl1x7Eof6OvQm
 HscMKxaTMKpShsRyBRhY3gJrW1Y4aZnvGLojxMuiL5+xtZkXvDfZUgznRfrFvJ5OBHFs
 NOnw==
X-Gm-Message-State: AOAM5313DzGy1EV37Oo149pTPJHEKkIiv/glYl3yHnJeE56XtLUexsK0
 +837QBgOlF4FqX0hF5BhsW1bhg==
X-Google-Smtp-Source: ABdhPJzk9rzEHXNKgPn2fjhff4FViXwqiINd84CXjH/N2BENePpDAqO7snMbvDPMbHaVZcPZC0KWIg==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr16673709wro.351.1598451598432; 
 Wed, 26 Aug 2020 07:19:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id n7sm6604411wrs.2.2020.08.26.07.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 07:19:57 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2 0/2] Add an embedded controller to sbsa-ref machine
Date: Wed, 26 Aug 2020 15:19:50 +0100
Message-Id: <20200826141952.136164-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=graeme@nuviainc.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, leif@nuviainc.com, rad@semihalf.com,
 qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is to an add embedded controller to the sbsa-ref machine
so that PSCI can communicate platform power states to the platform
which in this case is QEMU.

v1->v2
 - broke out the EC itself as hw/misc/sbsa_ec.c as seperate patch
 - applied review comments to date




Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63BAC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45FF214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6P9zfQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45FF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSlLR-00044u-Q1
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:41:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl9B-00031Z-KQ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hSl98-0001FU-0y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hSl94-0001Cp-0h
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:28:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id l2so15319535wrb.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YCN4s6HR1/KrVRGNw0XQMaeLQvxAhrw3P2htQwH2UHU=;
	b=k6P9zfQwkL1iVZPWGReO2YjJyl870GuwmSwY29w+vQaqh7mRdMQCaWEDzXXMruCiBP
	5hPNL8fZm4mKEf/HGLmEcBB6rcEa6WLTfQZ4NyLFmyzeepTfc3LaDnfos/4KXKCvJJ9t
	JI1JQlagCbLvYatWqvcYnAQGkWhoCiQzNpk3Gy/htwnQ2oKssV+qrjLmkQR2zcPNYdyN
	THqkkn0Fy/0HRIkRN47GzbaGoOib+zChZn3bT2f3nm51tQISdo5wKkRHd46hpHUCXLOR
	lUYPVXHyut5i/l9pwVCmklGRbZhE3IWufmmm2wquSF0G9nO8ix7T1P5WmQuQZQNluewl
	zxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=YCN4s6HR1/KrVRGNw0XQMaeLQvxAhrw3P2htQwH2UHU=;
	b=jgbVeDj8QlhQzBPwfRF3T5keRlT+XSo8s6k8Yv1cfK2gg9YgomXWdr6TfDfGYRpWs8
	tAodd7PQHrFgKEcTVw2cKeWr1drklCagJ5SvR9XhtKTHXlMfTA+vdxxa7fQuseeNBb4B
	RNc3QSIxxuhK5uMMd04vOE5wMOHOUgCKqeGw01PRKFOYCbWO0CVppDRROzRf4dl4xwII
	RTijzb7+vEi0iXy2/c4cvm0cK+ZDdvm7NS1cSQhJkqI6Oi6VJXwuWEks7xAsreRAqM/D
	OkCSNVyDTE2xMrgtQ+5N7cCLAGJ4H+Y/Fi1Wo+3ZzffMKcRLlNV2PtW5MHylhIQnrVJg
	VgFw==
X-Gm-Message-State: APjAAAXgMalFi6MHsdE0CEXcwSMDq5q6dWEh8HE69eCaSPlyQMvsQYlb
	iS+HqdlnDj8iNh51iDPa3wTSXAXORpo=
X-Google-Smtp-Source: APXvYqypUC0jyMS8JkjeLONenDVwkIwwyb0yw5zAEw+WRFkJ+4YHd+AVyyr8WN14vCNZ5NkBnD6qkg==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr45584711wrp.123.1558369692446;
	Mon, 20 May 2019 09:28:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id x2sm5830394wrs.39.2019.05.20.09.28.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 09:28:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:28:05 +0100
Message-Id: <20190520162809.2677-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PATCH 0/4] hw/intc/arm_gicv3: Four simple bugfixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset fixes four bugs in our implementation of the GICv3.
They're all fairly small fixes, largely typo/cut-n-paste errors...

thanks
-- PMM

Peter Maydell (4):
  hw/intc/arm_gicv3: Fix decoding of ID register range
  hw/intc/arm_gicv3: GICD_TYPER.SecurityExtn is RAZ if GICD_CTLR.DS == 1
  hw/intc/arm_gicv3: Fix write of ICH_VMCR_EL2.{VBPR0,VBPR1}
  hw/intc/arm_gicv3: Fix writes to ICC_CTLR_EL3

 hw/intc/arm_gicv3_cpuif.c  |  6 +++---
 hw/intc/arm_gicv3_dist.c   | 10 ++++++++--
 hw/intc/arm_gicv3_redist.c |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.20.1



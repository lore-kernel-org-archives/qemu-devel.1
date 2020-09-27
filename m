Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C8C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E44B2389F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 09:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q78q+sr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E44B2389F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMSgM-00065r-7c
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 05:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfS-0004Xo-Gq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMSfQ-00029b-PY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 05:08:26 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w5so8372936wrp.8
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2020 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CRsxPEjwu/Tfs+v11iOawnEIrvbh812WjS0q1mDKol8=;
 b=q78q+sr5ew+d3LDaOw3Epl4Z0dD7znmIvTWb/hho+a6Y5YN28z1USIaVDUvpjE4uN7
 6glOEtwFbdTg99SfCYcr1wnW4qs8veNgEtm4oGGCG7Gp1FneZdk3wK6kTKlKKXwWQMHq
 Uw4mrQZneO7/y31B2Lq1sJ7KXiHLVnkc68b+hNGB7u26sugxhVrvXbMrByyD5i5B5xnU
 E1jxr6+hMHgHGuXxp4ZsKKE4vohWU7wsgGfOAHZaVCaao+NMMM1VFe7Y9Su2qxj2jyeg
 W5INJn9EdBYYBzq7HdMSOJf+w5LcztPhLSGdNHxEu5HZT0w7OcNA2crg27S1nzbh2g5J
 hy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CRsxPEjwu/Tfs+v11iOawnEIrvbh812WjS0q1mDKol8=;
 b=YxPL4uMVeL5kexMj1buKq9BQpkLm7Q2pKbUGhEq30UEUGBaI+gvIqt+eXgCHXLmcFI
 xFCFoBuhDDu+MqVdApOIntGJlvvzpeNRtIyBpjPPd1BgT1trUL4cShx7IosZOBYtmJy3
 k8vCFjtI06lNc/KAymXkJtTOeWJnhzFFVjHIPRZUoJlj0bAx7+T2/tnl8CroCjjNw/DP
 TeYq1YfAPKJS8puHxAKIHrlOzwAmrumGad95Uuz7oZKvJJjj4YltpnLJO7M8pgm7V05w
 KXoZ3x3wZsWeeuyMGfApl8XzUtb66NWI6nnLvcex89Cqj7APaeIGaJi0OAxsK0vY7Q+v
 XXeA==
X-Gm-Message-State: AOAM530jVVV990h6TZ9H3Q8QKkObbXrGy4MTj/PxT1G/F94a/eLCXsIG
 pqcZXg/YtrcGNIO9cTd3454WfAKFRoI=
X-Google-Smtp-Source: ABdhPJzzaPP/tbAq276Ilfprd+1FU7IIpsAmXxe+S05mz9BeS8olhnGQjLpNXZQ9fm/9VdcXlgrFPg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr13125955wrq.245.1601197702908; 
 Sun, 27 Sep 2020 02:08:22 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y6sm9007187wrn.41.2020.09.27.02.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2020 02:08:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] qdev-clock: Minor improvements to the Clock API
Date: Sun, 27 Sep 2020 11:08:17 +0200
Message-Id: <20200927090820.61859-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handy patches while using the Clock API:
- display frequency in SI scaled unit
- display error hint when device lack clock support

Philippe Mathieu-Daudé (3):
  util/cutils: Introduce freq_to_str() to display Hertz units
  qdev-monitor: Display frequencies scaled to SI unit
  hw/qdev-clock: Display error hint when clock is missing from device

 include/qemu/cutils.h | 12 ++++++++++++
 hw/core/qdev-clock.c  | 11 +++++++++++
 qdev-monitor.c        |  8 +++++---
 util/cutils.c         | 10 ++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.26.2



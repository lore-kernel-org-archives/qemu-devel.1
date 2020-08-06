Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B920C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7473E206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T56IbBxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7473E206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fa0-0003XO-FF
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYh-0001yj-4w
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYe-00075W-NM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id f7so43957337wrw.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZS2sEdylBL0TO/Xgl0Pd8Z831IskePNlBiwKGe1mzho=;
 b=T56IbBxoQDeLVRVaohb6a3LVVGLRwMzyXTZkVf6YGkbQjHAnEHCBdk3yBCNk4epRfS
 RpsvaMtQaEBByRror//wa2M8w1NHzs6siFivjqkbzy61nPcSbIKMiu+ILLlnW34Hww9J
 NFEhLviy5Fqwgl1+dodDO6/4JkoUlDpkIoreteCVdhtbXyPrQzwM6xAEu2GeqJTl4gCO
 XqnFLF2CitiGumYThgCPTmyy3poO6H+f5LoLnhTrsbYkh2B20TqQBK2kijQB47VdIm29
 LqLlPdk/sTHbnMjHCvwy2CM0mwd71yBFshGYwY2Q7qE1SJGncu+5jOQCXgRxCTxPdurU
 aIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZS2sEdylBL0TO/Xgl0Pd8Z831IskePNlBiwKGe1mzho=;
 b=BTbmOo/3YUn3axSNYNly1HtIctJ0FKmSoVufK+M2JqhkuV/kPFDrmfb4zcT/ks0+d+
 rpckyZu0MdhrVZpPNGBln3GvBKALc2tasK3og9jQgIx8rUPTYTtjkfOaxAHf1fFf4zCd
 p1IhIizMQHge6i5Qc4n/SLybZQgIM+UFk22+5bYEgx2MkgTAMehZfpnGjMMoPpKXq+bo
 l4xg5eOkaBMi09JJF28yh9H1P3T2rJY1Q8jnd6kRRhwcIa2U6/AmAhP3bA6dX2rH1/wL
 qtcuVUxLqzKYbwrpTQcj7Oni9buWs2M+jcdaSO0GLazuWTuQRUe/+P6h60N56EMXb0AU
 /ynQ==
X-Gm-Message-State: AOAM530eaJR+0TwmBRAjeJ/j85It4zjK3SkKGZm5hlUPqzCtjWCPYAK/
 pf4TmO79N+tJmfzzBgioAjXvQIKJ
X-Google-Smtp-Source: ABdhPJwHkAJs9k/5K0aSpAESjbR3WA8gNMaeOY3Ij+VHowOIYmB3FILl7wqr3ns9Fn/ZDUnKtneOtQ==
X-Received: by 2002:adf:8282:: with SMTP id 2mr7268571wrc.76.1596719022378;
 Thu, 06 Aug 2020 06:03:42 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e16sm6409113wrx.30.2020.08.06.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:03:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
Date: Thu,  6 Aug 2020 15:03:36 +0200
Message-Id: <20200806130340.17316-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series improve tracing of multiple UART device in the same
chipset, and allow to use the Clock API to feed each device with
an (updatable) input clock.

Based-on: <20200730165900.7030-1-philmd@redhat.com>
"hw/char: Remove TYPE_SERIAL_IO"

Philippe Mathieu-Daudé (4):
  hw/char/serial: Replace commented DPRINTF() by trace event
  hw/char/serial: Remove old DEBUG_SERIAL commented code
  hw/char/serial: Let SerialState have an 'id' field
  hw/char/serial: Use the Clock API to feed the UART reference clock

 include/hw/char/serial.h |  4 +++
 hw/char/serial.c         | 55 +++++++++++++++++++++++-----------------
 hw/char/trace-events     |  5 ++--
 3 files changed, 39 insertions(+), 25 deletions(-)

-- 
2.21.3



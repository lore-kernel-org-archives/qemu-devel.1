Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2276C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D411206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoYUReKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D411206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpe4i-0005Ur-UF
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 16:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpe3n-0004TG-Ih
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:37:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpe3l-0006T2-64
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:37:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id s10so14541359wrw.12
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dnio0De21POelvllvqksyjy+SMPI9o8bFPvLcCpu5ds=;
 b=LoYUReKuPBBhh50+a5IguzVq+r/I83IUCW3vmf9iHNpl7awgxs7d1eCsTvEsraF0yH
 SKjC8/DKy29FdUqQocYTiBOyYFsz2vDst/dWQ5EmibRE0N6h4nClf0ZBGlfDpw20KzUO
 TBk5SOzrli/LAJ1Yn/ObMVNwqR9ojsmNkAaPBaP5fK+D+OYJx4Z6N8CPuYjnANJPNzTC
 yCIhxGNtfd9SIWTbr/TMYnsNqWbZtLLF5sofT7+XDEoZPRQ/zGbCsGzvIqMCg8dOyFu4
 N9ZC82uzQPwgTyGLiMiu/0gqtkIv7t3cFZ33qcR5yDbFP3xFfk7heu3khKafmxIj38/y
 BDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dnio0De21POelvllvqksyjy+SMPI9o8bFPvLcCpu5ds=;
 b=i66zUlOFChIzTL8x6MTBblzIpVhD2EQLZE3I+wr94f4yJ7VaBX/NtJG6iqgDuEaUIy
 gxov+9+g1FlFTENBEkL8YqTu3fJ5oq99+MfJlmGEadDSrC6dxZCus2w+qwzn9ihWEiIr
 I5kUKdKLQurKsx8MECrLRDQyPOXlvShJsNLWLsc/p5m0AAFa/FwVqbwwbcdNZTgHqs+C
 wLwxAh13+5h1WZ91TlPhWmu457NDl1U9mQXmH1yVVQxamJ6uVrfLsJEacXgzlTdOzQ+C
 U/oUuGuhp/BhaMYcG/XwMVcUycwAcELVIFIXMDsW2HoMVJDGFE8khSPY6rXq2Y9WBrrp
 nrgw==
X-Gm-Message-State: AOAM532FpLYXslc2CGJORDs6hq3/bYGjOCxlPGcWh1TOy2hUIKwh4D7V
 iZSa1NJ8iqBeX7xeykee0rhEyw==
X-Google-Smtp-Source: ABdhPJyBoWNloiWIvZU91opBKa+r9r/MOs5Xphr9ejNJpVsqjAfziBHpJQpCQOOIyO3cP/SRJuIClg==
X-Received: by 2002:adf:f104:: with SMTP id r4mr14587232wro.90.1593376671386; 
 Sun, 28 Jun 2020 13:37:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r11sm8402884wmh.1.2020.06.28.13.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 13:37:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] tosa: fix Coverity CID 1421929
Date: Sun, 28 Jun 2020 21:37:46 +0100
Message-Id: <20200628203748.14250-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes Coverity issue CID 1421929, which pointed out that
the 'outsignals' in tosa_gpio_setup() were leaked, in the same way
that the equivalent bug for spitz was fixed in the series I posted
earlier: instead of using qemu_allocate_irqs() we create a device
to encapsulate the handling of the misc GPIO lines on this board.
This is simpler than the spitz case because for tosa we don't need
to work with any of the other devices on the board, so the misc-gpio
device can be simple and self-contained.

As with spitz, I started out by tidying up some stray hard-tabs.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/tosa.c: Detabify
  hw/arm/tosa: Encapsulate misc GPIO handling in a device

 hw/arm/tosa.c | 132 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 86 insertions(+), 46 deletions(-)

-- 
2.20.1



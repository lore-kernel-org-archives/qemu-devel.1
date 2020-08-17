Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23919C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BD82063A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKIFRYYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BD82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7izW-0002hE-3V
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7iyC-0001d9-0I; Mon, 17 Aug 2020 13:30:52 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7iy9-0005vW-Gb; Mon, 17 Aug 2020 13:30:51 -0400
Received: by mail-lj1-x243.google.com with SMTP id g6so18339328ljn.11;
 Mon, 17 Aug 2020 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8xtVXFHEYgnf6JtDTPN7WBm75COKu7o/cNjaOQO6yxY=;
 b=kKIFRYYJL9VpsyL0Wk0FZ11WIfPIGoQPANCiwmyMqCg3ceIur2Wj0jOVcjzosAGmeZ
 XPFrBV6FUTwwAmTX/iX3B5bD7moLuPw5Oaq/WO3FZbhJLKCzqGxOpf1HYqHirS2RAtqw
 UEUaP7pFDRRT6cXkTLpC6G/ZEDGeZk2iq/TF0kpuHGSLLr8jxguowLQdzCafUKrFDO7h
 8uRHTFqF7T/L9LAATvWN8Yav3dBlFhGTQ4HAFczmY7Uf58dpP7yzaGx7rfRisc6cxJpQ
 RgHHozUaR5lJcdHzLBDk2OvEBrPg1qJFhz3hxAbh0zvorLamTxDaYj0yKF0BUpFoGp65
 ziTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8xtVXFHEYgnf6JtDTPN7WBm75COKu7o/cNjaOQO6yxY=;
 b=m6ifWxYp6Melxy0y0BVCF1y/LSHDX+3oa/8MMGD7WNBMN1yQGyCHHL6Q0aHio12/hz
 v0zswZaZ69d0cp+jxP9ME0eKyqUQaxGyFgSODkYvvxMIFRNM0MFKF6PPNKwKCo4qahB5
 4cUNEY0+8cazt1ybWnPMfXhGxwmT0JmbLr3KcqCE5DieAzItSTque+JjMbSmctLpkZVv
 IGBAjxhYKeuLRsics2hIY7IbUUvbthK9V0SlLY6NjzvfKXmIwV2jYBGUmGMflkYC6P6t
 YYBZYpCdipC8Lub2ZttGJLRtESTCUVQ9na+S6GiyvcdALxnRFCaZBPf4ruTEIr827Mye
 GU4A==
X-Gm-Message-State: AOAM530AsaV2PnqIwKIrpuchB7Px470jrIad7x/PLhE4c49QQ6a2pdeL
 PG97C0Hv4U4r3yN5cI3uPZNgQvu7iyml4Q==
X-Google-Smtp-Source: ABdhPJxDpDb4V2TnVUhK6OMC3mHHhXnip+JuGacnhLADuf96Ga5uPoPxN8SjCrDL17uDYnk2D8BXCw==
X-Received: by 2002:a2e:9595:: with SMTP id w21mr8205457ljh.334.1597685446657; 
 Mon, 17 Aug 2020 10:30:46 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f14sm5644909lfd.2.2020.08.17.10.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:30:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] target/microblaze: mbar: Trap sleeps from user-space
Date: Mon, 17 Aug 2020 19:30:44 +0200
Message-Id: <20200817173045.437534-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

As suggested by Richard, trap mbar/sleeps from user-space.

Cheers,
Edgar

Edgar E. Iglesias (1):
  target/microblaze: mbar: Trap sleeps from user-space

 target/microblaze/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.25.1



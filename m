Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402CAC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0092072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STvhflsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0092072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK0CL-00082m-2O
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Ah-0006Nm-SD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jK0Ag-0001pm-RL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:46:15 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jK0Ag-0001n0-Hv; Thu, 02 Apr 2020 09:46:14 -0400
Received: by mail-lj1-x243.google.com with SMTP id i20so3275850ljn.6;
 Thu, 02 Apr 2020 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a1+oHXuKff6r/woFFFjfDPVNB78x30jyW/Sxef4N894=;
 b=STvhflsw6eolqY0UHQEGzqbVyOhbYvFOu2Ob9oaj4ToQgxJOJP5otOAS5KOHY1fkLB
 7D/gEN1CBaiLKVh1TyH7u+5qiqAsuajkXHoHn3+sy8wzDEmztIIMOA7nuGR5paqiQyJx
 0pW4WXVkq99UurAI6nDpeQiGujwRnz2UqsrMVJVAkwWmY6F+xEqK17mzJYGkm9gaAlNL
 MwaHjsavZ/1AxCB9p2g2ECUbjScgypuMMhnTPkrhxyK8HEWzahqTro/naMnXhskJU1/h
 xYcRWFrjAQBHNZr0O9kSw4TROFYlE6p2rXJ4YqwY+KYEZeYdUZWdBIr+Lo1bdH7+LC5I
 d5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a1+oHXuKff6r/woFFFjfDPVNB78x30jyW/Sxef4N894=;
 b=dODNJZm0ITt6XFQqu8/VJD7kem2OqxAnYWwX8U8/fsKTaMTnZ4Vs26GIDgAreh2RgX
 /TvHVSQU1FB+/TnR9Gr43fP1jD9+AkSdk+I4iJbDqhL6M48/UbFthYAno8SzTTg3KFow
 W4SpnCnQktB/+AVdOYx4RKUEn7gYRpvMJVfSi4piDxv0O1zqeADrZpJTdYdhlpIFLh6W
 rraD+IB94hM6NHvlScUHOMg25YxBV+4G3bG3CkPRJU8ltPpEnAYFuQZ8JtnO2TNxMsgZ
 fnlQiLVXGc5QGh3+4eKdMJEpCeZuWqgODqneZqfawtxDHJeHwECEhxVcWjrTK5SHcwpv
 egsw==
X-Gm-Message-State: AGi0PuY56C4eNQ5gaqSuTE+3gFjX4eRRpfAWYbTvdoLey+hr4J4dyFPD
 xnjRRxotzsL2l7cmQ/SXzntix6aaswTf5A==
X-Google-Smtp-Source: APiQypIKo5dxbCxIJwOveAPdFIJWesCQXlyagXAbegz4h44n1s/trm/VnObZ7gwlOxm4W7zEQkZUHA==
X-Received: by 2002:a05:651c:1aa:: with SMTP id
 c10mr2103915ljn.53.1585835172206; 
 Thu, 02 Apr 2020 06:46:12 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id c22sm3849538lfi.41.2020.04.02.06.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:46:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] dma/xlnx-zdma: Bug fixes
Date: Thu,  2 Apr 2020 15:47:16 +0200
Message-Id: <20200402134721.27863-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

Hi,

This series fixes a couple of bugs we've ran into with some
proprietary test code and drivers using the Xilinx zDMA.

Cheers,
Edgar

Edgar E. Iglesias (5):
  dma/xlnx-zdma: Remove comment
  dma/xlnx-zdma: Populate DBG0.CMN_BUF_FREE
  dma/xlnx-zdma: Clear DMA_DONE when halting
  dma/xlnx-zdma: Advance the descriptor address when stopping
  dma/xlnx-zdma: Reorg to fix CUR_DSCR

 hw/dma/xlnx-zdma.c | 56 ++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

-- 
2.20.1



Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CCC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894652395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsk1Esf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894652395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPMt-00052o-KK
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGY-0004Ps-Gl; Thu, 24 Sep 2020 07:18:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLPGX-0003w5-0l; Thu, 24 Sep 2020 07:18:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id s12so3333962wrw.11;
 Thu, 24 Sep 2020 04:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jy59s2K9kYiBxlA0hJextDJqNNjzNOlqp0zEmQTHIzI=;
 b=Qsk1Esf95NymoPBfYMmfEKzU7xIIx35y4/E2mkp26+k6533cKzCFMjp4dY1kAX5597
 lf/tcKryKPtVezN1cK8QMWRWvgBUAHWpxXycifdCCXbq3UAllL7AjtFIs4dpZPevx7Sh
 +Oe1/trLIN6A9I3XZxW0zxnPgoKq0D3uM3yrUbF/XE4O1Z24ychNiKDpEC3qVglFS+f7
 ypAxavSq+CvcF/u3wAPXk1gepKehS1qaz35IPCrG8ICLXwHnVG8OiaTGqIYeY1pGnuDb
 4k2SJNHAfUXg9YPhr5mCGPMlF//VzujLmOZ1eixa1fhP61XJpeMhF0V/GG5xFwrk1Y/1
 6zVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jy59s2K9kYiBxlA0hJextDJqNNjzNOlqp0zEmQTHIzI=;
 b=nCy1UZhv0I8PbFgttAw9X/H3EG34gC8MfwOiaCGNVasIcenJW+WuTmOISAYpf+pPCg
 vJKiTjt1DhNHNHwSvPjypyRAkVZm4YGiuN/LVXFGybdHuYWLuhCxJnJOHU3FuBcLs30/
 8kBxG/ggHYOYzBPSMltP+9srSoeNZ0kCnAkiRdGa+ge8TtN/gziMX+6vfItkEtojudR3
 PPEIFTkWvfwypYEeoAMTHU2l92NUS4f0a/7f1eJLxEtTCo8ZKc981XZi0xJV9t1tC5BB
 21SiMqIg+xPAb7e4+hZHHY66znMQ7DSjTZ3QpHhV6J6er8J6xXHtm9rY7uYYYH9wySq2
 8ZsQ==
X-Gm-Message-State: AOAM533FLULscSo4DcEOl/qsI56OvK2J5/uNpbrRvjFAXA6RnHuHNE+B
 FEHRRIn2xlow7/+mzQGYqfCmwEvKdyI=
X-Google-Smtp-Source: ABdhPJwNk8TjMTRLAuASLyAKy3j7Ia3GzHXDkSajFMpTlFM7txSicGhOwAhumtkpuhGvtDbZF1zn+A==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr4472553wrx.3.1600946299022; 
 Thu, 24 Sep 2020 04:18:19 -0700 (PDT)
Received: from x1w.redhat.com (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm3400363wme.10.2020.09.24.04.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:18:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] hw/arm/raspi: Use RaspiProcessorId to set the firmware
 load address
Date: Thu, 24 Sep 2020 13:18:07 +0200
Message-Id: <20200924111808.77168-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924111808.77168-1-f4bug@amsat.org>
References: <20200924111808.77168-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The firmware load address depends on the SoC ("processor id") used,
not on the version of the board.

Suggested-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 0d8e5a34c78..ae98a2fbfca 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -238,7 +238,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
      * the normal Linux boot process
      */
     if (machine->firmware) {
-        hwaddr firmware_addr = version == 3 ? FIRMWARE_ADDR_3 : FIRMWARE_ADDR_2;
+        hwaddr firmware_addr = processor_id <= PROCESSOR_ID_BCM2836
+                             ? FIRMWARE_ADDR_2 : FIRMWARE_ADDR_3;
         /* load the firmware image (typically kernel.img) */
         r = load_image_targphys(machine->firmware, firmware_addr,
                                 ram_size - firmware_addr);
-- 
2.26.2



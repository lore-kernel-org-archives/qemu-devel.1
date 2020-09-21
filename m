Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B61C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5785C20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AacNfGaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5785C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGqo-00067P-Eq
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgl-0004Vh-Fx; Mon, 21 Sep 2020 03:56:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgj-0005uW-2Q; Mon, 21 Sep 2020 03:56:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id l9so11520634wme.3;
 Mon, 21 Sep 2020 00:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bdvjopkTSWyYlzzNIYBWFkPl2GYS4eTOsFgqMfsz/M4=;
 b=AacNfGaIGNK+5xuW8s1l0Qd+TpoVrU/nTYtNc+F7NhNK9yos+VwG5vzFcRyiYaFncc
 SkPVDbP4U5Bp7OLoJ42D+E59fruC+WJYfr5DytUvXXS8VJvqr7OdrDn8IvBU2FRp4564
 iJadkEPZuDyXkiUHnQnMkPupKeVOoYSsd6266ZfBHjGeV7tIuKClIw/5Dv1WY4aTgidS
 IZ2ej/wT+uu+dz2K0IlnKS+F4b49sd9+Du9qMc7yIIOg/IhTCyhRR4vNob5x0ZbU2rio
 gIctGbcsO30NG8Gnu6cubOU5upZt7MYNeMLWZebAsjxTRy8dkY0IDiqCG4nWcBe5+6x8
 /g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bdvjopkTSWyYlzzNIYBWFkPl2GYS4eTOsFgqMfsz/M4=;
 b=GWN8mr2JuT3vmskU98JZV0uPqDurgjH2AIqCO1iHIldwXgWF1EMsd5gzL103N7X9k+
 +rbF7lYgauhxzQF72gnS4HWwn/ohUKL6Ht4NJ3LAZ8xEMpaLYnb7xBHJZLhIb7bfZCGV
 8Mb6j0KzbP0yUc9V/VnEpf2aFb2dHTCWnXLFZ3YN8nCHXx6+EktfHh6/w+eJmEpOfmcU
 aDGUOa9BEgaxyyqtVnFTsbZAp3aq5TlaNFPx9a9zHi55CpASAztnB4dd0OFxRY/281vh
 +am1hHQVWHv1fMqrQKB3lWF8VwdOf/Z130RPOtEy/7Lx82rt5yhR97h71zNREs5JUJYI
 91jQ==
X-Gm-Message-State: AOAM5304VyvYq3Zam1+TenID5QDq6TvTliWoCYmQhCDIzzrN98IiSxND
 F7DTyuk7NKrPYqmmZC1OzdMPPpMj25g=
X-Google-Smtp-Source: ABdhPJz4KWGoGBmgjPt3scc6aJt1Q2ubx6+vDVKuTC72WwiVAhzOkQSvL5b6IRB6X7rNS35y3XsLjQ==
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr28912799wml.121.1600674998178; 
 Mon, 21 Sep 2020 00:56:38 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] hw/arm/raspi: Use RaspiProcessorId to set the firmware
 load address
Date: Mon, 21 Sep 2020 09:56:27 +0200
Message-Id: <20200921075628.466506-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The firmware load address depends of the SoC ("processor id") used,
not of the version of the board.

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



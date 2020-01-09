Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B871FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839EC20643
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO9XO2CS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839EC20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipLLX-000547-JZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKN-0003P2-0J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKL-0007TM-Tm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:30 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50631)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKL-0007RQ-NZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id a5so908151wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=losV8OmGXQZ4fRFeT4I2pKpzAi0vNXizsX/DL7svRT4=;
 b=iO9XO2CSfVfVP81gziM8Lql/NcDW3IhHH1R+kzPxlFnXs2sFMSTDdNEYMQ/5jgGuLS
 JYGRKyNnaPmEf34xOUqoeCqsWmQLtifXM6GjEvltF5qy42N44vZm/Vz4umW3HPaMR4ac
 ZwXArccoyYMdMJJv6QTIstqyK8Pi8o4DO2GKlZjiwBmsilR9QoCfHwtZDODoAcAgryMO
 h4FGt1p5NUW7UmQeHOT5vY4jXN/AJHDI0rN9Gkb4PIR6b9PUcUIwWoLDaamb2/T0s0fR
 6jadtWu4hSznRamjS51W7vQ5kYfsbyse50mgM3FAY32GDnpP9ugU1kZuMQ/7ekskCreh
 R1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=losV8OmGXQZ4fRFeT4I2pKpzAi0vNXizsX/DL7svRT4=;
 b=rx0swsN18UEVHby+NEuOcOSyhpvGNtaLB30vvmaZ2swMQMzcgoyTBY8Kgd7ZOlT+r1
 TMxlH1LuGqY0hXQfPczFAWNc3zwSwJnk00Wo7i4XZ/r/PKLXSkqbLG3u8oI88vJHvw8+
 7VlLgRQPt6kh7kyJTfx+UYyjcmLhcE9omVPjgH6Qot0sgY94vf7ToYIYgLm158EEi/mz
 hCR8I2UfVt7t7JYikPSFCVVHNp0Qs9bDMpIvDs51YcuozEe/j12JbQfKrr+jQPAaSea3
 Hf61TETw7O/HQM25eKTTh/jYyf3/+2vyUttHGcUfAJBVHsdIlcdydUrYnTVhZCEDhVBd
 8sQw==
X-Gm-Message-State: APjAAAVcR8besC4yAHA9xrv/XUDS6ecETj3N7PDhQniOycnZW5rG8y7w
 z1yEQ+4kIF2cPE5Bhd+Y3/c=
X-Google-Smtp-Source: APXvYqwIFU+6X/hq463dA/joS0koW8zG1FIDm9TeEMHDAM8nKrf/fLlheaxYyMski8JJB5xMwTY69Q==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr1290514wmh.44.1578528328656; 
 Wed, 08 Jan 2020 16:05:28 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm5947827wru.38.2020.01.08.16.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:05:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/hppa/machine: Correctly check the firmware is in
 PDC range
Date: Thu,  9 Jan 2020 01:05:23 +0100
Message-Id: <20200109000525.24744-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109000525.24744-1-f4bug@amsat.org>
References: <20200109000525.24744-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The firmware has to reside in the PDC range. If the Elf file
expects to load it below FIRMWARE_START, it is incorrect,
regardless the RAM size.

Acked-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0de26140..6775d879f8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machine)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
+    if (firmware_low < FIRMWARE_START || firmware_high >= FIRMWARE_END) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
-- 
2.21.1



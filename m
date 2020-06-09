Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F688C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B577207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqc6021J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B577207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYlS-0005si-9x
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkA-00044a-MW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYk9-0007WD-5l
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id c71so1786273wmd.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QmQet6MF2UoYbap2Zvn3IP+yrgTESYuhDl3I2oxJkS8=;
 b=jqc6021JAritlIr+jZKVFRcDKIELFg+iNBv3UFkpuN01Tesks+N4FVPlzf+PZ2XgLZ
 CFRVlE+MRfWbgysJU0TWJ6T+X81IFzoh4xUr9t/NlZbxzd8EEwcSVBnMe9zFaBejzLIe
 oGDhbrpGlCIeVJyoNG9Oh2eWYPA5lJ6TNAY5G3uYY8Rf0RMXoMzoB0QVK15QM1ikLnrC
 G3PgGSz0y8IDI9LBNIM2EIeUJVAxDRkAf27fBoC4CGJQOTGp7kA3I1jH1zx0edXuwKtV
 RXuE54ErDe7ledbRRqqY9AmiUjm+3B/HqUtbKqwBjNzo4Dsud7vURQtBtkQFLa3eKNv4
 2bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QmQet6MF2UoYbap2Zvn3IP+yrgTESYuhDl3I2oxJkS8=;
 b=a4nkMTd+8vy/lbK09cSY4ig+v+UgsfnWk9qzSkN+qV5/A/V85v2CdkWorj+UIyZiq1
 1gMtrljNvVa8E0HweUZvw7xPMCaJ79Y4Jv3FfzDtuKy+9MDFI7+drWEumHWW0Q8z/4XC
 2UAyt6bVuoBDcsG/kE26vHKhjc2N7qols0K6nosQeRqIk7cpLLWRztRT3Y4ekUDx6Gtz
 fv+YDXJnEOH7Ceb56XkBcvuY2CwwMs8f6qI7eRQKISYviXtAGJbB3EBgg3yuysosnqWZ
 HTfvjB3H/66livEOCG5+lwZk7dOA7Q8G6vqEK46DuLDFB/JUpXaui/rWsSc1VN6HS2ER
 Dmqg==
X-Gm-Message-State: AOAM532FFoS1WpG8vM5OlMnrfU/mtmW+yZhm+Z6Y06yEmGX0+tD658n3
 J75rHt6d3hmSUpq7C+jXDzO33FU2
X-Google-Smtp-Source: ABdhPJxKmgp9GzvJWEFU5rTr46A02LwHNDexMBa+As65EtTKStIkwpOS33e5BZEqhLnDP/gxH/Fx1w==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr2698186wme.171.1591687938484; 
 Tue, 09 Jun 2020 00:32:18 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] hw/misc/empty_slot: Lower address space priority
Date: Tue,  9 Jun 2020 09:32:00 +0200
Message-Id: <20200609073214.14079-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Empty slots model RAZ/WI access on a bus. Since we can still
(hot) plug devices on the bus, lower the slot priority, so
device added later is accessed first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-3-f4bug@amsat.org>
---
 hw/core/empty_slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 3ba450e1ca..5ab426e965 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -67,7 +67,7 @@ void empty_slot_init(hwaddr addr, uint64_t slot_size)
 
         qdev_init_nofail(dev);
 
-        sysbus_mmio_map(s, 0, addr);
+        sysbus_mmio_map_overlap(s, 0, addr, -10000);
     }
 }
 
-- 
2.21.3



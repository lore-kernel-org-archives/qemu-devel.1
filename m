Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0702C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF0A2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3HhdleI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF0A2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYsI-0008Fv-OZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkL-0004BE-6p
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37157)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-0007Xb-7V
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id x13so20071689wrv.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BKwzKZtrbxU02j73ueEcyHllddh/ol1Dq+AGgYyiyJs=;
 b=t3HhdleIImJBA0xMLGx7YL3FR2NxtWCDWJ1qFSCsxOwINNeOjndksMM5sBWoeLJMxa
 nclJnQ62hikK3rX7dD1QTF+ZFkMhFhTSoPRrgtaM/wcDP2q2PBjXO5Ek+ndYrbK6kkvD
 5GFxB6bNUSeusPEi97pqCyehrGPUOZQ1ARxzoc2PXEOsZd+5fHTkszm1GujOathvaCvI
 LiN94VIKb0BOtgFOcfCDXZ3YJNZFSFOaZ90RyYM6giEBkiWp+IJffPLQbBY2duUSARdV
 brmehWTQHtBLPO31gsIvKZWhjfv529OTA3DHskxKwTNIdcadfDGC+h5B+ZvAa8UwUd2c
 WITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BKwzKZtrbxU02j73ueEcyHllddh/ol1Dq+AGgYyiyJs=;
 b=AH71V84Asrau4JuQfZ0LI23inMzVKIAr5+ddgyIQXDcFqPznm96VCGoPAcl0JUt0rk
 6PA0IKalya8Ai9Wey595pP/i+5iiwjZ9ub2bbkGdqJb9Q67K3e8nkG89uV7ZsTCOcjKd
 ajCjuXupJ5Yzfc9sRbccg1d6v8nYUzXNz1cOQgCebvQvH3RO5q55kgBEOCyCVQ03bGJp
 iH54wKf03yW0zhhXKVmM5fFesUW4A8V2/u2IzlSpeodkoSw3JAKPPnSS6OHvkgBaUpDT
 FkUlY8CcRKg5naoKvV0D7iAxLuLVsfG6bCE35SIt5ZgrjzcYL8TtFfCGCYeLYNP4Ry1K
 5wgQ==
X-Gm-Message-State: AOAM532VKEIR6cU7VA1y69vB34jGtaCV2bBula8O3TcKPXK3t8K5mjvq
 8ecKqgXi7PO6mdia+m8w3eZ+hST1
X-Google-Smtp-Source: ABdhPJxPyA+960c94CGmRIQcTTddtKuPFlnmmzmpQNg/tnzGht2WMYg+gQm6RwqVBteTcit9id/7ew==
X-Received: by 2002:a5d:4e88:: with SMTP id e8mr3022757wru.188.1591687950134; 
 Tue, 09 Jun 2020 00:32:30 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
Date: Tue,  9 Jun 2020 09:32:10 +0200
Message-Id: <20200609073214.14079-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

The Plug & Play region of the AHB/APB bridge can be accessed
by various word size, however the implementation is clearly
restricted to 32-bit:

  static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
  {
      AHBPnp *ahb_pnp = GRLIB_AHB_PNP(opaque);

      return ahb_pnp->regs[offset >> 2];
  }

Similarly to commit 0fbe394a64 with the APB PnP registers,
set the MemoryRegionOps::impl min/max fields to 32-bit, so
memory.c::access_with_adjusted_size() can adjust when the
access is not 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-4-f4bug@amsat.org>
---
 hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 72a8764776..d22ed00206 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -146,6 +146,10 @@ static const MemoryRegionOps grlib_ahb_pnp_ops = {
     .read       = grlib_ahb_pnp_read,
     .write      = grlib_ahb_pnp_write,
     .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
-- 
2.21.3



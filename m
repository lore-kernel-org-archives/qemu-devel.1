Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15343C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D116A20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhmP95Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D116A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G8D-00078U-WB
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0004mm-74
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Oi-1N
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhM-0002Jr-Qo
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:36 -0500
Received: by mail-wm1-x344.google.com with SMTP id t23so6545453wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GWz1pjVoz6EtEwxuWeaelwOEmy5EO8eEws/ey/K03f8=;
 b=BhmP95Exm/gK6DIhdwZvHR2w/qXWOLQX6K1tO4UzwadBpAEOX6iZjrIr4We4QPyzav
 XeiOY7BCkxyr00YSJilvGDmnE25aX5KN5kq5ezQ5n+kcz0ivD2hk5/26w5hyOAX8g+3s
 Nu1kCvHqIHD5GY3VTqObTGf/A6gXZurBxxwXjAJBgjOPTx9Lr5qGgdRQBHpUCf76dRhn
 k6NtpmPwTezQjIlFhfMyDn+DDj4OAAu2cTkWz+DifJm8T+DAbMDcuWbdKwqdGU3lSMx0
 9XqClUUONZjdi+nSGBl0Kd0viV/G3sK4rOC3GNn6ziqy/aL0b7ZRkANt3e5pLLLP1D8v
 4D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GWz1pjVoz6EtEwxuWeaelwOEmy5EO8eEws/ey/K03f8=;
 b=eomcmT/0j+jy8mfej+g/2sHexm/gckMZiP5atyp4zPJeCbKHKi9MQy1KkEWZI0PcWi
 ymmN+8mD/ESGSWx1q9Fu3eHLEU0lH4h/8++6tUwDL35xY+bxtwZbiRx5zec2x0mzdzrE
 PeHgL3rsPbOeIp+jDQu6Mt3TyylIvjiHhyNMEBv4bEoozTpbpMN+xTPUDvMmLm/pOZBZ
 78URAzJjpdqAx2iMej35Hg7tuolbBD9cxAx5JAm6Daki6fbVnvCgT9/4A4ss0hMR9P5W
 5ifLXCHlfzrAICgj8QMu9zml3s6teblaqPsB3CT5GRP5vUj+RvQZeM7h1o0wBAFJ83jA
 yo2g==
X-Gm-Message-State: APjAAAXbtGY5hxbXQVbLXYUAFoc/zPqY2F+AkwNM9vnqr/o0ApNTspVx
 OmNc16JsBQtLxcevqKsL6f5yFX6s1zM=
X-Google-Smtp-Source: APXvYqxZlRYvB5OlqBUmfdFnmCVMqixBq/pjTIZEgq+x+O5IsGATa3zecZpTB3Fmly7voxqV9wdUgw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr6111153wmg.20.1581604949515; 
 Thu, 13 Feb 2020 06:42:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/46] hw/arm/raspi: Extract the processor type from the board
 revision
Date: Thu, 13 Feb 2020 14:41:36 +0000
Message-Id: <20200213144145.818-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The board revision encode the processor type. Add a helper
to extract the type, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-6-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dcd8d2d6d38..7a2ca97347e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -67,6 +67,21 @@ static int board_version(uint32_t board_rev)
     return board_processor_id(board_rev) + 1;
 }
 
+static const char *board_soc_type(uint32_t board_rev)
+{
+    static const char *soc_types[] = {
+        NULL, TYPE_BCM2836, TYPE_BCM2837,
+    };
+    int proc_id = board_processor_id(board_rev);
+
+    if (proc_id >= ARRAY_SIZE(soc_types) || !soc_types[proc_id]) {
+        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
+                     proc_id, board_rev);
+        exit(1);
+    }
+    return soc_types[proc_id];
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -213,8 +228,7 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
     }
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            version == 3 ? TYPE_BCM2837 : TYPE_BCM2836,
-                            &error_abort, NULL);
+                            board_soc_type(board_rev), &error_abort, NULL);
 
     /* Allocate and map RAM */
     memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram",
-- 
2.20.1



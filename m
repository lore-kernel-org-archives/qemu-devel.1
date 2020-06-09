Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB59AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CDA2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFbheXaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CDA2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYtQ-0001oH-Rg
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-00049W-DR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkG-0007XM-7q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so20074648wrc.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tdQA57lBeQOvfXchna8N/D8Nyo98nJ4cAaaQhD8ORsY=;
 b=vFbheXajUu3sgB8XRH5I1gdvhMlo45aUS6lYEAEMj2oV5YCkTmn3ywN3Z1TkklURiH
 2La1hJ+pglcsmC/8BRJBSUPnk3k/EUcOdPMRWLA9ev5lCDcHe8Dz+8WIMN3Eu1F8XrYB
 sUL+PugTmnW1ltu3HG8CXAFxhgsM6B8rbckePxW/AYNmPTwlFbCH8EKfxz67d21c5sTN
 5ofN98W/NH+jZgAW3qr6djfq0MfImOuA7XcGoECBy+GQHbyg3KPvTbUKiOcmeDnrtSJb
 0WL7oB4uCxgQJW1u3yNjxqOTC9tF4h88BvsBpKQignbavfpfgM9Djh/7mPgekE4F6IPj
 wI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tdQA57lBeQOvfXchna8N/D8Nyo98nJ4cAaaQhD8ORsY=;
 b=trWbVBuqRlEtCNqBBYBdeT2hCPiQv5IWH7wSkzzwwgQ92yF5VUXLSNpcHlFqymQPoQ
 tp2W0Yg/ygA7pSqI6r6wrJq3m1nqVtjKj0/RemF6u6q84mzuiVGB2/DRgIf4pJei0uye
 5a779lZz/p5vsXRpDzzLmcjkRbDpOUR+g3HBBfgyeXiTI8dNZgdaDli4PrTii8pEyNnj
 ZYF/a8MrmSO+wYYF/hYqW+K9UK2rE/4Lyxlf/t+88dc3hpeWf7j/+9xJdGVrqbMqNeXS
 L7ADm/zGqjhgx8OBKGuz0ZEQ+FR6yKEWYeAjgOItoxip5qHOpXR9/RgHzADGsXHkVSTX
 xO2A==
X-Gm-Message-State: AOAM531ICdMzm1Cjef6eZmcEFmLUVdsStQyJZSA0AZq9pPxYYGrONcGI
 8M0nqRvkUsHu9Ggxr9OyEE376yAn
X-Google-Smtp-Source: ABdhPJx9ZgRmV+P4rgQIOQvbsA6BXsriqLApJ2rVxWsdNn19aDMpRpJ5YkN5A27oPODJ80nNI1TcKA==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr3168891wrt.158.1591687946702; 
 Tue, 09 Jun 2020 00:32:26 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] hw/sparc64/niagara: Map the UART device unconditionally
Date: Tue,  9 Jun 2020 09:32:07 +0200
Message-Id: <20200609073214.14079-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

The UART is present on the machine regardless there is a
character device connected to it. Map it unconditionally.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200608172144.20461-4-f4bug@amsat.org>
---
 hw/sparc64/niagara.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index ab5ef8c5b3..148a26890e 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -152,10 +152,8 @@ static void niagara_init(MachineState *machine)
             exit(1);
         }
     }
-    if (serial_hd(0)) {
-        serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
-                       serial_hd(0), DEVICE_BIG_ENDIAN);
-    }
+    serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL,
+                   115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
-- 
2.21.3



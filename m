Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B8C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C19B2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnvACBIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C19B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKvK-0003qs-5C
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieKuS-0002ms-4h
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <daniel.thompson@linaro.org>) id 1ieKuN-0006VL-2g
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:25:16 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <daniel.thompson@linaro.org>)
 id 1ieKuM-0006U7-Pd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:25:11 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so16686993wrq.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aGde4CZaZE2g83epTJ24+hkZLk06bQgpmJ+TMTkjII4=;
 b=LnvACBIHHIl30sTRb/r3Cefu+ncKuO1uJiadFQydWCKRSfsIH42wpHy5X3aaSWou6R
 INMnkPlJxvep/tztrMzqi/mL/I36D+JWuXHJOruImZZ7u+80R37hujLCZFTLlMQnMyCN
 wuM0W9J1mLZBTlobHENItkSuzeXQoslito/jYxvr5JQn1YTAo936/AVoDWFIqxe8r9BF
 6eCmeZw2F9j5pa6S4A308zbIaZ4aE+shSWcpNG5aa1+6l+jgZq0qvtgvI5vEdGgD6RU6
 y367pRB00srhm6/onSWkHugDp4q9eeJhrT6zPPmPTz/VEuz0ZyxpjCHx7oP04WlmdZIc
 qvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aGde4CZaZE2g83epTJ24+hkZLk06bQgpmJ+TMTkjII4=;
 b=RpCjGcru/MRz9uPEWn8vl37J9oTrcp1fkoN7DlumcQUvPt6o2fHUGR1Eu/XFL1LpOJ
 0uXb0p8v5BGD+D1bApq2e/GKMCaPH9CFT5T8dwqbBkLc96Zzfsak87k9vY0GmpTt3EZa
 AW0dzrerRdh79kj1XfbEkaVFyAOIYslJSDYjA4jQS/i2pw24GiAoLYSlDNzz3YozkdHL
 MD2NBKSVRH6lG6G4OAm3uQ1Ziokh/8rDnthDRGm8+h6OPVKuacu3z/nHm2sVnM4z9LjJ
 5vRRBhWpCkPPl7Bcqxm9iSrKUiVbz9GD/YFuhzbVsa8R7dppFz2ZubfOdgGbm2uxGTqZ
 rMvg==
X-Gm-Message-State: APjAAAXZIXelDrHejjmD8RyV+dCk/NYUaRqBFABx6Ii7psv5leWztt03
 1j/8ZP+qGe7SBse1SHcnh/csmw==
X-Google-Smtp-Source: APXvYqzuy/laWjexzdEipuxFiA5531SrDLRRfqUM2bZmR0ybwssZlMTDLKI1lDHCYXOpnQ6ujdse9A==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr2831505wrh.49.1575905108758;
 Mon, 09 Dec 2019 07:25:08 -0800 (PST)
Received: from wychelm.lan
 (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id u18sm27606386wrt.26.2019.12.09.07.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 07:25:08 -0800 (PST)
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm/virt: Second uart for normal-world
Date: Mon,  9 Dec 2019 15:24:55 +0000
Message-Id: <20191209152456.977399-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Daniel Thompson <daniel.thompson@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, patches@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virt machine can have two UARTs but the second UART is only
registered when secure-mode support is enabled. Change the machine so
this UART is always registered bringing the behaviour of the virt
machine closer to x86 land, where VMs can be expected to support two
UARTs. This approach is also similar to how a TZPC would typically
make a UART inaccessible to normal world on physical hardware.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    It is difficult to add a UART without some kind of odd difference of
    behaviour somewhere. As far as I could tell the choices are:
    
    1. Move the secure UART from UART1 to UART2. This is a
       not-backward-compatible difference of behaviour (will likely break
       the command lines for existing users of the secure UART).
    
    2. We tack the new UART on at the end, meaning UART1 will re-enumerates
       as UART2 when secure mode is enabled/disabled. This is rather
       surprising for users.
    
    3. UART1 is registered and inaccessible when secure mode is not enabled
       (e.g. user must provide a dummy -serial argument to skip the missing
       UART)
    
    4. Normal world can only use the second UART if there is no secure mode
       support.
    
    5. Don't support an extra UART ;-)
    
    Of these I concluded that #4 was least worst! Ultimately it is should be
    unsurprising for users because it is how most physical hardware works
    (e.g. a trustzone controller is used to make an existing UART
    inaccessible to normal world).

 hw/arm/virt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc260712..a5cca04dba7f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1721,6 +1721,12 @@ static void machvirt_init(MachineState *machine)
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
         create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+    } else {
+        /*
+         * If secure mode is disabled then let's setup the "secure"
+         * UART so that normal world can use it.
+         */
+        create_uart(vms, pic, VIRT_SECURE_UART, sysmem, serial_hd(1));
     }

     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);

base-commit: 8350b17be015bb872f28268bdeba1bac6c380efc
--
2.23.0



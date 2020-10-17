Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACDBC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FB420708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5diqqeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FB420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnLr-0005mN-K8
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqX-0005MG-Kh
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:09 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmqW-00048p-0B
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:06:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id e23so6142301wme.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gN5fG1W2a6ABvVlFISLEsEnU3++HZ+v2I6FNfu0op4U=;
 b=d5diqqeFh0UWzD1oEGPFGSH0Vp0hsp93siVOISRezbTjupm2MDl/aOiNULYOztM0x8
 NLUx1EJkE1CIobTOmhdv1Zd6reVXZ0gqbgaKGnI2okhSyyHqsJFGHXClD5dOVfs6iaoP
 e/VJWs/dRaRGP7XYDqbmwLbg3Mqk/pn3CbwD5XWvMzECTkl+Ri9DGcBPgNkvgt9UOQko
 AFn0+kmKtqVl9DGaEOhi+Pb3kWlRZZfA/XmNEDIFFN/FZDwf2tGEHHU+RXAdpl03DylS
 bTwFR6Eh3gyWuxhIC47VvvARTwRd2WvEl7T877v7yUzP9l23wV7/Hh6TcwxWaF+mh7UD
 +8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gN5fG1W2a6ABvVlFISLEsEnU3++HZ+v2I6FNfu0op4U=;
 b=Un7grveiFsQicSWQXTBtDoq9kw7HxdzsdjbWJSD2du9retRd0pMu9+grH5v2vhFUnb
 S1GKKGBPnRfaPb/QybSKbMbG+ryN281an563x8PFBwHVF6GfTd/RE1cNeLVr3tcz1M8w
 80JD5GQnonOcJ3IhtZSUhsMM1qDbbGobg+Cv6woKo7votYz5G31/VoJIoVg5VLvZy3sm
 jlla85f7fVMgbpJkK1/J9infBfUjhob8mlHcN6VWLbh04w4t1NBWhEyMHNbsoqAEZJjl
 sL9qsAkUXUydSvjICwzb2A5hw6tDjUhpisYSdlX1bv3dlBYspUMadgOrokDPrOa7N9mv
 GCtA==
X-Gm-Message-State: AOAM530qA68IdYLvVmIVN2yd/af+04NJo3S3uPFGhScFlGgc4s7P1C3K
 NZyS96nUWgPaB+Cdc0P2m+r53bBBlbI=
X-Google-Smtp-Source: ABdhPJwGri4MKQExmjGpd06cO0csoTaEcETa7dJ3YVIlJrW+leo6QafUYzIIaCgC5+79Ae4JAFESiw==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr9265405wmc.91.1602943566495; 
 Sat, 17 Oct 2020 07:06:06 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id c15sm3534613wmb.27.2020.10.17.07.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:06:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/44] MAINTAINERS: Remove duplicated Malta test entries
Date: Sat, 17 Oct 2020 16:02:42 +0200
Message-Id: <20201017140243.1078718-44-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Malta tests are already covered in the Malta section.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201013101659.3557154-3-f4bug@amsat.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8770cd6d05a..a7f0acf8663 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -237,8 +237,6 @@ F: include/hw/intc/mips_gic.h
 F: include/hw/mips/
 F: include/hw/misc/mips_*
 F: include/hw/timer/mips_gictimer.h
-F: tests/acceptance/linux_ssh_mips_malta.py
-F: tests/acceptance/machine_mips_malta.py
 F: tests/tcg/mips/
 K: ^Subject:.*(?i)mips
 
-- 
2.26.2



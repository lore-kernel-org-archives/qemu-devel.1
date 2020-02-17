Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE466C34020
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8552070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbrhbUoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8552070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gUt-0000ND-Oo
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gSl-00069H-3a
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gSk-0001jL-6V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:29:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3gSk-0001it-16; Mon, 17 Feb 2020 08:29:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id a6so18488697wme.2;
 Mon, 17 Feb 2020 05:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X+VUpOyrP1K99lWKDQzsDNVHm6OjkjeFpNl83oieryk=;
 b=MbrhbUoMSP03+fIiB0nFu8tl2W9xI4yB/SEQx4Gxnwi+gMjztbgMU6pAwhZPh3MKCS
 izaUyZrLKa2FOXxtp7e/6ixZArXZ52GQGoGSFIYhEVJwCvKS2ZkYK75BXp+GyH34Qcbj
 o75bbb4sVfSP2j0on/waKXKumt10pLzVSrZx5WiU1pJRlE0y7pUHPmQFi1xoRdwNxdjW
 PFD2Qq01vUtFxTpuPgKprQH463uhPAbF08n8ULOCKEMRdbUn+FoXPX7zaV9Au+eS70ZC
 u+gelUStzBdJ3tLO+LAmoJLFB0IVus3FVwJqsWvyTP+oF+/y179u2ouvdYDw1YBUz1Ta
 jBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=X+VUpOyrP1K99lWKDQzsDNVHm6OjkjeFpNl83oieryk=;
 b=XiHYzztid578VG95Pwyl6/f2+f/rQma3DqC2XyoTEu8PURWt/QG6yR7eOtfVYTdhBG
 PBouNrJEqNmMQ6KyKVPRlGQqHLoaGQNLM/Lp1oejCV6air67QdQsTYXBr1wvIK3farYU
 Ouv6Y6vdXpNDih0OKYCzrcWd4KinwMAi1X+0BXCoDfexYHYN/7drp3G0NB/yGy31EEau
 t0kFEA+FRxJqvpvzSIxxUjDKkTXCnmZhEjmAspA3oAcbWCa6RbAkrixWAHAmMrA5lzvC
 He6gsYu04Fwl3SS3fY2fZHpmGRm4kaKdQxNEZRbIsPIOTw/rrMpyF/yg6DJ0UxTg/86v
 dygg==
X-Gm-Message-State: APjAAAW2CQQsmvjLdYzbpyVml+s7PwQ/a/zDOkuaMBLegyns1GlOD+St
 P69IuWEW+z0d7WvBB7chDv5PS8IsDGc=
X-Google-Smtp-Source: APXvYqy8By6qk+qJlzlxKdqLjG4m1+JliPYwYaVTIINQa2rN5HTBpjNqzXbO4XQgXVTs2dpyeAklDQ==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr22367859wme.25.1581946164404; 
 Mon, 17 Feb 2020 05:29:24 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm578945wmk.31.2020.02.17.05.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 05:29:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
Date: Mon, 17 Feb 2020 14:29:22 +0100
Message-Id: <20200217132922.24607-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/misc/iotkit-secctl.o
  hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is never read
          value &= 0x00f000f3;
          ^        ~~~~~~~~~~

Fixes: b3717c23e1c
Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: AND the register... (pm215)
v2: Corrected bitwise-not precedence (pm215)
---
 hw/misc/iotkit-secctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
index 609869821a..9fdb82056a 100644
--- a/hw/misc/iotkit-secctl.c
+++ b/hw/misc/iotkit-secctl.c
@@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque, hwaddr addr,
         qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
         break;
     case A_SECPPCINTCLR:
-        value &= 0x00f000f3;
+        s->secppcintstat &= ~(value & 0x00f000f3);
         foreach_ppc(s, iotkit_secctl_ppc_update_irq_clear);
         break;
     case A_SECPPCINTEN:
-- 
2.21.1



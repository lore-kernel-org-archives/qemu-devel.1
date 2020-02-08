Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0257C35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A382624658
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZk8ndr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A382624658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0TTY-0003Xp-QX
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 12:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ1-00064x-QN
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ0-0001pw-Hj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:57:21 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0TQ0-0001pK-B0; Sat, 08 Feb 2020 11:57:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id k11so2466913wrd.9;
 Sat, 08 Feb 2020 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I1ANtru2D3HkYCis4oA6m7f9tmoOY3ITOVs2JLAacGI=;
 b=VZk8ndr9V+wlgKGno4YlyVHLYbXW72LQtDapq/FsBaTeEB4SPSw+/mqKGs1CSgS2/K
 Py/aY80pR7H8mz+aScCydnvg+9VLZpMnCHTZ0aJD7kNGIj5ZVxiJcT3vQCWxoV3RPqE6
 RNhXnoIhd4eNn8/koSSRHGCDg9KJ2C3Fex7iVm3c5Qk9zu6qSufYCnPy7kCJVPhCHAd5
 iViKiEhZkeTl5j82tlzMmjCSoAUZXYq9XUN9azo9pJ4n1xwv2N4cFx9iuQzL/1JZHV78
 Amy4YRDSfvOMCwhUUzhHiGWntqUvYBvaUPPRvg6v6gy2ZDHxO6guIKTskO0Yqbdap+ah
 xupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I1ANtru2D3HkYCis4oA6m7f9tmoOY3ITOVs2JLAacGI=;
 b=lEm64eXsp3uHXsZOCHvz8GIHCRzvAA3FeMJal1mJY9JmglP46GkxNv5H042SJWbIH5
 zMi2if6M3BgGigm3GQK3VbIsNnJJbqa9CD//juZQFLFgGoGBjlPpRRH3TpQOMs9Sm5s1
 BJMIfma0nv72dFr9b9gPb4dKojzEdAU3rhWFGuyq/4etBNjJweSWwGDeH239l8N5JKT9
 NAYEMNpr7bCmnNxYQGDccBbPFomVbAVYyizla33DCkd1tUjvJ4QPluvt8C+CEkk0NWPR
 03VJ4g/IBrjjACeHp4IXGyj3DjRuYwRsTgTtDZ1BdkGrCl2EjVo0btgBmAT9WejAElQx
 cxmw==
X-Gm-Message-State: APjAAAVgyVsvJIqQ7TSgXLTAECdCDK6/xZkCWrlltDoUMuVcbCVutIa2
 qgvBZ0dagJkxwz08fGC4OtyBEXO4
X-Google-Smtp-Source: APXvYqx8r2YV16w7KdnS3+pL0IrepzcAahqFoavg3BNxk0Ea2Oj0CNjJNfpuLrYLSdvA6id4/AfBDQ==
X-Received: by 2002:adf:ea4a:: with SMTP id j10mr5927231wrn.119.1581181039263; 
 Sat, 08 Feb 2020 08:57:19 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a5sm7872763wmb.37.2020.02.08.08.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:57:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/13] hw/arm/raspi: Set default RAM size to size encoded
 in board revision
Date: Sat,  8 Feb 2020 17:56:42 +0100
Message-Id: <20200208165645.15657-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We added a helper to extract the RAM size from the board
revision, and made board_rev a field of RaspiMachineClass.
The class_init() can now use the helper to extract from the
board revision the board-specific amount of RAM.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 1628b0dda7..f0dcffbc2e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -296,7 +296,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
     mc->ignore_memory_transaction_failures = true;
 };
 
@@ -317,7 +317,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = board_ram_size(board_rev);
 }
 #endif
 
-- 
2.21.1



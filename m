Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EA1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A577120672
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPfYDkFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A577120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq00l-0002AA-Se
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpzzZ-0001UT-8k; Mon, 29 Jun 2020 16:03:01 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpzzX-00083r-Pi; Mon, 29 Jun 2020 16:03:00 -0400
Received: by mail-ed1-x543.google.com with SMTP id b15so14042786edy.7;
 Mon, 29 Jun 2020 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W7HO/oMkPvYxcNGJN3DuxoOFdsHhv++SXUx3BJbN4/8=;
 b=lPfYDkFHK91nEAbqCz7F3xndYYQNDLjZDJy9JGiL5ekTocOFMkOpk+jXkcpcPU7ITM
 v+DFNl3LQf8pYvoDbH/flmdFbIIz+xf/6V/UYDmjRFbK8cxjiUTR4eEcscj9TrYjdvrV
 Jckfm2S4yznnjKT3NAeAkQeGRzhtXGzKFSyRPbpVjcazJz6op4nwazE55muabas0A840
 qL5PPqEdhjRadsedtFxOJ8/g8djQbObZ6JFRJU5hKxEi9Iubv3jmB3xX1I9MdYOxAgr/
 wRpnZMYdsnxBk1MSK2G5N58QhGqjwnJJoMPpCBJTRA1gpK0xhJBl9OSa8mBVKcHf7T62
 kcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=W7HO/oMkPvYxcNGJN3DuxoOFdsHhv++SXUx3BJbN4/8=;
 b=LFffOqTUBiZU/1WTGowHJCfK09uIZicDCYd8sZ3akw88LJF/bP69Fy9Up/AOSns8yU
 7smHqRcY8yp8U1W7QtyDm6FRZg0CIPKbob+q0eSzY4SF4kiVyyCS0ughA1OcCVKE7gd9
 vUI0jpnh0qZwB7+mcFsKCHsm6wQ5YmjAvLKQex8IScZDC63F3IKVuKxXu6o+7vCIFNUe
 tO4arrnfQdkArp06AiqE3vjzo7ZO0ua8Ro7tLo3DYU7nXBk2ROzrYovlaTOR+vevXstz
 FV/MKFcF2WSxaG45tZm7jLPeq6xdiTivgzg4egOkK9klnFjdVfRhhzhFCplq8zY/iGpd
 hYsw==
X-Gm-Message-State: AOAM533CR4WGx6YrApaarEW0z4Utiy94SwaHH5uBJnB1d09Pz0GlraY2
 BzxQlnbHJBTYnKTGiKwXuclw1TR5HWg=
X-Google-Smtp-Source: ABdhPJzdZNEpkwTG3gK2vBkQ+d5g2NUnDFOAgjhEo3hbRbV2kuIfQpQcoScpoMn/pe5K1YlGCKlIUw==
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr20280632edo.123.1593460977795; 
 Mon, 29 Jun 2020 13:02:57 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e1sm668156edn.16.2020.06.29.13.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 13:02:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/ppc/ppc4xx: Only accept (combination of) pow2 DDR sizes
Date: Mon, 29 Jun 2020 22:02:55 +0200
Message-Id: <20200629200256.2240-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use popcount instruction to count the number of bits set in
the RAM size. Allow at most 1 bit for each bank. This avoid
using invalid hardware configurations.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/ppc4xx_devs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index f1651e04d9..c2484a5695 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -687,6 +687,15 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
     int i;
     int j;
 
+    if (ctpop64(size_left) > nr_banks) {
+        if (nr_banks) {
+            error_report("RAM size must be a power of 2");
+        } else {
+            error_report("RAM size must be the combination of %d powers of 2",
+                         nr_banks);
+        }
+        exit(1);
+    }
     for (i = 0; i < nr_banks; i++) {
         for (j = 0; sdram_bank_sizes[j] != 0; j++) {
             bank_size = sdram_bank_sizes[j];
-- 
2.21.3



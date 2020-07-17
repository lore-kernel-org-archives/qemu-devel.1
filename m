Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B006C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A6F2063A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBQmNZqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A6F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNQz-0008GJ-GR
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNQP-0007hL-39; Fri, 17 Jul 2020 06:17:05 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNQN-0005YG-8D; Fri, 17 Jul 2020 06:17:04 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so10148998ejb.11;
 Fri, 17 Jul 2020 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uPtwKDDCa76VzRbbfDCizJwxl+rZegXzGw3EeNacAGE=;
 b=OBQmNZqaWjL7pkxtJvLtAEs5aQWM0/p6wCDFWNKJJAtEJEKvEeBuxZXRPvObTyxcd2
 mxeJ+/09IqfwkIKo1sOW5I7UpRB72D82rRp1t80Q2DIU1hvuPMCdl1aPcNStYmk2YWzC
 zYygNVpJ3+2f96MgxNnzxwkSQJfSSMUmQofIi67MSgaBQds6N4ZHnUR8GkJ8PAHxs4TB
 SUOgBIk1n5SeUGWfbafhz2sAHSQ4cwZSzBJZhVCNwUfDTY9cNEU5vbXBui5b1pn5en/S
 zP44l9p3cNhncTDhQKXF4w4zK2pZx0GfDL5lpjUr4lthV/BgFUO6BvT29HlekaUs3R/N
 9igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=uPtwKDDCa76VzRbbfDCizJwxl+rZegXzGw3EeNacAGE=;
 b=bjjTYC9EMkO8wW9LOhHpyewR21pvFrBL5NrrwEcYTzYlZ3tjlxyJrTsPfwfcUfqY8S
 KlMYWpCtP9hYPTZBKNxG70TnbaELDjwDrZsUoFEIm52kelO2wgf0ZvWVrBS8HJ3cbiRk
 8xiCx9gV5ohYDding5HHJEmlWk8DGO50WctlhgtDrur5U1zQKxj9JMF4aoVDowKT/nZx
 l/K2DA9lagbTgt0qFD6elkTQxe4+it3X/HWvcbMYUVF7DX3j+4j0y/7P4jPGVWzdatGB
 QlyEKYcILAHO8a5UHekUlZv4ys0wZ86SMmZ3wqfyWOo5mdf7m5kKnDwx5oe3VbbY+gY4
 g5Pw==
X-Gm-Message-State: AOAM530OY+zxEw6B67EmzllzNyQkVFIQnSnPDkT1/qAZabZoPhgDLM9o
 2Ut5JtkZXrRspucLs8RnZa5fCA/o+N8=
X-Google-Smtp-Source: ABdhPJzvHUsXEWz1WmBC3HRQ5mW3ifvuB1J9FhShxzZS74RYd5VqNyhGZVj+jNZVTPYZheuUtd/BMA==
X-Received: by 2002:a17:906:1f94:: with SMTP id
 t20mr7710210ejr.233.1594981021170; 
 Fri, 17 Jul 2020 03:17:01 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id yj16sm7623611ejb.122.2020.07.17.03.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 03:17:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1] hw/ide: Avoid #DIV/0! FPU exception by setting
 CD-ROM sector count
Date: Fri, 17 Jul 2020 12:16:59 +0200
Message-Id: <20200717101659.20031-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer found an undefined behavior (#DIV/0!) in ide_set_sector()
when using a CD-ROM (reproducer available on the BugLink):

  UndefinedBehaviorSanitizer:DEADLYSIGNAL
  ==12163==ERROR: UndefinedBehaviorSanitizer: FPE on unknown address 0x5616279cffdc (pc 0x5616279cffdc bp 0x7ffcdaabae90 sp 0x7ffcdaabae30 T12163)

Fix by initializing the CD-ROM number of sectors in ide_dev_initfn().

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: b2df431407 ("ide scsi: Mess with geometry only for hard disk devices")
BugLink: https://bugs.launchpad.net/qemu/+bug/1887309
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/qdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index 27ff1f7f66..6ce7fc317c 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -201,6 +201,15 @@ static void ide_dev_initfn(IDEDevice *dev, IDEDriveKind kind, Error **errp)
                               errp)) {
             return;
         }
+    } else {
+        uint64_t nb_sectors;
+
+        blk_get_geometry(dev->conf.blk, &nb_sectors);
+        if (!nb_sectors) {
+            error_setg(errp, "CD-ROM size can not be zero");
+            return;
+        }
+        dev->conf.secs = nb_sectors;
     }
     if (!blkconf_apply_backend_options(&dev->conf, kind == IDE_CD,
                                        kind != IDE_CD, errp)) {
-- 
2.21.3



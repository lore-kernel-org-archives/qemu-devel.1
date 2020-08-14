Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DB2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E96B2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/fscXm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96B2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V7k-0000BE-NO
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V53-0003Xu-FP; Fri, 14 Aug 2020 04:28:53 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V51-0004ME-38; Fri, 14 Aug 2020 04:28:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id f1so7614497wro.2;
 Fri, 14 Aug 2020 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iye/cBGgUFdbmxaz6sgS3yQXvh0DJ2OzL+FyZ1uhmuc=;
 b=R/fscXm3OxNrTuTWiZetZYr5co3X/BxtPC8sFoqmIbCRuD02jizE7VrEMS25d0Vev4
 87bnU5FD5SB4usBzumk0gplrdBOrl2t1c6esEPMc9Qm7AbCGrtqcuYkgvOtc72qyjP3k
 ro0zHkARcXOfrnt9bm4lUHG1eFVRQuPe7WYFjFXQYFR+AH/Q+5Z3R1xTeMyizD8NkOW9
 XlITZJrglz9pR9qyxEspMcaD+8gOMRnkxoJRx2au+bradv/r8QZR+aaiJsjxfjFob+sG
 ikU4i7n/saSRRw/76LCH776HFJjvzlMHYmwmhsWAqj7f7BIXg3Qpab2jryGwc0ACyYCS
 gg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Iye/cBGgUFdbmxaz6sgS3yQXvh0DJ2OzL+FyZ1uhmuc=;
 b=FFH3pVcOwdiO3J4Ti6Z0AefyEbe+lLyv5G0YkReOqW8B+bbVOHqFh4rEkUwSM1pxrK
 /RGbCJPjqAqvVzk97NsRLO9L+pT4t5gRzzufCbuN9iBRbb9myTlw2lcuQlNKOcZEy3Db
 9f4K7fMP0bfidbMqh6LDsWykBuOcLpsCMjHj/H+bwZ4HOhGgEOEt/efXOuoigISsRyJu
 EmWyPQ1zJ5a8cyHiFImzVw1glONv70WQ/bIe2q+KIB07rPcTta6EI3+oa8LPO1VaRiAM
 Xweqy51YDFEQUwzZXpT/FCUFPGmNkRVry5hsKJ1s6FzxOOhWLKmhZshHCy1uGml6tU0+
 /ZaQ==
X-Gm-Message-State: AOAM5332zosV99JiBaCCmgOn72xK34AKlke7uTqs59TiuEyD/4/JQ+w4
 /FjlbeSnZFLAkfDQkYxMGxA4H7+BXdU=
X-Google-Smtp-Source: ABdhPJz2krOF4Sk4sBu4hfRcOeuJw1zBMxCFmgWxUoQAYnfZIl1fZYvXyBG56CWSUI9m0hj8f+ar1Q==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr1581637wrv.146.1597393728922; 
 Fri, 14 Aug 2020 01:28:48 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE
Date: Fri, 14 Aug 2020 10:28:38 +0200
Message-Id: <20200814082841.27000-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/ahci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 009120f88b..b696c6291a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1151,7 +1151,7 @@ static void process_ncq_command(AHCIState *s, int port, uint8_t *cmd_fis,
     if (!ncq_tfs->sector_count) {
         ncq_tfs->sector_count = 0x10000;
     }
-    size = ncq_tfs->sector_count * 512;
+    size = ncq_tfs->sector_count * BDRV_SECTOR_SIZE;
     ahci_populate_sglist(ad, &ncq_tfs->sglist, ncq_tfs->cmdh, size, 0);
 
     if (ncq_tfs->sglist.size < size) {
@@ -1703,7 +1703,8 @@ static int ahci_state_post_load(void *opaque, int version_id)
                 return -1;
             }
             ahci_populate_sglist(ncq_tfs->drive, &ncq_tfs->sglist,
-                                 ncq_tfs->cmdh, ncq_tfs->sector_count * 512,
+                                 ncq_tfs->cmdh,
+                                 ncq_tfs->sector_count * BDRV_SECTOR_SIZE,
                                  0);
             if (ncq_tfs->sector_count != ncq_tfs->sglist.size >> 9) {
                 return -1;
-- 
2.21.3



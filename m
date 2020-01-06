Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B668C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247A2207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eO/AqUVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247A2207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXTJ-0001Li-3I
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX48-00024C-EM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX47-00049j-8H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:24 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:43226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX47-00049R-3z; Mon, 06 Jan 2020 13:25:23 -0500
Received: by mail-qv1-xf42.google.com with SMTP id p2so19407459qvo.10;
 Mon, 06 Jan 2020 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQ30SiavMBc1O6qPtvk0xgAULn2vwWgQBHbs/PLUbI8=;
 b=eO/AqUVMui9U6V4k1266lbWw9rHB6L1/xQKK9x30mQ8ILZg7Wj6nXgXUTRudpF1J1G
 6FABU8/sNTARDGMPGCjHZHS6sZ2Cjr3RSBUY7s0d6ipN4okgaDy3N1BxvUD79bBl77z2
 Ev5/wUAvrl2KfeDaF+EwO7m7camnfr6OTyfdS1ntFDov9WF7CDLcHbriiMldC2IyDsD4
 iQpLdrsZaagqfp7eoQpzG0xoTW2+I5xsSwUvBEAW2uE8gC+hp9VS+Vwg/TvzFqMi/CPh
 exC/csYIhV3cyoDllSgzE7Kfy5AnyjYVB0Mo0RBkdV/PcKkszn/3lMFAVQbrLyBEm+TM
 FwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQ30SiavMBc1O6qPtvk0xgAULn2vwWgQBHbs/PLUbI8=;
 b=D+FqbNPJz2i5kdbY71RojygEw89XLNpU/bVvLNYbVvFNGgfPBSXjZC0Ej1wN+STtnq
 kt/0CPPSAHyFoHkQifrV7NXgUrvJdMaJn2I2KIQKXwsKOtCbRRo8kspiQIHK6mMqpZTM
 s2wiwBBeHvuP6fyTwGtPym2fUgVQblpmCdz0SOhJFGMkevJbMXvVn5Ik5wbkfth4EwvJ
 2gBEvQRkaEIC2gHM9y/43nGTZRGvd13cfCXzrHGe2Ts92OoxHXbfGW3/1fhKB4W9FTIi
 +Q+pRkXgydzI3j79RBwuPMCSgIK5nKV7wacXgwJSZ7aJuAFvoof7xULEsGMeb4UYMHGp
 RAdw==
X-Gm-Message-State: APjAAAUZpS9CN9VNdDI88LqFAnF3iq8HC2tp5YoGPobG4SbgjBzlOaFw
 6biPkpDwyku6Vbc44pNYfq3Qs7V5
X-Google-Smtp-Source: APXvYqxOrPWINPn22Tyf/XmY642bRM7VWtoZbvGTLor0xos/mdHd9Ta3OD1J1WE+mG5vddqcaLHxQg==
X-Received: by 2002:a0c:c18f:: with SMTP id n15mr68377057qvh.35.1578335122527; 
 Mon, 06 Jan 2020 10:25:22 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:22 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 17/59] block/dmg.c: remove unneeded 'fail' label in
 dmg_read_mish_block()
Date: Mon,  6 Jan 2020 15:23:43 -0300
Message-Id: <20200106182425.20312-18-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the 'fail' label and 'ret' variable can be removed from the
function. Instead, call 'return -EINVAL' in the error conditions.

CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/dmg.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..ce39a87864 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -217,7 +217,6 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
                                uint8_t *buffer, uint32_t count)
 {
     uint32_t type, i;
-    int ret;
     size_t new_size;
     uint32_t chunk_count;
     int64_t offset = 0;
@@ -273,8 +272,7 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
-            ret = -EINVAL;
-            goto fail;
+            return -EINVAL;
         }
 
         /* offset in (compressed) data fork */
@@ -288,8 +286,7 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
             error_report("length %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->lengths[i], i, DMG_LENGTHS_MAX);
-            ret = -EINVAL;
-            goto fail;
+            return -EINVAL;
         }
 
         update_max_chunk_size(s, i, &ds->max_compressed_size,
@@ -298,9 +295,6 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
     }
     s->n_chunks += chunk_count;
     return 0;
-
-fail:
-    return ret;
 }
 
 static int dmg_read_resource_fork(BlockDriverState *bs, DmgHeaderState *ds,
-- 
2.24.1



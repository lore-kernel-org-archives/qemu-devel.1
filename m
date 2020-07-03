Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF13AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E7620724
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htalOAG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E7620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQts-0001l6-U2
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt5-0000X6-IC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQt4-0001U2-4m
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 14:58:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so32922875wmh.4
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NRdSaebxxpQtMnPysytAP33orrhVy4jChl+bw6WV04k=;
 b=htalOAG2XOlJ3mUsuWqejlLWO/5RpsFdYhGsk4ip9IhIj43FODYDpUfYlp+HbV9er/
 OOxmcSy35uH4wwLf/HrvIThGYCNvFq1Hc5mF297nZ6XOjA3GtgDJS8xoSnXxkemMLUwK
 IJ5Nazx+C4QKwOnxKiP5iQyYNN39+QqOmmfHSJuiHcOgvS0iR4hbU4C6+p7vQJ+KOvFU
 pEbojh4JDHslMcfvg05jWJ5VOYmaRsfAaQLAUT6P3Dsmb5hi+r5y+xsp6ZmXqhNGoBvl
 ltTrGgEItPVDHHGAt33A+kw8kGwqNmafhXHQW9PsKL3Ibnxo6Cu06azh136QgmA/xxOj
 XrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NRdSaebxxpQtMnPysytAP33orrhVy4jChl+bw6WV04k=;
 b=U/kqRzOE0CH6DB8riUO2QI3IqjwysPw+D+uHrQOAVjqwxv7zfHHQEatD8tskmTL7/6
 ep/AuuE0tB6XLPMQaEF+3YP5TyHR/ZWV1f+xRy8CknNVUUQBxkn5CU+p4UOfB7ZiGznQ
 Q46ZaCMoSNt5A0+j/qAsSQHT9rurUesnGRcnNUOcHSG3hISulTrZJwRDyIPJ6yddJ4iV
 nCtfRaeY37R6OsF9XZCzjof7x4DxBaaOF4ntZr8RyvCx5y9NZn0XjmGKfufKSXkqng0H
 D3jMv6rFSGN0FMeGYh0JWqPK5CQlBQjFBidie3QwbS18LXd2y1lDUj1gikYNcrjSKFTl
 4a1A==
X-Gm-Message-State: AOAM531ReCtojIAy8KTS/y8rLBC7XforxbXDRWX9mdJ6riQMueecSPyi
 JIx7qx54CJtXxrx5/VLgy60UDERbz6s=
X-Google-Smtp-Source: ABdhPJy+XWE10TSaTB1D1VprNZOrklzD6bF6RP3bTBUm6dirbLcOL6pcgaZ12FJA5G/CQwTYCeqItg==
X-Received: by 2002:a1c:9c8c:: with SMTP id
 f134mr37105851wme.142.1593802692584; 
 Fri, 03 Jul 2020 11:58:12 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id t16sm16060929wru.9.2020.07.03.11.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/char/serial: Separate and document static properties
Date: Fri,  3 Jul 2020 20:58:08 +0200
Message-Id: <20200703185809.5896-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703185809.5896-1-f4bug@amsat.org>
References: <20200703185809.5896-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add more descriptive comments to keep a clear separation
between static property vs runtime changeable.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 535fa23a2b..d955963ef1 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -55,9 +55,7 @@ typedef struct SerialState {
        it can be reset while reading iir */
     int thr_ipending;
     qemu_irq irq;
-    CharBackend chr;
     int last_break_enable;
-    uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
     uint32_t wakeup;
@@ -77,6 +75,10 @@ typedef struct SerialState {
 
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
+
+    /* Properties */
+    CharBackend chr;
+    uint32_t baudbase;
 } SerialState;
 
 typedef struct SerialMM {
@@ -84,6 +86,7 @@ typedef struct SerialMM {
 
     SerialState serial;
 
+    /* Properties */
     uint8_t regshift;
     uint8_t endianness;
 } SerialMM;
-- 
2.21.3



Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669CD206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X294QEMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669CD206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd452-0001VR-JI
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd42z-00087g-E1; Sun, 24 May 2020 23:45:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jd42y-0006vF-PT; Sun, 24 May 2020 23:45:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so15852594wru.0;
 Sun, 24 May 2020 20:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jdIRLwa0ab05Cst8ONtq0+eHOzirKZG9j3qEtBls8q8=;
 b=X294QEMQkIEh2Ns4OZH2+M5N0cNj4/kIgMPBHtRkqsoNlnl4W+Be/rksfUoGGMP8hH
 iIIDHE7f7rvRqgLmh7ehOswMU2vVJNXXBBW6w4T+SlJ+LQBiF2aqpfOS+cIWWJJKxXB7
 o2wFx5/2e0haIiGj07PgRWJqO2rbbNq+mDtuBqitoVS41xPFf6tx724wCuognHbKxIEL
 ag6o0CVPOqK+g8FWA/Oq5IfMqi1S41PhFuTvuDT7E2jS9U1WmGnGZKdBLnvBHRXmriEh
 m0kWXq6thCoP17j52R5NEgEtZajVCR/LrlmfeZJfWi6Y6tZF4fs112O821TaiIlmnNwc
 zEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jdIRLwa0ab05Cst8ONtq0+eHOzirKZG9j3qEtBls8q8=;
 b=TnttYc28Wm9Jn7H1VFzUIUkXfV5z63QrwuPpj9Imcq7z+3kwZKlAG0qFrCQnKefGcG
 4qKYiHNgzZRoaJ97+8jD1sKYxanmeIMLGsoneoSfeSzBPZyw6RGcZNgJltA0QO0ZogSf
 JZp0OSYxscMEex+9yBKIW01EPz6O3JfIKnrop65Vbc1VjKVvEppoYDgeGJYUIiCyTEh4
 myxlCE+NWTMjR8d7FrKnccVfXjV9qr/b0AXvnPMoTJ7NAYb0n2OHzVJHsx/ehdzXdpqE
 XKCOWeVQ8K9T041ZcSlOeUDH2/hyei8xvwxEojf0cDsE2EQlrdBxIELKRDKh97gpQLpA
 IifQ==
X-Gm-Message-State: AOAM531c2wJv40e9NFmvaATo2BQ5JWXDJveEzaiRwon194NuiUqXm8GB
 4PIoC0QIMUb4CizWZiRcfM67Ss4i27s=
X-Google-Smtp-Source: ABdhPJz2hMMhnoqEvZipw8yskJT5emgg+7m6Ky47vuHVTdSqu6R/F+M9+HrksFbSc6hk7kXWIm+qNg==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr13612103wru.308.1590378302429; 
 Sun, 24 May 2020 20:45:02 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n9sm17555150wmj.5.2020.05.24.20.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:45:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of debug
 printf
Date: Mon, 25 May 2020 05:44:56 +0200
Message-Id: <20200525034459.28535-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525034459.28535-1-f4bug@amsat.org>
References: <20200525034459.28535-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the deprecated DPRINTF() call by qemu_log_mask(LOG_UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index f8e7b97971..06aabf20c5 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -196,7 +196,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uint32_t address,
         }
         break;
     default:
-        DPRINTF("Not implemented!\n");
+        qemu_log_mask(LOG_UNIMP, "AUX cmd=%u not implemented\n", cmd);
         return AUX_NACK;
     }
 
-- 
2.21.3



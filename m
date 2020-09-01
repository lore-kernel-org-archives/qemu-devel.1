Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FEC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308AA2151B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SASqnb+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308AA2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6s5-00014x-Am
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qs-000859-Si; Tue, 01 Sep 2020 10:01:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6qr-0002Uf-95; Tue, 01 Sep 2020 10:01:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id c18so1653591wrm.9;
 Tue, 01 Sep 2020 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nVzUwFb/Pru0mu/Wze/TshCcACe4nWk3tSS2yGusfjU=;
 b=SASqnb+RFqXx8M5S6P9b80CdwD2fCFwkebYGu8B5gfaEvOEVNTPkN6rz/fDJmoDFBj
 JMxtuvRF8plK8TholW9XV86jtBye/Drie2Uozi0DS4VBjGs6/LGg8syBYYbEelNZ/yXk
 MuTLfDdW3AKzDAn/x0X2CE+tqOQDAEktWVGwfQjKSRBOGCOj14x4lBRzn2amo/qV61HS
 t8zO5C16ck3XHw9FacAEbnGsI2KVx/wAlKnQlns/NYo4g2NCN2F0KzGu5cTLE+/PbZjm
 CwPOOIwQPgtA5hETnyHTr1JRfYhPPiwwU+3R1+5kEVC0k4ihlEFEtkUrIsq/e80Etq+b
 +Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nVzUwFb/Pru0mu/Wze/TshCcACe4nWk3tSS2yGusfjU=;
 b=ET/LQE0AtPuut5v5JNxWPiwemPeVXD1Pyem7HULL/ugHRpfhIDzg4DbrQcs9eEhXVL
 3WZml8NbePyUMGsh4eymSruywduqfgQzLfgPZsPt2kOSUs5CHpcreBYmmV6b0jDb3ZAS
 Brs4Y5llh1EdALcMeVr5yAFGc87bNqq9rzQ+NyuQ3m/rTCyQ2EG67XluovLlOipSWkUl
 1DX9YIcgD0AFF7YB0mh8r73mvF7qtbUaClQ72flnBuNIhAcdpqkLadj7bHlkcH+QX4hq
 bSNdnSTRjCvZuzYRLaqZYCfWkfOty1lMNelXPOGqPM+NKqKBGK55Ebw8iCRHlXgeRhWA
 lWwg==
X-Gm-Message-State: AOAM531Gy3nCB6tQ+ONKfMhuV5OcYGHuUr7N2dXjhJRsi6lw64/1qOwC
 2EcXDu86lllTsw2wCfkjDuO9c8oOiag=
X-Google-Smtp-Source: ABdhPJyHdqNk8QmVqS3jLkG35xdwwawsbObdYlpd0LJHEHrzd9qmiLUyRbiNg4MOQIBzb6qrM4vQjQ==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr2065703wrt.354.1598968890999; 
 Tue, 01 Sep 2020 07:01:30 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id m13sm1492107wrr.74.2020.09.01.07.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:01:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/sd/sdhci: Fix qemu_log_mask() format string
Date: Tue,  1 Sep 2020 16:01:25 +0200
Message-Id: <20200901140127.111454-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140127.111454-1-f4bug@amsat.org>
References: <20200901140127.111454-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add missing newline character in qemu_log_mask() format.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1785d7e1f79..e2ef288052e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1109,7 +1109,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         /* Limit block size to the maximum buffer size */
         if (extract32(s->blksize, 0, 12) > s->buf_maxsz) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Size 0x%x is larger than "
-                          "the maximum buffer 0x%x", __func__, s->blksize,
+                          "the maximum buffer 0x%x\n", __func__, s->blksize,
                           s->buf_maxsz);
 
             s->blksize = deposit32(s->blksize, 0, 12, s->buf_maxsz);
-- 
2.26.2



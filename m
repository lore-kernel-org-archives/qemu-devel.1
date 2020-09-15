Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598A520731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoBtXm1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598A520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAEd-0006ty-Gr
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qx-00011n-Oq; Tue, 15 Sep 2020 08:14:31 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qv-0008Ep-N3; Tue, 15 Sep 2020 08:14:31 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kk9so1624064pjb.2;
 Tue, 15 Sep 2020 05:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oGHfde2/p7Unz0ZWASemFfUTS9Iu9gtXZvUHoGMG0N8=;
 b=VoBtXm1iXA2cWPMVJjiuvbaRmJfadoHiieVIKykWquoVeayOo3GLcPawOKzS8A5ani
 Lf/5b4Rk1sVWPjbHLoAUXrXMmRIk2oCVSjpxXqCcFtxCkHjBPTqLRPDyvOpH0x+l3OOG
 XEtRECeKQiEH0yqshV9KIhWj0IrRkVjzQw1kLOIpJ+0B0dywuXjGznQnMQjeOANlmaCR
 WGAoOFbYfjF0/lnYGoYCcwJhmVcxJnjmBEWJjruypMQ2SpkEq1WP+xBsMKn58oWGbw3Y
 g2KHap6m2rHqcQ991nDNVZDGIXW//aEXDRY1k+8MZ8KjtQitUcg/rrOYYdQHM74dN37s
 zjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oGHfde2/p7Unz0ZWASemFfUTS9Iu9gtXZvUHoGMG0N8=;
 b=m1wMJ5S//YU3yx/MotzN0btr8RGrXMw+7zYXGPK3B77KElSF4A8MZPHsh/TQn8c2k1
 WDOQWmpIEvaH6ofacTq/Lyi/aqrrVcRJ7jV0kAYxjK/oakQOlM098iXHx4QwKLZfDQql
 qOULdjSpo02Ouz7YN/Eiin6s6yfe3UemVlL55bleklAaDpW37CmZho/JDcyvSFkBdIlZ
 AlEy6czMEG3MsyBb4tTW1e74lG7VrEW/e6im4mjeiZNdjnkpsxqiuB+wHnehugMJ3z+U
 AQO0H0KHXAXO/yPEOiFvkIi0FqOFJxqcArsXjWH4ijYyBQBTUk8YpCbwZbpuxff23KNx
 dV0g==
X-Gm-Message-State: AOAM533JvLSVpwzhWhHNjiQZga1XS5XghpJrda6/5Yi1y9lLYPIAWYiy
 dGY5uYhaqe/W/zrNhcrh2evvixHzlykEVVEMbj0=
X-Google-Smtp-Source: ABdhPJxf67dWEUzcJ29bQNXsHeYqVbM44nvPNU97E1rJTq6ySQStXsTGRcdjrXbbqjHKxK2vaHF6cA==
X-Received: by 2002:a17:902:c1cb:b029:d0:cb2d:f271 with SMTP id
 c11-20020a170902c1cbb02900d0cb2df271mr19226911plc.10.1600172067565; 
 Tue, 15 Sep 2020 05:14:27 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:14:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/26] gcrypt: test_tls_psk_init should write binary file
 instead text file.
Date: Tue, 15 Sep 2020 20:13:03 +0800
Message-Id: <20200915121318.247-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On windows, if open file with "w", it's will automatically convert
"\n" to "\r\n" when writing to file.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/crypto-tls-psk-helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
index a8395477c3..4f3bd446ad 100644
--- a/tests/crypto-tls-psk-helpers.c
+++ b/tests/crypto-tls-psk-helpers.c
@@ -26,13 +26,15 @@
 #include "crypto-tls-psk-helpers.h"
 #include "qemu/sockets.h"
 
+#include <glib/gstdio.h>
+
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 void test_tls_psk_init(const char *pskfile)
 {
     FILE *fp;
 
-    fp = fopen(pskfile, "w");
+    fp = fopen(pskfile, "wb");
     if (fp == NULL) {
         g_critical("Failed to create pskfile %s", pskfile);
         abort();
-- 
2.28.0.windows.1



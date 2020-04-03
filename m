Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131BAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C402076E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b62VDQt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C402076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRnL-0000FT-WB
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjb-0003Vb-HP
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRja-0002V3-8F
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjZ-0002Ql-Vs
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id e9so8904963wme.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DgcsVRLcv58otFdRsNxFND+i/4AlyINLiQErQsSUPtE=;
 b=b62VDQt7B3YmV/5dG6ywTOUYfm7P42bQuEiI5fRJ/Rp08d14EXw/AF5k8JNgFlUhEQ
 L+Dhj398lyB7K90oUGcCwxuUPK6lo7rb7YrGdrBdNgjNaHnq4o8GldLgPhS1RqtY3n1P
 cV1JY8SNT81dEHX+FU8jLozLPtpZJUiz69Oh7GqZCqaL3felghuRrKzGYbCXNe0/WAWJ
 Lf/+1sU3tMA4/SZTImDcWVYU4A/uR4o9K2iNk8yzlmYX9YHeU6CHvCrAopH3eHRZ7J23
 URFR/bWFZ0OncpMuHr0Uxz2NgITCv9HSRojONMLWCwmfESYaUtGKfhb/nGpkXhmZ4PQO
 t6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DgcsVRLcv58otFdRsNxFND+i/4AlyINLiQErQsSUPtE=;
 b=TMW6RvAqcepjaAqrPma27eskEL9A/Z1f+c53Knr0bAzOPHwDjgGqn/SZYwXxL1t9vf
 DIfEHEznq603UkYdIaIKJhfBzk3H1gZ4jx23jGF7aN2o3GkD7H0W1MSxRk69BfwiV4XS
 H2wV00fAFtVxV40Two8CAllSLjuTJiHq7I9+zzwVUF2o9UYxmCPSKhZuZ1RiyxWt0E+y
 cxPiwu+HBlWT/Jh6P44ymk0MQEexi4RM9Z6JBRlzH/50b0dfpUOTyJHW/gZu0K92UIQy
 eFhMfzIu55NAYRiWLu3yjBgmdRItIFR+3xA1wy8XCxP+goUtJg7F7Shb7hHGLY3DCxS0
 Q88A==
X-Gm-Message-State: AGi0PuasbEcLTLpOZLqKSOkQ+RJWVHLkgtkrpqq1fjr8oUec1y9wfzT6
 nwXKhloAS9Kickb81CWm9ien/w==
X-Google-Smtp-Source: APiQypLAqJtUiO70v5QjRA6gD5NDJFlIWIItByivUmZ1H6tC12vNUCfYKfTuLd+KyNx8H9FGC+UvMQ==
X-Received: by 2002:a1c:9c47:: with SMTP id f68mr9851632wme.148.1585941124945; 
 Fri, 03 Apr 2020 12:12:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c6sm10161053wrm.85.2020.04.03.12.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD5241FF9A;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/12] hw/core: properly terminate loading .hex on EOF
 record
Date: Fri,  3 Apr 2020 20:11:49 +0100
Message-Id: <20200403191150.863-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The https://makecode.microbit.org/#editor generates slightly weird
.hex files which work fine on a real microbit but causes QEMU to
choke. The reason is extraneous data after the EOF record which causes
the loader to attempt to write a bigger file than it should to the
"rom". According to the HEX file spec an EOF really should be the last
thing we process so lets do that.

Reported-by: Ursula Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/core/loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index eeef6da9a1b..8bbb1797a4c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1447,6 +1447,7 @@ typedef struct {
     uint32_t current_rom_index;
     uint32_t rom_start_address;
     AddressSpace *as;
+    bool complete;
 } HexParser;
 
 /* return size or -1 if error */
@@ -1484,6 +1485,7 @@ static int handle_record_type(HexParser *parser)
                                   parser->current_rom_index,
                                   parser->rom_start_address, parser->as);
         }
+        parser->complete = true;
         return parser->total_size;
     case EXT_SEG_ADDR_RECORD:
     case EXT_LINEAR_ADDR_RECORD:
@@ -1548,11 +1550,12 @@ static int parse_hex_blob(const char *filename, hwaddr *addr, uint8_t *hex_blob,
         .bin_buf = g_malloc(hex_blob_size),
         .start_addr = addr,
         .as = as,
+        .complete = false
     };
 
     rom_transaction_begin();
 
-    for (; hex_blob < end; ++hex_blob) {
+    for (; hex_blob < end && !parser.complete; ++hex_blob) {
         switch (*hex_blob) {
         case '\r':
         case '\n':
-- 
2.20.1



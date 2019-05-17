Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AFDC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838C420862
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCHpTevO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838C420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSrB-0000v7-O3
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:44:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmY-0005RX-CV
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSmX-00024G-6L
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmX-00023Y-0l
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:39:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id t22so2505773pgi.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=yCHpTevOUWizQsywQjRausmmMeemkcHfBs7EqHrBNFtyycHabhIwUhvS4z5M1PI7yF
	MUWDLE5XAgP9j416ibx1kvlJlSRBoP7Dc52zzoBisZ88bWmQ+6GrkLlKMvQPKcu3hAQ4
	On9aOx7EXlG5b4qg4HKd0FKPuB00nc7VAjEi5kILv2eaiICPu4tGO/8E2+uYeG1vjgE5
	RYQkn/RCTPldThmgreRvRw1yJaSTmHM/eAQkjydeEv84F9jPqYXwJiMJz0wC9DQuqho/
	tLs0xUpesL1/KMgrnf2iPjn/zqbeUP3DWftUcWLGubk/wjIVXAeLJ0nh/ZkdMAuTRTgb
	nJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=un0FG8WhdPzMW5hI4gQSy35bMhkwVicISvb3uWDS8HBggdXwRtFUUJuZGoQpugxZIW
	UH7Tu2Gjy/hxyg/NtVh2XslOBjRoC9VCa2YVcDpzR6KSvBzOeZcH4hZNaXIQbzlbYQ+j
	SVtP862puoTqfNJUjE4qAIxXoGRmZTrs/BrhfhWlv1vF1ZMxh8Q4U2zawdRGlB4fTeKc
	gdXdhCPwWrKi3zx+U+SxXBkb4SpCfC3dBT6eh0LfMQqq4J2zgQckYq1x70fTA8LFQmCj
	yyaOxx3Prx45y0MGxmC+E1LBE7+BQXQH8+e3x/u8fZnVIhqbCLm+LDZUl2f1e19qdCPB
	+Kuw==
X-Gm-Message-State: APjAAAW+rZAgoNV4NsnJQLkE0atSN/I2r/g6a4eopSC1qacfOXw99rhm
	wkznFZuDKkgXR0lPEeO4RCIsiIV5AFs=
X-Google-Smtp-Source: APXvYqwPj1M9Gi78888aYu1PWv+oBZBmJL0hU3qr9O8PSOvuL3ezzw7xUu7FW1Gn3Jw2ijL1KD9VVw==
X-Received: by 2002:a62:4607:: with SMTP id t7mr58962052pfa.138.1558060775460; 
	Thu, 16 May 2019 19:39:35 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:06 -0700
Message-Id: <20190517023924.1686-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v8 07/25] crypto: Change the
 qcrypto_random_bytes buffer type to void*
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using uint8_t* merely requires useless casts for use with
other types to be filled with randomness.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/random.h  | 2 +-
 crypto/random-gcrypt.c   | 2 +-
 crypto/random-gnutls.c   | 2 +-
 crypto/random-platform.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/crypto/random.h b/include/crypto/random.h
index 8764ca0562..fde592904e 100644
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -34,7 +34,7 @@
  *
  * Returns 0 on success, -1 on error
  */
-int qcrypto_random_bytes(uint8_t *buf,
+int qcrypto_random_bytes(void *buf,
                          size_t buflen,
                          Error **errp);
 
diff --git a/crypto/random-gcrypt.c b/crypto/random-gcrypt.c
index 9f1c9ee60e..7aea4ac81f 100644
--- a/crypto/random-gcrypt.c
+++ b/crypto/random-gcrypt.c
@@ -24,7 +24,7 @@
 
 #include <gcrypt.h>
 
-int qcrypto_random_bytes(uint8_t *buf,
+int qcrypto_random_bytes(void *buf,
                          size_t buflen,
                          Error **errp G_GNUC_UNUSED)
 {
diff --git a/crypto/random-gnutls.c b/crypto/random-gnutls.c
index 445fd6a30b..ed6c9ca12f 100644
--- a/crypto/random-gnutls.c
+++ b/crypto/random-gnutls.c
@@ -26,7 +26,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 
-int qcrypto_random_bytes(uint8_t *buf,
+int qcrypto_random_bytes(void *buf,
                          size_t buflen,
                          Error **errp)
 {
diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index cb3ca1bc09..66624106fe 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -64,8 +64,8 @@ int qcrypto_random_init(Error **errp)
     return 0;
 }
 
-int qcrypto_random_bytes(uint8_t *buf G_GNUC_UNUSED,
-                         size_t buflen G_GNUC_UNUSED,
+int qcrypto_random_bytes(void *buf,
+                         size_t buflen,
                          Error **errp)
 {
 #ifdef _WIN32
-- 
2.17.1



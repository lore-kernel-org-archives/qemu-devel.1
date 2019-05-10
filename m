Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81110C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07E42182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1MhPPBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07E42182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuSH-0007Th-Vx
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:36:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Iy-TT
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-000150-JL
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-0000zZ-AA
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id y11so2239129pfm.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=x1MhPPBzSmgGNoeKDU1r/iSLWIObmL4ruPAPjFk2gF5V2hkUlPbign0V91FQliMEv+
	C+T9mFpCzsNhyWICh2G7bqVQ0aXjWQ5ihnA2i3gW2QGeQIHXfTnRUSgJvJ6JYhcluEVl
	jLGMP+5jh79dk38+nY5/GV+Z+2g1TgNapKFkRHyvflkEUT5QPkt+ySDMmIXjPObBkjG5
	FxzBpP5kTLmRxqC4j7xtBaa3L7EwNA6uRSbymKdO7xrSh/aZwwHuqkKuUXVQZbH2EK9m
	uNekuTGPLhar1Dl9rvQ9XzIZr2KrGgzcAu+d7clb1ThKMX/32gXgNub7VQZfeU4C4UP7
	Kyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=ijwMdb3mu2wUQE5kYs+0ycMiN+VxmgiPFNHxFmoMqwtAeNKG8leUMVAEpL0vLd2Y+t
	EofsvhGK7LhpFGyy97ifQTY4xfQSg3yXJhR5L42Wplfiiy7SmgNUWeG1S9yKJieLVnNx
	wsgQnwjDMM8Tbl0yRYK0VZEhZkfTFZx/OykKkC8VUulctzsLntZkvM1DBpz969QtiLwf
	bPw36DI8hIa140+4qhznFTq1okDmioBSai48CqV+zH3oMso83MRrsEu0i7PIN0kNTR5u
	35UaXQwFHSZSvBA68XtcYKvyRuOMUVfygH+r/zLdgKjqFLPq75iyP30y8dV6v3/gfpPf
	Heeg==
X-Gm-Message-State: APjAAAVWajt0EsJL80fhVP6Cjhov3bMDvGtaMx232k7boWURJNc5j7I/
	+SJsNp7ZcsB8yP6iyb5XlVbIDH2IJyQ=
X-Google-Smtp-Source: APXvYqzHOb6BQY0AS/MelGNgiv+MsvSaQAJ4M3ojJ8IAZCoCFjcom5iTS2+DJRHxK2UbWcN4ETT0dw==
X-Received: by 2002:a62:5e42:: with SMTP id s63mr8247249pfb.78.1557451509230; 
	Thu, 09 May 2019 18:25:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:41 -0700
Message-Id: <20190510012458.22706-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v5 07/24] crypto: Change the
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



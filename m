Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D11C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FA6217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdtUsywC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FA6217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWq7-0008W9-Ex
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:23:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOr-0008Eq-8a
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCE-00084L-3I
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:39 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b]:45668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCD-00083b-Uk
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:38 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id e128so1238772ybc.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=AdtUsywCFarbxNYqrewX5Po7UVveY81UBDxGa+6hX7qZjmyAQLpmsOAIiQ+/l3OcWo
	UzJ5vyffFccwB1+HbqZkdmX64Gn7T5DSajnAayzDOYi/MTcC9r3PH7QdlhsXPC+BRPa6
	30wvqhT4MXq2lPg/bVrNscj+fQzZy2pnMs2z4Sz/wpfObmwKh0HLeJMqSX55bkwtGe1/
	S7mdAtvoZ03aAunGwKwzTPl1CHvFAQSE31/gKOFBf1vTHwU2cxvShhoL0LGy9j/H+uLx
	640Ie3MZPeX7OBCTElgC9CKlqo0CVRCawbszF4VRPubRIIcvP/uQiKm0W8dN28RRfyay
	KNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=z+TkCJ+Ncy1KMgA4q+7eFD+GiqzlCrNmhclplUZOTOM=;
	b=q/D2I5C+CB7TT//syXKuQMP+OV6CR06f6Es1COEeLbRj70O2u9IpItukWKvE9MQcUZ
	/UJm+RlgloulytVk1ELn1x+V+jcFwixsrXjQUYwsPT8E9RcPqIBLOMTjIdSDzhB7sDng
	UlNFiTW1tP6CAB67PIR/IbvNwN7fmo48aKK0ygJcb47wS0G1mTklWItYp36erD7EMiGy
	FSf+oLxTiquhzVqp8U5nDTA2bigSltGiFwdjLk08ywK6D3j5/PWoY20ofg2Wu/w7LFMR
	pytkbO9T/GLhuJJgzfKAH8RO2dJhxPXvKV4qXuvz1Iq14Ck5u56K7Tz8jwuxKNB5nuQl
	5fJw==
X-Gm-Message-State: APjAAAU+0enkcwNSOFQqqpZerC7Ktr2xZF78e3HgWFq6N3zWeLK5+1/Z
	3M4IBLlNbwWhJfmms7l8wyg/SsEee4M=
X-Google-Smtp-Source: APXvYqyKXPfBnn0yk5jIpWn0FfodD8ggVjtRDjV7M9kjN0idlBo1PQcYeXTxq0xRC4hjyQ7eA4J1lA==
X-Received: by 2002:a25:4041:: with SMTP id n62mr2455760yba.388.1558550555780; 
	Wed, 22 May 2019 11:42:35 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:08 -0400
Message-Id: <20190522184226.17871-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2b
Subject: [Qemu-devel] [PULL 07/25] crypto: Change the qcrypto_random_bytes
 buffer type to void*
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
Cc: peter.maydell@linaro.org
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



Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:08:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7574320BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCiZo0TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7574320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJVd-0005BP-26
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTP-000050-1g
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTN-0007gL-CP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22/8j3nSglJouwHuKcmQ4OJ5TmHD2LDjjXggNCdZvbI=;
 b=JCiZo0TI8+992qhNuDeMp+xESNdfC33bWBA7jcPmEmrn0mPCy7EOfixDizhfKVBdvhPQBS
 4eBUm/EZRtSPh9ySLXULqpZG6366PBXq666/o+Fl512VhvFkdhD9ds3tksieKrwAyuCBC7
 /X6q7yu3NA5uSpRBM3HW0w0xx0hOUU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-MCA9rrJEPMKASciiV7urdA-1; Thu, 10 Sep 2020 06:06:30 -0400
X-MC-Unique: MCA9rrJEPMKASciiV7urdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B9464081;
 Thu, 10 Sep 2020 10:06:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8826F1002D5C;
 Thu, 10 Sep 2020 10:06:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] crypto: Rename cipher include files to .c.inc
Date: Thu, 10 Sep 2020 11:06:09 +0100
Message-Id: <20200910100623.1088965-4-berrange@redhat.com>
In-Reply-To: <20200910100623.1088965-1-berrange@redhat.com>
References: <20200910100623.1088965-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

QEMU standard procedure for included c files is to use *.c.inc.
E.g. there are a different set of checks that are applied.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/{cipher-builtin.c => cipher-builtin.c.inc} | 0
 crypto/{cipher-gcrypt.c => cipher-gcrypt.c.inc}   | 0
 crypto/{cipher-nettle.c => cipher-nettle.c.inc}   | 0
 crypto/cipher.c                                   | 6 +++---
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename crypto/{cipher-builtin.c => cipher-builtin.c.inc} (100%)
 rename crypto/{cipher-gcrypt.c => cipher-gcrypt.c.inc} (100%)
 rename crypto/{cipher-nettle.c => cipher-nettle.c.inc} (100%)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c.inc
similarity index 100%
rename from crypto/cipher-builtin.c
rename to crypto/cipher-builtin.c.inc
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.c.inc
similarity index 100%
rename from crypto/cipher-gcrypt.c
rename to crypto/cipher-gcrypt.c.inc
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.c.inc
similarity index 100%
rename from crypto/cipher-nettle.c
rename to crypto/cipher-nettle.c.inc
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 2722dc7d87..005b5da4de 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -151,11 +151,11 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
 
 #ifdef CONFIG_GCRYPT
-#include "cipher-gcrypt.c"
+#include "cipher-gcrypt.c.inc"
 #elif defined CONFIG_NETTLE
-#include "cipher-nettle.c"
+#include "cipher-nettle.c.inc"
 #else
-#include "cipher-builtin.c"
+#include "cipher-builtin.c.inc"
 #endif
 
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-- 
2.26.2



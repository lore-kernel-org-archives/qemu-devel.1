Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D34C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6972F20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTNfyef5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6972F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJUV-00024n-5l
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTU-0000IG-7z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40793
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTS-0007hK-D0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19KEz/DRMwQy3pUnVgUen5fEjahzfLsC3s499xtdYUY=;
 b=jTNfyef5TSZ8MKLEXlMUPrHfUhs3me93aC33HYisOdhDrMVGCIEQDRN/Rp33tmlgJ5c54y
 e6EoFGmOhDp/g41EvuKmdu5W2dMwL7ABu0d4X1tgnUOpWIn8HKJIXC24HevgD364oblqGs
 QTg3qTIMLJpdy6GuCJELrhVfTBetAGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-r64GhKoJNuiCjhXsU8REIg-1; Thu, 10 Sep 2020 06:06:35 -0400
X-MC-Unique: r64GhKoJNuiCjhXsU8REIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7271B8018A1;
 Thu, 10 Sep 2020 10:06:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23E981002D5C;
 Thu, 10 Sep 2020 10:06:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] crypto: Move QCryptoCipherDriver typedef to
 crypto/cipher.h
Date: Thu, 10 Sep 2020 11:06:12 +0100
Message-Id: <20200910100623.1088965-7-berrange@redhat.com>
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Allow the use in QCryptoCipher to be properly typed with
the opaque struct pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipherpriv.h     | 2 --
 include/crypto/cipher.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239f41..9228c9fc3a 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -17,8 +17,6 @@
 
 #include "qapi/qapi-types-crypto.h"
 
-typedef struct QCryptoCipherDriver QCryptoCipherDriver;
-
 struct QCryptoCipherDriver {
     int (*cipher_encrypt)(QCryptoCipher *cipher,
                           const void *in,
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 5928e5ecc7..8a42a683a4 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -24,6 +24,7 @@
 #include "qapi/qapi-types-crypto.h"
 
 typedef struct QCryptoCipher QCryptoCipher;
+typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 
 /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
  * enums defined in qapi/crypto.json */
-- 
2.26.2



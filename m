Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6EC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA8BC20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPRksRww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8BC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWaU-0002yr-Oa
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:07:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOp-0008P8-TZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCG-00085H-1R
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:41 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCE-00084Z-Rk
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:39 -0400
Received: by mail-yb1-xb42.google.com with SMTP id n145so1243674ybg.10
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=mPRksRwwbN/3/077MRePyAeJDUS6P0OM8kpNYghC9BDh8iqyPbzDpUz7JyfVjKF2r5
	PzO+ThcVIwNj4vkL+MISSptc13xDpdNrnH2Kk5xY7t6PsX1/Tdq+NzArtxpU+ZREwmOO
	avkBpZoy2WjVvfrc3sBnqDBrq/IYeXnX/7CF+VUbqx/v99zpLgoi7q6mQkeNa4FwvJe3
	H/oV4yTJVwuPrWIAH9HMV4cqfTVDyVuVQ87KG9GpLqSLiS3Xl0VUmd4ppqayRC/mZbmE
	seTaha8kwb6oqvh0s753pOFFXw3cBz5Yu3n9gQe0VtrCyVokCIPawT8yycTe+COfw1Bo
	NzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DHS+azgDjOz9872pwx2wjM+spw3T8bEncaHuHvbQJSc=;
	b=Po3FnGmjc5GL919yeILDl2C1RbBHnA7KU8hpxDvsNhwuCpqWBmGde1jyI9r5lU/bCg
	FHEMW+WQI+t9UsgcwIl8bV1RUwDznNXjyPdRFujCP2txM/uwDeZS11W+n1gIxCZen2Hn
	71Dm0ecSi1fVelz1GUKqsEnfYCWZIn364cb3RQ/DA94TrkVwZNzkOgf8SxbY7HbHBcOP
	qvSYlBhbOxvn8UUO9+1gsMuR2pMl9KI/SkyN1ES80L+cMNY1Po0hDqQ9Gix67np62Uld
	UJL7KoCn1aoDSx7W3JtX+J33V5W52g9O9Nz4eppZZ++zBJeG0bT3FalmHc3FetquOgJh
	W41g==
X-Gm-Message-State: APjAAAVWLJ4KhKY+ih1P066gnANICVEQiW19SlGf3jahUeTJCW98c/Mz
	AWyQJ2UpOFi+KIu674enXKnkeAjXcwU=
X-Google-Smtp-Source: APXvYqy+CCBlIiTbLEMtyuGul9Jwf9V3w8aGGL+xmMK1hGZLmVRC8f/cnOcSzDv/SSrUV85yVQ2WcQ==
X-Received: by 2002:a25:b18e:: with SMTP id h14mr8631012ybj.18.1558550557978; 
	Wed, 22 May 2019 11:42:37 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:10 -0400
Message-Id: <20190522184226.17871-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [PULL 09/25] ui/vnc: Use gcrypto_random_bytes for
 start_auth_vnc
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

Use a better interface for random numbers than rand().
Fail gracefully if for some reason we cannot use the crypto system.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ui/vnc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 785edf3af1..d83f4a6ff9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -43,6 +43,7 @@
 #include "crypto/hash.h"
 #include "crypto/tlscredsanon.h"
 #include "crypto/tlscredsx509.h"
+#include "crypto/random.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
 #include "io/dns-resolver.h"
@@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
     vnc_client_error(vs);
 }
 
-static void make_challenge(VncState *vs)
-{
-    int i;
-
-    srand(time(NULL)+getpid()+getpid()*987654+rand());
-
-    for (i = 0 ; i < sizeof(vs->challenge) ; i++)
-        vs->challenge[i] = (int) (256.0*rand()/(RAND_MAX+1.0));
-}
-
 static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
 {
     unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
@@ -2628,7 +2619,16 @@ reject:
 
 void start_auth_vnc(VncState *vs)
 {
-    make_challenge(vs);
+    Error *err = NULL;
+
+    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
+        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
+                            error_get_pretty(err));
+        error_free(err);
+        authentication_failed(vs);
+        return;
+    }
+
     /* Send client a 'random' challenge */
     vnc_write(vs, vs->challenge, sizeof(vs->challenge));
     vnc_flush(vs);
-- 
2.17.1



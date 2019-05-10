Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF4C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B930217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 01:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2g1Rits"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B930217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35178 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOuUy-0001iz-Ap
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 21:38:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHk-0006Ix-Ra
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOuHj-00014l-GS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOuHj-000111-78
	for qemu-devel@nongnu.org; Thu, 09 May 2019 21:25:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so2107040pgi.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 18:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=y2g1Rits7EabH8URhQFjlCxR1PX6UaETo8kTzAGIRREYFBIZkP2TCQ49d1BSYqHqtS
	aaysfVPPg3je/PAHExurerfrD0QFHLhLpB5eXTX9Bm2gM9o4/0rhrOMlpwRWHmTCbCVy
	jszUfwcTN7/MIN6guL5HuSMmYSxSX/oC/fNYdq3QtziEZh/nYMRY7F2W2y2JeR2TsPs8
	zYz/ePlmNOZsJKzrS9mqlrxW7n6z/p6f0/6Bd1m9Ilezils2ZX4PREW41Yp5zEvdONKx
	AuNKrd7a8FIbr9aWBXNFnCN3b+uPqj3JVnypRlEFitBS0y1MbfjrtAHcOmklgT2EfW4U
	fIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=GzZ6sdsQnCxaP08WJJVqg6PJeegbCSKeJSjuYCKexO9rjX+Dr5eXHngzl6IAyzwI/V
	0o6PIj5z5wF3XNBoPVORTvjuBDC+RD1uQfzz3axtmU7K4vfPIGaVe9++oWayecwAimOI
	cm4ZuIoM1zH4SIVpwEKm49Qc/1jM4jAlXzyPMnEULV1BHfzT2HBkE4VExzMeAJhGXxPk
	LJc62QOib5ddwwByZRffPC7xcMYh80tigz+rRAJ2YehoZseQ/8V51NBCub7zPCkgMOEO
	W4N2VYxXdGeaaP+OZUlesUKTzQLCdVPA+oN/ucBrxIbQ+Ij/7Zu60chlSzmtz1fMv1W8
	6Geg==
X-Gm-Message-State: APjAAAWz3ujSzbDI1YJdS6ds1Jv2j9jyEYFx8m+7eNSsZdIqLLn0Oesa
	OaMsp6jBX8jdsifxjaQPmYBM3dW3epE=
X-Google-Smtp-Source: APXvYqzxuyYLJuZmBmSx7iacMf+VKOhl5ts7mc9bEJY4jgbjkuwNdKD9dgXFEXC+QnhiC2iZTMG53Q==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr10156834pff.135.1557451510326; 
	Thu, 09 May 2019 18:25:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	n18sm8252700pfi.48.2019.05.09.18.25.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 18:25:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 18:24:42 -0700
Message-Id: <20190510012458.22706-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510012458.22706-1-richard.henderson@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v5 08/24] ui/vnc: Split out
 authentication_failed
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

There were 3 copies of this code, one of which used the wrong
data size for the failure indicator.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 ui/vnc.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 1871422e1d..785edf3af1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2535,6 +2535,18 @@ void start_client_init(VncState *vs)
     vnc_read_when(vs, protocol_client_init, 1);
 }
 
+static void authentication_failed(VncState *vs)
+{
+    vnc_write_u32(vs, 1); /* Reject auth */
+    if (vs->minor >= 8) {
+        static const char err[] = "Authentication failed";
+        vnc_write_u32(vs, sizeof(err));
+        vnc_write(vs, err, sizeof(err));
+    }
+    vnc_flush(vs);
+    vnc_client_error(vs);
+}
+
 static void make_challenge(VncState *vs)
 {
     int i;
@@ -2609,14 +2621,7 @@ static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size_t len)
     return 0;
 
 reject:
-    vnc_write_u32(vs, 1); /* Reject auth */
-    if (vs->minor >= 8) {
-        static const char err[] = "Authentication failed";
-        vnc_write_u32(vs, sizeof(err));
-        vnc_write(vs, err, sizeof(err));
-    }
-    vnc_flush(vs);
-    vnc_client_error(vs);
+    authentication_failed(vs);
     qcrypto_cipher_free(cipher);
     return 0;
 }
@@ -2638,13 +2643,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
      * must pick the one we sent. Verify this */
     if (data[0] != vs->auth) { /* Reject auth */
        trace_vnc_auth_reject(vs, vs->auth, (int)data[0]);
-       vnc_write_u32(vs, 1);
-       if (vs->minor >= 8) {
-           static const char err[] = "Authentication failed";
-           vnc_write_u32(vs, sizeof(err));
-           vnc_write(vs, err, sizeof(err));
-       }
-       vnc_client_error(vs);
+       authentication_failed(vs);
     } else { /* Accept requested auth */
        trace_vnc_auth_start(vs, vs->auth);
        switch (vs->auth) {
@@ -2673,13 +2672,7 @@ static int protocol_client_auth(VncState *vs, uint8_t *data, size_t len)
 
        default: /* Should not be possible, but just in case */
            trace_vnc_auth_fail(vs, vs->auth, "Unhandled auth method", "");
-           vnc_write_u8(vs, 1);
-           if (vs->minor >= 8) {
-               static const char err[] = "Authentication failed";
-               vnc_write_u32(vs, sizeof(err));
-               vnc_write(vs, err, sizeof(err));
-           }
-           vnc_client_error(vs);
+           authentication_failed(vs);
        }
     }
     return 0;
-- 
2.17.1



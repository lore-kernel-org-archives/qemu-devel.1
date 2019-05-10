Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E00C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525C7217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkucTqx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525C7217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9UQ-0006Az-GI
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:39:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MN-0007O8-Gi
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MM-000635-IY
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MM-00062e-Cf
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:02 -0400
Received: by mail-pg1-x543.google.com with SMTP id t187so3317134pgb.13
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=ZkucTqx1ygwD5C7Hj7PhsTB7jxIMlQ6e2F/EH6+aLcbGpH8Lak2jiwj+iX0sjdFPK2
	v+tjvLeqFnN53/nOHpGuIJ+zNdtZpEUabe8zw8WkItXLIt0qlNMkV8pPBgTDplvJH8N2
	R4KdhQfH4Snnhsw6CC9NnfXxLiucvRsPUAikqaeUWnWTfy9Cj3RipAXKXohkQrV105dB
	bF/2yFL/yE/LXlQjBTPDBoRln0PGeevBO+BvGbIKBoHnMla0CMtwdpP14b88GjFMsqZU
	zBOp6hnXGav/NKaoty5Et1ZQ8wZ579pKYezO97/EvOGEXgJIda+F5xbMJ33g78m67Zoy
	RzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=zQEKMjfpCTDyJlIECnLYp610ugeuDB8/XWCLVFEbpkI=;
	b=jNYA32t9dFW+QxWmsYjqFaPS7jQQ6ttlZPHrR7ADfVkV5qPeMUIlT3zmXpz2INnosT
	Pcj59oKQwu20Q95zuzFfpx2JhOWiNMGgj4uhdQmGnxIInKxcRhgykc4jBiFZBECuFzql
	JorXstLW07cH9M/8peNF1Dp/tvTkee6QSYqzRH9TbqHNj/QtZA7ZF7CUzodfI5n8SSLS
	89qf1+OgUaEfW0OostbKd80e4G36+Nz4CNzRcl7FXTkOHwnNj/i1w0jP165a4XdNcO9q
	uGn1LMhoP5/Xmw2uXjChnONgQIvLoKBz7VWstrp+P3geW424lIfUTmXw+Z3AnP263z2i
	dOfA==
X-Gm-Message-State: APjAAAXwy/TFm+LcMdkV7eGUh2Yq6cl5gCp4AG0b1BAuqB462VQCsETd
	/tUnXWUL4HfC73eRC6k5e2LuLAazEy4=
X-Google-Smtp-Source: APXvYqweiFPe2mQ2M+2Tzxxwd70ivNWbSJ4t+uMFoAz4G5y7bnRO0dQtYhtvlfZqvz8B0vWmg2/YwQ==
X-Received: by 2002:aa7:9356:: with SMTP id 22mr15760191pfn.188.1557509461094; 
	Fri, 10 May 2019 10:31:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:32 -0700
Message-Id: <20190510173049.28171-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v6 08/25] ui/vnc: Split out
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



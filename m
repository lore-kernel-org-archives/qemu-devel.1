Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84010C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538842084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGyAIple"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538842084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82hP-0004Zs-CB
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fz-0003Ja-3r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1i82fy-00026B-1f
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:51 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:44887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1i82fx-00025v-Rv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:28:50 -0400
Received: by mail-ed1-x543.google.com with SMTP id p2so19439868edx.11
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 06:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pHX+56qH2ZwoTB579TAA15MpZKo/s5P4WenS+gMTRWg=;
 b=MGyAIpleehtxH6pdx2yq4RyY+Z8pj2XFpfb8d9DVnyI/aC+qAtPTl37I1a/H+h1xom
 ZTOcfa5ixU67yj3WKIQrrfG8uehxWsdoFfdsJojvQGiXGESZHgDR03aw5BdRUCIFtTzQ
 N2j3axT+bIS1Q9Jfr/tj6rZP7WuD8k3jtS7tnw15lqzvPtRptx5+yf5eCGLaj+GOQ8mH
 FqW6+Tj8t+KvsRT+FMTGmsCXSiUzG9334AH3Z70ekolrbEemKODjG/ukFc/c2/TNjPVP
 VI2kjAR5UTCaPOnIa/9bNmtvEBBbWazG8qEuhL3BII0/RbGMDzX9EOX6ST+JUmpNhG2J
 wR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pHX+56qH2ZwoTB579TAA15MpZKo/s5P4WenS+gMTRWg=;
 b=HIB8nDvwTEmpgbhScvgaChPBrlp/x7FTv8UL7WAp+KkCp2S552xMyYmbOLpx9Eekig
 L7RS+GDzJ9PBbAIdYWOUAkdlzNnUM+7tMg1lA7fQFCKRha4tdW94HdolxYKEgfZBJsVc
 1TZk1Oxix2DVaUqDt/Um4HzXjICO8RLhtFDJZ9MNczvn1xrlKuC/Ltw3gRlKOqqAyeSK
 M69JIMwylV3PvIJ6/kTbi/K0Qb/Lw4zYeDD3Bk/3i6D9k6RzuauB7Ad6Kn1u9pfVDfAD
 PNM6bRBHMuxIL/gBBRYeYsdk9Q4gMurmmVIOy+Y60zHCezyHSxtzgn0GcowtBnC6IlqT
 FEwg==
X-Gm-Message-State: APjAAAUQuqSYWqNfNXFi6UB50HKklcN7W3Oz1xa1hAphb5mvwiRAYPzy
 V5o/vC5/oS9uxdawJ1gJTxaWkafY
X-Google-Smtp-Source: APXvYqx0KI5xzVhsptG+WBnyra6WRiiVluZzUw77ymZ2Q5mtcu2CGnpxS41TvgLq4TnhyFt34miGrQ==
X-Received: by 2002:a50:8933:: with SMTP id e48mr2963617ede.51.1568208528694; 
 Wed, 11 Sep 2019 06:28:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id g21sm4092827edv.0.2019.09.11.06.28.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Sep 2019 06:28:48 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 13:28:39 +0000
Message-Id: <20190911132839.23336-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190911132839.23336-1-richard.weiyang@gmail.com>
References: <20190911132839.23336-1-richard.weiyang@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: [Qemu-devel] [PATCH V2 2/2] migration/qemu-file: fix potential buf
 waste for extra buf_index adjustment
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

In add_to_iovec(), qemu_fflush() will be called if iovec is full. If
this happens, buf_index is reset. Currently, this is not checked and
buf_index would always been adjust with buf size.

This is not harmful, but will waste some space in file buffer.

This patch make add_to_iovec() return 1 when it has flushed the file.
Then the caller could check the return value to see whether it is
necessary to adjust the buf_index any more.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---
v2:
   * wrap these common steps into add_buf_to_iovec()
---
 migration/qemu-file.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 47f16d0e54..417eeba64b 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -382,8 +382,16 @@ int qemu_fclose(QEMUFile *f)
     return ret;
 }
 
-static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
-                         bool may_free)
+/*
+ * Add buf to iovec. Do flush if iovec is full.
+ *
+ * Return values:
+ * 1 iovec is full and flushed
+ * 0 iovec is not flushed
+ *
+ */
+static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
+                        bool may_free)
 {
     /* check for adjacent buffer and coalesce them */
     if (f->iovcnt > 0 && buf == f->iov[f->iovcnt - 1].iov_base +
@@ -401,6 +409,19 @@ static void add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
 
     if (f->iovcnt >= MAX_IOV_SIZE) {
         qemu_fflush(f);
+        return 1;
+    }
+
+    return 0;
+}
+
+static void add_buf_to_iovec(QEMUFile *f, size_t len)
+{
+    if (!add_to_iovec(f, f->buf + f->buf_index, len, false)) {
+        f->buf_index += len;
+        if (f->buf_index == IO_BUF_SIZE) {
+            qemu_fflush(f);
+        }
     }
 }
 
@@ -430,11 +451,7 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
         }
         memcpy(f->buf + f->buf_index, buf, l);
         f->bytes_xfer += l;
-        add_to_iovec(f, f->buf + f->buf_index, l, false);
-        f->buf_index += l;
-        if (f->buf_index == IO_BUF_SIZE) {
-            qemu_fflush(f);
-        }
+        add_buf_to_iovec(f, l);
         if (qemu_file_get_error(f)) {
             break;
         }
@@ -451,11 +468,7 @@ void qemu_put_byte(QEMUFile *f, int v)
 
     f->buf[f->buf_index] = v;
     f->bytes_xfer++;
-    add_to_iovec(f, f->buf + f->buf_index, 1, false);
-    f->buf_index++;
-    if (f->buf_index == IO_BUF_SIZE) {
-        qemu_fflush(f);
-    }
+    add_buf_to_iovec(f, 1);
 }
 
 void qemu_file_skip(QEMUFile *f, int size)
@@ -761,11 +774,7 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
     }
 
     qemu_put_be32(f, blen);
-    add_to_iovec(f, f->buf + f->buf_index, blen, false);
-    f->buf_index += blen;
-    if (f->buf_index == IO_BUF_SIZE) {
-        qemu_fflush(f);
-    }
+    add_buf_to_iovec(f, blen);
     return blen + sizeof(int32_t);
 }
 
-- 
2.15.1



Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D9C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABAF208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6ArrT20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABAF208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXHU-0003Ae-Kn
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4B-00025s-6q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX49-0004CU-PK
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:27 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:46975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX48-0004BY-SC; Mon, 06 Jan 2020 13:25:24 -0500
Received: by mail-qk1-x744.google.com with SMTP id r14so40253712qke.13;
 Mon, 06 Jan 2020 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pow/5Z2bAbGCDH4hbr5Mur0CSZ4ZY/agAkg/ACDkDZ0=;
 b=O6ArrT20JB0/YZXuReV5drE66ncq7KfKgtG8G6AlTLIwqMGmnO475rEpkucFjrTPYv
 wWARQwKOSDhQsCDhiekVFrmO9KCiTzr5Kat9RVZvE/NmDWVJQwaV0k+1h0X5dW91CeC+
 DW72POEdFxKAMJFPhBT7FRlaqXxypExV/pSz1beW5g619qBGgdvMyV53OglJbIpUCv14
 Yu7i0l8Y7/gZ7jupfhBRdeFWFGeXxBeP6WE1Ml1p1JVXVfbv5pJ+8l0cVwznBy5d+cLK
 tqeCFjbQ4QIpvVna6eblN3TddJ8xY/0soEHHUYff8uYqHHxVpeLlWt3h+De1ZEhSQu/q
 plOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pow/5Z2bAbGCDH4hbr5Mur0CSZ4ZY/agAkg/ACDkDZ0=;
 b=H4hINKhTWqJNtiSPQJoxV9D3x2SQnyclyhrzqvHV81w8kw0dvQO5YDuGiUWYb995PT
 xnTnWYYwrp5YD0eloq5+3BSbaYd7IeP76hYi7Gd5fepv+zuqhzqlMscVaOknmSXMLuEj
 4vqUZu4pe9mjoF06d+X/rSv4ogUWGVpuboj2wTfaojgLkW+oQ1/BubappQgKI/GOGeKo
 yFNRWDU09gaXMlKbkfRRQTHlHwyOo0nGCjfE+lNtxOswjKtXWMo7nWazxNk+cWwhaE+7
 5AVnCH2Xj2r3Mx2TMY7OjIKgrKblpvXh5vhgoqmdLtWHhExRTRw22hkxchMU2IVSULBs
 ppnw==
X-Gm-Message-State: APjAAAXdDBzmmOzcZ3glkJNxLU1tOFTh5OLA17yEJKHOY2YudC26Ywkk
 nRU8M+jqxYaU/mt0v90lYo46voHx
X-Google-Smtp-Source: APXvYqwTQSm0S+pxsKqQKEDTkChAA5zcEGP4fQuGs0g4MI6u+vnRzeP0qhLoy59GQyQd/aUTo8xhvw==
X-Received: by 2002:a05:620a:6b8:: with SMTP id
 i24mr86399499qkh.9.1578335124342; 
 Mon, 06 Jan 2020 10:25:24 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:24 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 18/59] qcow2-refcount.c: remove unneeded 'fail' label in
 qcow2_refcount_init()
Date: Mon,  6 Jan 2020 15:23:44 -0300
Message-Id: <20200106182425.20312-19-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'fail' label can be replaced by 'return ret' and 'return -ENOMEM'
calls.

CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: qemu-block@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/qcow2-refcount.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..1fe66677d1 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -111,22 +111,19 @@ int qcow2_refcount_init(BlockDriverState *bs)
 
     if (s->refcount_table_size > 0) {
         if (s->refcount_table == NULL) {
-            ret = -ENOMEM;
-            goto fail;
+            return -ENOMEM;
         }
         BLKDBG_EVENT(bs->file, BLKDBG_REFTABLE_LOAD);
         ret = bdrv_pread(bs->file, s->refcount_table_offset,
                          s->refcount_table, refcount_table_size2);
         if (ret < 0) {
-            goto fail;
+            return ret;
         }
         for(i = 0; i < s->refcount_table_size; i++)
             be64_to_cpus(&s->refcount_table[i]);
         update_max_refcount_table_index(s);
     }
     return 0;
- fail:
-    return ret;
 }
 
 void qcow2_refcount_close(BlockDriverState *bs)
-- 
2.24.1



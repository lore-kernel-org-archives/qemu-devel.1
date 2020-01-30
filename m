Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271DA2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhCyK3jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271DA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHdR-0005wr-At
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ixHX2-0003S1-Jl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ixHX1-0001WI-FF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:24 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ixHX1-0001Sn-B2; Thu, 30 Jan 2020 16:39:23 -0500
Received: by mail-qk1-x744.google.com with SMTP id j20so4499590qka.10;
 Thu, 30 Jan 2020 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aYZBLLNRu3YFcgNICbDH2tSO88Vv+b9q9C7iEzpwyPc=;
 b=dhCyK3jwn9dwQsm71wGRlprzheln3ZoEJ+9qPRaBln8b3WSe5BcJps/28qjyjbLXL1
 +FCDLF5SzAZ8KKDhqIIcclUATgLVL5cs4XS5S9YkPhZ01GzH1/41Sfm6rzYtgVCLSYrZ
 /Uwmgoew1zZuraWdxiDtskg9C0QfZpSD+LhQas8bFk+s10eHqeU/o/EpD/QWuKtG5wdG
 f/ohCdBsU7gG5k64IpM3wM6nnEl3sIQwnCBDryPvRiAt7eGoUMNmVr+Txipx7Riqcwa7
 hP52AmXlb1pv5CJ3vh87KdrgNbAhzHlmh+3YRcc0rHNzdRfikB9iKWN4s82QkEjvv1y/
 N3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aYZBLLNRu3YFcgNICbDH2tSO88Vv+b9q9C7iEzpwyPc=;
 b=iOcyx8Eluns00a1zTC0wp0xabSMqVTW87vQ5l0fGSyPtFH4ASivTFR0d4wnRNiWN5b
 dITAvc8/wJW5JWoFaLgfx/pUBYzgg4GAla9d2V0IiX2/cjKOca2qjpriDfL3ad3kXXwj
 KvA1xdd28xIf/QOEmhwpsFngd/lKMJ4to6jebcwkzLIhOHjUgAI2BAxKarbvazWpoZTd
 iPwXgvD68d0m2K7AV+bMH91yVAJWwPR3WiCe3+zeFEQR/ZHQsY1q1Z+Wp5NcsgWVcald
 Xc8DIFRiMhZI2YBwV7qq5vsmmN7PczdUrrTDtksaJEUCODVLgwer2bgMUbkbPI8GpECj
 rkTQ==
X-Gm-Message-State: APjAAAXmX5f6n0LyHW0R56itneJV3ljf43mk1OW9YvOYBmRnCq2QLPsN
 RxcuHFshUUr3+NI2gN2cWgTTzcnN
X-Google-Smtp-Source: APXvYqyOvaVUzhwczteurBygaAyKmE2jxlOFbgzeJEwPFg7jPyeaoi2jDI9nkoysstRh8+LVfncnHw==
X-Received: by 2002:a05:620a:2010:: with SMTP id
 c16mr7338388qka.386.1580420361631; 
 Thu, 30 Jan 2020 13:39:21 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id f26sm3650597qtv.77.2020.01.30.13.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 13:39:21 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
Date: Thu, 30 Jan 2020 18:39:06 -0300
Message-Id: <20200130213907.2830642-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
References: <20200130213907.2830642-1-danielhb413@gmail.com>
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Srikanth Aithal <bssrikanth@in.ibm.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using a non-UTF8 secret to create a volume using qemu-img, the
following error happens:

$ qemu-img create -f luks --object secret,id=vol_1_encrypt0,file=vol_resize_pool.vol_1.secret.qzVQrI -o key-secret=vol_1_encrypt0 /var/tmp/pool_target/vol_1 10240K

Formatting '/var/tmp/pool_target/vol_1', fmt=luks size=10485760 key-secret=vol_1_encrypt0
qemu-img: /var/tmp/pool_target/vol_1: Data from secret vol_1_encrypt0 is not valid UTF-8

However, the created file '/var/tmp/pool_target/vol_1' is left behind in the
file system after the failure. This behavior can be observed when creating
the volume using Libvirt, via 'virsh vol-create', and then getting "volume
target path already exist" errors when trying to re-create the volume.

The volume file is created inside block_crypto_co_create_opts_luks(), in
block/crypto.c. If the bdrv_create_file() call is successful but any
succeeding step fails*, the existing 'fail' label does not take into
account the created file, leaving it behind.

This patch changes block_crypto_co_create_opts_luks() to delete
'filename' in case of failure. A failure in this point means that
the volume is now truncated/corrupted, so even if 'filename' was an
existing volume before calling qemu-img, it is now unusable. Deleting
the file it is not much worse than leaving it in the filesystem in
this scenario, and we don't have to deal with checking the file
pre-existence in the code.

* in our case, block_crypto_co_create_generic calls qcrypto_block_create,
which calls qcrypto_block_luks_create, and this function fails when
calling qcrypto_secret_lookup_as_utf8.

Reported-by: Srikanth Aithal <bssrikanth@in.ibm.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/crypto.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..00e8ec537d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -596,6 +597,23 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
 
     ret = 0;
 fail:
+    /*
+     * If an error occurred, delete 'filename'. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret && bs) {
+        Error *local_delete_err = NULL;
+        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * the 'bdrv_co_delete_file' interface. This is a predictable
+         * scenario and shouldn't be reported back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP)) {
+            error_report_err(local_delete_err);
+        }
+    }
+
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
-- 
2.24.1



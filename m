Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1628C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1CE21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLaUpvx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1CE21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMqN-0001E1-36
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hvMoq-00067D-FY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hvMop-000076-AA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:36 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:34685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hvMop-00006x-5q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:35 -0400
Received: by mail-qt1-x842.google.com with SMTP id k10so19333533qtq.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dGfD+OKaAJtklYlmiZJfVWpoqCv42S59cVjzwBeRJNs=;
 b=fLaUpvx+YTXTwSrSe/iAG0Z7uSXo7Wcgu4E24TBm/UxIfq8POpcJqdfiuTRvX9qj0T
 D6klQjWfclW1ugpsxa90cjxRH0UPoXToibXlZ97+bCAQx7cmIGjNmyqFFPvS8lnPtbjy
 b4+DGYcMBePyMOjTjskvRJHvyVldEICdbuAFToUgeejyhsnHf7V94VFD+V1ry73cODxz
 TAyoze6y3dn2h2aaCTjoYox6oOlUSP42XTbF09Nk+k8cxhUn+6/m69zosYdYgQaGVUsL
 dQsR3wilDq4pkcqENBDtFBw50dmExmY/ylQ9auzzSIRuU0DUgC0unwCOw1LCRelYWxPb
 JEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dGfD+OKaAJtklYlmiZJfVWpoqCv42S59cVjzwBeRJNs=;
 b=Or33CUo2rDvdoQRiylAv7dCICyKOTQ6BgTri14+9sLQaABzLu8NxIW7RPr5ajdDK+E
 m2NksVpkwQq3rT7hOTgrC60zmeB09c3PVlwzlFOxhqzkA6NOwO9CoUVkSaX9B21v4PIQ
 ObyGeh4N8DscsaNTP3IWsZ0NiHIQkaoe1WVjnHoYGoUUWerzdFl9gHoM0QzBd82i8uBm
 0HGeG6rP+Y1tCMR+UnxvqvLRBRiS4fZzUMY1myJ0KNqfWrk5ghQiPXU/tHiYAwf4VWJ0
 MOk3uYn7MRd7UqwQWQEckX5hjS+Lbgclc3rDm5RtbrbkPOBuWS/Qy/OZwoBzj2Ek/tzb
 oWPw==
X-Gm-Message-State: APjAAAVOWPuK6otuE2EJ4+RJYwdoRKmgoXE9Q+Xh2XFGd8bH8opdbGME
 7cIKLPkAp7YSijw0tYmBsFPpULFi
X-Google-Smtp-Source: APXvYqwDxuCSHvRbxW42whOvF1eLZbuBwmtBfH2LmZ7I+ICRCKOilf7wV2xsxC1VIRmeqhibqa10IA==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr8248597qti.72.1565187694567;
 Wed, 07 Aug 2019 07:21:34 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id e18sm31472034qkm.49.2019.08.07.07.21.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:21:34 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 11:21:13 -0300
Message-Id: <20190807142114.17569-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807142114.17569-1-danielhb413@gmail.com>
References: <20190807142114.17569-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v5 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, berrange@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, mreitz@redhat.com,
 Srikanth Aithal <bssrikanth@in.ibm.com>, jsnow@redhat.com
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
 block/crypto.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..8ffca81df6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -575,6 +576,25 @@ fail:
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
+
+    /*
+     * If an error occurred, delete the file. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret) {
+        Error *local_err;
+        int r_del = bdrv_delete_file(filename, &local_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * 'bdrv_co_delete_file'. ENOENT will happen if the file
+         * doesn't exist. Both are predictable and shouldn't be
+         * reported back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP) && (r_del != -ENOENT)) {
+            error_reportf_err(local_err, "%s: ", bs->filename);
+        }
+    }
+
     return ret;
 }
 
-- 
2.21.0



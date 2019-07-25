Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1720C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D56C20840
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNtDbLcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56C20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaXA-0007Jh-Ni
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46929)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hqaWz-0006uq-Ui
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hqaWy-0003HU-Tz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hqaWy-0003Gt-NK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:59:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id z1so50051283wru.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OzlZKSZ0puaqzc/KZY+YYshwgMEAsbAGs4Z9IOdUNaM=;
 b=kNtDbLcOFn462rz8LBONOmpLHcXD933RkP4xYFtIzRevKRLXqcVpNVGCQ+biXlTe4g
 lBelp/CynFLyaIsPZo8hdtsDcz8+Shr5O2pSHn2wtFbwNMS3ThtmZD+GqScJLcAVYQNp
 fg8dRP4Ierjtdl3PsMY1GR8i8JtGq6FpUbR/G1MTOen51U+TPRs9avKNr5T+Uobg+fUx
 0Hlrh70Iu2l+zdF/wuSxnj6364EhNdK34JbhIrvZ+i6tC6tOP1AezA/KkA3cpCJfX30N
 srrHrEk2/JroDWcURAAL5FAfELSFzGph3Py0IKCfhPMtJunPV9323+6SGtB1SlCCoezR
 OCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=OzlZKSZ0puaqzc/KZY+YYshwgMEAsbAGs4Z9IOdUNaM=;
 b=GQEXXRop5KYutMUWIJNCUwLLV17hAvfqasYnYtlclIfUV7kjwK3amkIfr2iTVpIUYC
 6ZMP1t+hh6TfQoyRBHPHJxjHZ1h1HKUXEGzOIWaXLRGR2+P1xrZsvq/fCuW0E6Hfl0+R
 dcbR/TEZiP07KhODzo6Z7MGA/es+KUWAVO3/vM8qPrVlViTtu5AeRrTUc2lsLF9SdWkq
 zW0xx70ocG8K+1jqZSAnLzEDgAOCx0A8rBWbbuKQgA40VzU9eUhzAfWcE4yuYfSTZ3P7
 +/p4F5xyClPM3kVFdcxnDT7KH2UFABXXvXYlKTP9waHZLsXZd7H+dRvLsp/WDtM714Pj
 2Acw==
X-Gm-Message-State: APjAAAXvPNGvPRRz7Mv4sAG/jzHfhRgOi2JCbofE/aLXbOjdagK7sdhl
 QXFGG5ACkV9mnqD6SKbsxAJTj6/b3Sg=
X-Google-Smtp-Source: APXvYqwJvBZ3+AO3rpWDSwWrmYw7CsELF4nPJbzclDDu37LfwqqttqBTzUHc2wtx/WL0lRzG7IvpaA==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr44880272wrv.128.1564048762437; 
 Thu, 25 Jul 2019 02:59:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id
 d10sm40221726wrx.34.2019.07.25.02.59.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 02:59:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:59:20 +0200
Message-Id: <20190725095920.28419-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH] block: fix NetBSD qemu-iotests failure
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Opening a block device on NetBSD has an additional step compared to other OSes,
corresponding to raw_normalize_devicepath.  The error message in that function
is slightly different from that in raw_open_common and this was causing spurious
failures in qemu-iotests.  However, in general it is not important to know what
exact step was failing, for example in the qemu-iotests case the error message
contains the fairly unequivocal "No such file or directory" text from strerror.
We can thus fix the failures by standardizing on a single error message for
both raw_open_common and raw_normalize_devicepath; in fact, we can even
use error_setg_file_open to make sure the error message is the same as in
the rest of QEMU.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 73a001ceb7..a2089b1f87 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -217,7 +217,7 @@ static int raw_normalize_devicepath(const char **filename, Error **errp)
     fname = *filename;
     dp = strrchr(fname, '/');
     if (lstat(fname, &sb) < 0) {
-        error_setg_errno(errp, errno, "%s: stat failed", fname);
+        error_setg_file_open(errp, errno, fname);
         return -errno;
     }
 
@@ -547,7 +547,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     ret = fd < 0 ? -errno : 0;
 
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not open '%s'", filename);
+        error_setg_file_open(errp, -ret, filename);
         if (ret == -EROFS) {
             ret = -EACCES;
         }
-- 
2.21.0



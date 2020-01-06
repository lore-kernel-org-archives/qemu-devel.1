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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8916AC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53631208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnwIgj7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53631208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXM4-0001hQ-RX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX44-0001zH-P6
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX43-00046c-Mm
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:20 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:45614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX43-00046G-Ih; Mon, 06 Jan 2020 13:25:19 -0500
Received: by mail-qv1-xf41.google.com with SMTP id l14so19415266qvu.12;
 Mon, 06 Jan 2020 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hSgP8NRncEIEX6pPa78Nm0OrXSlmyhM+fq2uskBfwUQ=;
 b=PnwIgj7Mss+7c3FRHg/gxnuuuKT8VRVeMsMvCbh1H4EGvXB3DM2fzXTh5jB0Rkh2Nn
 JCW4h8jtc19hRCb2cAOxvhCJC05xHS92i2Zm+j5y/OZJwI+goDz5791lDCJwzm5ERSeH
 WyEgduHpVUIVR6CNKpZSeLfVr8/wH9iGgMwLxf7nhDIEiTcm2Wxk0kgicREh0VB+jcE3
 /wsN8ac/2tnyy0LXicEg4VGn+YEY9hzwjeI1TBRwY7YeDZm2TgQLxbuwAVScuhpewABw
 MdJWkCG0Rn0e1e7Z310As33vFUSeFS0x4GdRDnDesE1Yn78gGk2VZMB5VhNk0wq8/8nl
 3ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hSgP8NRncEIEX6pPa78Nm0OrXSlmyhM+fq2uskBfwUQ=;
 b=DGuWTI4uDeeyoIWwxJ7jx6Y5Nquo7EUUV1bUzWQmoQEELbv6gIfvzOFwJ/+W8kpoDF
 v7gm7/3Zs0QDU+5NePMSz/U+LrygWULskNSKjI8p2bzJO9U0gNKz/fUiZhY/axUwwi0p
 3hrQ+xPZESr2hlXcCy8JW4lvB8Qr4eZUHAGG5RYvv3aD3abII59iCBdLBgbT1yRvzpCt
 8UPd51Tli28FwjroUTXXr45a8xsJmSENZEv94/mpzMzG3XT9lH+TPjZ4B4ypX3t+4Ub2
 x+Xybzzl5sRO1O2TQvJ3pK37AbOEDUQMCJRz+IJe8QIs297XiRlZYpPc6sv/jqBDlDAB
 RtOA==
X-Gm-Message-State: APjAAAUPkRzRp7jf65vPj0r9qql3eFHPcyx+g3CiOR98yzPcf2Iyx4Y3
 TS6c81Gzui2WyfhNmOpTgCwYiq6l
X-Google-Smtp-Source: APXvYqxX16Cv1Akxg3pbiFk+LwU7ID3SXP4GXRzIaaySsTIEkjSILzEueIMKSMxhXeNKoZzSZuNfdA==
X-Received: by 2002:a0c:8bd2:: with SMTP id a18mr53137941qvc.38.1578335118942; 
 Mon, 06 Jan 2020 10:25:18 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:18 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 15/59] block/blkreplay.c: remove unneeded 'fail' label in
 blkreplay_open()
Date: Mon,  6 Jan 2020 15:23:41 -0300
Message-Id: <20200106182425.20312-16-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both the 'fail' label and the 'ret' variable can be removed.
Use 'return -EINVAL' in the error condition and 'return 0' in
the end of the function.

CC: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/blkreplay.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..d8c4c311f3 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -24,23 +24,19 @@ static int blkreplay_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
     Error *local_err = NULL;
-    int ret;
 
     /* Open the image file */
     bs->file = bdrv_open_child(NULL, options, "image",
                                bs, &child_file, false, &local_err);
     if (local_err) {
-        ret = -EINVAL;
         error_propagate(errp, local_err);
-        goto fail;
+        return -EINVAL;
     }
 
     bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
     bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED;
 
-    ret = 0;
-fail:
-    return ret;
+    return 0;
 }
 
 static int64_t blkreplay_getlength(BlockDriverState *bs)
-- 
2.24.1



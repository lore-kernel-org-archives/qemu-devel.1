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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED77C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A854E208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV2233OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A854E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXIL-0004Yb-AH
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4P-0002R3-5p
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4N-0004Qv-Md
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:40 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4N-0004QZ-J4; Mon, 06 Jan 2020 13:25:39 -0500
Received: by mail-qt1-x843.google.com with SMTP id e6so43208219qtq.7;
 Mon, 06 Jan 2020 10:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q+bOzXBEsI8nNVkaMppRn/FCllRO/uVUk7UDRcJPDvc=;
 b=OV2233OKuf+rUsSvB+iilCKEFGrWOy30+te8ooCAwZfPiQbGkPvIcW7BN1GG/za4ih
 cG8Hwbz2L+lM8fUdGGzKGAo8m7vRhI3y+w/74n0UNzgn/e00j1Fv+1Celw1U4qvaM6QH
 vMh/K2VavxGGJ8lA5Fwf1lMvQ38SXE7l0wjzP64uT8Q634whU6l57KsB7QTcJDhFSH+o
 UAValYXfUXAAxNVmTpURArStt+68P+KPHScLU3uPIULXRy5IizI8LSq2sHxfKv65qFeI
 NxZXQ9NFV9DwP3UFgH1qaQiCyrtYaUbmPyUYuPdloUFr+krHdH5jgbCmIyRDYUlxrEZ8
 9+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q+bOzXBEsI8nNVkaMppRn/FCllRO/uVUk7UDRcJPDvc=;
 b=lyXaVuapamFRMGWZaSRD+I3/sVBhl+8PyZ5p+p/REEN3jCDDYP2WKaPzl91P8pssoZ
 1uEZrsB9kuLwPs1pNQPUnQOshAnUYYJs/tEKZ37Ho/xZ+ZHRiiJXqbofLyNOukB4sdqK
 eO5pFRph1sm8NW8lLd+HD247cnH1KL54ygQgxJH9H0B1ksakbu/qt4EREodBvA4qhaj7
 B8R+29WJF00zXeX/haY8CJ5054zoey1tLcaSdyIB3JVpCE9U4kfpVBgvLxZwWjoJMJEz
 hJpPTOo/rM2AIYtCTGaL/sTHgQZb2wlFrZGGJ62ohL4GkQJJ4YrT4bxUQI3FGO35aNml
 Eb6Q==
X-Gm-Message-State: APjAAAVWLGR8dNA0p7h23vjiiLlmKA958ZRfTwsdMVwzZN/Bc/EApisv
 pzPMVOZBB+I9JVGYgNhFfrgiGHZ9
X-Google-Smtp-Source: APXvYqyh5mMSZQ3pxp9i2UhaMKhzyAq85dan9+Qp2AUbce0/Y7zG4ocvzlPpaOwU8tebgr9Uv32NCQ==
X-Received: by 2002:ac8:21ae:: with SMTP id 43mr77471513qty.223.1578335139073; 
 Mon, 06 Jan 2020 10:25:39 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:38 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 26/59] block/replication.c: remove unneeded label in
 replication_co_writev
Date: Mon,  6 Jan 2020 15:23:52 -0300
Message-Id: <20200106182425.20312-27-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The label 'out' in replication_co_writev() can be replaced by
'return ret'. The other label, 'out1', was renamed to 'out'
since the original 'out' label was removed.

CC: Wen Congyang <wencongyang2@huawei.com>
CC: Xie Changlong <xiechanglong.d@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/replication.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 99532ce521..3d5eb64d41 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -258,7 +258,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
     assert(!flags);
     ret = replication_get_io_status(s);
     if (ret < 0) {
-        goto out;
+        return ret;
     }
 
     if (ret == 0) {
@@ -280,7 +280,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
                                       remaining_sectors * BDRV_SECTOR_SIZE,
                                       &count);
         if (ret < 0) {
-            goto out1;
+            goto out;
         }
 
         assert(QEMU_IS_ALIGNED(count, BDRV_SECTOR_SIZE));
@@ -292,7 +292,7 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
         ret = bdrv_co_pwritev(target, sector_num * BDRV_SECTOR_SIZE,
                               n * BDRV_SECTOR_SIZE, &hd_qiov, 0);
         if (ret < 0) {
-            goto out1;
+            goto out;
         }
 
         remaining_sectors -= n;
@@ -300,9 +300,8 @@ static coroutine_fn int replication_co_writev(BlockDriverState *bs,
         bytes_done += count;
     }
 
-out1:
-    qemu_iovec_destroy(&hd_qiov);
 out:
+    qemu_iovec_destroy(&hd_qiov);
     return ret;
 }
 
-- 
2.24.1



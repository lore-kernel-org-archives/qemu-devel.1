Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F03FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0AE20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk9TOKcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0AE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlClh-0007so-5u
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQQ-0003Jh-6D; Tue, 16 Jun 2020 10:18:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQO-0006vA-IW; Tue, 16 Jun 2020 10:18:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id v13so16030474otp.4;
 Tue, 16 Jun 2020 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eT4kasepupf0quY9iPCk6nU2ks2xXCw/NfEezYt8oHw=;
 b=Zk9TOKcBcbcRvgjLNBjKCxNze2FGr/VvYIwqXWwz2JxjMETRQ0OKHPGX19tQw89fHU
 3cHyKxELNJNTiiB3CXygXEU/r5XUmrtxIBh5CIaluxZu5H3udY1SkmJXKHs+LTeKY3Cp
 zMO+xx1/66JMqMQ8Ko67B+/JQVwkAkpxdalB9M2hs95r2LP91YXLgojj35ajc+qegwY+
 GcCNdxiGBmrLADsXVKUCc/i6eWOSJ4rfQ3w3KUiW1B/GVsW8UuEdvNMkt1/J8thOlFCR
 rkoGVJELiEGywWbun4YJ/teZ94Ntayjd5PTkK83iFXxyf1pPFbtwy//879HBB/NpWJEU
 56UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eT4kasepupf0quY9iPCk6nU2ks2xXCw/NfEezYt8oHw=;
 b=nogD/0KLRmaUIRSa1l54h4EYRjsg/3wDEcRW+BvFGOzWYLf3yJZDYws7Sd1hZsdna0
 GKdTAJjtabIn4Mat1jn3SA9VvJ006tg7WzUTKynlN78dQTKCfxxkMzP8PJb0XAykCNHD
 iffrZ7cFGnl5+P7DhlladNeIdOT7myP6xs/gAQ9RAwQGbtiC3VtSs1by+f0Yl6w6G7lW
 hlPY2bLZDKOwkVSd0oZPa8/pcQwAlABTz+2OcM7r1//Ov8Ri9bXSNt0wU6mnOcfnCdRM
 qCnnrWVjF7PyslP7/362WeVHg9ylSb2xWuLuq1BfhvfuM+/OpQsrH2AGGHfI3wh9xCV5
 Py3Q==
X-Gm-Message-State: AOAM532jtt15qDCd2rTucAuX9jZjnhrLZqbFy/JTtF471Qosse7aTTBX
 xsmlH6tw32wEIXQzOXgQxLymNUfM
X-Google-Smtp-Source: ABdhPJyMH1zL1V54S0jl8dEBw22p+kWgOqC3YRAeAJJhkdzMEeCcEvnoYTiOSsgzCfb+xUpihKyJ7A==
X-Received: by 2002:a9d:7f93:: with SMTP id t19mr2598707otp.347.1592317130464; 
 Tue, 16 Jun 2020 07:18:50 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id e17sm4169311oiy.21.2020.06.16.07.18.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:49 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/78] block/qcow2-threads: fix qcow2_decompress
Date: Tue, 16 Jun 2020 09:15:21 -0500
Message-Id: <20200616141547.24664-53-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On success path we return what inflate() returns instead of 0. And it
most probably works for Z_STREAM_END as it is positive, but is
definitely broken for Z_BUF_ERROR.

While being here, switch to errno return code, to be closer to
qcow2_compress API (and usual expectations).

Revert condition in if to be more positive. Drop dead initialization of
ret.

Cc: qemu-stable@nongnu.org # v4.0
Fixes: 341926ab83e2b
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200302150930.16218-1-vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit e7266570f2cf7b3ca2a156c677ee0a59d563458b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2-threads.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 8f5a0d1ebe..0d193d1614 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -128,12 +128,12 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
  * @src - source buffer, @src_size bytes
  *
  * Returns: 0 on success
- *          -1 on fail
+ *          -EIO on fail
  */
 static ssize_t qcow2_decompress(void *dest, size_t dest_size,
                                 const void *src, size_t src_size)
 {
-    int ret = 0;
+    int ret;
     z_stream strm;
 
     memset(&strm, 0, sizeof(strm));
@@ -144,17 +144,19 @@ static ssize_t qcow2_decompress(void *dest, size_t dest_size,
 
     ret = inflateInit2(&strm, -12);
     if (ret != Z_OK) {
-        return -1;
+        return -EIO;
     }
 
     ret = inflate(&strm, Z_FINISH);
-    if ((ret != Z_STREAM_END && ret != Z_BUF_ERROR) || strm.avail_out != 0) {
+    if ((ret == Z_STREAM_END || ret == Z_BUF_ERROR) && strm.avail_out == 0) {
         /*
          * We approve Z_BUF_ERROR because we need @dest buffer to be filled, but
          * @src buffer may be processed partly (because in qcow2 we know size of
          * compressed data with precision of one sector)
          */
-        ret = -1;
+        ret = 0;
+    } else {
+        ret = -EIO;
     }
 
     inflateEnd(&strm);
-- 
2.17.1



Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16E1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7339720679
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGY7cca/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7339720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCwX-0005mF-Mn
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQb-0003So-9z; Tue, 16 Jun 2020 10:19:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQX-0006xQ-Tp; Tue, 16 Jun 2020 10:19:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id e5so16019021ote.11;
 Tue, 16 Jun 2020 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7NX1GvgPv5viUDZxWAQeYn9X/XeNXTZT8tdkMO5SGPc=;
 b=CGY7cca/2PrVPS+sI43RhOwOOKw/sBd/P2CuHE7+f/TA5es63A2YCbrwXdgjdZpktf
 FwlOT0lpxm/oiMDZ2oAODHpv/qRIzvpLuzdDatC47C5SmW5/GEbpkl/da9v920D++WGR
 PoSN9xPX0QKNGxkLPV9cFu+N16i36Vs15gOTF99RY1i2eob6rUWlslpPDEQ1SfWuytc+
 VIzmNnr+fsTKE88vbQFkyNzOLi2/XtOISxlYXi9oBouAW8C53UYbjb+Wp4yqhbJWCGpG
 FIlTAEpQHLtiSFJxlbRsfbmmwSraYss3NJ/d7hdkKI2At8aMZrEh2gUT1yzkKRGeI91u
 pGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=7NX1GvgPv5viUDZxWAQeYn9X/XeNXTZT8tdkMO5SGPc=;
 b=OB1Zsbrx4lj4ChT12ivGvtE1KlY6giWG0YVBn7J9Y1tY/9Set1DuipN4IwakrZdxbS
 sGeh4bXDZAUJ6NYGJXHbHHXGSUyV0iO6CpiGjTc9CorxtI8ze6pz7SlpaZtkrReJ7IJl
 f3MDwj3zl2u6EG9h/c/1pGUpMc1R6hXBVXnGB68bLE5He2zx+P2IS+HCQi2q9YMnIy+j
 PLbTJVqW6h5mQRY8da4n5AU00W3yuG3DduWar9CxKRgqFu6t2cS/Qb8Rb91Ohs4lPvhK
 Wm1NS5axgrn8kRTJ6objB8jAPQGfxejpPN619e9kf46Sbb8KT4Xp7r7x6/B588r6sNK6
 XfZA==
X-Gm-Message-State: AOAM531GLzXVZA9fHcIhynPcHMyGvPGq84SG4JlNEc/BKN/5C7IXy9NB
 0L21V1y681JL/kYrLZIJBuJ/xA53
X-Google-Smtp-Source: ABdhPJwS0A9w/iI4Ew+unRosDIyT/cBEWP9xRjnSJveQVBD9MYkW089eYNQViNjtTRPs0TH3NbLv0A==
X-Received: by 2002:a9d:969:: with SMTP id 96mr2515397otp.319.1592317140012;
 Tue, 16 Jun 2020 07:19:00 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g12sm2279151oos.8.2020.06.16.07.18.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:58 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/78] block/io: fix bdrv_co_do_copy_on_readv
Date: Tue, 16 Jun 2020 09:15:25 -0500
Message-Id: <20200616141547.24664-57-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
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
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Prior to 1143ec5ebf4 it was OK to qemu_iovec_from_buf() from aligned-up
buffer to original qiov, as qemu_iovec_from_buf() will stop at qiov end
anyway.

But after 1143ec5ebf4 we assume that bdrv_co_do_copy_on_readv works on
part of original qiov, defined by qiov_offset and bytes. So we must not
touch qiov behind qiov_offset+bytes bound. Fix it.

Cc: qemu-stable@nongnu.org # v4.2
Fixes: 1143ec5ebf4
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200312081949.5350-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 4ab78b19189a81038e744728ed949d09aa477550)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index f75777f5ea..949932d6cc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1395,7 +1395,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             if (!(flags & BDRV_REQ_PREFETCH)) {
                 qemu_iovec_from_buf(qiov, qiov_offset + progress,
                                     bounce_buffer + skip_bytes,
-                                    pnum - skip_bytes);
+                                    MIN(pnum - skip_bytes, bytes - progress));
             }
         } else if (!(flags & BDRV_REQ_PREFETCH)) {
             /* Read directly into the destination */
-- 
2.17.1



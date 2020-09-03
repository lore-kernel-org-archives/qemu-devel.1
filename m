Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC74420678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GndvPu3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC74420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxBt-0004fp-1u
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMF-0005C0-Ad; Thu, 03 Sep 2020 17:01:23 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwMD-0007un-ET; Thu, 03 Sep 2020 17:01:22 -0400
Received: by mail-oi1-x243.google.com with SMTP id e6so4530818oii.4;
 Thu, 03 Sep 2020 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=F7oBuPw2Gy+qGvdz894BU94j+ShqXQikgbDFVSsKbrY=;
 b=GndvPu3A1hgsuvcXKlLJ9kchrApbt6KknZc4A3O7EaT6KonEgE6giHY4eW0iG4xol3
 /amPAY+I0XN290IUoodCK4ZGR4WRVlsoN5hCzY1WbvsPwDy0kPbtR4sq3kwOasD0zxqn
 SUlrsQkxkRMBXYgaXEerlohzFTPcAtQUn6qyX4jvTE1P13g8UbG36MooqO/cJ1sV7jpL
 x2i+p3TeLH8Lxt3CWjMPmSw4bwD/ZVmAAxIiKWnUDQ9QjT//YTx8ZcellqRj4wz8+bOG
 NjdIlZ8bQd7PM/o8uE1RgrTpSE7XrLe1A+urNtXsq1DEDSXCFm9FEdcZ+73sBKhDTCHF
 nZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=F7oBuPw2Gy+qGvdz894BU94j+ShqXQikgbDFVSsKbrY=;
 b=BsQjxQ6p+MgNKImFtTH1w4Q7EaL1/EbOIKAB5WvZ7qkTMJdxVuyjCUE8/GsEDSAcyf
 SoRh/1Ls8H2/UJuEcXIcQuWQK4YQGAOoU/DzJA8eXwPstgw5O5UA72y7pkIM1YBEGMj1
 Wr6IbQMFhCCylyxSnj2eVSI5hacNODN49RAxTTajcGyhNoa3QOfqqXqgdGctA8qx7sAd
 fW3qZRenbGnvOmfPTRiUMUo2b0s/dPsTMThaQfnrV0PDlRjPOFI86vcTaITefUL0Rdjh
 K6VjdymTHd1ubF7rlGFjxKgzQ3G7N9W6T5+LolS/6Kf0BSKgS1G+tMFEIbnr4iepvwYp
 vp6A==
X-Gm-Message-State: AOAM532uZ/v2q3W5jtshQjhTOc37cpEk9X9N9VLsbkiFwLavyT0eY4th
 KaMZeZwFwe3XKZEgEfIv1QnnFKoRF8BAMQ==
X-Google-Smtp-Source: ABdhPJwVh4BpARhvw4Dd7HCBv8KnMq0nujSwsYeCYf9x83quSLp5V/nN0F5Hamdhyq8rf/niSF4qZA==
X-Received: by 2002:a05:6808:7c8:: with SMTP id
 f8mr3160952oij.119.1599166879648; 
 Thu, 03 Sep 2020 14:01:19 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x4sm725153oic.11.2020.09.03.14.01.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:19 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/77] block: Fix bdrv_aligned_p*v() for qiov_offset != 0
Date: Thu,  3 Sep 2020 15:59:30 -0500
Message-Id: <20200903205935.27832-73-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Since these functions take a @qiov_offset, they must always take it into
account when working with @qiov.  There are a couple of places where
they do not, but they should.

Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
       ("block/io: bdrv_aligned_preadv: use and support qiov_offset")
Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
       ("block/io: bdrv_aligned_pwritev: use and support qiov_offset")
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200728120806.265916-2-mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Claudio Fontana <cfontana@suse.de>
Tested-by: Bruce Rogers <brogers@suse.com>
(cherry picked from commit 134b7dec6ec2d90616d7986afb3b3b7ca7a4c383)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index aba67f66b9..496c813dd8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1501,12 +1501,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
             assert(num);
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
-                                     num, qiov, bytes - bytes_remaining, 0);
+                                     num, qiov,
+                                     qiov_offset + bytes - bytes_remaining, 0);
             max_bytes -= num;
         } else {
             num = bytes_remaining;
-            ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
-                                    bytes_remaining);
+            ret = qemu_iovec_memset(qiov, qiov_offset + bytes - bytes_remaining,
+                                    0, bytes_remaining);
         }
         if (ret < 0) {
             goto out;
@@ -2009,7 +2010,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
             }
 
             ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
-                                      num, qiov, bytes - bytes_remaining,
+                                      num, qiov,
+                                      qiov_offset + bytes - bytes_remaining,
                                       local_flags);
             if (ret < 0) {
                 break;
-- 
2.17.1



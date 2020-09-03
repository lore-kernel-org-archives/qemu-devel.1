Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A64C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:25:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39205206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBgHxt0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39205206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwjI-0001pr-8U
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLU-000496-4G; Thu, 03 Sep 2020 17:00:36 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLR-0007hM-I3; Thu, 03 Sep 2020 17:00:35 -0400
Received: by mail-oi1-x244.google.com with SMTP id d189so4479274oig.12;
 Thu, 03 Sep 2020 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qqO0q4PuTgIHgmO4BpcbGdGSE0v/V3QX2HSz7/NQHAc=;
 b=QBgHxt0SENiRPU4IfFatZ/taoMjuFG2MVBKHGhSgZqndtCiIP33d5lETEbz2H9UZ3h
 9lk1B9uc3Zg/6bls7qeNidcFOw/hRA5ydEM+j+SMKYrWKCveMqc4M5OqCXOpj996rDe2
 2U/dEIJaLblSG0M9ybqmvz332W8f99SXMKeGQLNFejzBcS3PmbqTpHU+f39oAi3oXm8E
 FDdk9GV5H5YzndLxrbN61dyIEOuRCHpvoqUrgBFdUJjKS1RfVYLyFqnIXIFzy27tiXGU
 1/Iszd9+6L/WR2cr4pkkaV3fHmCuSGM+Ge8Ru8G4q0sizzVTlTD7veUuJNKOkVZ5j5HB
 mPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=qqO0q4PuTgIHgmO4BpcbGdGSE0v/V3QX2HSz7/NQHAc=;
 b=jgVphdahdGhA69pH7xpwsn0ood1ab8Ca2jOaFB1ue9XuHKducJd/ACu8rP7kh6f1gy
 bFbkDGouhdkgkrnm8AR5Ujh8hrSO3sQ7a/O5BtZuFngNRhPsdRDPoX44FOzJQjwccxx4
 W0MDC7EmurYAtLet8zkRl7D8ExzPhGWmORlVafPbIfCIiKvl6zOj3noCxWeNGWTeJa+c
 IHDkCo7wZCuC8q/iZyRDZlu8xFpYt+6V8pe0zoMULMhnoDVtkg4bB4AX/dCh/GcFvDx6
 LWaO0JeHOvo8glKTNAhCcZETof/rncUgKVsk0Pex8KagwZi8YPOReklzHcLmchRrTnQv
 wa+Q==
X-Gm-Message-State: AOAM531uXlRaUYzOLCRWWF8qpv/9Vvo7Gq3m1nE29ub0veYaNIlIQwrK
 t4Immt7B05D/bCBYU4CGwrwTDx7Jwtg=
X-Google-Smtp-Source: ABdhPJwysubC3KWwQhGbppCyE3FDbdcV/xaohyynjtrIcBJB2TP6F94NIpqguL9tObaqtNXRh5XVIQ==
X-Received: by 2002:aca:ed0a:: with SMTP id l10mr3405235oih.9.1599166831704;
 Thu, 03 Sep 2020 14:00:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id z17sm836821oop.15.2020.09.03.14.00.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/77] nbd: Avoid off-by-one in long export name truncation
Date: Thu,  3 Sep 2020 15:58:58 -0500
Message-Id: <20200903205935.27832-41-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

When snprintf returns the same value as the buffer size, the final
byte was truncated to ensure a NUL terminator.  Fortunately, such long
export names are unusual enough, with no real impact other than what
is displayed to the user.

Fixes: 5c86bdf12089
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200622210355.414941-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
(cherry picked from commit 00d69986da83a74f6f5731c80f8dd09fde95d19a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index bfc0be6af6..bf3fbebfa0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2011,7 +2011,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
         len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                        "nbd://%s:%s", host, port);
     }
-    if (len > sizeof(bs->exact_filename)) {
+    if (len >= sizeof(bs->exact_filename)) {
         /* Name is too long to represent exactly, so leave it empty. */
         bs->exact_filename[0] = '\0';
     }
-- 
2.17.1



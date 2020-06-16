Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10863C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E6D20644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmZr+fbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E6D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCh7-0007cE-3P
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPn-000254-9d; Tue, 16 Jun 2020 10:18:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPi-0006fF-KM; Tue, 16 Jun 2020 10:18:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id g7so16013909oti.13;
 Tue, 16 Jun 2020 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MBxm7nuYUhmoYS/sHlImvlcd+nSnILjZSRJjgMLw/0Q=;
 b=bmZr+fbElDD0JaQE7MsKZ5sTkE3ClXno08gKztNtqB5gYQpDRMG4ZdITcXSSkPGgWq
 yibchgH84PMzmh/WqhUFb3yT2UiaFfxEcG9109c1CU3RzNarGzab9NODQWq8w+tOZmGJ
 GeXaAqTJvyYgHHwckHmkHR9xphLFNUP3fw3waM3aqju04jwvc26jdqSF2cDPbIvkJvLa
 SA1Mk8KFtwiLBhhZRkB+JKJKJ8E6LKCjAzVLLZCpF/9gNfxThnRYoKYIvOjhu1pzVOPv
 p4otV04dDskOMucWhYlBY3Tgwfe4nceU0pW+CD6hKXDSEXvqRg71c0TneNzPDWXu+GBr
 rjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=MBxm7nuYUhmoYS/sHlImvlcd+nSnILjZSRJjgMLw/0Q=;
 b=oBlZaoN+8ZycsPoSmQj4zx1/IWq4yLYcluI4+aONt5JJXMYsMHoZfQDMK0J8nlelWk
 5G02JXG/zU3NCnLb8WLMD2twjcrYPSh2MizrvhH7Jqj/FQXGflcogr4iVjSJzZfaq1mH
 7CIvoLyktZw7F9p7ktvgjUn3JqjNnYx4jz6NMmkylmV+z08o84Xa0yCCmeyQi1zwnEpL
 pTjxSlXapX17Fg5DXNch2VFl2xe/dim/phpOMVqms7MCtIjf4pmYXNeW+H2aXB1oaeuB
 O/Pt6QvZnauwYvtkHhpNG9+zEv6KtyhcACfyZyA/oo5DQxofZONDOjr5NufrN8znj9mC
 LKBg==
X-Gm-Message-State: AOAM533VHdx9z3vrKvNyFg933kXmAJtVxeX/kfHLpG7wKq+MA3C4PJ/3
 npxvJJ9yZ+3/e7f5afTy+HAr+YUS
X-Google-Smtp-Source: ABdhPJz5J7aVsq1RcsYH5jKM/6pSUvaw/Lg4/70DEV1PUTMPYIynh++uEE4/0AcwopEs0g4bR9VmdQ==
X-Received: by 2002:a05:6830:1294:: with SMTP id
 z20mr2452486otp.24.1592317088694; 
 Tue, 16 Jun 2020 07:18:08 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c23sm4072614otd.7.2020.06.16.07.18.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:07 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/78] block/nbd: fix memory leak in nbd_open()
Date: Tue, 16 Jun 2020 09:14:31 -0500
Message-Id: <20200616141547.24664-3-mdroth@linux.vnet.ibm.com>
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
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

In currently implementation there will be a memory leak when
nbd_client_connect() returns error status. Here is an easy way to
reproduce:

1. run qemu-iotests as follow and check the result with asan:
    ./check -raw 143

Following is the asan output backtrack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:295
    #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:49
    #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-sockets.c:386
    #5 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
    #6 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
    #7 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Direct leak of 15 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1834
    #4 0x56281da804ac in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281dab41a3 in qobject_input_type_str_keyval /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:536
    #4 0x56281dab2ee9 in visit_type_str /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:297
    #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-visit-sockets.c:141
    #6 0x56281dad17b6 in visit_type_SocketAddress_members qapi/qapi-visit-sockets.c:366
    #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets.c:393
    #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
    #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
    #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Fixes: 8f071c9db506e03ab
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1575517528-44312-3-git-send-email-pannengyuan@huawei.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 8198cf5ef0ef98118b4176970d1cd998d93ec849)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 6bb6715286..3d369fc8eb 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1900,6 +1900,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = nbd_client_connect(bs, errp);
     if (ret < 0) {
+        nbd_clear_bdrvstate(s);
         return ret;
     }
     /* successfully connected */
-- 
2.17.1



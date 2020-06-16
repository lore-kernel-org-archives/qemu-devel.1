Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E388208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5IVC64J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E388208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCnx-0005xB-PO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ9-0002n6-21; Tue, 16 Jun 2020 10:18:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ7-0006qK-Dt; Tue, 16 Jun 2020 10:18:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id n70so16045318ota.5;
 Tue, 16 Jun 2020 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0DBI2oDF9wCrNm/Eb66bKZMNBed6O1z+oe9NUEbxE3U=;
 b=q5IVC64Jdho2cZjqag1SQPfDt/f4W7BTx8ZcyfM27yIbgdMwh9WdRiRIyuluwZrEg6
 /b/FjuReRuY3BH/r7axhA6PiNxWjtGxICKISbr8OiZ8LW5Fw+iRY5mLUQ0/hA5alEhFG
 tsKp4054OeOGUfA6L0+v4JNENWS3Dh0VjMbVJMVEdQSzQxF3NeIbUriXHTvuF8dvi2Ee
 D0wA+oGq14QCa0BCa7XR5xwdFSklQ9wOGZTyy/5azNyV2E28TFNglzd2u+tDjUBHq/vc
 NptmaT0a9J2KNMkItaSRoHMYUdZxH2QnZlPGfLMzG3b1n57lXIHH9GBiN98ma3OLGR80
 5ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0DBI2oDF9wCrNm/Eb66bKZMNBed6O1z+oe9NUEbxE3U=;
 b=OMZQos6Ps5BlZDtjMdQ8eV1vD3Q/2ZA1d8rjrwonPvvCLwtHPbuysrD7ksf9x1s54g
 gz47QeYyJNqt4EPD+JSUDFBhj5nQA0AmmSClfdKxVeNs3LWGg6h7iCqeewj+Mpm9oSq6
 g4sfMPPorhi0iXevAfmsR78Da9HR2+HnPSsK/PHj+9HgsFLpFlUcTks9/vIqIUByF2Wu
 PN/Shj4/oJI738wjlN2x+ew/Ou6mcr2paXiLMV0eYSxTy/ly90aoMHwuRyRF7fy94voz
 waTov97MOLLu4Ugpl+HEwjRg3p6Z5d10uJ/XIf1s7q5euPAff0CDuk8MHNAgI8re+2ix
 tikA==
X-Gm-Message-State: AOAM530ZBV1795n7ZQ0QG6GY2XADgokrojGi+LM4w5JzWtWF6FRElbUj
 DBGcJClmNwomwf/KQS42C3FGuF+H
X-Google-Smtp-Source: ABdhPJzF+kaKZH8Dr7sG+XtfQ3tcisaOS4FMRjy3g4mLiBvGCcuNCFfyyBHnyUsEB4kxFykFQtPHJw==
X-Received: by 2002:a05:6830:1011:: with SMTP id
 a17mr2496158otp.163.1592317113693; 
 Tue, 16 Jun 2020 07:18:33 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w10sm4073655oon.40.2020.06.16.07.18.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:33 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/78] qcow2: update_refcount(): Reset old_table_index after
 qcow2_cache_put()
Date: Tue, 16 Jun 2020 09:15:13 -0500
Message-Id: <20200616141547.24664-45-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

In the case that update_refcount() frees a refcount block, it evicts it
from the metadata cache. Before doing so, however, it returns the
currently used refcount block to the cache because it might be the same.
Returning the refcount block early means that we need to reset
old_table_index so that we reload the refcount block in the next
iteration if it is actually still in use.

Fixes: f71c08ea8e60f035485a512fd2af8908567592f0
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200211094900.17315-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit dea9052ef1ba12c83f17d394c70d7d710ea1dec9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/qcow2-refcount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..b06a9fa9ce 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -889,6 +889,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                                                 offset);
             if (table != NULL) {
                 qcow2_cache_put(s->refcount_block_cache, &refcount_block);
+                old_table_index = -1;
                 qcow2_cache_discard(s->refcount_block_cache, table);
             }
 
-- 
2.17.1



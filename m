Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B12C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772F120786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cILtWzvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772F120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCSv-0006fD-NB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPC-00012M-9x; Tue, 16 Jun 2020 10:17:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCP9-0006Wd-Si; Tue, 16 Jun 2020 10:17:38 -0400
Received: by mail-oi1-x244.google.com with SMTP id x202so19359260oix.11;
 Tue, 16 Jun 2020 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h/hE49QX8YmTKtVnyAn2SmarU/Zwjxz9HKFw4F8vB1M=;
 b=cILtWzvP4L4u8FWC7MUMCvZCpDhksJ3K9fyP7VqsGLO7SFlvecUq1G3xrhO9Q5wZs0
 zx1GtJ/plwR6yaDF1sRIdhFHQe+MLOGcb7oK72YN2yXvjxzBzY8ohiYEwzNKPPmQKNkr
 JS4Ok+3CQUfplnqsOKCKtF4L4CiEvURUXv9tdT8jvaPdfqdeSoa+ZArrvONNG5w0XYWq
 cjAcKl2Dpwt87pK2BXglW/H6CsA0jpaUIwxILeeUZNSN6YpSdgBkJn8HGylLpTuEhl2r
 TaB8HMSNq81nO9PHX2qJrI5TUt0LTkz4KG1AgVS3v+1wx8rYthUv9sFmfmkNtaql0mvz
 iLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=h/hE49QX8YmTKtVnyAn2SmarU/Zwjxz9HKFw4F8vB1M=;
 b=RL6lAOIVDNsQjdTuu+dhNTuY2gfKgvUuBfuXhJ4XFSIkUvs43tshIE6rXCrMKF5DGE
 gGhO1VH5Jx4tvb4gdhBWKpdmXIP7QqWFSriMLKoFyp2LZsFd0YdSGgYmR4BfD/bCaUD0
 x3dPWfbmRWMHr0WWs0wDdfLUiKodD1U1RK1dJ9fM7kqRDleJ3GMqVXg1kQSrtI5wt01e
 qKaBZe6Z0WJOp37/irVGevi14eQmRmGAiIXEDa4PcyYyrtprIJQcmQVr50/sKgyOtNrn
 gbQvKwAg3S4CT0pXp17oC70AdhNZQft9s64n72Bb8xRlL6a0cxbrWt7idVQwOyYnLW5u
 Ncjg==
X-Gm-Message-State: AOAM533DcSckUyut4CTF5VJUGFD7xg6+6dOo/WMWvBG42iktjaxJyUjM
 P5U1fIdMlCfT6d+s+t04woeDyGkE
X-Google-Smtp-Source: ABdhPJz73mREHdQ5EcXrsg9AovfPWhWMQdl1n3a4ntKd10hu5WRuCz8K0YAxiFleXmQFkPkZeyi7sw==
X-Received: by 2002:aca:ba0a:: with SMTP id k10mr3361414oif.13.1592317053984; 
 Tue, 16 Jun 2020 07:17:33 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g3sm4100629oov.21.2020.06.16.07.17.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:33 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/78] backup-top: Begin drain earlier
Date: Tue, 16 Jun 2020 09:14:39 -0500
Message-Id: <20200616141547.24664-11-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

When dropping backup-top, we need to drain the node before freeing the
BlockCopyState.  Otherwise, requests may still be in flight and then the
assertion in shres_destroy() will fail.

(This becomes visible in intermittent failure of 056.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191219182638.104621-1-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 503ca1262bab2c11c533a4816d1ff4297d4f58a6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/backup-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 7cdb1f8eba..818d3f26b4 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -257,12 +257,12 @@ void bdrv_backup_top_drop(BlockDriverState *bs)
     BDRVBackupTopState *s = bs->opaque;
     AioContext *aio_context = bdrv_get_aio_context(bs);
 
-    block_copy_state_free(s->bcs);
-
     aio_context_acquire(aio_context);
 
     bdrv_drained_begin(bs);
 
+    block_copy_state_free(s->bcs);
+
     s->active = false;
     bdrv_child_refresh_perms(bs, bs->backing, &error_abort);
     bdrv_replace_node(bs, backing_bs(bs), &error_abort);
-- 
2.17.1



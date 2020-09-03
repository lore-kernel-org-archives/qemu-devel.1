Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D7C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136BA206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcn7eNHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136BA206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwb4-0002dO-7p
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKu-0003Dy-2X; Thu, 03 Sep 2020 17:00:00 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:42322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKs-0007Lp-Hw; Thu, 03 Sep 2020 16:59:59 -0400
Received: by mail-oo1-xc44.google.com with SMTP id a6so1118160oog.9;
 Thu, 03 Sep 2020 13:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zVupKeo5/zqUAABc2CM+FsEj1GwOQJfGqOqabRjhG30=;
 b=Hcn7eNHBIiehSOo6bfbV493jwPmim39jLTz7GrONUFC/MiYDkQ9V4Qb+6rFMCX1nZ9
 8OSh7AbxpaF28pQLftSLBGTZ9nB3OsuVcIHaHhsKwP8MIkggfoOc4omz2YCfQCZ67NQp
 ljslfVp7Yf+0ibjCCFf114zKF4ZnCrPlIIXNevSFQiZCAzyglZI5r2SxTsTrKYctCS49
 JkTeSo2WBvMacSAStkHlyLoXmHs40h1yQRtCpffytsM20rfh2bSAJ5b+7UN+7GvY51ZS
 AXhq2QbRWkFV2Ly0k/dMNauR60M8H/IwBdjY0ZwpmIZFCNQTBkJa275OdL411PaKFJnx
 0+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=zVupKeo5/zqUAABc2CM+FsEj1GwOQJfGqOqabRjhG30=;
 b=JQpEO1NCdz/gTgur6R02KTpyGKeTBuTGeLut1yeawzoo0sQAfBe6ZqHXadg+ypmQnn
 gY03E07aMoORuG04gmmDdzMlHrf/Q1FfT1kFWRI0pGRbdGeBurCPSskrEtIkfi0dbJcy
 6KdRfGmxbUtMsEpirBi6JwbvRX75vaDl/EXkgOct/PBy773opdKuj2YTr+BSWMaccuJZ
 g46VdNiLvnBSxPtc/M6LpfK2C4ShBuboXojR16w3+QNFV79D+ROKg+83TF5EdVXv/xwy
 0cNsJa6ZUjjwXFlCUGulGC0LRlo1o/cQE2TQWUU+7gYMpz6BXufvedXLEZI8KD6X9aUm
 qYcg==
X-Gm-Message-State: AOAM533+mAYyLqu4/gBJE8vOuE0us0aAU8COqUXxh11jsaJLJJwal3Dp
 g8q6v0GefNVhpi/N3ZDkMCjElbLf7n4=
X-Google-Smtp-Source: ABdhPJz9ZzS8tMAS+z2qImnTBI5O4SEi/MYsm7zWyok79/VsoSi8xfFyc5DLQ2KH1NBtvIDAF9Sw6g==
X-Received: by 2002:a4a:9cd6:: with SMTP id d22mr3435323ook.0.1599166796879;
 Thu, 03 Sep 2020 13:59:56 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id y83sm713971oiy.35.2020.09.03.13.59.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 13:59:56 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/77] xen-9pfs: Fix log messages of reply errors
Date: Thu,  3 Sep 2020 15:58:31 -0500
Message-Id: <20200903205935.27832-14-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-stable@nongnu.org,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

If delivery of some 9pfs response fails for some reason, log the
error message by mentioning the 9P protocol reply type, not by
client's request type. The latter could be misleading that the
error occurred already when handling the request input.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Message-Id: <ad0e5a9b6abde52502aa40b30661d29aebe1590a.1589132512.git.qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 9bbb7e0fe081efff2e41f8517c256b72a284fe9b)
*prereq for cf45183b718
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/xen-9p-backend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 18fe5b7c92..f04caabfe5 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -137,7 +137,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
     ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
     if (ret < 0) {
         xen_pv_printf(&xen_9pfs->xendev, 0,
-                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
+                      "Failed to encode VirtFS reply type %d\n",
+                      pdu->id + 1);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
@@ -201,9 +202,9 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
 
     buf_size = iov_size(ring->sg, num);
     if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu, less than minimum\n",
-                pdu->id, *size, buf_size);
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
+                      "%zu bytes, buffer has %zu, less than minimum\n",
+                      pdu->id + 1, *size, buf_size);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
-- 
2.17.1



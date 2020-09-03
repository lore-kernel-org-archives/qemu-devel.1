Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F436206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPQNpOEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F436206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwga-0004gU-NM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL0-0003Rn-O1; Thu, 03 Sep 2020 17:00:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwKy-0007OM-MC; Thu, 03 Sep 2020 17:00:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id a65so3999855otc.8;
 Thu, 03 Sep 2020 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DnoLtc59NarnPTasZCly4q1/2ffMi+9W8GNcCg5WkuI=;
 b=UPQNpOEuzla8r0L7AyY5MczaFSat1A446PzeEO/TRqNE4LF8/4oQ+2srzALnhy+BHR
 qvO+5OPglTWvpkh85Nvfd4xwtvMkWy1/YHiO4CXoTGBidDFmCJuzH9DMDslBWCXk7ZvZ
 Xxv75cLW033W8FAZAWr5MLO9pqChKsNkunNDbojK9mn2v9xY7VYvR/zk/QmHKxE5hmLP
 I8DK6YzZQo5kplnucdF9vslEXrsQwS5OWJw/gBtaiKi4Rt0L6TVeokoV3J5NHbw4g4G4
 nv/MaaBIVW4B4UwurqvJEt0cipBaNmwGd0oAccS+eJja9jtr/yMheEas4lXyrl7hdT4t
 RJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=DnoLtc59NarnPTasZCly4q1/2ffMi+9W8GNcCg5WkuI=;
 b=Dx6o2cfy4MgQk3vueKEAbvscQyjB7jGtzdeqnxNu1gN3KlECErT3Iogn24YM+rihP2
 YEZP3tGvw5zeWgJk4eO9JcmHRHMrk1UKV4xJ2T2mcR73hASMQn8sd5OaVTmHH9kPA3Zo
 nmtyXNO1ROhKrbG6hE78xluLAe27cIGqy/DBXxhTUS9O9l5YcMBhWVlcRb+/Zm+FF75g
 bsme+4TkvqCYvcnSvALTgvo4pc8Jg8y/9qSvVkrhFQ6kaUVhLJ/Fq8r1YBzBaAPsP+4S
 2owz6yjyw8fKlVgxBp5Q+ak1VSAqess6lep1aWHVfHQM6CKT4jOQdE8Tu7s8arvoB1xb
 G8eA==
X-Gm-Message-State: AOAM530id3KpFXKpXLdMW53fZKNMgcEjM834PoprkJ0t8Y8UnzOi2Ae3
 QsoWIgVtQ0TRKOOZP92uVaA90i2CMZY=
X-Google-Smtp-Source: ABdhPJyde/+tNfRJ3SeIhbX+MNu9dZC6NZHTJ7EcMqaFtXs1RkFocV91elsja5/9USme1ZEI52lPcg==
X-Received: by 2002:a05:6830:2141:: with SMTP id
 r1mr2963428otd.314.1599166802781; 
 Thu, 03 Sep 2020 14:00:02 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id a2sm820168ooo.26.2020.09.03.14.00.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:02 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/77] Fix tulip breakage
Date: Thu,  3 Sep 2020 15:58:36 -0500
Message-Id: <20200903205935.27832-19-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

The tulip network driver in a qemu-system-hppa emulation is broken in
the sense that bigger network packages aren't received any longer and
thus even running e.g. "apt update" inside the VM fails.

The breakage was introduced by commit 8ffb7265af ("check frame size and
r/w data length") which added checks to prevent accesses outside of the
rx/tx buffers.

But the new checks were implemented wrong. The variable rx_frame_len
counts backwards, from rx_frame_size down to zero, and the variable len
is never bigger than rx_frame_len, so accesses just can't happen and the
checks are unnecessary.
On the contrary the checks now prevented bigger packages to be moved
into the rx buffers.

This patch reverts the wrong checks and were sucessfully tested with a
qemu-system-hppa emulation.

Fixes: 8ffb7265af ("check frame size and r/w data length")
Buglink: https://bugs.launchpad.net/bugs/1874539
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit d9b69640391618045949f7c500b87fc129f862ed)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/tulip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1295f51d07..44db56447c 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -171,9 +171,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
             len = s->rx_frame_len;
         }
 
-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -= len;
@@ -186,9 +183,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct tulip_descriptor *desc)
             len = s->rx_frame_len;
         }
 
-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -= len;
-- 
2.17.1



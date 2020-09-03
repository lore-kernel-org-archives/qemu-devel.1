Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F50C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6A2206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2WB0332"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A2206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwZ6-0007s8-Fl
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLU-0004Au-Tk; Thu, 03 Sep 2020 17:00:36 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:46892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLS-0007i5-UT; Thu, 03 Sep 2020 17:00:36 -0400
Received: by mail-oo1-xc41.google.com with SMTP id r6so1115659oon.13;
 Thu, 03 Sep 2020 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0LMgxbFODWFpBaUC7jVrX4CuO2pJP6IZde8nJ19Zvuo=;
 b=o2WB0332e2+ouLNHFWs8qrQ3/t2f+lmDJT2MAdiGBD7ag2Gx8HcDGTtGsyTp1GytlL
 Yupc2EKN+YmlCXgU43eUvh17WmeTU4vyyubcou1Opt9ORzB4N02hFfIytmBq43OXaLQf
 HWV4oTJIaL4HE8G22zxSwjd14vbZCkbyMwcyKLDxREXu+28BuUJrfM85CT+qBM4ZxbFV
 hXlqwcsw8qv6jgslPPlc0t3RM0zufewMaajGecy7psXqswcvZP4u5ivCCYrqls+Daem0
 B/IcS2fxE1eqYQoDVGT6iiiVXoJ6Kqt8olgFGQpByFnTELWhs9WM7tmiXyJqNEfzyJ4T
 idBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0LMgxbFODWFpBaUC7jVrX4CuO2pJP6IZde8nJ19Zvuo=;
 b=KKLVGUueAtByWDGzAte+7xJwmjtOgjsxrfUcIHzSoe+orIae7SotGpuOUoZlByULVh
 b1w0jCnpbmKfo1OpeFgIlv7URWiCGSwKqlyUr7q3sntbGLJb00Zc8x/GJU99KrNok3KR
 /s2ZVxXBhA0tafAWeEeoaF0cmxp+NnkfKxdQW17lBDEu3JjUTRAWNWHcEMr1klyVhP+R
 KdfnstnjuusfPwxPiTn2LQ/jOrpYywjgqmCwsA5rbioazxEKOxZEm262zOoD4Gbffa7I
 LBngmK3/j89tZaaTCZqwwQyu9JYA3r4YhW3EJmwI1JQV6j0iK42EuGQdV+y220U/I4v4
 MmUg==
X-Gm-Message-State: AOAM533WJTQ30mkVD/+WODib3ReQWeYuTYukwz7mnoSxs6bbo298cMdS
 hgH2eBXti6dP7QGid2ZiNnqqBtRqWLc=
X-Google-Smtp-Source: ABdhPJyDdn4kiKWjUdAKxHyH9FK8TbJETKGPOTOnGSk/WbWecviuBQvvJ3iQLQkqaLZOcX4rgS/DCw==
X-Received: by 2002:a4a:7241:: with SMTP id r1mr3344079ooe.48.1599166832885;
 Thu, 03 Sep 2020 14:00:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 40sm757020otj.76.2020.09.03.14.00.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:32 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/77] qemu-nbd: Close inherited stderr
Date: Thu,  3 Sep 2020 15:58:21 -0500
Message-Id: <20200903205935.27832-4-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc41.google.com
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
Cc: qemu-stable@nongnu.org, Raphael Pour <raphael.pour@hetzner.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Pour <raphael.pour@hetzner.com>

Close inherited stderr of the parent if fork_process is false.
Otherwise no one will close it. (introduced by e6df58a5)

This only affected 'qemu-nbd -c /dev/nbd0'.

Signed-off-by: Raphael Pour <raphael.pour@hetzner.com>
Message-Id: <d8ddc993-9816-836e-a3de-c6edab9d9c49@hetzner.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: Enhance commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 0eaf453ebf6788885fbb5d40426b154ef8805407)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-nbd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4aa005004e..306e44fb0a 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -916,7 +916,11 @@ int main(int argc, char **argv)
         } else if (pid == 0) {
             close(stderr_fd[0]);
 
-            old_stderr = dup(STDERR_FILENO);
+            /* Remember parent's stderr if we will be restoring it. */
+            if (fork_process) {
+                old_stderr = dup(STDERR_FILENO);
+            }
+
             ret = qemu_daemon(1, 0);
 
             /* Temporarily redirect stderr to the parent's pipe...  */
-- 
2.17.1



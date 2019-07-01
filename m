Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10FC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172E820881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Du5eu6tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172E820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi87G-0006YW-Oo
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hi4Sv-00016G-BW
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hi4Sl-00028G-3h
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:07:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hi4Se-00026G-5o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:07:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id e3so5910631wrs.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H5JCIl/sTUYayqnfbnRrzXQvGcI9pQ/R8Eioapux/4s=;
 b=Du5eu6ttB/k2scC1BWfNTldbtY6WQnwnoC16Kw4lShjxs6BD31KoiJX9BaakyS77cQ
 0TTvHscEIu8iv4ohqdBKUyR5h47fCASWe3iaNjsjDzJo8M2tFAbivbetldnly8wR4fv+
 9Q6gmkWt3KRfArbq8EOrCLN/MP2nlvZL7+Mjd7fMvTwsHH2uxx1rPdCsLFBkw2qeIA8r
 SkMxX8FP81nGVnTW170XG7K6kkT3N+Z7E+fDd72g3WXbo7PQSCcFEtQE1QMsMYBs8lJf
 VVj96pgn2+nPYQv+rAy1mvVySjAekVdv+ctpTyaJmKubenyJ57wwypqPL6vV5/Y+fzGm
 ESLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H5JCIl/sTUYayqnfbnRrzXQvGcI9pQ/R8Eioapux/4s=;
 b=gYrzjvLhKg4MXQB+k+ybvUzv+bHzzDvmw2KH9wnovbFvDQwFbhKeTqqZsiDN2H1/b0
 nQ2MzmbDxX0uK1hdk9tQ5n17KXKhqindhkN+yErifQJEgdHhBa7ZlDRfJ1HUtwqqCI9a
 jvyVa4RPBuZX667Sj/lHV9km2R09PXw4COyc4nt23ROZkwd+xQyGM8GX4Nii27MRGRRW
 /2Ll4YtRPZ0vyvTti8dXHvLg5elBjuTONDrRAw4kJ6VP98W76Q1bH0Pniw8QFHHE1v+Y
 +xkKzeLnm+1tGLbMFTW0PK7NcxBUlpsY3mX3JpYXs/CYjDKoCwr8YiIcY+VIrFkkTfK1
 hXQw==
X-Gm-Message-State: APjAAAXVruk+1w+XNUiq/APM6SKaMVDGs7/d55dgRJY8bn79hb8oppyZ
 w7bnZuEaGOZi7uLhJpJEq8sTkia+/aA=
X-Google-Smtp-Source: APXvYqy9F6nnlQtlRY2/dH3H2K05l8wiv4/aaLkfwGX8j5Xgp2xa1Pmv7J6FEbpEBlmWIuUvDSti5g==
X-Received: by 2002:adf:f591:: with SMTP id f17mr20621432wro.119.1561999656586; 
 Mon, 01 Jul 2019 09:47:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v204sm185026wmb.15.2019.07.01.09.47.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:47:36 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A997D1FF87;
 Mon,  1 Jul 2019 17:47:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon,  1 Jul 2019 17:47:32 +0100
Message-Id: <20190701164732.30518-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] [PATCH] migration: move port_attr inside CONFIG_LINUX
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise the FreeBSD compiler complains about an unused variable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 migration/rdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 74cb2aa9f9..3036221ee8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -839,10 +839,9 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
  */
 static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 {
-    struct ibv_port_attr port_attr;
-
     /* This bug only exists in linux, to our knowledge. */
 #ifdef CONFIG_LINUX
+    struct ibv_port_attr port_attr;
 
     /*
      * Verbs are only NULL if management has bound to '[::]'.
-- 
2.20.1



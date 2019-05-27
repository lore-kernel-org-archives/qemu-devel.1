Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3769C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F382070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klDEPBG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F382070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAdo-0000MU-OK
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:05:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAc1-0007dF-1E
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hVAc0-0001bD-6M
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:04:04 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hVAc0-0001ax-1d; Mon, 27 May 2019 04:04:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id c5so6743488pll.11;
	Mon, 27 May 2019 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3FKBJA17va/jv2u1TvUxLDB1xiagIFwWCBsEV/clovc=;
	b=klDEPBG04+RmJ4+QGwvb3hwPdCqQcsLwMiL8ftkr+KlDViv3oFmVyXwa43iRuule3G
	zp/qIP4iNvK59xAf+553dZqa8UDjmP2cIf4fIAJrNiwFPWs5Q7SoGfXoIYX6GDmGzn/5
	Ln/CRjSSLGuhf7g8nDnQ0xu0IbnxNjMFCbAn32EFJwz35dug1BBxyk1mTxxI+Wf+0oiL
	s2PQiDuVaOxnu+3dtoTpN21oCs+RarkNwHiR/vXScAfnqdwT7ciZ/tQ+PwZzSipeT+zh
	pnR2wZqunaeEwyFzSx6lK2vUCOH5NQp08J7t0Jcm+c5Je/5fq6ZtKEo7H4miWsOYRlgq
	YZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3FKBJA17va/jv2u1TvUxLDB1xiagIFwWCBsEV/clovc=;
	b=rKuk9e2VBtxitrpio16GXYIdX/lmAXnZ78MYgcd6bTH60YXEKo8Lr8fjvyj+GoM3I8
	gk33qwc506PUcuqKNSdgQNuHjwaPFhaEnkeWgkcT0dpUtKb7+CcT2qSDNxTmAKzWVbSR
	YTX0NDHK9MyljF4DXXBNp8IfJmtUuwsrilNsCOqtA+actlBaEWuqmw7d991EMG4wkeL1
	4KjoXQ/MESSiRv6XkLDRQeEo9UeNmRO9pVh1U6e/1FPTXw110HWbsAo64GdxMtb/7kA7
	0gj1UGQKhOwvJ+Wp0jnzPaKWzpe4NHu+mNqGjnjWAFMQnuEr1aDHa2EdZeZb2YBIdmOT
	bj5g==
X-Gm-Message-State: APjAAAUeXRrpSAm8cMpBIXTq/wFVZc9HruVuRucw1qMCXBL0qkKVFFN8
	q/QbH4Q1f+pAorPzcYpxHB0JxXWYRM0o7w==
X-Google-Smtp-Source: APXvYqx8szK/Ee5gqOwDdJcgrOxryRKBr37ENvkZry2XacCKwJhO+9AHaJUUwOC2G//yL7wPVGg33A==
X-Received: by 2002:a17:902:158b:: with SMTP id
	m11mr85445017pla.268.1558944242814; 
	Mon, 27 May 2019 01:04:02 -0700 (PDT)
Received: from localhost.localdomain ([120.57.119.140])
	by smtp.gmail.com with ESMTPSA id
	j5sm10030853pfa.15.2019.05.27.01.03.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 01:04:02 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 27 May 2019 13:33:22 +0530
Message-Id: <20190527080327.10780-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
References: <20190527080327.10780-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v3 3/8] block/block: add BDRV flag for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 9b083e2bca..60f7c6c01c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.17.1



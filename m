Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAF0C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C11D217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwWIgeZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEkp-0004Xk-P7
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:05:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEcY-0005oR-PU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hTEYh-0001dK-SJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 19:52:40 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hTEYh-0001d3-NJ; Tue, 21 May 2019 19:52:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id w7so126757plz.1;
	Tue, 21 May 2019 16:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LRaFFcCz9V1QD7Nw7bkLXRkuVZNJbVer9JVm4TimWgA=;
	b=VwWIgeZZ5/MBtJzQLdxtn3PXnbPFJErvmovMXIa3p+4NLl+UoNdFQA09LLD2b15toS
	fzqAVo4YydOomMNzWjJ+6gY/usO4+Lq2T/Fcwy7jksdsb2h29+66DCpvHBRRKwpBrxSM
	1moMbCaRWfUOzoepTqeYhWe/nGIwHGc8pKg1XKSOXUk3ZQKWmM2E+6Kv9yQ4JO0xSVpf
	FrU3f+ezPeWCJKK8F9AdUZGs0sElNcFrS7rShuq77xFCDnqRWI03/wyvUYEwy0HZ6yBq
	LowRfKszjcnq2QjbPpXCVfiiGVUdENDIRR0bnnNTOMJquD0Yf5s/8HJLH/CW7lf8bsHU
	yaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LRaFFcCz9V1QD7Nw7bkLXRkuVZNJbVer9JVm4TimWgA=;
	b=TGOl+nfj1S0LbqqSS+nbM4bJoYjY05GUa+//5s7VdaTvj+gOjyWTFPOqEYN2mw6d6S
	HtiCGdR9fhIeO/5Pbe+xuDu3/r/LUxzPBc2F+OgViYIJHJ5ZSD91ZS3sNX8yMzFL+2+8
	LDcfp/Ss2p94AOb0991KZnhg3yXMhk017rguVYVemqy/QHaj5QwbwZcI9xTtmZEDD6tY
	nNkELdZ9aub8ZILKM8Ooq1Fs7g3QfFBGpsqkyDISL2n7Kh7gyUJtADQmnvtUVC6iBM9y
	Axa6a91s79tZ3PR5qYSdZGeFxnYa4EgxmpVRZbOaYpDxgwcSRUXcBQTyKQeTN1ytlPhm
	el9Q==
X-Gm-Message-State: APjAAAX0b60dRAbTLayIu0ekZyW3ksTTFIgYFNm76N9wZh/WJFARTn50
	x8KElrXxZrOLJm23oY3Gyz9hmFKXeoAJKQ==
X-Google-Smtp-Source: APXvYqyOyqWnuEqrtisT0T3c3nnK2ripmJWOfs4A2qm+YS8dQQPJAlD+fFXGn/sp7Z3/oX+Pr/x4OQ==
X-Received: by 2002:a17:902:b094:: with SMTP id
	p20mr63128698plr.164.1558482758299; 
	Tue, 21 May 2019 16:52:38 -0700 (PDT)
Received: from localhost.localdomain ([120.57.118.207])
	by smtp.gmail.com with ESMTPSA id
	e5sm51571752pgh.35.2019.05.21.16.52.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 16:52:37 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 05:22:08 +0530
Message-Id: <20190521235215.31341-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
References: <20190521235215.31341-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [RFC PATCH 2/9] block/block: add BDRV flag for io_uring
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
Cc: saket.sinha89@gmail.com, Julia Suvorova <jusual@mail.ru>,
	qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 5e2b98b0ee..005f42b133 100644
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


Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F80C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790B920880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="i+Fg6LGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790B920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbMT-0005Ii-II
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 16:59:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKP-0003t3-Mi
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKO-0007sc-3u
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:17 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:39618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKN-0007s0-R8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:16 -0400
Received: by mail-io1-xd2b.google.com with SMTP id e13so12308996ioq.6
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=n1ze122+JanIdZZCh4HuDj1UrrAxic8ImYq67LbwZwo=;
	b=i+Fg6LGFXS1k80RQg4i89RMhykchu4qvUTwiMSBlqroSqAqdcNPZU1yf5ouQg0xZ7l
	z9pG/sCfwr336xUKRsNCbX50HD+7BbyQekJf+J+vGbyEF0QRM+yyBXv89KfViZPtHfO3
	BWt5BpJEEcH+rIHTq5wbjkBOTiXU49yoy+n6UccHGpFdTggwOGCf2RcDquXeAxijYDCe
	ZNUypcGxmTY9lytsJn6tfxnlFhgBB4XV87Mv6jEuuMOUAejt9Y2zSwGN34MH0OG1DQcY
	oc8ektIuNhuCR4Lw1vDxMz543p8sjlXzMsGEWoJEAhz3gH5BANKqsc8gW4qLL3VwOmx7
	//FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=n1ze122+JanIdZZCh4HuDj1UrrAxic8ImYq67LbwZwo=;
	b=BQc1Q0WsNu+5WiXm8XYTANkRIxkZNjl0M7SuonOcF0VSs9XlQZfXKGCj7ishVrGpss
	myN0tJXtLd5F9lA25MbRuVHN6cKmmJc/tOveWLEbF5C+oPMuuZhJWZC0f9SKS1DVTzt5
	Q5PXzIJ77MtJkSQuh8zQu0VTjSrPqq377UnCJ3uFuZSPQtkOvA+/YQM4PVO5wnY4a2Zf
	ypSv9bc8e6CIvcur3GN544dNJxSoqRCMFK+NutKSaAkuJ/SGItDhsf/E65m5mjypyCiQ
	L5jnF8I4VDB34q2Gh8AUwcOBLqpnDzxJoc26oPtqJ70ORaApxju03Ljhib3HE/BuQjcp
	xHzA==
X-Gm-Message-State: APjAAAV0zufD9VRY8mX+X43pttY/GPleLOb7pgaz/xpirGw+AkhpaFLM
	cSRvWqmwdgCCAGcu7MwWL+JGHFbov32UpQ==
X-Google-Smtp-Source: APXvYqzwNCDonoA6DDzhyWIyN7lyyr7mcr7kwcyDxOQZ+HsDeisMyaOq8K2fEvynRl8qxDfIYa6zxQ==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr19461189iog.127.1554757035145; 
	Mon, 08 Apr 2019 13:57:15 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:14 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:50 -0400
Message-Id:
 <278aee36fb8106857717b7d567dedb167fa4ea4c.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
Subject: [Qemu-devel] [PATCH 07/10] block/pflash_cfi02: Fix reset command
 not ignored during erase
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408205550.TVSSiqeYBFBwL13dBNeRcTuQjDn85G03cx8VBFSGkK4@z>

When the flash device is performing a chip erase, all commands are
ignored. When it is performing a sector erase, only the erase suspend
command is valid, which is currently not supported.

In particular, the reset command should not cause the device to reset to
read array mode while programming is on going.
---
 hw/block/pflash_cfi02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 32aba9a771..fa6929b9b6 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -325,7 +325,8 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                     pfl->bank_width * 2, value);
         }
 
-        if (cmd == 0xF0) {
+        /* Reset does nothing during chip erase and sector erase. */
+        if (cmd == 0xF0 && pfl->cmd != 0x10 && pfl->cmd != 0x30) {
 #if 0
             DPRINTF("%s: flash reset asked (%02x %02x)\n",
                     __func__, pfl->cmd, cmd);
-- 
2.20.1 (Apple Git-117)



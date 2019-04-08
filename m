Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6B3C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4731520863
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 21:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="f/AC4c7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4731520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDbQe-0000QG-Hc
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 17:03:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKW-00042B-47
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDbKT-0007xt-Tx
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:24 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:40277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDbKT-0007uh-Jk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 16:57:21 -0400
Received: by mail-it1-x144.google.com with SMTP id k64so1429011itb.5
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FI+c1gnaMYVDdjwo2QQ+OSPlpl5N2fagEdcijDjB1Wk=;
	b=f/AC4c7VL7tf54ZRPymRcuuqLo08R5No5mdzCydrRJFXsbzC62DuyfTHtAZjDejNXr
	B/GqSFzL+/8Spov5Ln5Wh57aCTovoDIoyr6Ts4PdWoTMn/kcdKNhXyuHQR/0hb1o2JpN
	OGGvd3P0to05n79ct/PsECfPG6lQotay3sK1zZ8jJPKrHwhT1ReXik+dg6jL9BQjdH9A
	77lFzsJxrE8yEkWgIY61POoLPTTCQNuY0U4Tx5PNpuvet3FbIPGEEQ8BTZISAcIrQmOc
	qAHUzZFwp1KA3fEpv1Yy17tfw2phlDK1hUmBeynj8pYHw4ygOXnnqJ9mG35BOyeHvvXP
	srZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FI+c1gnaMYVDdjwo2QQ+OSPlpl5N2fagEdcijDjB1Wk=;
	b=KUVOgVJhmOsZIs8bbIDZ0/MXY06xDdsZjLgEo8bkVVDs3vpYqnnQvo4BuAL++rcG+M
	Unw0ysV5HT1+ZWoue/q2afRp4uOnhVjm14Mlu1ErbhVxh0cc6N5FYtZi1ACu+/u8Tkck
	FsIRjYL8oX4ad7QK/XW6vDlKFkgpQRaysk5ecwcP3ihl+8oEjhRS8WrEGHK2igZ8oypf
	JPFIf2PwYebSmR0PeoJPkAg/RTQtagGN+d5PNA02q5N5S1wQBJoKSnzI5LScmTCLMKd0
	Jl1JY59sAwrsuu0iis3ROBTjGFeeMd4Jcz/ljdRURETNFeAHcY5fCBhAe2KRvyZwoHQd
	4jTg==
X-Gm-Message-State: APjAAAXskdD63Jwum1AY1nV+l0E28DlBAnjHlAUFyinDMnu9FyP8xENz
	EFTf9xsLtzQ48J5Z9mOrjyOwcbgIlmBZow==
X-Google-Smtp-Source: APXvYqwC7WMrIHEv/HCXreRBOQlEnqtTgyW2iff1meINDvYD36YDPhqWwkVyTZJl7qBN8slIU8FK1g==
X-Received: by 2002:a24:43d1:: with SMTP id
	s200mr23991351itb.155.1554757038306; 
	Mon, 08 Apr 2019 13:57:18 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93]) by smtp.gmail.com with ESMTPSA id
	h133sm5969313itb.34.2019.04.08.13.57.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 13:57:17 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 16:55:53 -0400
Message-Id:
 <ea23d53834372a9493d705ea603419f2c0845adf.1554755001.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: [Qemu-devel] [PATCH 10/10] block/pflash_cfi02: Use the chip erase
 time specified in the CFI table
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
Message-ID: <20190408205553.ijP7vAqY-sHct-LyEagBGbXWeDWxUDJucPSvU7xIMYQ@z>

When erasing the chip, use the typical time specified in the CFI table
rather than arbitrarily selecting 5 seconds.

Since the currently unconfigurable value set in the table is 12, this
means a chip erase takes 4096 ms so this isn't a big change in behavior.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f8a7314dee..f256049375 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -637,9 +637,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 pflash_update(pfl, 0, pfl->total_len);
             }
             set_dq7(pfl, 0x00);
-            /* Let's wait 5 seconds before chip erase is done */
+            /* Wait the time specified at CFI address 0x22. */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND * 5));
+                      (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
             break;
         case 0x30:
             /* Sector erase */
-- 
2.20.1 (Apple Git-117)



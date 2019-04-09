Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F81C282E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308E021473
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="jm48Fmkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308E021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33855 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDgEo-0001Fq-ET
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:11:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg7G-0003Qc-Ee
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg7C-0006pJ-Er
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:04:00 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:38912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg78-0006nA-FW
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:56 -0400
Received: by mail-it1-x141.google.com with SMTP id 139so2437678ita.4
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=jm48FmkwX+8OHmydGsK4/S4S/4R4b0DwL0g8XIYV3OJLRib5TKg7cwOIQUKie2t5E4
	BQNweuL84ufQ8+02PCd6HpUhgYoX31q5qGOPevKqoQ214TbX0Lnpx4c7O7vjoB/0Dxs7
	I5Hh2HSRztXUMECyk/iO1hkTjtGVUoMFhwCgI9edvhkZwCETvCfA5ILQRO/ZxV1a6cBe
	FYa1QB0Cac1oaWonBU5YQb+DyM85pXq/X29nJye/X1RHds5Zi17qfwl0KKOCdT5SYs1r
	Fmy9EbhLIx/T+rS/xAscqnarnlENk+iaO6kygdc07GwXUTI1xqOyPiuj9fyB4m11VGw2
	FrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=ePPMnpca7e95MRBdkNNQo4BoB0KrJ0FMbvKq5nCsWkuHcOw8xqyC6j4tYc0AumcXiy
	6lzOOu5hBL5nT0l+ugSBmojQANGQPURCJDzeuIjzFgydjNpp5crFvlfTW40hbhfG/A1A
	ih3mVkCO+Vw8G5iGNJne1Nqyc+6tGceIDUrcsCnhzRKdw3YlRcGlLz6FFI+yWdtWiBjf
	Uetf0LOupRx7WZ3ZxPaqFsZiFfPP3QHb68w8OwuKY00k8bAchw4r6OdP1Yax6GRdNXSX
	MK+VMyBdOgjafXt1UAXY0nGdyrsYVdYRvhYRorQyvpLlFVFgfkcW5M8ftzOHyqpfbJsg
	C6yA==
X-Gm-Message-State: APjAAAW8Dw01vvfJOhuCV++kSXuLpYK/3BtxIIPqCOs00OmULMUmAeTV
	ZKHKNI5/ZtQ+PypE/mmt7gBlD3/IukhJLw==
X-Google-Smtp-Source: APXvYqwt1c6Ea6ZLC+wq8NFn0aDTYencM92nxTmhLtauLGM6v+b74OijT1hsW+1bdx/HWX/xSx5+mQ==
X-Received: by 2002:a02:ab90:: with SMTP id t16mr24348111jan.119.1554775432722;
	Mon, 08 Apr 2019 19:03:52 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.03.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:03:52 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:34 -0400
Message-Id:
 <8f3c98364902035431d788f058b342b286cc924c.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
Subject: [Qemu-devel] [PATCH v2 10/10] block/pflash_cfi02: Use the chip
 erase time specified in the CFI table
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
Message-ID: <20190409020134.AqJJFH1Ni0vtlsYI96E-w0-j-AH_0OIH4LS_gIgX3x0@z>

When erasing the chip, use the typical time specified in the CFI table
rather than arbitrarily selecting 5 seconds.

Since the currently unconfigurable value set in the table is 12, this
means a chip erase takes 4096 ms so this isn't a big change in behavior.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index d9087cafff..76c8af4365 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -633,9 +633,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
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



Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E5C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B70217FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 22:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="cBRhkA9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B70217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGsik-0002qq-49
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 18:07:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdY-0007B6-Km
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hGsdX-0004hi-Ao
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:36 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:39946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hGsdX-0004gq-2y
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 18:02:35 -0400
Received: by mail-it1-x142.google.com with SMTP id k64so252471itb.5
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=cBRhkA9YU1lugeoSiSYA+SSJBdT2BC0Denu03GgFX/jEUViF3xzlhCx/UXgTHrmFKA
	BTHih0RJDi0Kh9xQTHvikliKohbyhdRron2+MXqLURNnJKyTKrHAJ2PVc0s3ztuppO2Y
	rCdshL2H94YAsOcc2OlassYeq1aLZcw2dQl/DRNHD9aNXXRaNs4DieRf6OCQwAsYSTx/
	2yZpXEDNlJshVEOX4LbW3VWO/3kcNIq4zf4YsDEMss9JhAvWP0c6MowYaddTsdb4Xfwu
	hPLt7jj1TiTG3vs+LYAIGXYWGreXsclZG1efQ5OdcaAlrq6WnQmpghWqym4joXIw1Blh
	RPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=SbrKcLXvzoIO0O3POVmzQ3e+IoDC5fWaxJBZNXwIr5jMpAkYuVE4vczjh5tIDoVqvn
	EMK8XZ7Zp+C+WV8B+qN7ZVnNJ1Dyy5qhu8MN8G6DrOy1rxngiPrkrTJsjKpuokMPqWwV
	fLEU+TAYPIPsO57pUYIunn0N0gStD07R4if+RejIxoG72d8yj14UzSD5ZJ6HoDnUwXhA
	vuuY6xdyJ35eiqjLkA24v+3xsrgW00/EAvseX851rYJ9Zc1ZgWWi+m+ZSnvIBG5geYFr
	wKVkMjF65tzVcoqo3GhsmuUx92AAVYI7d1hMeCYVoRzajG1WDIP3YOA+hz2pasD3a+Vm
	+09g==
X-Gm-Message-State: APjAAAUhvsmMK5BodS/AxcLg0fXs83FKn6agobypwxM8Mzzeh24NmLxs
	OwjMX1xMP6AeHhhnU4u9MtEvDVhdulzjUUge
X-Google-Smtp-Source: APXvYqzx+B3JAxESLmzbuI7WencRz8tc5K/fs294OQosfN4uchaAEmv6JxI3RuB6a9Ch2V/zhLdrbw==
X-Received: by 2002:a24:6583:: with SMTP id u125mr702178itb.151.1555538554390; 
	Wed, 17 Apr 2019 15:02:34 -0700 (PDT)
Received: from worksec.wireless.oberlin.edu (ip-70-93.wireless.oberlin.edu.
	[132.162.70.93])
	by smtp.gmail.com with ESMTPSA id e81sm147874itc.3.2019.04.17.15.02.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 17 Apr 2019 15:02:33 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Apr 2019 18:01:47 -0400
Message-Id: <20190417220147.67648-11-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
References: <20190417220147.67648-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
Subject: [Qemu-devel] [PATCH v3 10/10] block/pflash_cfi02: Use the chip
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417220147.NFvhciVmg6bnB0MNuFKvCEyzBKdPt_4_FkVk4XeayZc@z>

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



Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929EC76186
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FD52077C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 03:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTQSTtfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnxJa-0006on-7h
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 23:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnxJP-0006G0-0l
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnxJN-0007Dp-Vo
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 23:42:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnxJM-00078u-4q; Wed, 17 Jul 2019 23:42:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f17so7915932pfn.6;
 Wed, 17 Jul 2019 20:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ur9bPymZTNDLXeRjlO8b68p5gmLilZFxu0GgmM73OpY=;
 b=RTQSTtfawqvCdnHtyMuFI4viL+nUSIe1VVymoh+zvP2HLfQrQgaSKQb3yhtka0YT4f
 j70n11rmUGJOLeeRNp4SYtdjTrZKyr3FEvxwFjuVy92hXFG0XINNXd6TXzO1XOii8aTV
 bEFSGzqynXqnbWe18gH/ypW4BGyRbt6cA5eRUk0yzKrbiFSi7lisLkK+DAkqnLZaK6iY
 1DwKom+8UeC3NQwnjX96IVNx2ZNCafS4mKD/K/94QlO2zEyvxWDkK4ukSJ+MWpFT9aS2
 QIPB948lLay3kYfYpOqzIRj3ruv/yOTYXdelEDuG1MDYO4eWM6I48HaV8mRWgEFkl49G
 i4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ur9bPymZTNDLXeRjlO8b68p5gmLilZFxu0GgmM73OpY=;
 b=V/W/eKZGcTqXhZRcxBb9EF2e3I7SiYQ0rg14VflM8SncfQ5b4WNy6Ri1JIuyrDTPmo
 IsWprN8oD3Yae7pBydFGC0MeRUm5wvwWnFbJ6wqMGo6q8EeZAyKuTQX3EYjgnDEb4nuP
 YcZ7dBv6oky3ltb6hHLQVaCMKkhdTYgFqTNZDrrveOvS4V3H4fx9E/1NLiStbM8O9lfr
 nd7HvKXaVp8ztkjJ8+Khe41NAlA1z24zXxtOB4KPp7bie90S35halE6IcHTwyAn11dnn
 0cVVFvtfI9qvMIPaeUlqLcdciseBiq5vecpO+6BTn9ZBcvzvRd0CI9iDZS17SwonU4hE
 wMXg==
X-Gm-Message-State: APjAAAWTJPZNHG4DFlYN+nYPrC8LPVdxTFWZigTs7NJ7XL1eo9a8wyB2
 7I8qTk4YyA63Hy5/HIwbApA=
X-Google-Smtp-Source: APXvYqy6sZsupw5eAQA1or3/aiXJz9Nl1fXl2R/2/stK57qbYmhgP4EiATU8UfenPfs+FreZj5vtIQ==
X-Received: by 2002:a63:3203:: with SMTP id y3mr45735760pgy.191.1563421347063; 
 Wed, 17 Jul 2019 20:42:27 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id b3sm38787612pfp.65.2019.07.17.20.42.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 20:42:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:42:10 +1000
Message-Id: <20190718034214.14948-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH v6 0/4] spapr: implement dispatch and suspend
 calls
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lot of good reviews (thanks), several more bug fixes and some good
cleanups.

Thanks,
Nick

Nicholas Piggin (4):
  spapr: Implement dispatch tracking for tcg
  spapr: Implement H_PROD
  spapr: Implement H_CONFER
  spapr: Implement H_JOIN

 hw/ppc/spapr.c                  |  54 ++++++++++++
 hw/ppc/spapr_hcall.c            | 152 ++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h          |   7 ++
 include/hw/ppc/spapr_cpu_core.h |   1 +
 target/ppc/cpu.h                |   4 +
 target/ppc/translate_init.inc.c |  27 ++++++
 6 files changed, 240 insertions(+), 5 deletions(-)

-- 
2.20.1



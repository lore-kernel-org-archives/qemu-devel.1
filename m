Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EDC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C566275F1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+zvewF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C566275F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqZT-0002cX-8e
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:16:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqU7-0006x5-5S
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqU2-0003tG-9I
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:34653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqU0-0003oT-3h
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:10:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id e16so4655391wrn.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=bRzNU7pLbDF3z9hSoLufG1Um4Ru1n9Yc1bLC3gJaiBI=;
	b=P+zvewF+hqgJ7sxVqTcu/lePG6/HJKwULriDPvt1Ff+BLQfxFCsaY5JfhdNsmVAnRE
	KzyzmjPVW48GOAO8s9+WnRfJMDdR4AqFKgWeVtY5T5BIbm2A3881D0Mt9XPQIP+F0Dtn
	3BpHsd5fX1KwmJ1YMMT7TPxQ5omfj3n+4h10nPJ4bAcYd7VezRH/2JL9UCtxI+HJf2Nh
	WPv1f7C1sZtR9jjpmMKkn4pr2hXE0mPoARQ7tMx+ty0BcQyrGWHHWfp4GYvrvzwQWEBg
	nrJh9Cz7knst/PPoHYSr0bD9dJL8VfNNHJklkP3kPRlYcL6Ka9NEVgNUUoBNpaHVssRr
	4IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=bRzNU7pLbDF3z9hSoLufG1Um4Ru1n9Yc1bLC3gJaiBI=;
	b=sDOsi/hZCz+ARRoek4gqfUgOfMM+pVbTG6IXd1/325lkoJ/zVNxkbDIfo+T8BHPMvr
	dHhxjDRY6eS6PYf61veZP1YeEv5sFyFhLGL8vQqtbwOy2R5dG3OMwEmATRJHnAcUuOEc
	fRQgABe5Apvxo/niTQgGKTfNvqPSt2DB41mbdy7n5rDINE8ryb/eq+x0EnxjjrXKA4u2
	oOgL4kamNgkhpvyNZJUMbNraOPuEUIIKThENr1ed9Ehj0PyathHIgcPezlP2slShuLXj
	ZxKpBZbtSer505P1h5xEcUz4qJeeHKXSrBv7AmTGf99Xx/ETEYpjtBSCBQAag01EZxet
	+jHw==
X-Gm-Message-State: APjAAAXxtTZPanXbUg84SbbsnQpr6We5bAXCAuyCwNgpZFmRYTCenvRO
	hCKaT7MHVlJkKUX3ASxSM9mjC2nE
X-Google-Smtp-Source: APXvYqyLOURkgQtuOJBlfDpnznfJTquHUeATReBvA9w45U3125q88MaXCER4jUXzjUknZsDv3c9gMg==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr1549199wrs.151.1559581850680; 
	Mon, 03 Jun 2019 10:10:50 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:23 +0200
Message-Id: <1559581843-3968-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 04/24] memory: Remove memory_region_get_dirty()
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
Cc: Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

It's never used anywhere.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190520030839.6795-5-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 17 -----------------
 memory.c              |  8 --------
 2 files changed, 25 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9144a47..e6140e8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1255,23 +1255,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client);
 
 /**
- * memory_region_get_dirty: Check whether a range of bytes is dirty
- *                          for a specified client.
- *
- * Checks whether a range of bytes has been written to since the last
- * call to memory_region_reset_dirty() with the same @client.  Dirty logging
- * must be enabled.
- *
- * @mr: the memory region being queried.
- * @addr: the address (relative to the start of the region) being queried.
- * @size: the size of the range being queried.
- * @client: the user of the logging information; %DIRTY_MEMORY_MIGRATION or
- *          %DIRTY_MEMORY_VGA.
- */
-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
-                             hwaddr size, unsigned client);
-
-/**
  * memory_region_set_dirty: Mark a range of bytes as dirty in a memory region.
  *
  * Marks a range of bytes as dirty, after it has been dirtied outside
diff --git a/memory.c b/memory.c
index 3071c4b..0920c10 100644
--- a/memory.c
+++ b/memory.c
@@ -2027,14 +2027,6 @@ void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
     memory_region_transaction_commit();
 }
 
-bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
-                             hwaddr size, unsigned client)
-{
-    assert(mr->ram_block);
-    return cpu_physical_memory_get_dirty(memory_region_get_ram_addr(mr) + addr,
-                                         size, client);
-}
-
 void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size)
 {
-- 
1.8.3.1




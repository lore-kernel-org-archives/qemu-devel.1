Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61274C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386572087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386572087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzwWp-0008M2-8M
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 01:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzwVU-0006oc-AJ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzwVT-0004ye-91
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzwVT-0004yL-0s
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:31 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59C5C31D8B6
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:16:30 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id q67so4002697pfc.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 22:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0AIXG9YRNIS5SGJJHqBAwB0d5gG3AkFqHgKovn1v0A8=;
 b=jGm8btlZtmYzK482t81+TS5yu3oAz9xjPAMVj6hoIBD6M9rfdyu+MYyIHtSagA1vcY
 MYdh1ud98aTebIYWJEvHpydM8aQATA+eB93TwJs9hQiF40KVLaGen5tZdMjIgc1TSNQE
 OLeE9hS6V5zkLSZFvYBONWLmvtLTJVopJiw9rwKeAjfyx2fikQBmZZfM/Vv5L/6rb41M
 QycDBsojS1HYTM5hHTPLj1TYedyJhrZI85bfAtewZNuv7ZXD+HTFZu6KsaeNnlOfb3Js
 REAbqHJbGYsFiLxuIk9UdNSS38c3L2cJZLBodxxnBgn7sifD0++pOMkLzDyQCUFkxbDU
 hymQ==
X-Gm-Message-State: APjAAAXttYwA7yt+aO3u55tcpYaCGS4kmpcq/kF3DBUZ/ZjO3XAK/CqA
 ZQtknEHQw2dqj6X7uPTujGb0ppAcytTSbo+zI585Cf9D0Ywg8Dkr6UUZbl7x5+RcxOCmMyn0xDL
 uFWt0POit9++XPHw=
X-Received: by 2002:a62:7641:: with SMTP id r62mr27039470pfc.201.1566278189225; 
 Mon, 19 Aug 2019 22:16:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyFdwoHpQ1+vrz8r30/Titx8drXstHIaRhv8tHi75qTA5d9sEnL8MyQ//CmgkGPj3nIr/7Vw==
X-Received: by 2002:a62:7641:: with SMTP id r62mr27039455pfc.201.1566278189068; 
 Mon, 19 Aug 2019 22:16:29 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e6sm17462610pfn.71.2019.08.19.22.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 22:16:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 13:16:14 +0800
Message-Id: <20190820051615.1210-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820051615.1210-1-peterx@redhat.com>
References: <20190820051615.1210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/2] memory: Inherit has_coalesced_range
 from the same old FlatRange
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous has_coalesced_range counter has a problem in that it only
works for additions of coalesced mmio ranges but not deletions.  The
reason is that has_coalesced_range information can be lost when the
FlatView updates the topology again when the updated region is not
covering the coalesced regions. When that happens, due to
flatrange_equal() is not checking against has_coalesced_range, the new
FlatRange will be seen as the same one as the old and the new
instance (whose has_coalesced_range will be zero) will replace the old
instance (whose has_coalesced_range _could_ be non-zero).

To fix it, we inherit the has_coalesced_range value from the old
FlatRange to the new one if it's describing the identical range when
updating the topology.

Without this patch, MemoryListener.coalesced_io_del is hardly being
called due to has_coalesced_range will be mostly zero in
flat_range_coalesced_io_del() when topologies frequently change for
the "memory" address space.

Fixes: 3ac7d43a6fbb5d4a3
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/memory.c b/memory.c
index 8141486832..c53dcfc092 100644
--- a/memory.c
+++ b/memory.c
@@ -939,6 +939,15 @@ static void address_space_update_topology_pass(Addre=
ssSpace *as,
             /* In both and unchanged (except logging may have changed) *=
/
=20
             if (adding) {
+                /*
+                 * We must inherit the has_coalesced_range information
+                 * if the new FlatRange is exactly the same as the old
+                 * one, because it'll be used to conditionally call
+                 * the coalesced mmio deletion listeners correctly in
+                 * flat_range_coalesced_io_del() when the FlatRange
+                 * needs to really go away.
+                 */
+                frnew->has_coalesced_range =3D frold->has_coalesced_rang=
e;
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region=
_nop);
                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, lo=
g_start,
--=20
2.21.0



Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F5BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2936C214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04xH-0006Ps-4i
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i04tS-0002Wl-Qx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i04tR-0007Qu-SK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i04tR-0007QO-NA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:49 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1006A89AC2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:13:49 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id f5so4174769plr.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2PxH9JaNXkeuvOjhzmhEfzKK45LxMRv9xnnAwcfD0eo=;
 b=PMBywFCsFNwwcPRGNb3ro9t4B7gT5R1gAqHLZ1/OSZeYFAn+vD21Uck1jy9lX9CM8l
 dlv9hMvzD/dMEFlY9mwCFA0DS8PikG1xaz7rQLSzLVY22f4UdY8rdo00HN9cUVkH+bBD
 OBds7fUt0SXQLaG9Hs1VIud4D8C1Gb/8SW4M8O+k0ZMXINYK99m05CI5/dkJskp4RrWm
 kh9hLgInxATKIHaiwFtLXydk1U+qEB4ssCJ9O1dsy/6w1iRvRcE0siEQ4JzoLPkyZvff
 fet0M7Qwa+YphPv72J36/djJLrXruO4nBFpz7OA4fnjPclbgkwZQ6u9CU2iaZohY0XnG
 MkxQ==
X-Gm-Message-State: APjAAAVod3p7TjTL/5477ybndLb83FkBskgadUvwOCj0rwngBzwNcU+Q
 9HKDXP4QrkNKF7gxGRUcGsHvf54OHtrrhZU72muJOdlbcymdXr2J0F8bWjAjv4QN4mOyPhPpAS3
 3il8ZSGAudZbMnwY=
X-Received: by 2002:a17:902:7c8a:: with SMTP id
 y10mr27982683pll.65.1566310428281; 
 Tue, 20 Aug 2019 07:13:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzhd+5Ot7CHyzqOniQ30wJxCNFI+sApSy093OVkQHhamL8alwAGuGSUJefUBqzFqiIHcOkQRQ==
X-Received: by 2002:a17:902:7c8a:: with SMTP id
 y10mr27982664pll.65.1566310428133; 
 Tue, 20 Aug 2019 07:13:48 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e185sm9057921pfa.119.2019.08.20.07.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 07:13:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 22:13:27 +0800
Message-Id: <20190820141328.10009-4-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820141328.10009-1-peterx@redhat.com>
References: <20190820141328.10009-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/4] memory: Refactor
 memory_region_clear_coalescing
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

Removing the update variable and quit earlier if the memory region has
no coalesced range.  This prepares for the next patch.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/memory.c b/memory.c
index 360e0cfa67..2f7a67086a 100644
--- a/memory.c
+++ b/memory.c
@@ -2283,7 +2283,10 @@ void memory_region_add_coalescing(MemoryRegion *mr=
,
 void memory_region_clear_coalescing(MemoryRegion *mr)
 {
     CoalescedMemoryRange *cmr;
-    bool updated =3D false;
+
+    if (QTAILQ_EMPTY(&mr->coalesced)) {
+        return;
+    }
=20
     qemu_flush_coalesced_mmio_buffer();
     mr->flush_coalesced_mmio =3D false;
@@ -2292,12 +2295,9 @@ void memory_region_clear_coalescing(MemoryRegion *=
mr)
         cmr =3D QTAILQ_FIRST(&mr->coalesced);
         QTAILQ_REMOVE(&mr->coalesced, cmr, link);
         g_free(cmr);
-        updated =3D true;
     }
=20
-    if (updated) {
-        memory_region_update_coalesced_range(mr);
-    }
+    memory_region_update_coalesced_range(mr);
 }
=20
 void memory_region_set_flush_coalesced(MemoryRegion *mr)
--=20
2.21.0



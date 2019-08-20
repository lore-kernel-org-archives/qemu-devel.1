Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35F7214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35F7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04v3-0003h4-Fy
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i04tQ-0002SM-8i
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i04tP-0007NM-7w
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i04tP-0007Mj-0z
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:47 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52B6C793FF
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:13:46 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id l11so4682999pgc.14
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ubAKcy3NY2gpBzdykwWOXUonxN5dGIVc7Web/xo6k04=;
 b=ULDxRpEtcuhO87PcJX/2Bx3UnAZhHx0bGdthDvLgteWAcId2iD1NsWJRgy9PRHFHT3
 SXF0d6z27UJ4brfh/UJ4KGT6t2uRERN/gd9Me6M72es1sZOzKmJSHYtccIWudGhrJclY
 7oK+r2gvCH/H0hoXYOxfygYUMrsn2yCpIrM9EJShn9qux0EGbE8Z7v8E+6MNRmftAA/C
 Mfh7QkHKB4HLcdAx5mY8yGgWZ65It+UuFnQnTWdw+9/eFMQYNAhqFEcKZ9JEHMQ/UIqP
 8xDOZsLnTW/zVnN2p8JG/uKYUYRh3i/TKatlFG+fumiymLpjCVKYelP03r486FKxPhji
 Defg==
X-Gm-Message-State: APjAAAXpv9oiBd99f2zzs6S5edX2luz6copSMFtMs5My61mxS7h2VBZW
 2O0Dta1qxkOpRfj+HeL1UllnKY115CqCp5oqofKPygQ5UbWPVcawPXGV66HREGt8xXKHStiGydY
 xjYfF/GkTvnJJ6So=
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr30859839pfj.8.1566310425531; 
 Tue, 20 Aug 2019 07:13:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqws+yms14Sv0pSupjYMPjs9nTbNvtj2TulTMrlvZNEzxSV6QEcGTN1yShiioMUKWqRl7MDArg==
X-Received: by 2002:aa7:9a52:: with SMTP id x18mr30859827pfj.8.1566310425368; 
 Tue, 20 Aug 2019 07:13:45 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e185sm9057921pfa.119.2019.08.20.07.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 07:13:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 22:13:26 +0800
Message-Id: <20190820141328.10009-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820141328.10009-1-peterx@redhat.com>
References: <20190820141328.10009-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/4] memory: Remove has_coalesced_range
 counter
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

The has_coalesced_range could potentially be problematic in that it
only works for additions of coalesced mmio ranges but not deletions.
The reason is that has_coalesced_range information can be lost when
the FlatView updates the topology again when the updated region is not
covering the coalesced regions. When that happens, due to
flatrange_equal() is not checking against has_coalesced_range, the new
FlatRange will be seen as the same one as the old and the new
instance (whose has_coalesced_range will be zero) will replace the old
instance (whose has_coalesced_range _could_ be non-zero).

The counter was originally used to make sure every FlatRange will only
notify once for coalesced_io_{add|del} memory listeners, because each
FlatRange can be used by multiple address spaces, so logically
speaking it could be called multiple times.  However we should not
limit that, because memory listeners should will only be registered
with specific address space rather than multiple address spaces.

So let's fix this up by simply removing the whole has_coalesced_range.

Fixes: 3ac7d43a6fbb5d4a3
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 memory.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/memory.c b/memory.c
index 8173f6be62..360e0cfa67 100644
--- a/memory.c
+++ b/memory.c
@@ -217,7 +217,6 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
-    int has_coalesced_range;
 };
=20
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -654,7 +653,6 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode =3D mr->romd_mode;
     fr.readonly =3D readonly;
     fr.nonvolatile =3D nonvolatile;
-    fr.has_coalesced_range =3D 0;
=20
     /* Render the region itself into any gaps left by the current view. =
*/
     for (i =3D 0; i < view->nr && int128_nz(remain); ++i) {
@@ -888,14 +886,6 @@ static void flat_range_coalesced_io_del(FlatRange *f=
r, AddressSpace *as)
 {
     CoalescedMemoryRange *cmr;
=20
-    if (!fr->has_coalesced_range) {
-        return;
-    }
-
-    if (--fr->has_coalesced_range > 0) {
-        return;
-    }
-
     QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
         flat_range_coalesced_io_notify(fr, as, cmr, false);
     }
@@ -910,10 +900,6 @@ static void flat_range_coalesced_io_add(FlatRange *f=
r, AddressSpace *as)
         return;
     }
=20
-    if (fr->has_coalesced_range++) {
-        return;
-    }
-
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         flat_range_coalesced_io_notify(fr, as, cmr, true);
     }
--=20
2.21.0



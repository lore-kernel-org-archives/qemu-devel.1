Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E702C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B3420578
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B3420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Dso-00038X-50
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i6Drc-0002gC-Ah
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i6Dra-0002UL-6a
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i6Dra-0002St-07
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:01:18 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 976F7796E9
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 13:01:16 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id v15so4516178pfe.7
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 06:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lL1moXYI5g6KK6FwXJ6Li1H8CgN3SoepTEzdoFZG3rQ=;
 b=j+Dr1fi3r287HUPzL73B7XB/PN97RFta0VSQo003L4sP/SQ7AanmZeA6iT2NSjZSve
 6TZBuezJX6FfPCdkCWTXZXK+T+PGUHWtBvKrMpZKEEFRhqC6K/WB/AtoJOJLcIirPxZk
 vbEIeBT5eQkEF3++IcWpq5RXbKo5RLSx3mfkHxBkoECKiDKq6GiPer5XdmWP9WXDvISo
 kPO/8xyLN8U944e0Ml38jhg/ZyGP1ddyWiXAMdemHks3j2fjtlC8VdbZEKYJqNO2CQth
 FH5wEswnpbi/3wsPmYuGhLTw3BDAMNRHcuYXprL2Dz4Mb/gNLjhVPPf1D1Mz7CN+938D
 bJNg==
X-Gm-Message-State: APjAAAXq2QG7lt0Gm6WMq1v47Vr76hi4xDH/ZJgZwm+cykIrjlPXGpNI
 SLkWZyvgOxEeKK3RAldKAN+TtYS1lJQPuJGzYvgRgFSnGBNFlbFvQOXLJYV5mhAAVEbdft5QUc7
 FGTvBjUVl06X7LiA=
X-Received: by 2002:a17:90a:c687:: with SMTP id n7mr9118488pjt.3.1567774875393; 
 Fri, 06 Sep 2019 06:01:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyiqYUKbFAaiS2zAyJBeWIR/EbWiCIsKJgCS/6ChL59YhEtBj31z5m6a/EsmrOGHGnKE83RLw==
X-Received: by 2002:a17:90a:c687:: with SMTP id n7mr9118457pjt.3.1567774875112; 
 Fri, 06 Sep 2019 06:01:15 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o64sm4880342pjb.24.2019.09.06.06.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 06:01:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 21:01:03 +0800
Message-Id: <20190906130103.20961-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] migration: Fix postcopy bw for recovery
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
Cc: Laurent Vivier <lvivier@redhat.com>, Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've got max-postcopy-bandwidth parameter but it's not applied
correctly after a postcopy recovery so the recovered migration stream
will still eat the whole net bandwidth.  Fix that up.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8b9f2fe30a..b307813aa3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3327,7 +3327,8 @@ void migrate_fd_connect(MigrationState *s, Error *e=
rror_in)
=20
     if (resume) {
         /* This is a resumed migration */
-        rate_limit =3D INT64_MAX;
+        rate_limit =3D s->parameters.max_postcopy_bandwidth /
+            XFER_LIMIT_RATIO;
     } else {
         /* This is a fresh new migration */
         rate_limit =3D s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
--=20
2.21.0



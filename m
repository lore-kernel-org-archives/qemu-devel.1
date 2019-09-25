Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D015C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615C02146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615C02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8N4-0002zR-2r
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8J8-0000bu-B2
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8J7-00070j-5p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8J7-00070H-07
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:17 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34A56C40BF
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:30:16 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id x26so6046383qtr.17
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ftfWxM+zsKCiRTl9X7Xq8J1GI2lASFD0yPDy8wdv8aM=;
 b=qGOSiPxZBmv7uEve6yhmhGj/uVwW7U+3fBydoAMtTlb1FQQf4K2EcUd+ThOCELwLCj
 67KUJolIQG9Pk6YYwqvZDc12m3UVJtmSFKqqMvio0tJqDtDf4CaipbF/RgM935p2XtOZ
 3paAMBCrZijY8UQk+CYLMqcLA6Yu1sAKnh/bNqBS92rHSIXDmZ5g2ymQVPbx6MRZzWbe
 DtzVhIaofuUa1E7pOJS6zORpAuSntr4Cht38CzHpy4gUN9Xh1dBY4baEU1h8mK43sspB
 ufkeLsHngYRBHLBd7/yHCruJLyMaptCfzfbHjtCgtGE3gOQbbUWRkmW1/s5jHGbOzyPt
 qclQ==
X-Gm-Message-State: APjAAAVIqPKfShgAvNC0IncCoE7v8bCWBNwjti0UfA+XWVfCmE1VEysZ
 YtI0lzWG3ArioM5XagqWoe7BRo2xdkxa7lyKILalg8iUyiT94O4yw9PwUtD+8zjyDJeJHbi5bBX
 qm95Z03xA8pxk77U=
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr3777864qke.251.1569421815153; 
 Wed, 25 Sep 2019 07:30:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvOKc0M3yGRz0B3wSIMEA1yoNSoRkFcq1TnWdagveUW8T7GCAuOFNz0B8RapLryygbkI16PA==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr3777832qke.251.1569421814953; 
 Wed, 25 Sep 2019 07:30:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id w34sm4228790qth.84.2019.09.25.07.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:30:14 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] memory: Align MemoryRegionSections fields
Message-ID: <20190814175535.2023-2-dgilbert@redhat.com>
References: <20190925142910.26529-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190925142910.26529-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190925143010.y-8Krww6ql1NLEwvASLyLOdDwnhizrpfPNrI714oPhY@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

MemoryRegionSection includes an Int128 'size' field;
on some platforms the compiler causes an alignment of this to
a 128bit boundary, leaving 8 bytes of dead space.
This deadspace can be filled with junk.

Move the size field to the top avoiding unnecessary alignment.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190814175535.2023-2-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index a30245c25a..a1e6d846cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -495,10 +495,10 @@ static inline FlatView *address_space_to_flatview(A=
ddressSpace *as)
  * @nonvolatile: this section is non-volatile
  */
 struct MemoryRegionSection {
+    Int128 size;
     MemoryRegion *mr;
     FlatView *fv;
     hwaddr offset_within_region;
-    Int128 size;
     hwaddr offset_within_address_space;
     bool readonly;
     bool nonvolatile;
--=20
MST



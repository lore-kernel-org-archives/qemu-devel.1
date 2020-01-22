Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA2CC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AA42465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyfbOuJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AA42465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuA04-0000y2-Ap
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qc-00050j-DR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qb-0008E7-54
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58523
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qb-0008Dq-1c
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUTzXG5c0P/cfpSyLzCfAtskYDWEcm5+URpIdvpUQzQ=;
 b=WyfbOuJbSznrZiBbYF2T5yJYfLZ/WJ64Sf4wzpNLYdOpFzXD3EC3ST8vjJxoCH0kbJamrs
 TIcOCkh2J9DhmgGz4T+lEQF5LvMNRzh7IBtNXpdcttuCHZfo2pm7uZ+oY3bqSIO+oENP35
 9PBlLou8EvdNXIkoM+QBs23nTz4G6xQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Yhx5HnvWOj2EF_77E-P4pQ-1; Wed, 22 Jan 2020 01:50:38 -0500
Received: by mail-wr1-f71.google.com with SMTP id f17so2598792wrt.19
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=miOqrXp0EkoFa9QINKw9BvmGX6vXumq1+xiaY2GCJjQ=;
 b=pecB/Z9W5kVDqmYEWI++MQ8AR5tjNLeD+QPmug0Z3oQham/4ydmRkweKJ1gIkVewvM
 OK+AZFIKn27KWMQ8HSGzvyCi8RRYfV+ZGToYgrU7ybZ+YGGrgqCm3TyEU5JEhQTVJ73S
 glKmTk+xAHEFGnoC4sjGK4lkKrSa0MsAE+M8mZ2lbKeNkVesaPbZjY0s+MfPrzhtMFrR
 xjgYjp0UH8ZToaMMiGzorXuB4l9ynbqsrthJi9+GuHmVT+79xLX41TSo5PvgXs041TKy
 OF+g7uAtFauchLvLqAnvqoPgnB6uLHG397ABTZO0ITT5FqxyWW/mkD2yR7uwp5fdjUw/
 C2iA==
X-Gm-Message-State: APjAAAVeO1APAJjHUccVYYLaVHHkpNux551HoxhKqFK8vFwC6MZ4kbIz
 lB/vEv4LNA+OAjR207D2GxZIWOiz3fOrMm2MJUH9Fea1zZxOpGK2hKrkixfaJAzINQc2bSiSZ+w
 j/+ImXCjj64vBeZs=
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr9225563wrf.174.1579675837038; 
 Tue, 21 Jan 2020 22:50:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjh52+qS1ilGDb234D6YPFTtWYiQLaUxKthR5iBPmnKs70yKOCVw1eRwV23h1WXT0VQhOl2w==
X-Received: by 2002:a05:6000:367:: with SMTP id
 f7mr9225543wrf.174.1579675836813; 
 Tue, 21 Jan 2020 22:50:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 d23sm2365597wra.30.2020.01.21.22.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:36 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/17] vhost: Only align sections for vhost-user
Message-ID: <20200122064907.512501-17-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Yhx5HnvWOj2EF_77E-P4pQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I added hugepage alignment code in c1ece84e7c9 to deal with
vhost-user + postcopy which needs aligned pages when using userfault.
However, on x86 the lower 2MB of address space tends to be shotgun'd
with small fragments around the 512-640k range - e.g. video RAM, and
with HyperV synic pages tend to sit around there - again splitting
it up.  The alignment code complains with a 'Section rounded to ...'
error and gives up.

Since vhost-user already filters out devices without an fd
(see vhost-user.c vhost_user_mem_section_filter) it shouldn't be
affected by those overlaps.

Turn the alignment off on vhost-kernel so that it doesn't try
and align, and thus won't hit the rounding issues.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200116202414.157959-3-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vhost.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 774d87d98e..25fd469179 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -547,26 +547,28 @@ static void vhost_region_add_section(struct vhost_dev=
 *dev,
     uintptr_t mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->m=
r) +
                          section->offset_within_region;
     RAMBlock *mrs_rb =3D section->mr->ram_block;
-    size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
=20
     trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
                                    mrs_host);
=20
-    /* Round the section to it's page size */
-    /* First align the start down to a page boundary */
-    uint64_t alignage =3D mrs_host & (mrs_page - 1);
-    if (alignage) {
-        mrs_host -=3D alignage;
-        mrs_size +=3D alignage;
-        mrs_gpa  -=3D alignage;
+    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
=20
+        /* Round the section to it's page size */
+        /* First align the start down to a page boundary */
+        size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
+        uint64_t alignage =3D mrs_host & (mrs_page - 1);
+        if (alignage) {
+            mrs_host -=3D alignage;
+            mrs_size +=3D alignage;
+            mrs_gpa  -=3D alignage;
+        }
+        /* Now align the size up to a page boundary */
+        alignage =3D mrs_size & (mrs_page - 1);
+        if (alignage) {
+            mrs_size +=3D mrs_page - alignage;
+        }
+        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa,=
 mrs_size,
+                                               mrs_host);
     }
-    /* Now align the size up to a page boundary */
-    alignage =3D mrs_size & (mrs_page - 1);
-    if (alignage) {
-        mrs_size +=3D mrs_page - alignage;
-    }
-    trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa, mrs=
_size,
-                                           mrs_host);
=20
     if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
--=20
MST



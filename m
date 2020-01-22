Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CBFC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29592465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uz8CSCNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29592465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuA4F-0005Ug-17
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iu9qY-0004uq-R6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iu9qX-0008BY-Os
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iu9qX-0008BE-LC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rfFv49LFSLdXK1/7HJzZJqCabeu5CMr+Q9T61Qs2V4s=;
 b=Uz8CSCNtz5tnjCjyg/srLIow9GUMJ4hQ+XEmHDn6z4lL+KWbrJlk0KyvpUGyZmD6y0x+mG
 xw5IwZg9eHosx2VaVMKhF7gkVtnQLbufNt14PVAds9+WgbbYGzfNt6WxHfpS2PmB6OO3Wm
 xPN7UGgtbHuMoQI1jrYEaCVstu2Ylg4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-WeUBRaM0OKmpUZ9cKInegg-1; Wed, 22 Jan 2020 01:50:35 -0500
Received: by mail-wr1-f72.google.com with SMTP id k18so2613582wrw.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 22:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EdvlCEDlyygl5LZfs8930w7NjWVUhDfxRmswNGuyQBQ=;
 b=naHdCSjzRTPqZhpxNzpOWDYcsfQmgpKxKBYmiwntRwwHF8Oe2o4pikUPabR15OTnpd
 YjCNLDmVHt7O4j/LlP0AYBtPx8F9nS8Q4SLdazgqJfbVPfjqcFZvI+OnyZQiUynULQA7
 plamTmZ29Q9xUstQmTMzWvjaiJHupwifPSv2NuwpubZcb15d4d+xYr1WaRSajc9SnsCz
 MBjhk/CseUHmeuhzga3oj2zN+FWacNr9H/ae5IvqLQxGxx2Siuy6YnEn5Eo18DrD7urC
 twyZxbQeWibt6uO9F4XtHgvv0yD6gJgwdWkNz6zniS57qz6i7Mh7xM3uPRbaSBn33ITi
 aBFA==
X-Gm-Message-State: APjAAAVRUqhT7ggnWIdFzBrxSZny6xN6V8ecCTMgZZLzK8Hk1M8Gb46D
 t6JGkgDSzwOrkc2NCSUa7OUlhqO6ktf0Hp3ZWeobUK25K13oUPyjdRymR+8OVmBS4RB3uHO3DUM
 EwWTBvKeSsiAMzlU=
X-Received: by 2002:a5d:558d:: with SMTP id i13mr9227189wrv.364.1579675834355; 
 Tue, 21 Jan 2020 22:50:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7WPklQFNZv/KRAo/tjmw3visjEB2U/g6CsYfvPiLgDG/ZnjC7EmzvQ8FBLyivLKVwzbwucQ==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr9227174wrv.364.1579675834166; 
 Tue, 21 Jan 2020 22:50:34 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 c4sm2560063wml.7.2020.01.21.22.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 22:50:33 -0800 (PST)
Date: Wed, 22 Jan 2020 01:50:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/17] vhost: Add names to section rounded warning
Message-ID: <20200122064907.512501-16-mst@redhat.com>
References: <20200122064907.512501-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200122064907.512501-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: WeUBRaM0OKmpUZ9cKInegg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the memory region names to section rounding/alignment
warnings.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200116202414.157959-2-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4da0d5a6c5..774d87d98e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -590,9 +590,10 @@ static void vhost_region_add_section(struct vhost_dev =
*dev,
              * match up in the same RAMBlock if they do.
              */
             if (mrs_gpa < prev_gpa_start) {
-                error_report("%s:Section rounded to %"PRIx64
-                             " prior to previous %"PRIx64,
-                             __func__, mrs_gpa, prev_gpa_start);
+                error_report("%s:Section '%s' rounded to %"PRIx64
+                             " prior to previous '%s' %"PRIx64,
+                             __func__, section->mr->name, mrs_gpa,
+                             prev_sec->mr->name, prev_gpa_start);
                 /* A way to cleanly fail here would be better */
                 return;
             }
--=20
MST



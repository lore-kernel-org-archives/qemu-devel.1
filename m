Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB9C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011A4217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnEx0CxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011A4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWrc-0005mm-Tg
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdx-0006p2-2H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdv-0000Bm-Vn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdv-0000BK-RC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jbGyeuMwv2CGwDe+4+FRf90DJhJt/iFUIQrlaWheaQ=;
 b=RnEx0CxZYu7V6twGpgOBGzb2ExcxnfHbg/PHr13ZP9bZ09676Zgo7q7vubf17/D5e50Kta
 Vpm220do9QmMWF2yHT0SXm6r56ra8RSSWhyrh+vVoQUAVpoTxRkRF3wcAt3Se9ijB6iYxp
 O8AkEojuPTZ9A2aR7kwKHyDHmdPuhtY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-gNZp70aSPHmD-NP_8CEJxw-1; Thu, 23 Jan 2020 02:11:06 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so1299877wrm.16
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=am4EjmW9E48Zpqsim6RC+G3gEvfWGSqcNR38rpxPe+M=;
 b=fIQmDxIMx1xJFhqtxtkl5QZqlp9CV83Hdl69TnrHLEHV3mAt1sbeTuBy5cVQGYKTre
 BXjkYuGOkJFuAm1doMw77rFTQwJQ01KZuNe4yl7/rpKmI7qLj7Pd64YLfvQLH761pkjt
 4Hffjc3/Q5/cNESYh2xCUphutOKCqcOR1JR5IbnahJegshCef2fFr4eY5ed2b/KcVvvT
 PoEe37gCF+UBv75rkxm3zNaZv8Tp0ohQDJoD+5LTqvAurlbW+Hrd23Bzm5/d5mamzlVS
 EkHV9hQHiz0hw6TJy/DEFInEGMllXqUkJqmcHXIDTECfmNsjo8gsQz/fkkUDLJcqHz7G
 CARg==
X-Gm-Message-State: APjAAAVBzLabTkNpCt2LkKeA7EECct4Rx1jUZltgt98edp/elgEw7Yte
 yNgC66Y5/lGbcvoslYOX4Ufj8QEOq/pLB2cFn9GKm4/9A/Wgs62bGhGgZasEknNq9TJQqff9tvN
 qp80IcWW2BSdq9u8=
X-Received: by 2002:adf:f003:: with SMTP id j3mr16319794wro.423.1579763464601; 
 Wed, 22 Jan 2020 23:11:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyh/YOeDXA82fIQsmivjUPn5GpAPYFxlITkjzl8aen09sNsHgnqRP5zRDo/L3pnVvTCK/s2KA==
X-Received: by 2002:adf:f003:: with SMTP id j3mr16319780wro.423.1579763464435; 
 Wed, 22 Jan 2020 23:11:04 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 k16sm1967199wru.0.2020.01.22.23.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:11:03 -0800 (PST)
Date: Thu, 23 Jan 2020 02:11:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 18/18] vhost: coding style fix
Message-ID: <20200123070913.626488-19-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: gNZp70aSPHmD-NP_8CEJxw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop a trailing whitespace. Make line shorter.

Fixes: 76525114736e8 ("vhost: Only align sections for vhost-user")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 25fd469179..9edfadc81d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -551,7 +551,7 @@ static void vhost_region_add_section(struct vhost_dev *=
dev,
     trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
                                    mrs_host);
=20
-    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
=20
+    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {
         /* Round the section to it's page size */
         /* First align the start down to a page boundary */
         size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
@@ -566,8 +566,8 @@ static void vhost_region_add_section(struct vhost_dev *=
dev,
         if (alignage) {
             mrs_size +=3D mrs_page - alignage;
         }
-        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa,=
 mrs_size,
-                                               mrs_host);
+        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa,
+                                               mrs_size, mrs_host);
     }
=20
     if (dev->n_tmp_sections) {
--=20
MST



Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11853C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7122253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceiKSfQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7122253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuB5y-0002tL-Vh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuB4L-00014P-7g
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuB4K-0007mD-6A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuB4J-0007lh-Oj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579680535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7jbGyeuMwv2CGwDe+4+FRf90DJhJt/iFUIQrlaWheaQ=;
 b=ceiKSfQliLlFe4JtR+FCRuqY4ImfuLU1RNoxNxC/gG09mv0B0m8ioxiMsVR9Zy5hg737bP
 LdXGM5VrCAx+0z6w2Ca2Uutn9kADF3D01grNsaEMrrV8d1iqwivdOSP5ZcQiMKcv1tK/LI
 5RWX9QKfAN4U7wjNIEdtrdYRuN+w4fA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-BhE86HY7PcGrtnSIe6cAGA-1; Wed, 22 Jan 2020 03:08:53 -0500
Received: by mail-wm1-f69.google.com with SMTP id 18so1720584wmp.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=am4EjmW9E48Zpqsim6RC+G3gEvfWGSqcNR38rpxPe+M=;
 b=PUKx0qZeY8UYfivAdRwKXt1kSDAkbt/YrUtir4kfRGbpv5c5T6bhZ7ENHYIjy2y0IR
 iYCMaOJoKxSvBI7uSijYsFRouhHVwDSkXp3Kyn44gFUjs5UwsA36044lVFDpX0wBCHpt
 Q5qf5dCNosYvDfko+02+gsNEjavGvCtU8zJXsMNJABvEAsdvlXtRmNIvPRIAFqHbBfGh
 4z2XJm8QOWvVjyPDDF76f9whd7kPsZobqoJ50bxYuNu+wBFP4Co3JIRK1g1uVsEnqKzL
 LcZ6XNyCLGrI7rT8fTyel75NqGvJ+07mCInp4PzelHwyFnt/7RnWp6OAxvPqeMRugMrl
 ivnA==
X-Gm-Message-State: APjAAAX+2g1fZ38uNFJfr5J5pmxG2r1eGkmPJFcWu2kXwIUpr3rsYHq6
 d4M91ih7gh4ikNN/DhsNzpCljBFVX+UwvsF9XLiWjqr4unXy2NrcAcU7zi0uFIT3upbb5TO0C1N
 vaxOXDrDS4H+aBq4=
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1635057wmk.50.1579680532034; 
 Wed, 22 Jan 2020 00:08:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrZOzsPTrSqe1EBoOCeqZIekp8akD6S4z76xWyyQgINF0VSqBAyqI8TLorxk5OAbuHuJUwuA==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr1634997wmk.50.1579680531355; 
 Wed, 22 Jan 2020 00:08:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 m7sm56021634wrr.40.2020.01.22.00.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:08:50 -0800 (PST)
Date: Wed, 22 Jan 2020 03:08:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost: coding style fix
Message-ID: <20200122080840.592054-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: BhE86HY7PcGrtnSIe6cAGA-1
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
Cc: dgilbert@redhat.com
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



Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE6C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D38206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4vjEyjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D38206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBhp-0008Bw-FO
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isBgp-00073w-2C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isBgn-0006bF-67
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isBgn-0006aW-2G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNez6IxU3/7Q9hEtGYz6qTWwUPHKrvmn+EW+Tm1OE9s=;
 b=c4vjEyjgSUHCC8hVvGunBDZbSOl2Z2GdtwtVb1vql2EuMnQzuyH5LIcIp0Vx5wDnhzO/MB
 +eiA9nbBtJAfUuTmu5fUsgs5mREgF4Yof2sRllAYKQMrsA7rY+gkgIyyy4lFJseU7bq//d
 jolDH+v760950RuHkdlhKYmiV76jSkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-tcw-HadSNRmVyVeC7BsegQ-1; Thu, 16 Jan 2020 15:24:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD7C800D4E
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 20:24:21 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97FBA5C1D8;
 Thu, 16 Jan 2020 20:24:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v3 1/2] vhost: Add names to section rounded warning
Date: Thu, 16 Jan 2020 20:24:13 +0000
Message-Id: <20200116202414.157959-2-dgilbert@redhat.com>
In-Reply-To: <20200116202414.157959-1-dgilbert@redhat.com>
References: <20200116202414.157959-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: tcw-HadSNRmVyVeC7BsegQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the memory region names to section rounding/alignment
warnings.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
2.24.1



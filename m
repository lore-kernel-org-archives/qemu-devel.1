Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B38C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC9206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dvwu6Brc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC9206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c69-0005hc-N9
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6bve-00038t-Qv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6bvb-0002B3-6R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6bvb-0002AX-1C
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUkymaXxsrUBHOeYB4neDB0KIBMTPed4qcRzCegXv08=;
 b=Dvwu6BrcZcfVQoU+e923dnYUmP2gMhN9ELaC/JNybLSCgtBGgUGYiHwoiKtaRndMIWhGGY
 wUpqid+J1bW/sp3H4dMixcyyjdB61Hb1VX66MN+viyfEtCqavA7WEDmLfZy0PUU10JaJ2G
 37Fl+64ry+woHB/mGGpu3psMOQ3fB7A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-Jz5AhUd2PIqNZ4mmaqn_iw-1; Tue, 25 Feb 2020 10:15:13 -0500
X-MC-Unique: Jz5AhUd2PIqNZ4mmaqn_iw-1
Received: by mail-qv1-f70.google.com with SMTP id v19so13182506qvk.16
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:15:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XaK3jxvT8IURsZc2FPYAI9xgrRGt+WXCR/pHTLcG0Wc=;
 b=CpPYskhi7eKkjhoJZEE+oIGF4ZRWHWBr7aqc6oqGAXdzNluKRZBZT0CfWkDJA5jYSK
 HyAz5OKuu1Cy1scvHYqQ5y+w9R40WMwvahvACpCVYMISqN9GT31lrpbplOGtWtSv4wl6
 KN05xovh2TjV4+vgoebDs0vxyyWzQQim7b1/vO0PRgBGEPsFJ+ouR8eelBQJwjtVgax6
 aZe44oH63Xh3b9WGG0jVuEqmVF6cfSJRJfqzPC0W6KC1jYC7es5C8OiMtXEfMlWbz3ZG
 nGNCTgEjpK9cZfhFkRzom4pffpRhfPQ/rkTgVxBLKJryyrQWWvNTh3cUQ9fdV14bd/h/
 ru5g==
X-Gm-Message-State: APjAAAVoLiIFEE4TRTCC+cTsdvPE0ocdFoFH6Mc9rel7HWoIBKKLnEeQ
 0zaT9i4LDP2tz3ds2xdDOwkBGZPgb76BVeJKmnHN+3eGwY85Fv3uW2C7XDh8CM2IJQ8PTPQkYUE
 6cR3H85qrVme8Jns=
X-Received: by 2002:ae9:dcc1:: with SMTP id
 q184mr54488720qkf.480.1582643712565; 
 Tue, 25 Feb 2020 07:15:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3rA58e4itkje2BrTsKcsd1eLqGM6ZBB6h6iTmFdMyPPol443KVMkbQj62IQvnh0M6U/YNFg==
X-Received: by 2002:ae9:dcc1:: with SMTP id
 q184mr54488678qkf.480.1582643712072; 
 Tue, 25 Feb 2020 07:15:12 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 y91sm7795014qtd.13.2020.02.25.07.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:15:11 -0800 (PST)
Date: Tue, 25 Feb 2020 10:15:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] Fixed assert in vhost_user_set_mem_table_postcopy
Message-ID: <20200225151210.647797-33-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Peter Turschmid <peter.turschm@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

The current vhost_user_set_mem_table_postcopy() implementation
populates each region of the VHOST_USER_SET_MEM_TABLE message without
first checking if there are more than VHOST_MEMORY_MAX_NREGIONS already
populated. This can cause memory corruption if too many regions are
added to the message during the postcopy step.

This change moves an existing assert up such that attempting to
construct a VHOST_USER_SET_MEM_TABLE message with too many memory
regions will gracefully bring down qemu instead of corrupting memory.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
Message-Id: <1579143426-18305-2-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 35baf4f347..08e7e63790 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -443,6 +443,7 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,
                                      &offset);
         fd =3D memory_region_get_fd(mr);
         if (fd > 0) {
+            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
                                                   reg->memory_size,
                                                   reg->guest_phys_addr,
@@ -455,7 +456,6 @@ static int vhost_user_set_mem_table_postcopy(struct vho=
st_dev *dev,
             msg.payload.memory.regions[fd_num].guest_phys_addr =3D
                 reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
             fds[fd_num++] =3D fd;
         } else {
             u->region_rb_offset[i] =3D 0;
--=20
MST



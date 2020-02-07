Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE86AC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B23214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cr7+vMMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B23214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j050k-0001gm-Ns
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:53:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <016728cfe268492b180a5045b1ce6d3d143bf981@lizzy.crudebyte.com>)
 id 1j04sw-0007SY-9a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <016728cfe268492b180a5045b1ce6d3d143bf981@lizzy.crudebyte.com>)
 id 1j04sv-0006Fo-7d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:45:34 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:40761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <016728cfe268492b180a5045b1ce6d3d143bf981@lizzy.crudebyte.com>)
 id 1j04su-0004D3-GZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=cVaDLnM2mwS3m2xiObJb7wACXihL0DcSa2dUkcfUO+o=; b=cr7+v
 MMZsJ0dSDlRWJC4Yd0C+EoINDMYi34jM0x5GtQJ0h8DbHOz99uGAOA/KiudMi/ixNn6G+Kqq55jIj
 zMXDSHAyfyXGVXEp3EZQwAKlnkiPV44EwCJG0NAHKMH8NjppH8qTY909gpAeuiDlMkaNHD56vXqMM
 ssI8whbB2llAeUWjl/rZfeFjkHdyu08PIE0ULHurPPeYpdHQB+KMIsLSWKWat3ayqQ0/4zOyJC2nt
 0VXSzKLii7mlG8n99z3wwwJ0qb+2p2tH+m2FbMcp2+5FjBvL2R129gIviSGdtV/cQ1VV+zlwNRE5W
 g29Q3nzZmOLV82eQMPOn5zr/ud5aw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 7 Feb 2020 14:32:43 +0100
Subject: [PATCH] MAINTAINERS: 9pfs: Add myself as reviewer
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1j04TG-0001xn-JY@lizzy.crudebyte.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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

Currently 9pfs is only taken care of by Greg. Since I am actively working
on 9pfs and already became quite used to the code base, it makes sense to
volunteer as reviewer for 9pfs related patches.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e72b5e5f69..ce46c0a552 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1578,6 +1578,7 @@ F: include/hw/virtio/
 
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
+R: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
-- 
2.20.1



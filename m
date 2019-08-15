Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2388EC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA80C2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 13:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA80C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyFn4-0006nV-VH
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 09:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1hyFmS-0006NX-9a
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hyFmP-0005kj-R4
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:27:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hyFmP-0005jn-MU
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 09:27:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AAF6307CDEA
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 13:27:00 +0000 (UTC)
Received: from localhost (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B53310016E8;
 Thu, 15 Aug 2019 13:26:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 14:26:51 +0100
Message-Id: <20190815132651.22410-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 15 Aug 2019 13:27:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] MAINTAINERS: add Stefan Hajnoczi as
 vhost-vsock maintainer
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A MAINTAINERS entry wasn't added when this code was merged.  Add it now
so that scripts/get_maintainer.pl works for vhost-vsock.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200453..b8fc408bf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1571,6 +1571,13 @@ F: hw/virtio/virtio-crypto.c
 F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
=20
+vhost-vsock
+M: Stefan Hajnoczi <stefanha@redhat.com>
+S: Supported
+F: hw/virtio/vhost-vsock.c
+F: hw/virtio/vhost-vsock-pci.c
+F: include/hw/virtio/vhost-vsock.h
+
 nvme
 M: Keith Busch <keith.busch@intel.com>
 L: qemu-block@nongnu.org
--=20
2.21.0



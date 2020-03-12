Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C036C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066DE206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KExyqezd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066DE206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCO3l-00019D-7M
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jCO23-0008GL-4i
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jCO21-0006mn-Jl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:37:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jCO21-0006mW-GC
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584020268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MaSyzj5se7fjW7XdQQKq6JuGWysaABYVLVsZvk3ZbWI=;
 b=KExyqezdy/4b+WuH9Lq2py5VbsXsuBMdqcJ/VwO0YdCL0XysyRYFR+yqrXbJiIwqd6e6de
 Anx8J1RfVBZGIeUItDHoOzHW9JdAmjAwObvCzAcCftE/W5UiUVXGDhkL6zVPNzBWhwOeoO
 yzigXYjxaxPP12mJapj3qe9ji6D7pbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-6QouTogKPVaOT2qvM5V10g-1; Thu, 12 Mar 2020 09:37:46 -0400
X-MC-Unique: 6QouTogKPVaOT2qvM5V10g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E95228B5D59;
 Thu, 12 Mar 2020 13:37:45 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD76A101D494;
 Thu, 12 Mar 2020 13:37:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1] MAINTAINERS: Add myself as virtio-balloon co-maintainer
Date: Thu, 12 Mar 2020 14:37:25 +0100
Message-Id: <20200312133725.8192-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As suggested by Michael, let's add me as co-maintainer of virtio-balloon.
While at it, also add "balloon.c" and "include/sysemu/balloon.h" to the
file list.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d881ba7d9c..7fdd30c04d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1595,6 +1595,15 @@ F: hw/virtio/trace-events
 F: net/vhost-user.c
 F: include/hw/virtio/
=20
+virtio-balloon
+M: Michael S. Tsirkin <mst@redhat.com>
+M: David Hildenbrand <david@redhat.com>
+S: Maintained
+F: hw/virtio/virtio-balloon*.c
+F: include/hw/virtio/virtio-balloon.h
+F: balloon.c
+F: include/sysemu/balloon.h
+
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
--=20
2.24.1



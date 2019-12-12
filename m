Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEBBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B45214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta9Z9HOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B45214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRsv-0007Gz-6e
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVR-0005ZC-HM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVQ-0001pN-FO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45360
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVQ-0001om-C0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5lU5iduXjOwpyWmxZd+9Bd4gUNVKWBzNojU0J9pvytI=;
 b=Ta9Z9HOOreOkhRcZJnYuqIEBXojtKy1mvwD1ovaSh6qcbQWqmR1hqPPTIlVKR7IsywdKhk
 iXlLi2E+sns6kAF9LbPckbhYUkwRuICuRwSMggni4w6l/wfWRbqt7bB+vYMvqTzl7+woW+
 FlI0NzGTdexeTg5+6ff1wuUUzJNEFKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-zQHtcn-YPiKY6SN4D0oGBg-1; Thu, 12 Dec 2019 11:39:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D029864A7F
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0222360BE1;
 Thu, 12 Dec 2019 16:39:56 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 031/104] virtiofs: Add maintainers entry
Date: Thu, 12 Dec 2019 16:37:51 +0000
Message-Id: <20191212163904.159893-32-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zQHtcn-YPiKY6SN4D0oGBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..d1b3e262d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1575,6 +1575,14 @@ T: git https://github.com/cohuck/qemu.git s390-next
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
+virtiofs
+M: Dr. David Alan Gilbert <dgilbert@redhat.com>
+M: Stefan Hajnoczi <stefanha@redhat.com>
+S: Supported
+F: tools/virtiofsd/*
+F: hw/virtio/vhost-user-fs*
+F: include/hw/virtio/vhost-user-fs.h
+
 virtio-input
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
--=20
2.23.0


